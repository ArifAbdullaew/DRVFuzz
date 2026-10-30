#!/usr/bin/env bash
# Export RISCV_WRAPPER_* variables via the upstream setup script, then run the
# requested command.
set -e
source /opt/drvfuzz/DRVFuzz/scripts/setup_riscv_env.sh >/dev/null
exec "$@"
