#!/usr/bin/env bash
# Build a DRVFuzz-compatible XiangShan emu (Verilator) on a large server and put
# it, with the difftest reference model, where docker-compose.xiangshan.yml
# expects it. Run on the host (needs git and Docker), not in the DRVFuzz image.
#
#   XS_DIR=/abs/path/xs docker/xiangshan/build_emu.sh [WORK_DIR]
#
# Environment:
#   XS_DIR        output directory (required)
#   XS_CONFIG     XiangShan config, default DefaultConfig (~100 GB RAM for Verilator,
#                 see XiangShan README); MinimalConfig builds with less
#   JOBS          parallel C++ compile jobs, default 16
#   EMU_THREADS   Verilator model threads, default 8
#   XS_NATIVE=1   build with the tools already on this host (an xs-env setup)
#                 instead of the xs-env Docker image
#   XS_OFFLINE=1  no downloads: WORK_DIR and the xs-env image must already be
#                 prepared by an online run; the build container gets
#                 --network none (see docker/XIANGSHAN_SERVER.md)
#
# Steps:
#   1. xs-env Docker image (official XiangShan build environment), pinned commit
#   2. XiangShan at a pinned commit, `make init` (submodules)
#   3. difftest-drvfuzz-commit-trace.patch applied to XiangShan/difftest
#   4. `make emu CONFIG=$XS_CONFIG`
#   5. $XS_DIR/xiangshan_rv64 (emu) and $XS_DIR/xiangshan_rv64_ref_spike_so
#      (ready-to-run/riscv64-spike-so, SHA-256 checked) + BUILD_INFO.txt
set -euo pipefail

XS_ENV_COMMIT=7507284549cccbd9217dfbc7c690475435ba8527
XIANGSHAN_COMMIT=182b2277c0e4115e39ae396f7d705bc4e20e0def # kunminghu-v3, 2026-11-11
DIFFTEST_COMMIT=ecdf41e225a93699b9a1141ec4d0fc1ff485b890  # its difftest submodule
REF_SO_SHA256=45329fdec4c8ae8cfd3f931cdd2636745d0575c6179cc4cc0f90576c340442eb # ready-to-run 4cf9983 riscv64-spike-so

: "${XS_DIR:?set XS_DIR to the output directory}"
XS_CONFIG="${XS_CONFIG:-DefaultConfig}"
JOBS="${JOBS:-16}"
EMU_THREADS="${EMU_THREADS:-8}"
WORK="$(mkdir -p "${1:-$PWD/xiangshan-build}" && cd "${1:-$PWD/xiangshan-build}" && pwd)"
PATCH="$(cd "$(dirname "$0")" && pwd)/difftest-drvfuzz-commit-trace.patch"
IMAGE="drvfuzz-xs-env:${XS_ENV_COMMIT:0:12}"
mkdir -p "$XS_DIR"
exec > >(tee -a "$WORK/build_emu.log") 2>&1
echo "== $(date -u +%FT%TZ) XS_OFFLINE=${XS_OFFLINE:-0} XS_CONFIG=$XS_CONFIG JOBS=$JOBS EMU_THREADS=$EMU_THREADS WORK=$WORK"

OFFLINE="${XS_OFFLINE:-0}"
checkout() { # url dir commit
    if [[ "$OFFLINE" == 1 ]]; then
        [[ -d "$2/.git" ]] || { echo "offline: $2 is missing, prepare WORK_DIR with an online run"; exit 1; }
    else
        [[ -d "$2/.git" ]] || git clone "$1" "$2"
        git -C "$2" fetch -q origin "$3" 2>/dev/null || true
    fi
    git -C "$2" checkout -q --detach "$3"
}

if [[ "${XS_NATIVE:-0}" != 1 ]]; then
    echo "== 1. xs-env image $IMAGE"
    if docker image inspect "$IMAGE" >/dev/null 2>&1; then
        echo "image present"
    elif [[ "$OFFLINE" == 1 ]]; then
        echo "offline: image $IMAGE is missing, docker load it first"; exit 1
    else
        checkout https://github.com/OpenXiangShan/xs-env.git "$WORK/xs-env" "$XS_ENV_COMMIT"
        docker build --build-arg SLIM=true -t "$IMAGE" "$WORK/xs-env"
    fi
fi

# Run a command in the XiangShan checkout: natively, or in the xs-env image
# (the host then needs only git and Docker). Non-root, only the checkout is
# mounted; HOME inside it keeps the mill/coursier caches with the sources.
in_xs_env() {
    if [[ "${XS_NATIVE:-0}" == 1 ]]; then
        (cd "$WORK/XiangShan" && NOOP_HOME="$WORK/XiangShan" "$@")
    else
        local net=()
        [[ "$OFFLINE" == 1 ]] && net=(--network none)
        mkdir -p "$WORK/XiangShan/.home"
        docker run --rm "${net[@]}" --user "$(id -u):$(id -g)" \
            -v "$WORK/XiangShan:/xs" -w /xs -e NOOP_HOME=/xs -e HOME=/xs/.home \
            "$IMAGE" "$@"
    fi
}

echo "== 2. XiangShan $XIANGSHAN_COMMIT"
checkout https://github.com/OpenXiangShan/XiangShan.git "$WORK/XiangShan" "$XIANGSHAN_COMMIT"
if [[ "$OFFLINE" == 1 ]]; then
    git -C "$WORK/XiangShan" submodule status --recursive | grep -q '^-' \
        && { echo "offline: uninitialized submodules in $WORK/XiangShan"; exit 1; }
else
    in_xs_env make init
fi
actual=$(git -C "$WORK/XiangShan/difftest" rev-parse HEAD)
[[ "$actual" == "$DIFFTEST_COMMIT" ]] || { echo "difftest is at $actual, expected $DIFFTEST_COMMIT"; exit 1; }

echo "== 3. difftest patch"
if git -C "$WORK/XiangShan/difftest" apply --reverse --check "$PATCH" 2>/dev/null; then
    echo "already applied"
else
    git -C "$WORK/XiangShan/difftest" apply "$PATCH"
fi
git -C "$WORK/XiangShan/difftest" diff --stat

echo "== 4. make emu CONFIG=$XS_CONFIG"
in_xs_env make emu CONFIG="$XS_CONFIG" EMU_THREADS="$EMU_THREADS" -j"$JOBS"

echo "== 5. install into $XS_DIR"
ref="$WORK/XiangShan/ready-to-run/riscv64-spike-so"
echo "$REF_SO_SHA256  $ref" | sha256sum -c -
install -m 0755 "$WORK/XiangShan/build/emu" "$XS_DIR/xiangshan_rv64"
install -m 0644 "$ref" "$XS_DIR/xiangshan_rv64_ref_spike_so"
cat >"$XS_DIR/BUILD_INFO.txt" <<EOF
built: $(date -u +%FT%TZ) on $(hostname)
XiangShan: $XIANGSHAN_COMMIT  CONFIG=$XS_CONFIG EMU_THREADS=$EMU_THREADS
difftest: $DIFFTEST_COMMIT + $(basename "$PATCH") (sha256 $(sha256sum "$PATCH" | cut -d' ' -f1))
xs-env: $XS_ENV_COMMIT (native=${XS_NATIVE:-0})
reference: ready-to-run/riscv64-spike-so sha256 $REF_SO_SHA256
xiangshan_rv64_no_unaligned_rw: not built (see docker/README.md, XiangShan)
EOF
ls -l "$XS_DIR"
echo "done: next run drvfuzz-check-xiangshan (docker/README.md, XiangShan)"
