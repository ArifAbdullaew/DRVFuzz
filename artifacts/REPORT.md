# DRVFuzz: отчёт о Docker-сборке и тестировании

Дата: 2026-10-30. Хост: macOS 15.3.1, arm64, Docker 29.2.1, Compose v5.1.0.
Коммит репозитория: `eb52806`. Исходный код DRVFuzz не изменялся.

## Итог

| Проверка | Результат | Лог |
|---|---|---|
| Архив wrappers: SHA-256 совпадает с `release_assets/*.sha256` | OK | `logs/00_wrapper_archive_checksum.log` |
| `docker compose build --no-cache --pull` | OK (5 мин 48 с) | `logs/01_docker_compose_build.log` |
| `cargo build --release --locked` (Rust 1.99.1) | OK | там же, шаг `[11/14]` |
| `riscv64-unknown-elf-{gcc,as,ld,objdump,nm}` на `PATH` | OK (GCC 16.1.0, binutils 2.47) | `logs/02_env_verification.log` |
| `DRVFuzz --help` и help подкоманд | OK | `logs/04_cli_help.log` |
| Smoke test `exec` на Spike, rv64 | **OK**: x1=1, x2=2, x3=3, исключений 0 | `logs/05_smoke_spike.log`, `smoke_spike/` |
| `exec` на Rocket, rv64 (та же программа) | **OK**: x3=3 | `logs/05_smoke_rocket.log`, `smoke_rocket_execution_report.md` |
| `diff` Spike vs Rocket, `--max-runs 5 --concurrency 2` | **OK**: 5/5 прогонов, workers завершились штатно, 30 с | `logs/06_diff_spike_rocket.log`, `diff_spike_rocket/` |
| Пример из README в точности (`add  x3, x1, x2`) | FAIL, upstream-баг (см. ниже) | `logs/05_readme_example.log` |

Важно: успешная сборка образа и успешное выполнение фаззинга подтверждены
по отдельности. Выполнение реально проверено только для Spike и Rocket.

## Окружение образа `drvfuzz:local` (linux/amd64)

- База: `ubuntu:24.04@sha256:fe81560990fa…ef852` (glibc 2.39). Wrappers — x86-64 ELF, им нужен glibc ≥ 2.38. На arm64-хосте образ работает под эмуляцией.
- RISC-V toolchain: официальный prebuilt `riscv-collab/riscv-gnu-toolchain`, релиз `2026.08.27`, `riscv64-elf-ubuntu-24.04-gcc.tar.xz`. Проверяется по SHA-256 digest GitHub, ставится в `/opt/riscv`, `RISCV=/opt/riscv`.
- Rust: `rustup-init` 1.29.2 (проверка SHA-256), toolchain 1.99.1, профиль minimal.
- Wrappers: release `artifact` из upstream `YzhDDDing/DRVFuzz` (родитель форка; тег указывает на коммит `d3c69d7` из истории репозитория). Внутри `docker build` архив проверяется по checksum из репозитория.
- Runtime-пакеты: libstdc++6, libgcc-s1, libatomic1, zlib1g, libzstd1, libelf1t64, libsqlite3-0, **device-tree-compiler** (Spike вызывает `dtc`).
- Пользователь `fuzz` (uid 1000) без root. Compose: `cap_drop: ALL`, `no-new-privileges`. С хостом смонтирован только `./artifacts`.

## Проблемы, найденные и решённые по ходу

1. **Toolchain из Ubuntu (GCC 13.2 / binutils 2.42) слишком старый**: `-march`, который формирует DRVFuzz, отвергается с ошибкой `unexpected ISA string at end: 'svinval'` (`logs/05a_*`). Решение: toolchain riscv-collab GCC 16.1.
2. **Нет `dtc`**: Spike завершался с `Failed to run dtc` (`logs/05b_*`). README эту зависимость не называет. Решение: пакет `device-tree-compiler`.
3. **Регистронезависимая ФС macOS**: DRVFuzz делает `gcc -E program.S -o program.s`; на bind-mount с APFS оба имени указывают на один файл, и исходник затирается. Решение: `docker/run_tests.sh` запускает DRVFuzz в каталоге внутри контейнера, затем кладёт в `artifacts/` tar-архив (точная копия) и копию отчётов.

## Открытые проблемы / ограничения

- **BOOM v3/v4 и CVA6 не работоспособны** с release-архивом: им нужны `libriscv.so` (+ `libdramsim.so` для BOOM), которых нет в архиве. RPATH указывает на сборочные пути автора (`/root/work/chipyard/...`, `/opt/riscv/lib`; `logs/03_missing_libs_boom_cva6.log`). Заглушки не подставлялись. Нужны библиотеки от авторов, либо собирать Spike/libriscv и DRAMSim той же версии.
- **Пример `exec` из README не проходит дословно**: в `src/tracer.rs` пробелы нормализуются в строках dump, но не в пользовательских инструкциях, поэтому `add  x3, x1, x2` (два пробела) не находится. Smoke test использует ту же программу с одинарными пробелами. Исходник не правился.
- PicoRV32, Kronos, Srv32: библиотеки разрешаются (`ldd`), но запуск не проверялся.
- Diff нашёл расхождения по исключениям: Rocket выдаёт `0x2` (illegal instruction) на Zfa/Zfh-инструкциях (`fli.h`, `fmaxm.h`, `froundnx.d`, …), которые Spike принимает. Похоже на разницу в поддерживаемых расширениях, а не на баг. Не анализировалось.
- Wrappers работают под эмуляцией x86-64 на arm64; на нативном x86-64 Linux замеры времени будут другими.

## Воспроизведение

```bash
# из корня репозитория; архив wrappers должен лежать в release_assets/
curl -fL -o release_assets/riscv_impls_bins_binaries.tar.gz \
  https://github.com/YzhDDDing/DRVFuzz/releases/download/artifact/riscv_impls_bins_binaries.tar.gz
shasum -a 256 -c release_assets/riscv_impls_bins_binaries.tar.gz.sha256

docker compose build
docker compose run --rm drvfuzz drvfuzz-run-tests smoke        # Spike smoke test
docker compose run --rm drvfuzz drvfuzz-run-tests diff 5       # Spike vs Rocket, 5 прогонов
docker compose run --rm drvfuzz                                # интерактивный bash
```

## Добавленные файлы

- `Dockerfile`: образ (база по digest, toolchain, Rust, wrappers с проверкой checksum, release-сборка).
- `docker-compose.yml`: сервис `drvfuzz`, platform amd64, mount `./artifacts:/artifacts`.
- `.dockerignore`: исключает `.git`, `target`, `artifacts`, локально распакованные wrappers.
- `docker/entrypoint.sh`: делает `source scripts/setup_riscv_env.sh` и запускает команду.
- `docker/run_tests.sh`: ограниченные smoke/diff-тесты и сбор результатов в `/artifacts`.

Вне git: скачан `release_assets/riscv_impls_bins_binaries.tar.gz` (уже в `.gitignore`) и распакован в `DRVFuzz/riscv_impls_bins/` (там тоже игнорируется).
