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
| Прочее | `device-tree-compiler` (нужен Spike), `python3` (для `drvfuzz-check-xiangshan`), runtime-библиотеки из README |

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
- [`check_xiangshan.sh`](check_xiangshan.sh) — команда
  `drvfuzz-check-xiangshan` (см. «XiangShan»).
- [`docker-compose.xiangshan.yml`](../docker-compose.xiangshan.yml) —
  монтирует `$XS_DIR` в `/opt/xiangshan` (read-only).
- [`xiangshan/difftest-drvfuzz-commit-trace.patch`](xiangshan/difftest-drvfuzz-commit-trace.patch)
  — патч difftest под формат трассы DRVFuzz.
- [`xiangshan/build_emu.sh`](xiangshan/build_emu.sh) — сборка `emu` с патчем
  на сервере.
- [`xs_report.py`](xs_report.py) — команда `drvfuzz-xs-report`: собирает
  результаты прогона в один архив для отправки.
- [`XIANGSHAN_SERVER.md`](XIANGSHAN_SERVER.md) — запуск на сервере без
  интернета и возврат результатов.

## XiangShan

> Пошаговая инструкция для сервера без интернета, включая отправку результатов
> обратно: [XIANGSHAN_SERVER.md](XIANGSHAN_SERVER.md).

XiangShan не входит в release-архив. Его симулятор (`emu`, Verilator) нужно
собрать самостоятельно на сервере: по README XiangShan конфигурации
`DefaultConfig` нужно около 128 ГБ ОЗУ. Образ DRVFuzz подключает готовый `emu`
с хоста через [`docker-compose.xiangshan.yml`](../docker-compose.xiangshan.yml).

### Что DRVFuzz ожидает от XiangShan

Из `DRVFuzz/src/impls/xiangshan/execute.rs`:

```
$RISCV_WRAPPER_XS_EMU -i program.elf --diff $RISCV_WRAPPER_XS_DIFF_SO --dump-commit-trace
```

Вывод `emu` (stdout+stderr) сохраняется в `skiptrap.commit.log` и разбирается
построчно. Нужны строки `commit` с префиксом регистра (`dst x08`), строки
`exception` и данные о записях в память.

### Патч difftest

Штатный `OpenXiangShan/difftest` печатает `dst 08` без префикса и не выводит
store. С таким `emu` DRVFuzz не увидит ни одной записи в регистры или память.
Это проверено по всей истории difftest; патч авторов DRVFuzz не опубликован.
Поэтому в репозитории есть свой патч:
[`xiangshan/difftest-drvfuzz-commit-trace.patch`](xiangshan/difftest-drvfuzz-commit-trace.patch)
(3 файла, +28/−15).

- `InstrTrace` печатает `dst x01` / `dst f03` / `dst v01`. Тип регистра берётся
  из `rfwen`/`fpwen`/`vecwen`, которые раньше сливались в один `wen`.
- При получении store-события от DUT (`StoreRecorder`) печатается строка
  `mem pc <pc> addr <addr> data <data> mask 0x<mask>`. DRVFuzz умеет её разбирать
  (`RE_MEM_LINE`). Событие XiangShan отправляет, когда store уходит из store queue
  в `Sbuffer`, то есть вскоре после коммита инструкции, а не при вытеснении в кэш.
- Сравнение с reference-моделью не меняется. Строки печатаются только при
  `--dump-commit-trace`.

Пример вывода пропатченного кода и как его разбирает парсер DRVFuzz:

```
[00] commit pc 0000000080000010 inst 00100093 wen 1 dst x01 data 0000000000000001 idx 001
[01] commit pc 0000000080000014 inst f20001d3 wen 1 dst f03 data 4008000000000000 idx 002
[02] commit pc 0000000080000018 inst 00313023 wen 0 dst x00 data 0000000000000000 idx 003 (05)
mem pc 0000000080000018 addr 0000000080001000 data 0000000000000003 mask 0xff
[05] exception pc 0000000080000024 inst 00000000 cause 0000000000000002
→ x1=0x1, f3=0x4008000000000000, байты 0x80001000..07 = 03 00 …, exception cause 0x2
```

