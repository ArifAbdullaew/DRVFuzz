# DRVFuzz + XiangShan на сервере без интернета

Инструкция для запуска DRVFuzz на XiangShan на сервере в закрытом контуре и
возврата результатов на проверку. Фон и ограничения описаны в
[README.md](README.md), раздел «XiangShan».

Схема такая:

1. Снаружи, на машине с интернетом, готовим всё, что требует загрузок.
2. Переносим архивы в контур.
3. На сервере собираем `emu`, проверяем готовность и запускаем ограниченный
   фаззинг.
4. Командой `drvfuzz-xs-report` собираем один архив с результатами и
   отправляем его обратно.

> На сервере в любом случае получится честный отказ, а не ложный успех.
> Каждая команда останавливается на первой ошибке и называет причину. Для
> разбора нам хватит её вывода или файла `*.summary.md`.

---

## 0. Что узнать о сервере заранее

| Что | Зачем | Как |
|---|---|---|
| Архитектура `x86_64` | образ DRVFuzz и `emu` собираются под amd64 | `uname -m` |
| ОЗУ и ядра | `DRVFuzzDefaultConfig` требует около 128 ГБ, `DRVFuzzMinimalConfig` меньше | `free -g`, `nproc` |
| Docker с BuildKit и Compose v2 | всё запускается через `docker compose` | `docker version`, `docker compose version` |
| UID/GID пользователя, от которого будет запуск | контейнер пишет в `artifacts/` от этого UID | `id -u`, `id -g` |
| Свободное место | архивы и сборка XiangShan — десятки ГБ | `df -h` |

---

## 1. Снаружи: подготовка (нужен интернет, x86-64, Docker)

Все команды выполняются из корня репозитория.

### 1.1. Образ DRVFuzz

Архив wrappers `release_assets/riscv_impls_bins_binaries.tar.gz` должен быть на
месте (см. [README.md](README.md), шаг 1). В `--build-arg` подставьте
UID/GID **серверного** пользователя:

```bash
docker compose build --build-arg USER_UID=<uid> --build-arg USER_GID=<gid>
docker save drvfuzz:local | gzip > drvfuzz-image.tar.gz
```

### 1.2. Окружение и исходники XiangShan

```bash
export XS_DIR=$PWD/xs-out
docker/xiangshan/build_emu.sh $PWD/xiangshan-build 2>&1 | tail -20
```

`build_emu.sh` собирает Docker-образ `xs-env` и клонирует XiangShan со всеми
сабмодулями, затем запускает `make emu`. Во время сборки mill скачивает
зависимости Scala в `xiangshan-build/XiangShan/.home`.

- **Если машине хватает памяти и сборка дошла до конца:** готовый `emu` уже
  лежит в `xs-out/`. Его можно перенести как есть и пропустить шаг 3.1 на
  сервере: в difftest-сборке нет `-march=native`. Собирать на целевом сервере
  всё равно надёжнее.
- **Если памяти не хватает:** дождитесь, когда в
  `xiangshan-build/build_emu.log` начнётся компиляция Verilator. К этому
  моменту все загрузки уже позади. Падение после этого по памяти — нормально.

Затем **проверьте, что сборка пойдёт без сети.** Тот же сценарий в
офлайн-режиме ничего не скачивает, а сборку запускает с `--network none`:

```bash
XS_OFFLINE=1 docker/xiangshan/build_emu.sh $PWD/xiangshan-build
```

Если сборка дошла до Verilator (дальше можно прервать по Ctrl+C) или до конца,
контур её не остановит. Если упала на загрузке, в логе будет понятно, что
пыталось скачаться. Тогда нужно снова запустить онлайн-сборку, чтобы этот шаг
прошёл.

### 1.3. Упаковка

```bash
docker save drvfuzz-xs-env:7507284549cc | gzip > xs-env-image.tar.gz
tar -czf xiangshan-build.tar.gz xiangshan-build
git bundle create drvfuzz-repo.bundle --all       # или архив рабочей копии
# если emu собран снаружи:
tar -czf xs-out.tar.gz xs-out
sha256sum *.tar.gz *.bundle > SHA256SUMS
```

Переносим: `drvfuzz-image.tar.gz`, `xs-env-image.tar.gz`,
`xiangshan-build.tar.gz` (или `xs-out.tar.gz`), репозиторий и `SHA256SUMS`.

