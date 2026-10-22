#!/usr/bin/env python3
"""Check a z-design-ux package for forgotten screens, broken flow links and missing states.

Usage: check_package.py <directory-or-markdown-file>

Reads the tables marked with <!-- ux:screens -->, <!-- ux:objects -->,
<!-- ux:flow-steps -->, <!-- ux:sweep --> and <!-- ux:states --> (formats in
references/coverage.md) and the evidence labels, skipping fenced code blocks.
Exits 0 when all checks pass, 1 otherwise. Standard library only.
"""

from __future__ import annotations

import re
import sys
import unicodedata
from pathlib import Path

SCREEN_ID = re.compile(r"\bSC-\d+\b")
STEP_ID = re.compile(r"\bF\d+-\d+\b")
MARKER = re.compile(r"<!--\s*ux:([a-z-]+)\s*-->")
SEPARATOR = re.compile(r"^\|?\s*:?-{3,}:?\s*(\|\s*:?-{3,}:?\s*)*\|?\s*$")
FENCE = re.compile(r"^\s*(```|~~~)")

SWEEP_KEYS = [
    "sign-in", "sign-up", "password reset", "first run", "account settings",
    "account deletion", "data export", "invite and roles", "billing and limits",
    "notifications", "email and message templates", "search results", "help",
    "terms and consent", "not found", "server error", "maintenance", "session expired",
]
STATE_KEYS = ["empty", "loading", "error", "permission", "offline", "conflict", "extreme"]
WEAK_REASONS = {
    "", "n/a", "na", "none", "not needed", "not applicable", "unnecessary", "no", "nothing",
    "same", "tbd", "-", "不要", "なし", "該当なし", "特になし", "対象外", "必要なし", "未定", "同上",
}
MIN_REASON_WIDTH = 10  # ASCII characters count 1, CJK characters count 2
NA_REVIEW_RATIO = 0.4
REPEAT_LIMIT = 4
GUESS_WARN_RATIO = 0.7
REQUIRED = ("screens", "flow-steps", "states", "sweep", "objects")


def strip_fences(text: str) -> list[str]:
    out, inside = [], False
    for line in text.splitlines():
        if FENCE.match(line):
            inside = not inside
            out.append("")
            continue
        out.append("" if inside else line)
    return out


def split_row(line: str) -> list[str]:
    line = line.strip().replace("\\|", "\x00")
    if line.startswith("|"):
        line = line[1:]
    if line.endswith("|"):
        line = line[:-1]
    return [c.strip().replace("\x00", "|") for c in line.split("|")]


def width(text: str) -> int:
    return sum(2 if unicodedata.east_asian_width(ch) in "WF" else 1 for ch in text)


def normalise(text: str) -> str:
    return re.sub(r"[\s.。、,!！?？]+$", "", text.strip().lower())


def reason_problem(cell: str, prefixes=("n/a:",)) -> str | None:
    """Return why a cell is not a decision, or None if it is acceptable."""
    low = cell.strip().lower()
    for prefix in prefixes:
        if low.startswith(prefix):
            reason = cell.strip()[len(prefix):].strip()
            if normalise(reason) in WEAK_REASONS or width(reason) < MIN_REASON_WIDTH:
                return f'reason "{reason}" is too thin; say why it cannot happen or is not needed'
            return None
    if normalise(cell) in WEAK_REASONS:
        return f'"{cell}" is not a decision; write the design or "{prefixes[0]} <reason>"'
    if low.startswith("n/a") or low.startswith("none"):
        return f'"{cell}" needs the form "{prefixes[0]} <reason>"'
    return None


class Report:
    def __init__(self):
        self.errors: list[str] = []
        self.warnings: list[str] = []

    def fail(self, msg: str):
        self.errors.append(msg)


def parse_tables(sources, report: Report):
    """Return {kind: [(file, line_no, header, [(line_no, row)])]} for every marked table."""
    tables: dict[str, list] = {}
    for path, lines in sources:
        i = 0
        while i < len(lines):
            m = MARKER.search(lines[i])
            if not m:
                i += 1
                continue
            kind = m.group(1)
            j = i + 1
            while j < len(lines) and not lines[j].strip():
                j += 1
            block = []
            while j < len(lines) and lines[j].strip().startswith("|"):
                block.append((j + 1, lines[j]))
                j += 1
            where = f"{path}:{i + 1} ux:{kind}"
            if len(block) < 2:
                report.fail(f"{where}: marker is not followed by a table")
            elif not SEPARATOR.match(block[1][1].strip()):
                report.fail(f"{where}: second line is not a header separator (| --- | --- |)")
            else:
                header = split_row(block[0][1])
                rows = []
                for line_no, raw in block[2:]:
                    row = split_row(raw)
                    if len(row) != len(header):
                        report.fail(f"{path}:{line_no} ux:{kind}: row has {len(row)} cells, header has {len(header)}")
                        continue
                    rows.append((line_no, row))
                tables.setdefault(kind, []).append((path, i + 1, header, rows))
            i = max(j, i + 1)
    return tables