### Невыровненный доступ: только `rv64_unligned.toml`

DRVFuzz ищет два `emu`. `RISCV_WRAPPER_XS_EMU` используется при
`--allow-unaligned` или `unaligned_access_required = true`. Во всех остальных
случаях, включая `configs/rv64.toml`, используется
`RISCV_WRAPPER_XS_EMU_NO_UNALIGNED_RW`, и Spike там запускается без
`--misaligned`, то есть невыровненный доступ даёт исключение.

В текущем XiangShan (`kunminghu-v3`) невыровненные load/store всегда
обрабатываются аппаратно. Параметры `EnableHardware{Load,Store}Misalign` и биты
CSR `smblockctl` `HD_MISALIGN_*` до конвейера памяти не доходят. Собрать
«no unaligned» вариант флагом нельзя.

Это существенно. В сохранённом прогоне Spike/Rocket на `rv64.toml` исключения
misaligned (`0x4`/`0x6`) встретились в 12 из 13 тестов. XiangShan
расходился бы со Spike почти в каждом тесте. Поэтому:

- сценарий сборки делает только `xiangshan_rv64`;
- фаззинг XiangShan запускайте с `configs/rv64_unligned.toml` (Spike там с
  `--misaligned`);
- с `configs/rv64.toml` DRVFuzz завершится ошибкой
  `EnvVarNotSet { var: "RISCV_WRAPPER_XS_EMU_NO_UNALIGNED_RW" }` вместо ложных
  расхождений.

### Сборка `emu` на сервере

Нужен сервер x86-64 с git и Docker; образ DRVFuzz тоже amd64.

```bash
export XS_DIR=/data/xs              # куда положить emu и reference .so
docker/xiangshan/build_emu.sh /data/xiangshan-build
# для пробы быстрее и с меньшим объёмом памяти:
# XS_CONFIG=MinimalConfig docker/xiangshan/build_emu.sh /data/xiangshan-build
```

[`xiangshan/build_emu.sh`](xiangshan/build_emu.sh) делает следующее:

1. Собирает Docker-образ из официального `OpenXiangShan/xs-env` (коммит
   `7507284`): Ubuntu 24.04, Verilator v5.052, JDK 21, mill, clang 19.
   `XS_NATIVE=1` — собирать инструментами, уже установленными на хосте.
2. Клонирует XiangShan `kunminghu-v3` на коммите `182b227` и выполняет
   `make init`. Затем проверяет, что difftest стоит на `ecdf41e`.
3. Применяет патч к `difftest`. При повторном запуске уже применённый патч
   пропускается.
4. Выполняет `make emu CONFIG=$XS_CONFIG EMU_THREADS=$EMU_THREADS -j$JOBS`
   (по умолчанию `DefaultConfig`, 8, 16) в контейнере xs-env, без root.
5. Кладёт в `$XS_DIR` файлы `xiangshan_rv64` и `xiangshan_rv64_ref_spike_so`.
   Второй — это `ready-to-run/riscv64-spike-so`, SHA-256 проверяется. Туда же
   пишется `BUILD_INFO.txt`. Лог сборки — `<WORK_DIR>/build_emu.log`.

Учтите, что `xs-env` сам скачивает GraalVM JDK (`latest`) и исходники Verilator
без проверки контрольных сумм. Это решение upstream.

### Проверка на сервере

```bash
export XS_DIR=/data/xs
docker compose -f docker-compose.yml -f docker-compose.xiangshan.yml run --rm drvfuzz drvfuzz-check-xiangshan
# если прошло — короткий diff Spike vs XiangShan:
docker compose -f docker-compose.yml -f docker-compose.xiangshan.yml run --rm drvfuzz drvfuzz-check-xiangshan --diff 1
```

`drvfuzz-check-xiangshan` останавливается на первой ошибке и называет причину:

