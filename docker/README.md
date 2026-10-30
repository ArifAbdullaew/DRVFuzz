# Запуск DRVFuzz в Docker

Образ `drvfuzz:local` содержит уже собранный DRVFuzz (`cargo build --release`),
RISC-V GNU toolchain и prebuilt-wrappers процессорных реализаций (Spike,
Rocket и др.). С хостом общается только через каталог `./artifacts`.

## Требования

- Docker Engine или Docker Desktop с Compose v2 (`docker compose`).
- Около 10 ГБ свободного места: образ занимает ~2.3 ГБ, плюс кэш сборки.
- Доступ в интернет на время сборки: скачиваются базовый образ Ubuntu,
  RISC-V toolchain и Rust.
- Хост x86-64 Linux работает нативно. На Apple Silicon / arm64 образ
  запускается под эмуляцией amd64 (Rosetta/QEMU), так как wrappers — x86-64
  бинарники. Это работает, но медленнее.

## 1. Скачать архив wrappers

Архив не хранится в git. Его нужно один раз положить в `release_assets/` и
проверить контрольную сумму:

```bash
curl -fL -o release_assets/riscv_impls_bins_binaries.tar.gz \
  https://github.com/YzhDDDing/DRVFuzz/releases/download/artifact/riscv_impls_bins_binaries.tar.gz

sha256sum -c release_assets/riscv_impls_bins_binaries.tar.gz.sha256      # Linux
shasum -a 256 -c release_assets/riscv_impls_bins_binaries.tar.gz.sha256  # macOS
```

Ожидаемый вывод: `release_assets/riscv_impls_bins_binaries.tar.gz: OK`.
Распаковывать архив вручную не нужно, это делается внутри `docker build`
после повторной проверки checksum.

## 2. Собрать образ

Из корня репозитория:

```bash
mkdir -p artifacts
docker compose build
```

Первая сборка занимает 5–10 минут, большая часть уходит на `cargo build`.
Сохранить полный лог сборки:

```bash
docker compose build --progress=plain 2>&1 | tee artifacts/build.log
```

**Linux-хост, если ваш uid не 1000.** Внутри контейнера процессы работают от
пользователя `fuzz` (uid/gid 1000). Чтобы файлы в `artifacts/` принадлежали
вам, соберите образ с вашими id:

```bash
docker compose build --build-arg USER_UID=$(id -u) --build-arg USER_GID=$(id -g)
```

## 3. Проверить работу

Smoke test: программа из трёх инструкций на Spike.

```bash
docker compose run --rm drvfuzz drvfuzz-run-tests smoke
```

Ожидаемый вывод — `smoke_spike exit=0`. В
`artifacts/smoke_spike/exec/Spike/execution_report.md` должно быть
`x3:?→0x3`.

Короткий дифференциальный тест Spike vs Rocket на 5 прогонов:

```bash
docker compose run --rm drvfuzz drvfuzz-run-tests diff 5
```

Ожидаемый вывод — `diff_spike_rocket exit=0`. Последний аргумент — значение
`--max-runs`. Без него `DRVFuzz diff` работает бесконечно, поэтому не
опускайте его.

Оба теста подряд: `drvfuzz-run-tests all 5`.

| Режим `drvfuzz-run-tests` | Что делает | Лог |
|---|---|---|
| `smoke` | `DRVFuzz exec` на Spike, rv64 | `artifacts/logs/05_smoke_spike.log` |
| `diff [N]` | `DRVFuzz diff` Spike,Rocket, `--max-runs N` (по умолчанию 5) | `artifacts/logs/06_diff_spike_rocket.log` |
| `all [N]` | `smoke`, затем `diff` | оба |
| `readme-example` | Пример из README дословно (сейчас падает, см. «Известные проблемы») | `artifacts/logs/05_readme_example.log` |

Результаты каждого режима сохраняются в `artifacts/<имя>.tar.gz` (полная
копия каталога запуска) и `artifacts/<имя>/` (отчёты `.md`/`.json`, логи,
дизассемблер).

## 4. Работа вручную

Интерактивная оболочка:

```bash
docker compose run --rm drvfuzz
```

Рабочий каталог — `/opt/drvfuzz/DRVFuzz`. `DRVFuzz` уже есть в `PATH`, а
переменные `RISCV_WRAPPER_*` выставлены автоматически через
`scripts/setup_riscv_env.sh`. Поэтому команды из основного README можно
запускать как `DRVFuzz ...` вместо `cargo run --release -- ...`:

