#!/usr/bin/env bash
# Readiness check for running DRVFuzz on XiangShan inside the container.
# Each stage stops at the first failure with the reason; nothing is reported
# as passing unless the real emu produced it.
#
# Stages:
#   1. emu / reference .so present, executable, shared libraries resolved
#   2. emu accepts the options DRVFuzz passes (-i, --diff, --dump-commit-trace)
#   3. DRVFuzz generates XiangShan testcases and ELFs
#   4. one DRVFuzz exec on XiangShan (--allow-unaligned): the commit trace has the
#      format DRVFuzz parses (src/impls/xiangshan/execute.rs, needs
#      docker/xiangshan/difftest-drvfuzz-commit-trace.patch) and the register,
#      memory and exception results equal Spike's for the same program
#   5. same without --allow-unaligned, only if xiangshan_rv64_no_unaligned_rw exists
#   6. (only with --diff) bounded `diff spike,xiang-shan --max-runs N` on
#      configs/rv64_unligned.toml
#
# Usage: check_xiangshan.sh [--diff [N]]
set -uo pipefail

OUT=/artifacts/xiangshan_check
WORK=/home/fuzz/runs/xiangshan_check
TIMEOUT="${XS_TIMEOUT_SECS:-600}"
cd /opt/drvfuzz/DRVFuzz
rm -rf "$WORK" && mkdir -p "$WORK" "$OUT"
exec > >(tee "$OUT/check.log") 2>&1

fail() { echo "FAIL: $*"; save; exit 1; }
save() { tar -czf "$OUT/runs.tar.gz" -C "$(dirname "$WORK")" "$(basename "$WORK")" 2>/dev/null; }

check_file() { # var [exec]
    local p="${!1:-}" real missing
    [[ -n "$p" ]] || fail "$1 is not set: /opt/xiangshan/ is not mounted or lacks the file (see docker-compose.xiangshan.yml)"
    real=$(readlink -f "$p")
    echo "$1=$p -> $real"
    file -L "$p" | sed 's/^/   /'
    if [[ "${2:-}" == exec && ! -x "$real" ]]; then fail "$real is not executable"; fi
    missing=$(ldd "$real" 2>&1 | grep 'not found')
    [[ -z "$missing" ]] || fail "unresolved libraries for $real: $missing"
}

echo "== 1. files"
check_file RISCV_WRAPPER_XS_EMU exec
check_file RISCV_WRAPPER_XS_DIFF_SO
if [[ -n "${RISCV_WRAPPER_XS_EMU_NO_UNALIGNED_RW:-}" ]]; then
    check_file RISCV_WRAPPER_XS_EMU_NO_UNALIGNED_RW exec
else
    echo "RISCV_WRAPPER_XS_EMU_NO_UNALIGNED_RW not set: only unaligned-allowed runs (configs/rv64_unligned.toml) can use XiangShan"
fi

echo "== 2. emu options"
"$RISCV_WRAPPER_XS_EMU" --help >"$WORK/emu_help.txt" 2>&1
for opt in -i --diff --dump-commit-trace; do
    grep -q -- "$opt" "$WORK/emu_help.txt" || fail "emu --help does not mention $opt (see $OUT/runs.tar.gz: emu_help.txt)"
done
echo "emu supports -i, --diff, --dump-commit-trace"

echo "== 3. generate"
DRVFuzz generate --config configs/rv64_unligned.toml --riscv-impl xiang-shan --run-dir "$WORK/generate" \
    >"$WORK/generate.log" 2>&1 || fail "DRVFuzz generate failed: $(tail -3 "$WORK/generate.log")"
echo "generated: $(cd "$WORK/generate" && ls)"

# x5 = 0x80002000, the start of the DRVFuzz user memory range for XiangShan
# (DRVFuzz/src/impls/xiangshan/config.rs); the last load is misaligned.
cat >"$WORK/user_instructions.asm" <<'EOF'
lui x5, 0x40001
slli x5, x5, 1
addi x1, x0, 1
addi x2, x0, 2
add x3, x1, x2
sd x3, 0(x5)
ld x4, 0(x5)
ld x6, 1(x5)
EOF

