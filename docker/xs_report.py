#!/usr/bin/env python3
"""Pack the results of a DRVFuzz diff run into one small feedback archive.

    drvfuzz-xs-report <run-dir> [--log diff.log ...] [--out /artifacts]

Writes <out>/xs_feedback_<UTC time>.tar.gz and a copy of its summary.md next
to it. The archive holds:
  summary.md   environment, XiangShan build info, readiness check result,
               per-run / per-iteration tables, XiangShan emu end states and
               commit-trace statistics, automatic warnings
  vectors/     every iteration's testcase.json, reports and each
               implementation's execution_output.json (the test vectors and
               their results)
  traces/      full program.S/program.dump and implementation logs for a few
               selected iterations (XiangShan not ending in GOOD TRAP first,
               then iterations with differences, then one clean one); large
               logs are cut to head + tail
  check/       /artifacts/xiangshan_check/check.log and the exec report
  logs/        the --log files (diff driver output), cut to head + tail

Works for any implementation pair; the XiangShan statistics appear when an
iteration has a XiangShan/skiptrap.commit.log.
"""
import argparse
import collections
import datetime
import hashlib
import json
import os
import re
import shutil
import socket
import statistics
import subprocess
import tarfile
import tempfile
from pathlib import Path

ANSI = re.compile(r"\x1b\[[0-9;]*m")
# Same patterns as RE_COMMIT / RE_EXCEPTION / RE_MEM_LINE in DRVFuzz/src/impls/xiangshan/execute.rs
RE_COMMIT_ANY = re.compile(r"^\[\d+\] commit pc ")
RE_COMMIT = re.compile(
    r"^\[\d+\] commit pc [0-9a-fA-F]{16} inst [0-9a-fA-F]{8} wen \d+ dst [xXfFvV]\d{1,2} data [0-9a-fA-F]{16} idx [0-9a-fA-F]{3}")
RE_EXCEPTION = re.compile(r"^\[\d+\] exception pc [0-9a-fA-F]{16} inst [0-9a-fA-F]{8} cause [0-9a-fA-F]{16}")
RE_MEM = re.compile(r"^mem pc [0-9a-fA-F]{16} addr [0-9a-fA-F]{16} data [0-9a-fA-F]{16} mask 0x[0-9a-fA-F]{2}$")
# End states printed by difftest emu.cpp
EMU_END = re.compile(r"(HIT GOOD TRAP|HIT BAD TRAP|ABORT|EXCEEDING CYCLE/INSTR LIMIT|SOME SIGNAL STOPS THE PROGRAM|EXIT) at pc = (0x[0-9a-fA-F]+)")
# difftest reports: "<reg> different at pc = ...", "Mismatch for store commits"
RE_MISMATCH = re.compile(r"different at pc|Mismatch for store")
RE_CYCLES = re.compile(r"Guest cycle spent: ([\d,']+)")
RE_HOST_MS = re.compile(r"Host time spent: ([\d,']+)ms")
RE_LOG_PROBLEM = re.compile(r"TimedOut|EmptyTrace|NoPcMapping|panicked|\bERROR\b|\berror\b")


def num(s):
    return int(re.sub(r"[,']", "", s))


def copy_cut(src, dst, max_bytes):
    """Copy src to dst; if larger than max_bytes keep the first 2/3 and the last 1/3."""
    dst.parent.mkdir(parents=True, exist_ok=True)
    size = src.stat().st_size
    if size <= max_bytes:
        shutil.copyfile(src, dst)
        return False
    head, tail = max_bytes * 2 // 3, max_bytes // 3
    with open(src, "rb") as f, open(dst, "wb") as out:
        out.write(f.read(head))
        out.write(f"\n\n[... drvfuzz-xs-report: {size - head - tail} bytes cut, original size {size} ...]\n\n".encode())
        f.seek(size - tail)
        out.write(f.read())
    return True


def run(cmd):
    try:
        return subprocess.run(cmd, capture_output=True, text=True, timeout=30).stdout.strip()
    except (OSError, subprocess.SubprocessError):
        return "n/a"