def main() -> int:
    if len(sys.argv) != 2:
        print(__doc__.strip())
        return 2
    target = Path(sys.argv[1])
    if not target.exists():
        print(f"error: {target} does not exist")
        return 2
    files = sorted(target.rglob("*.md")) if target.is_dir() else [target]
    sources = [(str(f), strip_fences(f.read_text(encoding="utf-8"))) for f in files]
    report = Report()
    tables = parse_tables(sources, report)

    for kind in REQUIRED:
        if kind not in tables:
            report.fail(f"missing table: no <!-- ux:{kind} --> table (format in references/coverage.md)")

    def rows_of(kind):
        for path, _start, header, rows in tables.get(kind, []):
            for line_no, row in rows:
                yield f"{path}:{line_no}", header, row

    # Screens: ID | Name | Purpose | Primary action | Used by (last column)
    screens: dict[str, str] = {}
    used_by: dict[str, str] = {}
    for where, _h, row in rows_of("screens"):
        ids = SCREEN_ID.findall(row[0])
        if not ids:
            report.fail(f"{where} ux:screens: first cell \"{row[0]}\" is not a screen ID like SC-01")
            continue
        sid = ids[0]
        if sid in screens:
            report.fail(f"{where} ux:screens: {sid} is listed twice (first at {screens[sid]})")
            continue
        screens[sid] = where
        used_by[sid] = row[-1]
    if "screens" in tables and not screens:
        report.fail("ux:screens has no rows")

    def check_screen_refs(where, kind, label, cell) -> list[str]:
        ids = SCREEN_ID.findall(cell)
        for sid in ids:
            if sid not in screens:
                report.fail(f"{where} ux:{kind}: {label} points to {sid}, which is not in ux:screens")
        return ids

    referenced: set[str] = set()

    # Objects: Object | List | Detail | Create / edit
    objects: set[str] = set()
    for where, header, row in rows_of("objects"):
        name = row[0]
        objects.add(normalise(name))
        for col in range(1, min(4, len(row))):
            cell = row[col]
            label = f"{name} / {header[col]}"
            ids = check_screen_refs(where, "objects", label, cell)
            if ids:
                referenced.update(ids)
            elif not cell:
                report.fail(f"{where} ux:objects: {label} is empty; give a screen ID or n/a: reason")
            else:
                problem = reason_problem(cell) or (None if cell.lower().startswith("n/a:") else "write a screen ID or n/a: reason")
                if problem:
                    report.fail(f"{where} ux:objects: {label}: {problem}")

    # Flow steps: Step | Actor | Action | System response | Screen | Failure branches
    steps: set[str] = set()
    step_rows = list(rows_of("flow-steps"))
    for where, header, row in step_rows:
        ids = STEP_ID.findall(row[0])
        if not ids:
            report.fail(f"{where} ux:flow-steps: first cell \"{row[0]}\" is not a step ID like F1-01")
            continue
        steps.add(ids[0])
    if "flow-steps" in tables and not steps:
        report.fail("ux:flow-steps has no rows")
    for where, header, row in step_rows:
        ids = STEP_ID.findall(row[0])
        if not ids:
            continue
        step = ids[0]
        if len(row) < 6:
            report.fail(f"{where} ux:flow-steps: {step} needs 6 columns (Step, Actor, Action, System response, Screen, Failure branches)")
            continue
        sids = check_screen_refs(where, "flow-steps", step, row[4])
        if not sids:
            report.fail(f"{where} ux:flow-steps: {step} has no screen ID in the Screen column (5th)")
        referenced.update(sids)
        failure = row[-1]
        if not failure:
            report.fail(f"{where} ux:flow-steps: {step} has no failure branches; list them or write none: reason")
        else:
            problem = reason_problem(failure, prefixes=("none:", "n/a:"))
            if problem:
                report.fail(f"{where} ux:flow-steps: {step} failure branches: {problem}")

    # Sweep: Item | Decision
    sweep_rows = list(rows_of("sweep"))
    for key in SWEEP_KEYS:
        pattern = re.compile(r"(?<![\w-])" + re.escape(key) + r"(?![\w-])")
        if "sweep" in tables and not any(pattern.search(r[0].lower()) for _w, _h, r in sweep_rows):
            report.fail(f'ux:sweep: no row for "{key}"; add it with a screen ID or n/a: reason')
    for where, _h, row in sweep_rows:
        decision = row[1] if len(row) > 1 else ""
        ids = check_screen_refs(where, "sweep", row[0], decision)
        if ids:
            referenced.update(ids)
        else:
            problem = reason_problem(decision) if decision else "empty decision"
            if not problem and not decision.lower().startswith("n/a:"):
                problem = "write a screen ID or n/a: reason"
            if problem:
                report.fail(f"{where} ux:sweep: {row[0]}: {problem}")

    # Every screen must be reached from a flow step's Screen column, an object cell or a
    # sweep row; the Used-by column is checked only for references that do not exist.
    for sid, where in screens.items():
        used = used_by.get(sid, "")
        for step in STEP_ID.findall(used):
            if step not in steps:
                report.fail(f"{where} ux:screens: {sid} is used by {step}, which is not in ux:flow-steps")
        if sid not in referenced:
            report.fail(f"{where} ux:screens: {sid} is not named by any flow step's Screen column, object or sweep row")

    # States: Screen | empty | loading | error | permission | offline | conflict | extreme | ...
    state_rows: dict[str, str] = {}
    na_cells = total_cells = 0
    na_reasons: dict[str, int] = {}
    for path, start, header, rows in tables.get("states", []):
        lowered = [h.lower() for h in header]
        for key in STATE_KEYS:
            if not any(key in h for h in lowered):
                report.fail(f"{path}:{start} ux:states: no column for \"{key}\" (put the English key in the heading)")
    for where, header, row in rows_of("states"):
        ids = SCREEN_ID.findall(row[0])
        if not ids:
            report.fail(f"{where} ux:states: first cell \"{row[0]}\" is not a screen ID")
            continue
        sid = ids[0]
        if sid not in screens:
            report.fail(f"{where} ux:states: {sid} is not in ux:screens")
        state_rows[sid] = where
        for col in range(1, len(row)):
            cell = row[col]
            label = f"{sid} / {header[col]}"
            total_cells += 1
            if not cell:
                report.fail(f"{where} ux:states: {label} is empty")
                continue
            if cell.lower().startswith("n/a"):
                na_cells += 1
                key = normalise(cell[4:] if cell.lower().startswith("n/a:") else cell)
                na_reasons[key] = na_reasons.get(key, 0) + 1
            problem = reason_problem(cell)
            if problem:
                report.fail(f"{where} ux:states: {label}: {problem}")
    if "states" in tables:
        for sid, where in screens.items():
            if sid not in state_rows:
                report.fail(f"{where} ux:states: {sid} has no row; every screen needs its states")
    for reason, count in sorted(na_reasons.items(), key=lambda kv: -kv[1]):
        if count > REPEAT_LIMIT:
            report.warnings.append(
                f'needs human review: the same n/a reason appears in {count} state cells ("{reason}"); '
                "check that it really holds for each screen"
            )
    if total_cells and na_cells / total_cells > NA_REVIEW_RATIO:
        report.warnings.append(
            f"needs human review: {na_cells}/{total_cells} state cells are n/a "
            f"(over {int(NA_REVIEW_RATIO * 100)}%); check that states were decided, not skipped"
        )

    # Evidence labels (outside code fences)
    text = "\n".join("\n".join(lines) for _p, lines in sources)
    counts = {
        "user": len(re.findall(r"\[user\]", text)),
        "source": len(re.findall(r"\[source:[^\]]*\]", text)),
        "data": len(re.findall(r"\[data:[^\]]*\]", text)),
        "guess": len(re.findall(r"\[guess\]", text)),
    }
    total_labels = sum(counts.values())
    if total_labels == 0:
        report.fail("no evidence labels found; mark claims [user], [source: URL], [data: path] or [guess]")
    for m in re.finditer(r"\[source:([^\]]*)\]", text):
        if "http" not in m.group(1):
            report.warnings.append(f'"[source:{m.group(1)}]" has no URL')
    if total_labels and counts["guess"] / total_labels > GUESS_WARN_RATIO:
        report.warnings.insert(0, (
            f"mostly inference: {counts['guess']}/{total_labels} labels are [guess]; "
            "say so at the top of the package"
        ))

    print(f"screens {len(screens)}, flow steps {len(steps)}, state rows {len(state_rows)}, "
          f"labels user {counts['user']} / source {counts['source']} / data {counts['data']} / guess {counts['guess']}")
    for w in report.warnings:
        print(f"WARNING {w}")
    for e in report.errors:
        print(f"FAIL {e}")
    if report.errors:
        print(f"{len(report.errors)} problem(s). Fix them and run again.")
        return 1
    print("All checks passed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
