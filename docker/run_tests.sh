#!/usr/bin/env bash
# Bounded DRVFuzz checks inside the container: Spike smoke test and, if both
# wrappers are executable, a short Spike/Rocket differential run.
#
# Runs happen in a case-sensitive directory inside the container and are then
# collected into /artifacts. DRVFuzz preprocesses program.S into program.s,
# which collide on case-insensitive host mounts (default macOS APFS).
#
# Usage: run_tests.sh [smoke|readme-example|diff|all] [max_runs]
set -uo pipefail

MODE="${1:-all}"
MAX_RUNS="${2:-5}"
OUT=/artifacts
WORK="${WORK_DIR:-/home/fuzz/runs}"
cd /opt/drvfuzz/DRVFuzz
mkdir -p "$WORK" "$OUT/logs"

# Save a run directory to /artifacts: an exact tar archive (keeps program.s
# and program.S apart) plus a browsable copy of reports, logs and dumps.
collect() {
    local src="$1" name="$2"
    tar -czf "$OUT/$name.tar.gz" -C "$WORK" "$name"
    rm -rf "${OUT:?}/$name"
    (cd "$WORK" && find "$name" -type f \
        \( -name '*.md' -o -name '*.json' -o -name '*.log' -o -name '*.asm' -o -name '*.dump' \) \
        -exec cp --parents {} "$OUT/" \;)
}

run_logged() {
    local name="$1"; shift
    local log="$OUT/logs/$name.log"
    {
        echo "+ $*"
        local start=$SECONDS
        RUST_LOG="${RUST_LOG:-info}" "$@"
        local rc=$?
        echo "EXIT_CODE=$rc ELAPSED_SECS=$((SECONDS - start))"
        return $rc
    } >"$log" 2>&1
}

# The README example writes "add  x3, x1, x2" (two spaces). The tracer
# whitespace-normalizes dump lines but not user instructions
# (src/tracer.rs), so that exact text fails with "Missing user instructions
# in dump". The smoke test runs the same program with single spaces; the
# README text is kept as the readme-example mode to document the issue.
smoke() {
    local name="${1:-smoke_spike}"
    local dir="$WORK/$name"
    rm -rf "$dir" && mkdir -p "$dir"
    if [[ "$name" == readme_example ]]; then
        printf 'addi x1, x0, 1\naddi x2, x0, 2\nadd  x3, x1, x2\n' >"$dir/user_instructions.asm"
    else
        printf 'addi x1, x0, 1\naddi x2, x0, 2\nadd x3, x1, x2\n' >"$dir/user_instructions.asm"
    fi
    run_logged "05_$name" DRVFuzz exec \
        --asm "$dir/user_instructions.asm" \
        --riscv-impl spike \
        --isa rv64 \
        --run-dir "$dir/exec" \
        --timeout-secs 10 \
        --transition-report
    local rc=$?
    collect "$dir" "$name"
    echo "$name exit=$rc"
    return $rc
}

diff_spike_rocket() {
    for v in RISCV_WRAPPER_SPIKE_BIN RISCV_WRAPPER_ROCKET_RV64_BIN; do
        if [[ ! -x "${!v:-}" ]]; then
            echo "diff skipped: $v is not an executable wrapper"
            return 2
        fi
    done
    local dir="$WORK/diff_spike_rocket"
    rm -rf "$dir"
    run_logged 06_diff_spike_rocket DRVFuzz diff \
        --testcase-config configs/rv64.toml \
        --riscv-impl spike,rocket \
        --run-dir "$dir" \
        --impl-timeout configs/timeout.toml \
        --run-options configs/run_options.toml \
        --concurrency 2 \
        --max-runs "$MAX_RUNS"
    local rc=$?
    collect "$dir" diff_spike_rocket
    echo "diff_spike_rocket exit=$rc"
    return $rc
}

case "$MODE" in
    smoke) smoke ;;
    readme-example) smoke readme_example ;;
    diff) diff_spike_rocket ;;
    all) smoke && diff_spike_rocket ;;
    *) echo "unknown mode: $MODE" >&2; exit 64 ;;
esac