Незакоммиченные изменения в `git bundle` не попадут. Перед упаковкой
убедитесь, что файлы `docker/`, `Dockerfile`, `docker-compose*.yml`
закоммичены.

---

## 2. На сервере: загрузка

```bash
sha256sum -c SHA256SUMS
docker load < drvfuzz-image.tar.gz
docker load < xs-env-image.tar.gz
git clone drvfuzz-repo.bundle DRVFuzz && cd DRVFuzz      # или распаковать архив
tar -xzf /path/to/xiangshan-build.tar.gz -C /data        # -> /data/xiangshan-build
mkdir -p artifacts/logs
docker image ls | grep -E 'drvfuzz:local|drvfuzz-xs-env'
```

`docker compose run` использует уже загруженный `drvfuzz:local` и ничего не
пересобирает.

Проверка самого DRVFuzz (Spike и Rocket):

```bash
docker compose run --rm drvfuzz drvfuzz-run-tests smoke
```

---

## 3. На сервере: сборка `emu`, проверка, фаззинг

Долгие команды запускайте в `tmux`/`screen` или через `nohup`.

### 3.1. Сборка `emu` (часы)

```bash
export XS_DIR=/data/xs
XS_OFFLINE=1 JOBS=$(nproc) EMU_THREADS=8 docker/xiangshan/build_emu.sh /data/xiangshan-build
cat $XS_DIR/BUILD_INFO.txt
```

Для первой пробы можно задать `XS_CONFIG=DRVFuzzMinimalConfig`: так быстрее и
требуется меньше памяти. Лог сборки — `/data/xiangshan-build/build_emu.log`.

### 3.2. Готовность (минуты)

```bash
export XS_DIR=/data/xs
XS="docker compose -f docker-compose.yml -f docker-compose.xiangshan.yml"
$XS run --rm drvfuzz drvfuzz-check-xiangshan --diff 3
```

Последняя строка должна быть `PASS: XiangShan is usable from DRVFuzz`.
Главный шаг — 4: строка `XiangShan == Spike` означает, что патч difftest,
трасса и разбор работают на настоящем ядре. При `FAIL` дальше не идите:
сразу переходите к шагу 4 и отправьте отчёт.

### 3.3. Ограниченный фаззинг

```bash
$XS run --rm -e RUST_LOG=info drvfuzz bash -c '
  DRVFuzz diff --testcase-config configs/rv64_unligned.toml --riscv-impl spike,xiang-shan \
    --run-dir /artifacts/diff_spike_xiangshan \
    --impl-timeout configs/timeout.toml --run-options configs/run_options.toml \
    --concurrency 4 --max-runs 20 2>&1 | tee /artifacts/logs/xs_diff.log'
```

- Используйте только `configs/rv64_unligned.toml`. С `rv64.toml` DRVFuzz
  завершится ошибкой `RISCV_WRAPPER_XS_EMU_NO_UNALIGNED_RW`: варианта XiangShan
  без невыровненного доступа нет.
- `--concurrency` × `EMU_THREADS` не должно превышать числа ядер.
- Таймаут XiangShan по умолчанию — 120 с на запуск (`configs/timeout.toml`).
  Если в отчёте будут таймауты, подставьте свой файл, не пересобирая образ:

  ```bash
  printf '[impl_timeout_secs]\nSpike = 10\nXiangShan = 600\n' > /data/timeout.toml
  $XS run --rm -v /data/timeout.toml:/tmp/timeout.toml:ro drvfuzz ... --impl-timeout /tmp/timeout.toml ...
  ```

- Без `--max-runs` фаззинг идёт бесконечно. Для первой отчётности хватит 20.

---

## 4. Отчёт для отправки

```bash
$XS run --rm drvfuzz drvfuzz-xs-report /artifacts/diff_spike_xiangshan --log /artifacts/logs/xs_diff.log
```

Команда создаёт в `artifacts/` два файла:

- `xs_feedback_<время>.tar.gz` — архив, обычно единицы МБ;
- `xs_feedback_<время>.summary.md` — его сводка.

Если до фаззинга дело не дошло, всё равно запустите команду на пустом
каталоге (`mkdir -p artifacts/empty`, затем `drvfuzz-xs-report /artifacts/empty`).
В сводку попадут данные сборки и результат `drvfuzz-check-xiangshan`.

