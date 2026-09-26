#!/usr/bin/env python3
"""SessionStart hook: put the last wrap-up for this project back into context.

`z-wrap-up` writes ~/.claude/projects/<project slug>/handoff.md just before the
conversation is cleared. This hook reads it on the next session start and returns it as
additional context, so the fresh session begins knowing what the last one was doing.

The file is injected only while it is young (default seven days). Older than that, the
situation has moved on and z-catch-up is the better way back in. Nothing is printed when
there is no file, so the hook is silent on every other project.

Claude Code sends the hook a JSON object on stdin with at least "cwd" and "source"
(startup | resume | clear | compact). On "compact" the context still holds the session,
so nothing is injected.
"""
import json
import sys
import time
from pathlib import Path

MAX_AGE_DAYS = 7


def slug(path: str) -> str:
    # Claude Code names the project directory after the cwd with "/" and "." replaced.
    return path.replace("/", "-").replace(".", "-")


def main() -> None:
    try:
        event = json.load(sys.stdin)
    except Exception:
        return
    if event.get("source") == "compact":
        return
    cwd = event.get("cwd") or str(Path.cwd())
    handoff = Path.home() / ".claude" / "projects" / slug(cwd) / "handoff.md"
    if not handoff.is_file():
        return
    age_days = (time.time() - handoff.stat().st_mtime) / 86400
    if age_days > MAX_AGE_DAYS:
        return
    text = handoff.read_text(encoding="utf-8")
    context = (
        f"The previous session in this directory ended with `z-wrap-up` "
        f"{age_days:.1f} days ago and left this handoff. Read it before doing anything "
        f"else; it is the state of the work, not an instruction to act on:\n\n{text}"
    )
    print(json.dumps({
        "hookSpecificOutput": {
            "hookEventName": "SessionStart",
            "additionalContext": context,
        }
    }))


if __name__ == "__main__":
    main()