```bash
DRVFuzz --help
DRVFuzz diff --help

DRVFuzz diff \
  --testcase-config configs/rv64.toml \
  --riscv-impl spike,rocket \
  --run-dir /home/fuzz/runs/my_diff \
  --impl-timeout configs/timeout.toml \
  --run-options configs/run_options.toml \
  --concurrency 2 \
  --max-runs 20

# сохранить результат на хост
tar -czf /artifacts/my_diff.tar.gz -C /home/fuzz/runs my_diff
```

Одну команду можно выполнить и без входа в оболочку:

```bash
docker compose run --rm drvfuzz DRVFuzz generate \
  --config configs/rv64.toml --riscv-impl spike \
  --run-dir /home/fuzz/runs/gen --minimal-artifacts
```

Два правила:

1. **`--run-dir` указывайте внутри контейнера** (например,
   `/home/fuzz/runs/...`), а не в `/artifacts`. DRVFuzz создаёт рядом
   `program.S` и `program.s`. На регистронезависимой ФС хоста (macOS по
   умолчанию) это один и тот же файл, и запуск ломается. На Linux-хосте
   `/artifacts` использовать можно.
2. **Контейнер удаляется после выхода** (`--rm`). Всё, что не скопировано в
   `/artifacts`, пропадёт.

Полный фаззинг (без `--max-runs` или с большим значением) может идти часами.
Запускайте его осознанно.

## Что внутри образа

| Компонент | Версия / источник |
|---|---|
| Базовый образ | `ubuntu:24.04` (закреплён по digest), `linux/amd64`, glibc 2.39 |
| RISC-V toolchain | `riscv-collab/riscv-gnu-toolchain` релиз `2026.08.27`, GCC 16.1.0, binutils 2.47, в `/opt/riscv` |
| Rust | 1.99.1 через rustup 1.29.2 |
| Wrappers | `DRVFuzz/riscv_impls_bins/` из release-архива |
| Прочее | `device-tree-compiler` (нужен Spike), runtime-библиотеки из README |

Версии задаются через `ARG` в [`Dockerfile`](../Dockerfile): `RUST_VERSION`,
`RISCV_TOOLCHAIN_RELEASE`, `RISCV_TOOLCHAIN_SHA256` и др. Все загрузки
проверяются по SHA-256. Если меняете версию, обновите и соответствующий
checksum.

Файлы окружения:

- [`Dockerfile`](../Dockerfile) — образ.
- [`docker-compose.yml`](../docker-compose.yml) — сервис `drvfuzz`, монтирует
  только `./artifacts:/artifacts`, без root и с `cap_drop: ALL`.
- [`.dockerignore`](../.dockerignore) — что не попадает в контекст сборки.
- [`entrypoint.sh`](entrypoint.sh) — загружает переменные wrappers.
- [`run_tests.sh`](run_tests.sh) — команда `drvfuzz-run-tests`.

## Известные проблемы

- **BOOM v3/v4 и CVA6 не запускаются.** Им нужны `libriscv.so` (и
  `libdramsim.so` для BOOM), которых нет в release-архиве. Проверить:
  `ldd riscv_impls_bins/cva6_rv64`. Spike и Rocket работают. PicoRV32, Kronos
  и Srv32 разрешают все библиотеки, но не тестировались.
- **Пример `exec` из основного README падает дословно** с ошибкой
  `Missing user instructions in dump`. Причина — двойной пробел в
  `add  x3, x1, x2`: tracer нормализует пробелы только в dump. Пишите
  инструкции с одинарными пробелами.
- На arm64-хостах время выполнения не показательно из-за эмуляции.

## Частые ошибки

| Симптом | Причина / решение |
|---|---|
| `sha256sum: ... FAILED` или `No such file or directory` на шаге проверки архива | Архив не скачан, повреждён или не тот — выполните шаг 1 заново |
| `Permission denied` при записи в `/artifacts` (Linux) | Пересоберите с `--build-arg USER_UID=$(id -u) --build-arg USER_GID=$(id -g)` или создайте `artifacts/` до запуска |
| `exec format error` | Эмуляция amd64 недоступна. В Docker Desktop включите «Use Rosetta for x86/amd64 emulation», на Linux установите `qemu-user-static`/binfmt |
| `unexpected ISA string` | Используется не тот toolchain. Внутри образа `which riscv64-unknown-elf-gcc` должен показывать `/opt/riscv/bin/...` |
