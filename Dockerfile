# DRVFuzz reproducible build/run environment.
#
# The prebuilt implementation wrappers (Spike, Rocket, BOOM, CVA6, ...) are
# x86-64 Linux ELF binaries that require glibc >= 2.38, so the image is pinned
# to linux/amd64 on Ubuntu 24.04 (glibc 2.39). On arm64 hosts Docker runs it
# under emulation (Rosetta/QEMU).
FROM --platform=linux/amd64 ubuntu:24.04@sha256:fe81560990fae86dc4743202b2cb4d3df98d0bcf949173cecef15ce1127ef852

ARG DEBIAN_FRONTEND=noninteractive
ARG RUST_VERSION=1.99.1
ARG RUSTUP_VERSION=1.29.2
ARG RUSTUP_INIT_SHA256=5be191e8c70a5007074254cb74d78dbfdd25cd5a61c27de7b8e5410122ec24f4
ARG USER_UID=1000
ARG USER_GID=1000

# Prebuilt bare-metal RISC-V GNU toolchain from the official riscv-collab
# releases. Ubuntu's gcc-riscv64-unknown-elf (GCC 13.2 / binutils 2.42) rejects
# the -march strings DRVFuzz generates (e.g. zicfilp, zabha, svinval).
ARG RISCV_TOOLCHAIN_RELEASE=2026.08.27
ARG RISCV_TOOLCHAIN_SHA256=fe7dadf99dfaee59855b4be5f8d491dc66593bec295090e155a3ec51f0d14f56

# Build tools and the runtime libraries listed in README.md for the wrappers.
# Spike additionally needs `dtc` (device-tree-compiler) at runtime.
RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl file git pkg-config xz-utils \
        build-essential \
        libstdc++6 libgcc-s1 libatomic1 zlib1g libzstd1 libelf1t64 libsqlite3-0 \
        libmpc3 libmpfr6 libgmp10 libexpat1 \
        device-tree-compiler \
        fish \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL -o /tmp/riscv-toolchain.tar.xz \
        "https://github.com/riscv-collab/riscv-gnu-toolchain/releases/download/${RISCV_TOOLCHAIN_RELEASE}/riscv64-elf-ubuntu-24.04-gcc.tar.xz" \
    && echo "${RISCV_TOOLCHAIN_SHA256}  /tmp/riscv-toolchain.tar.xz" | sha256sum -c - \
    && mkdir -p /opt/riscv \
    && tar -xJf /tmp/riscv-toolchain.tar.xz -C /opt/riscv --strip-components=1 \
    && rm /tmp/riscv-toolchain.tar.xz \
    && /opt/riscv/bin/riscv64-unknown-elf-gcc --version | head -1 \
    && /opt/riscv/bin/riscv64-unknown-elf-as --version | head -1

# Non-root user for building and fuzzing (ubuntu:24.04 ships uid 1000 "ubuntu").
RUN userdel -r ubuntu 2>/dev/null || true; \
    groupadd -g ${USER_GID} fuzz && useradd -m -u ${USER_UID} -g ${USER_GID} -s /bin/bash fuzz

# Rust toolchain via checksum-verified rustup-init, pinned version.
ENV RUSTUP_HOME=/opt/rustup CARGO_HOME=/opt/cargo PATH=/opt/cargo/bin:$PATH
RUN curl -fsSL -o /tmp/rustup-init \
        "https://static.rust-lang.org/rustup/archive/${RUSTUP_VERSION}/x86_64-unknown-linux-gnu/rustup-init" \
    && echo "${RUSTUP_INIT_SHA256}  /tmp/rustup-init" | sha256sum -c - \
    && chmod +x /tmp/rustup-init \
    && /tmp/rustup-init -y --no-modify-path --profile minimal --default-toolchain ${RUST_VERSION} \
    && rm /tmp/rustup-init \
    && chown -R fuzz:fuzz ${RUSTUP_HOME} ${CARGO_HOME} \
    && rustc --version && cargo --version

WORKDIR /opt/drvfuzz
COPY --chown=fuzz:fuzz riscv-instruction-crates/ riscv-instruction-crates/
COPY --chown=fuzz:fuzz DRVFuzz/ DRVFuzz/
COPY --chown=fuzz:fuzz release_assets/ release_assets/

# Wrapper binaries: verify the release archive against the checksum committed
# to the repository before extracting it over DRVFuzz/riscv_impls_bins/.
RUN cd /opt/drvfuzz \
    && sha256sum -c release_assets/riscv_impls_bins_binaries.tar.gz.sha256 \
    && tar -xzf release_assets/riscv_impls_bins_binaries.tar.gz -C DRVFuzz \
    && find DRVFuzz/riscv_impls_bins -maxdepth 1 -type f -exec chmod +x {} + \
    && rm release_assets/riscv_impls_bins_binaries.tar.gz \
    && chown -R fuzz:fuzz /opt/drvfuzz

USER fuzz
WORKDIR /opt/drvfuzz/DRVFuzz
RUN cargo build --release --locked

# Equivalent of `source scripts/setup_riscv_env.sh` for non-interactive runs;
# the script is also sourced for interactive bash shells. RISCV is the
# toolchain root used by the CVA6 wrapper to find riscv64-unknown-elf-nm
# (and /opt/riscv/lib is also in the wrappers' RUNPATH).
ENV RISCV=/opt/riscv \
    PATH=/opt/drvfuzz/DRVFuzz/target/release:/opt/drvfuzz/DRVFuzz/riscv_impls_bins:/opt/riscv/bin:$PATH
RUN echo 'source /opt/drvfuzz/DRVFuzz/scripts/setup_riscv_env.sh >/dev/null' >> /home/fuzz/.bashrc

COPY --chown=fuzz:fuzz docker/entrypoint.sh /usr/local/bin/drvfuzz-entrypoint
COPY --chown=fuzz:fuzz docker/run_tests.sh /usr/local/bin/drvfuzz-run-tests
ENTRYPOINT ["/usr/local/bin/drvfuzz-entrypoint"]
CMD ["bash"]