def xs_trace_stats(log):
    st = {"end": "no end state", "end_pc": "", "commit": 0, "parsed": 0, "exc": 0, "mem": 0,
          "mismatch": 0, "cycles": None, "host_ms": None, "bytes": log.stat().st_size}
    with open(log, errors="replace") as f:
        for raw in f:
            line = ANSI.sub("", raw).strip()
            if RE_COMMIT_ANY.match(line):
                st["commit"] += 1
                st["parsed"] += bool(RE_COMMIT.match(line))
            elif RE_EXCEPTION.match(line):
                st["exc"] += 1
            elif RE_MEM.match(line):
                st["mem"] += 1
            else:
                if m := EMU_END.search(line):
                    st["end"], st["end_pc"] = m.group(1), m.group(2)
                if m := RE_CYCLES.search(line):
                    st["cycles"] = num(m.group(1))
                if m := RE_HOST_MS.search(line):
                    st["host_ms"] = num(m.group(1))
                st["mismatch"] += bool(RE_MISMATCH.search(line))
    return st


def timings(md):
    out = {}
    if md.exists():
        for m in re.finditer(r"^\|\s*([^|]+?)\s*\|\s*([\d.]+)\s*\|", md.read_text(), re.M):
            out[m.group(1)] = float(m.group(2))
    return out


def removal_reports(it):
    """Differences found in this iteration: counts per report kind, tags, classifications."""
    exc = wr = 0
    tags, classes = collections.Counter(), collections.Counter()
    for r in sorted(it.glob("report_*_removal.md")):
        text = r.read_text(errors="replace")
        n = len(re.findall(r"^## Test Instruction", text, re.M))
        if "exception_removal" in r.name:
            exc += n
        else:
            wr += n
        tags.update(re.findall(r"^- Tag: (.+)$", text, re.M))
        classes.update(re.findall(r"^- Classification: (.+)$", text, re.M))
    return exc, wr, tags, classes


def scan(run_dir):
    runs = []
    for rd in sorted(p for p in run_dir.rglob("iter_000") if p.is_dir()):
        rd = rd.parent
        final = (rd / "final_report.md").read_text() if (rd / "final_report.md").exists() else ""
        fr = {k: int(v) for k, v in re.findall(r"^- (.+?): (\d+)$", final, re.M)}
        iters = []
        for it in sorted(rd.glob("iter_*")):
            impls = {}
            for d in sorted(p for p in it.iterdir() if p.is_dir() and (p / "program.S").exists()):
                info = {"output": None}
                eo = d / "execution_output.json"
                if eo.exists():
                    data = json.loads(eo.read_text())
                    info["output"] = {
                        "insts": len(data.get("register_changes", [])),
                        "exceptions": len(data.get("exceptions", [])),
                        "reg": sum(1 for r in data.get("register_changes", []) if r),
                        "mem": sum(1 for m in data.get("memory_changes", []) if m),
                        "causes": collections.Counter(e["cause"] for e in data.get("exceptions", [])),
                    }
                if (d / "skiptrap.commit.log").exists():
                    info["xs"] = xs_trace_stats(d / "skiptrap.commit.log")
                impls[d.name] = info
            exc, wr, tags, classes = removal_reports(it)
            iters.append({"path": it, "impls": impls, "time": timings(it / "execution_timings.md"),
                          "exc_diffs": exc, "write_diffs": wr, "tags": tags, "classes": classes})
        runs.append({"path": rd, "final": fr, "iters": iters})
    return runs