1. файлы на месте и исполняемые, `ldd` без `not found`;
2. `emu --help` знает `-i`, `--diff`, `--dump-commit-trace`;
3. `DRVFuzz generate --riscv-impl xiang-shan` работает;
4. программа (`lui/slli/addi/add/sd/ld` и невыровненный `ld`) прогоняется через
   `exec --allow-unaligned` на XiangShan:
   - трасса в нужном формате, есть строки `mem pc`; если `emu` собран без патча,
     скрипт так и скажет;
   - `exceptions`, `register_changes` и `memory_changes` **совпадают со Spike**
     для той же программы;
5. то же без `--allow-unaligned`, только если есть `xiangshan_rv64_no_unaligned_rw`;
6. с `--diff N`: `diff spike,xiang-shan` на `configs/rv64_unligned.toml`,
   `--max-runs N`.

Результаты сохраняются в `artifacts/xiangshan_check/`. Таймаут одного `exec`
задаётся через `XS_TIMEOUT_SECS` (по умолчанию 600). Таймаут XiangShan внутри
`diff` задаётся в `configs/timeout.toml` (`XiangShan = 120`); для
`DefaultConfig` его может понадобиться увеличить.

Затем можно запустить ограниченный фаззинг. На Linux-сервере файловая
система чувствительна к регистру, поэтому `--run-dir` можно указывать прямо в
`/artifacts`; проблема `program.S`/`program.s` возникает только на macOS.

```bash
docker compose -f docker-compose.yml -f docker-compose.xiangshan.yml run --rm drvfuzz \
  DRVFuzz diff --testcase-config configs/rv64_unligned.toml --riscv-impl spike,xiang-shan \
    --run-dir /artifacts/diff_spike_xiangshan --impl-timeout configs/timeout.toml \
    --run-options configs/run_options.toml --concurrency 8 --max-runs 100
```

### Что проверено, а что нет

| Проверка | Результат |
|---|---|
| Код печати из пропатченного `diffstate.h`/`diffstate.cpp` (difftest `ecdf41e` и HEAD `56a632a`), вывод разобран настоящими функциями `parse_xs_commit_trace*` из DRVFuzz | ✅ регистры x/f, побайтовые записи в память (включая маску `0x0c`), исключения |
| Патч в настоящем дереве XiangShan `182b227` (difftest `ecdf41e`) | ✅ применяется, повторный запуск пропускает |
| `ready-to-run` в том же дереве | ✅ `4cf9983`, SHA-256 `riscv64-spike-so` совпадает |
| Тестовая программа шага 4 на Spike | ✅ без `--allow-unaligned` даёт исключение `0x4`, с ним `x6 = 0` |
| `generate`, монтирование, переменные, понятная ошибка без `emu` | ✅ (логи `10_*`–`14_*`) |
| Компиляция `instructions.cpp`/`store.cpp` с патчем | ⚠️ не проверялась: нужны заголовки, которые генерирует Chisel. Изменения там — передача одного аргумента и замена вызова |
| `build_emu.sh` целиком, `make emu`, запуск настоящего `emu` | ❌ не выполнялось: нужен сервер |

Оставшиеся риски, которые выявит шаг 4 или `--diff`:

- **Слияние инструкций.** XiangShan коммитит пару слитых инструкций одной
  записью (`nFused`), и запись регистра относится к PC первой из них. Если
  DRVFuzz сгенерирует такую пару, возможны ложные расхождения.
- **Последние store'ы.** Store попадает в лог при переходе в `Sbuffer`. Шаблон
  DRVFuzz ставит перед good trap несколько инструкций паддинга, но потерю
  последнего store до выхода `emu` здесь проверить нельзя.
- **Расхождение DUT и REF.** Штатный difftest останавливает `emu` на первом
  расхождении с REF. Трасса до этой точки сохраняется, и DRVFuzz покажет
  расхождение со Spike на следующих инструкциях.

Логи: `artifacts/logs/15_xiangshan_difftest_patch_format_test.log`, пример
трассы — `artifacts/xiangshan_patch/sample_commit_trace.log`.

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