# exec_pair <name> [--allow-unaligned]: run the program on XiangShan and Spike, compare.
exec_pair() {
    local name="$1" rc start trace total parsed exc mem
    shift
    start=$SECONDS
    RUST_LOG=info DRVFuzz exec --asm "$WORK/user_instructions.asm" --riscv-impl xiang-shan --isa rv64 \
        --run-dir "$WORK/$name/xs" --timeout-secs "$TIMEOUT" "$@" >"$WORK/$name/xs.log" 2>&1
    rc=$?
    echo "XiangShan exec exit=$rc elapsed=$((SECONDS - start))s"
    trace="$WORK/$name/xs/XiangShan/skiptrap.commit.log"
    if [[ -f "$trace" ]]; then
        total=$(grep -cE '^\[[0-9]+\] commit pc ' "$trace")
        # Same patterns as RE_COMMIT / RE_EXCEPTION / RE_MEM_LINE in src/impls/xiangshan/execute.rs
        parsed=$(grep -cE '^\[[0-9]+\] commit pc [0-9a-fA-F]{16} inst [0-9a-fA-F]{8} wen [0-9]+ dst [xXfFvV][0-9]{1,2} data [0-9a-fA-F]{16} idx [0-9a-fA-F]{3}' "$trace")
        exc=$(grep -cE '^\[[0-9]+\] exception pc [0-9a-fA-F]{16} inst [0-9a-fA-F]{8} cause [0-9a-fA-F]{16}' "$trace")
        mem=$(grep -cE '^mem pc [0-9a-fA-F]{16} addr [0-9a-fA-F]{16} data [0-9a-fA-F]{16} mask 0x[0-9a-fA-F]{2}$' "$trace")
        echo "commit lines: $total, parseable by DRVFuzz: $parsed, exception lines: $exc, store lines: $mem"
        grep -m3 -E '^\[[0-9]+\] commit pc ' "$trace" | sed 's/^/   /'
        if (( total > 0 && parsed == 0 )); then
            fail "commit trace has no 'dst x08'-style lines: the emu was built without docker/xiangshan/difftest-drvfuzz-commit-trace.patch"
        fi
        if (( total > 0 && mem == 0 )); then
            fail "no 'mem pc' store lines although the program stores: the emu was built without docker/xiangshan/difftest-drvfuzz-commit-trace.patch"
        fi
        grep -m3 -i -E 'mismatch|different at|ABORT' "$trace" | sed 's/^/   emu: /'
    fi
    (( rc == 0 )) || fail "DRVFuzz exec on XiangShan failed: $(tail -2 "$WORK/$name/xs.log" | cut -c1-400)"

    DRVFuzz exec --asm "$WORK/user_instructions.asm" --riscv-impl spike --isa rv64 \
        --run-dir "$WORK/$name/spike" --timeout-secs 30 "$@" >"$WORK/$name/spike.log" 2>&1 \
        || fail "DRVFuzz exec on Spike failed: $(tail -2 "$WORK/$name/spike.log" | cut -c1-400)"
    python3 - "$WORK/$name/spike/Spike/execution_output.json" "$WORK/$name/xs/XiangShan/execution_output.json" <<'EOF' \
        || fail "XiangShan and Spike results differ for the same program (see $OUT/runs.tar.gz: $name)"
import json, sys
keys = ("exceptions", "register_changes", "memory_changes")
spike, xs = ({k: json.load(open(p))[k] for k in keys} for p in sys.argv[1:3])
for k in keys:
    print(f"{k:17} spike={json.dumps(spike[k])}")
    if xs[k] != spike[k]:
        print(f"{k:17} xs   ={json.dumps(xs[k])}")
print("XiangShan == Spike" if xs == spike else "XiangShan != Spike")
sys.exit(xs != spike)
EOF
}

echo "== 4. exec --allow-unaligned (timeout ${TIMEOUT}s)"
mkdir -p "$WORK/unaligned"
exec_pair unaligned --allow-unaligned

if [[ -n "${RISCV_WRAPPER_XS_EMU_NO_UNALIGNED_RW:-}" ]]; then
    echo "== 5. exec without --allow-unaligned"
    mkdir -p "$WORK/aligned"
    exec_pair aligned
else
    echo "== 5. skipped (no xiangshan_rv64_no_unaligned_rw)"
fi

if [[ "${1:-}" == --diff ]]; then
    n="${2:-1}"
    echo "== 6. diff spike,xiang-shan on configs/rv64_unligned.toml --max-runs $n"
    RUST_LOG=info DRVFuzz diff --testcase-config configs/rv64_unligned.toml --riscv-impl spike,xiang-shan \
        --run-dir "$WORK/diff" --impl-timeout configs/timeout.toml --run-options configs/run_options.toml \
        --concurrency 1 --max-runs "$n" >"$WORK/diff.log" 2>&1 \
        || fail "diff failed: $(tail -2 "$WORK/diff.log" | cut -c1-400)"
    grep 'completed diff analysis\|exited cleanly' "$WORK/diff.log" | cut -c1-200
    echo "testcases run on XiangShan: $(find "$WORK/diff" -path '*/XiangShan/execution_output.json' | wc -l)"
fi

save
echo "PASS: XiangShan is usable from DRVFuzz (results in $OUT)"