### Что отправить обратно

| Если можно передать | Отправить |
|---|---|
| только текст | содержимое `xs_feedback_*.summary.md` |
| файлы | `xs_feedback_*.tar.gz` |
| сборка `emu` не удалась | `BUILD_INFO.txt` (если есть) и последние 200 строк `build_emu.log` |

Внутри архива только текст и JSON:

- `summary.md`;
- `vectors/` — тестовые векторы (`testcase.json`) и результаты каждого ядра
  (`execution_output.json`) по каждой итерации;
- `traces/` — программы и логи нескольких выбранных итераций; длинные логи
  обрезаны до начала и конца;
- `check/` — лог `drvfuzz-check-xiangshan`;
- `logs/` — вывод драйвера `diff`.

Данные — сгенерированные ассемблерные программы и значения регистров и памяти.

---

## 5. Как читать `summary.md`

В начале сводки есть блок **Warnings**, в нём собраны автоматические
проверки.

| Предупреждение | Что значит | Что делать |
|---|---|---|
| `readiness check did not pass` | `drvfuzz-check-xiangshan` упал | причина в той же строке; см. таблицу ниже |
| `did not end with HIT GOOD TRAP … ABORT` | `emu` остановился на расхождении с эталонной моделью внутри difftest | единичные случаи — кандидаты на настоящие расхождения, их трассы лежат в `traces/` |
| `… EXCEEDING CYCLE/INSTR LIMIT` / `no end state` | программа зависла или `emu` убит по таймауту | увеличить таймаут (шаг 3.3) |
| `only N of M commit lines have the format DRVFuzz parses` | `emu` собран без патча difftest | пересобрать через `build_emu.sh` |
| `iterations without store lines` | в трассе нет строк `mem pc` | если таких итераций много — проблема с патчем; если единицы — в программе мог не исполниться ни один store |
| `time per iteration reaches …s of the …s timeout` | XiangShan не успевает | увеличить таймаут |
| `differences in N of M runs` | расхождения со Spike в большинстве прогонов | сначала искать проблему настройки, а не ошибки ядра (см. README, «Оставшиеся риски») |
| `implementation runs without execution_output.json` | запуск ядра упал | смотреть `logs/xs_diff.log` |

Признаки корректного прогона:

- почти везде `HIT GOOD TRAP`;
- все строки `commit` разобраны;
- строки `mem pc` есть почти в каждой итерации;
- время итерации заметно ниже таймаута;
- расхождения со Spike — в меньшинстве итераций.

## 6. Частые ошибки

| Симптом | Причина / решение |
|---|---|
| `offline: image … is missing` | не выполнен `docker load < xs-env-image.tar.gz` |
| `offline: … is missing, prepare WORK_DIR` / `uninitialized submodules` | `xiangshan-build` перенесён не полностью — повторить шаг 1.2–1.3 |
| сборка в контуре пытается что-то скачать | снаружи не был выполнен прогон с `XS_OFFLINE=1` (шаг 1.2) |
| `difftest is at …, expected ecdf41e…` | `xiangshan-build` от другой ревизии — пересоздать по шагу 1.2 |
| `sha256sum: … FAILED` для эталонной модели (`riscv64-nemu-interpreter-so` / `riscv64-spike-so`) | повреждён `ready-to-run` в `xiangshan-build` |
| `emu end state: ABORT` после 1–2 commit на `pc 0x10000000` (например, `tinfo different`) | эталонная модель расходится с XiangShan в CSR; поставить NEMU: `XS_SKIP_BUILD=1 XS_REF=nemu docker/xiangshan/build_emu.sh …` |
| `RISCV_WRAPPER_XS_EMU is not set` | не задан `XS_DIR` или не указан `-f docker-compose.xiangshan.yml` |
| `unresolved libraries for …` | `emu` собран в окружении, отличном от образа; собирать через `build_emu.sh` (xs-env на Ubuntu 24.04) |
| `Permission denied` при записи в `/artifacts` | UID в образе не совпадает с серверным — пересобрать образ по шагу 1.1 с правильным `USER_UID` |
| Docker пытается скачать `ubuntu:24.04` | вызвана сборка (`docker compose build` или `--build`) — в контуре её не запускать |