def xs_timeout():
    p = Path("/opt/drvfuzz/DRVFuzz/configs/timeout.toml")
    m = re.search(r"^XiangShan\s*=\s*(\d+)", p.read_text(), re.M) if p.exists() else None
    return int(m.group(1)) if m else None


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("run_dir", type=Path, help="the --run-dir of DRVFuzz diff / diff-testcase")
    ap.add_argument("--log", type=Path, action="append", default=[], help="diff driver output to include (repeatable)")
    ap.add_argument("--check-dir", type=Path, default=Path("/artifacts/xiangshan_check"))
    ap.add_argument("--xs-dir", type=Path, default=Path("/opt/xiangshan"))
    ap.add_argument("--out", type=Path, default=Path("/artifacts"))
    ap.add_argument("--traces", type=int, default=5, help="iterations with full traces (default 5)")
    ap.add_argument("--max-file-mb", type=float, default=4, help="cut larger logs to head+tail (default 4)")
    a = ap.parse_args()
    if not a.run_dir.is_dir():
        ap.error(f"{a.run_dir} is not a directory")
    max_bytes = int(a.max_file_mb * 1024 * 1024)
    stamp = datetime.datetime.now(datetime.timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    name = f"xs_feedback_{stamp}"
    runs = scan(a.run_dir)
    stage = Path(tempfile.mkdtemp(prefix="xs_report_")) / name
    stage.mkdir(parents=True)
    S = []  # summary.md lines
    warn = []

    # --- environment
    S += [f"# DRVFuzz feedback {stamp}", "", "## Environment", "",
          f"- host: {socket.gethostname()}, CPUs: {os.cpu_count()}, "
          f"{next((l.split(':')[1].strip() for l in open('/proc/meminfo') if l.startswith('MemTotal')), 'n/a') if os.path.exists('/proc/meminfo') else 'n/a'} RAM",
          f"- DRVFuzz: `{run(['DRVFuzz', '--version'])}`",
          f"- run dir: `{a.run_dir}`", ""]
    if a.xs_dir.is_dir():
        S += ["## XiangShan build", ""]
        bi = a.xs_dir / "BUILD_INFO.txt"
        S += ["```", bi.read_text().strip() if bi.exists() else "BUILD_INFO.txt not found", "```", ""]
        for f in sorted(p for p in a.xs_dir.iterdir() if p.is_file()):
            S.append(f"- `{f.name}` sha256 `{hashlib.sha256(f.read_bytes()).hexdigest()}`")
        S.append("")

    # --- readiness check
    if (a.check_dir / "check.log").exists():
        log = ANSI.sub("", (a.check_dir / "check.log").read_text(errors="replace"))
        verdict = next((l for l in reversed(log.splitlines()) if l.startswith(("PASS", "FAIL"))), "no PASS/FAIL line")
        S += ["## drvfuzz-check-xiangshan", "", f"- result: **{verdict}**", ""]
        if not verdict.startswith("PASS"):
            warn.append(f"readiness check did not pass: {verdict}")
        for f in ("check.log", "exec_execution_report.md"):
            if (a.check_dir / f).exists():
                copy_cut(a.check_dir / f, stage / "check" / f, max_bytes)

    # --- runs and iterations
    S += ["## Runs", "", "| run | iterations | initial insts | final insts | exception-diff rounds | write-diff rounds |",
          "|---|---|---|---|---|---|"]
    for r in runs:
        f = r["final"]
        S.append(f"| `{r['path'].name}` | {len(r['iters'])} | {f.get('Initial test instruction count', '?')} | "
                 f"{f.get('Final test instruction count', '?')} | {f.get('Exception-difference removal rounds', '?')} | "
                 f"{f.get('Write-difference removal rounds', '?')} |")
        if not f:
            warn.append(f"{r['path'].name}: no final_report.md (run interrupted or failed)")
    if not runs:
        warn.append("no iterations found under the run dir")
    S += ["", "## Iterations", "",
          "| iteration | impl | time, s | insts | exceptions | insts with reg writes | insts with mem writes | exception diffs | write diffs |",
          "|---|---|---|---|---|---|---|---|---|"]
    tags, classes, causes = collections.Counter(), collections.Counter(), collections.defaultdict(collections.Counter)
    xs_rows, xs_times, missing = [], [], []
    for r in runs:
        for it in r["iters"]:
            rel = it["path"].relative_to(a.run_dir)
            tags.update(it["tags"]); classes.update(it["classes"])
            for impl, info in it["impls"].items():
                o = info["output"]
                if o is None:
                    missing.append(f"{rel}/{impl}")
                    S.append(f"| `{rel}` | {impl} | {it['time'].get(impl, '-')} | no execution_output.json | | | | | |")
                else:
                    causes[impl].update(o["causes"])
                    S.append(f"| `{rel}` | {impl} | {it['time'].get(impl, '-')} | {o['insts']} | {o['exceptions']} | "
                             f"{o['reg']} | {o['mem']} | {it['exc_diffs']} | {it['write_diffs']} |")
                if "xs" in info:
                    xs_rows.append((rel, info["xs"]))
                    if impl in it["time"]:
                        xs_times.append(it["time"][impl])
    if missing:
        warn.append(f"{len(missing)} implementation runs without execution_output.json: " + ", ".join(missing[:5]))
    S += ["", "Exception causes per implementation: " +
          "; ".join(f"{i}: " + ", ".join(f"{c}×{n}" for c, n in sorted(cs.items())) for i, cs in causes.items()), ""]
    if tags or classes:
        S += ["Write-difference tags: " + ", ".join(f"{t} ×{n}" for t, n in tags.most_common()),
              "", "Write-difference classifications: " + ", ".join(f"{t} ×{n}" for t, n in classes.most_common()), ""]
    with_diffs = sum(1 for r in runs if r["final"].get("Exception-difference removal rounds", 0)
                     or r["final"].get("Write-difference removal rounds", 0))
    S.append(f"Runs with differences: {with_diffs} of {len(runs)}")
    S.append("")

    # --- XiangShan
    S += ["## XiangShan emu", ""]
    if not xs_rows:
        S += ["No iteration with XiangShan/skiptrap.commit.log.", ""]
    else:
        ends = collections.Counter(st["end"] for _, st in xs_rows)
        commit = sum(st["commit"] for _, st in xs_rows)
        parsed = sum(st["parsed"] for _, st in xs_rows)
        no_mem = [str(rel) for rel, st in xs_rows if st["mem"] == 0]
        to = xs_timeout()
        S += [f"- end states: " + ", ".join(f"{k} ×{v}" for k, v in ends.most_common()),
              f"- commit lines parsed by DRVFuzz: {parsed} of {commit}",
              f"- iterations without `mem pc` store lines: {len(no_mem)} of {len(xs_rows)}",
              f"- XiangShan time per iteration, s: median {statistics.median(xs_times):.1f}, max {max(xs_times):.1f}"
              f" (timeout {to})" if xs_times else "- XiangShan time per iteration: n/a", "",
              "| iteration | end state | commit lines | parsed | exception lines | store lines | mismatch lines | guest cycles | host ms | log MB |",
              "|---|---|---|---|---|---|---|---|---|---|"]
        for rel, st in xs_rows:
            S.append(f"| `{rel}` | {st['end']} {st['end_pc']} | {st['commit']} | {st['parsed']} | {st['exc']} | {st['mem']} | "
                     f"{st['mismatch']} | {st['cycles'] if st['cycles'] is not None else '-'} | "
                     f"{st['host_ms'] if st['host_ms'] is not None else '-'} | {st['bytes'] / 2**20:.1f} |")
        S.append("")
        if set(ends) != {"HIT GOOD TRAP"}:
            warn.append("XiangShan emu did not end with HIT GOOD TRAP in every iteration: " +
                        ", ".join(f"{k} ×{v}" for k, v in ends.items() if k != "HIT GOOD TRAP"))
        if parsed < commit:
            warn.append(f"only {parsed} of {commit} commit lines have the format DRVFuzz parses (difftest patch missing?)")
        if no_mem:
            warn.append(f"{len(no_mem)} XiangShan iterations without store lines: " + ", ".join(no_mem[:5]))
        if to and xs_times and max(xs_times) > 0.8 * to:
            warn.append(f"XiangShan time per iteration reaches {max(xs_times):.0f}s of the {to}s timeout")
    if runs and with_diffs > len(runs) / 2:
        warn.append(f"differences in {with_diffs} of {len(runs)} runs: check for setup problems before treating them as core bugs")

    # --- driver logs
    if a.log:
        S += ["## Driver logs", ""]
        for lg in a.log:
            if not lg.exists():
                warn.append(f"log {lg} not found")
                continue
            probs = collections.Counter()
            examples = []
            with open(lg, errors="replace") as f:
                for line in f:
                    if m := RE_LOG_PROBLEM.search(line):
                        probs[m.group(0)] += 1
                        if len(examples) < 10:
                            examples.append(ANSI.sub("", line.strip())[:300])
            S += [f"- `{lg}`: " + (", ".join(f"{k} ×{v}" for k, v in probs.items()) or "no problem lines")]
            if examples:
                S += ["  ```"] + [f"  {e}" for e in examples] + ["  ```"]
                warn.append(f"{lg.name}: problem lines " + ", ".join(f"{k} ×{v}" for k, v in probs.items()))
            copy_cut(lg, stage / "logs" / lg.name, max_bytes)
        S.append("")

    # --- vectors: every iteration's testcase, reports and outputs
    for r in runs:
        for f in r["path"].glob("*.md"):
            dst = stage / "vectors" / f.relative_to(a.run_dir)
            dst.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(f, dst)
        for it in r["iters"]:
            files = [it["path"] / "testcase.json", *it["path"].glob("*.md")]
            for impl in it["impls"]:
                files += [it["path"] / impl / "execution_output.json", it["path"] / impl / "execution_report.md"]
            for f in files:
                if f.exists():
                    copy_cut(f, stage / "vectors" / f.relative_to(a.run_dir), max_bytes)

    # --- traces for selected iterations
    def priority(it):
        xs = [i["xs"] for i in it["impls"].values() if "xs" in i]
        if any(x["end"] != "HIT GOOD TRAP" for x in xs) or any(i["output"] is None for i in it["impls"].values()):
            return 0
        return 1 if it["exc_diffs"] or it["write_diffs"] else 2
    all_iters = [it for r in runs for it in r["iters"]]
    chosen = sorted(all_iters, key=priority)[:a.traces]
    if all_iters and not any(priority(it) == 2 for it in chosen):  # keep one clean iteration for reference
        clean = next((it for it in all_iters if priority(it) == 2), None)
        if clean:
            chosen = chosen[:max(a.traces - 1, 0)] + [clean]
    cut_any = False
    for it in chosen:
        for impl in it["impls"]:
            d = it["path"] / impl
            for f in [d / "program.S", d / "program.dump", *d.glob("*.log")]:
                if f.exists():
                    cut_any |= copy_cut(f, stage / "traces" / f.relative_to(a.run_dir), max_bytes)
    S += ["## Archive contents", "",
          "- `vectors/`: testcase.json, reports and execution_output.json of every iteration",
          f"- `traces/`: program and logs of {len(chosen)} iterations: " +
          ", ".join(f"`{it['path'].relative_to(a.run_dir)}`" for it in chosen) +
          (f" (files over {a.max_file_mb} MB cut to head + tail)" if cut_any else ""), ""]

    warn_lines = ["## Warnings", ""] + ([f"- ⚠️ {w}" for w in warn] or ["- none"]) + [""]
    S[2:2] = warn_lines  # right after the title
    (stage / "summary.md").write_text("\n".join(S) + "\n")

    a.out.mkdir(parents=True, exist_ok=True)
    archive = a.out / f"{name}.tar.gz"
    with tarfile.open(archive, "w:gz") as tar:
        tar.add(stage, arcname=name)
    shutil.copyfile(stage / "summary.md", a.out / f"{name}.summary.md")
    shutil.rmtree(stage.parent)
    print("\n".join(warn_lines))
    print(f"archive: {archive} ({archive.stat().st_size / 2**20:.1f} MB)")
    print(f"summary: {a.out / (name + '.summary.md')}")


if __name__ == "__main__":
    main()
