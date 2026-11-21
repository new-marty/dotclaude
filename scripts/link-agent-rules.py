#!/usr/bin/env python3
"""Write the rules Claude Code loads into the files the other agents read.

Claude Code reads ~/.claude/CLAUDE.md, which imports AGENTS.md (the rules for
every agent) and CLAUDE.machine.md (this machine's rules, which may import
more). agy, Codex and pi cannot follow Claude's @path imports, so sync-pull.sh
runs this after each pull: it expands every file CLAUDE.md imports, in order,
and writes the result to each agent's global rules file:

    ~/.gemini/AGENTS.md      agy
    ~/.codex/AGENTS.md       Codex
    ~/.pi/agent/AGENTS.md    pi

CLAUDE.md's own text stays out: it holds what only Claude Code needs.

Rules, so nothing another tool or a person put there is lost:
- an agent whose directory does not exist is skipped;
- a symlink, or a file starting with HEADER, is ours and is replaced;
  any other file is left alone and reported;
- ~/.gemini/GEMINI.md, which agy also reads, is removed when it is a symlink
  (it used to point at the machine rules, which would now load twice) and
  reported when it is a non-empty file.
Usage: link-agent-rules.py [claude_dir] [home]
       (defaults: $CLAUDE_SYNC_DIR or ~/.claude, $HOME)
Exit status is always 0; problems are reported on stderr.
"""
import os
import re
import sys
import tempfile

HEADER = "<!-- Written by ~/.claude/scripts/link-agent-rules.py"
IMPORT = re.compile(r"^@(\S+)\s*$")
MAX_DEPTH = 5  # Claude Code follows imports five levels deep
TARGETS = [".gemini/AGENTS.md", ".codex/AGENTS.md", ".pi/agent/AGENTS.md"]


def log(msg):
    print(f"[claude-sync] {msg}", file=sys.stderr)


def resolve(ref, base_dir, home):
    if ref.startswith("~/"):
        return os.path.join(home, ref[2:])
    return os.path.normpath(os.path.join(base_dir, ref))


def expand(path, home, depth, seen):
    """path's text with its @imports replaced by their own expansion."""
    real = os.path.realpath(path)
    if real in seen or depth > MAX_DEPTH:
        return ""
    seen.add(real)
    try:
        with open(path) as f:
            lines = f.read().splitlines()
    except OSError as e:
        log(f"agent rules: cannot read {path} ({e.strerror})")
        return ""
    out = []
    for line in lines:
        m = IMPORT.match(line)
        if m:
            out.append(expand(resolve(m.group(1), os.path.dirname(path), home), home, depth + 1, seen))
        else:
            out.append(line)
    return "\n".join(out).rstrip("\n")


def rules(claude_dir, home):
    """The expansion of every file CLAUDE.md imports, or None when there is nothing to write."""
    top = os.path.join(claude_dir, "CLAUDE.md")
    try:
        with open(top) as f:
            lines = f.read().splitlines()
    except OSError:
        return None
    seen = {os.path.realpath(top)}
    parts = [expand(resolve(m.group(1), claude_dir, home), home, 1, seen)
             for m in map(IMPORT.match, lines) if m]
    parts = [p for p in parts if p]
    if not parts:
        return None
    note = (f"{HEADER} from the files ~/.claude/CLAUDE.md imports. Edit those;"
            " this copy is rewritten after each pull. -->")
    return note + "\n\n" + "\n\n".join(parts) + "\n"


def ours(path):
    if os.path.islink(path):
        return True
    try:
        with open(path) as f:
            return f.read(len(HEADER)) == HEADER
    except OSError:
        return False


def write(path, text):
    if os.path.lexists(path) and not ours(path):
        log(f"agent rules: {path} is not ours; left as it was")
        return False
    if not os.path.islink(path):
        try:
            with open(path) as f:
                if f.read() == text:
                    return False
        except OSError:
            pass
    fd, tmp = tempfile.mkstemp(dir=os.path.dirname(path), prefix=".agents-md.")
    with os.fdopen(fd, "w") as f:
        f.write(text)
    os.chmod(tmp, 0o644)
    os.replace(tmp, path)  # replaces a symlink itself, not its target
    return True


def main():
    claude_dir = sys.argv[1] if len(sys.argv) > 1 else os.environ.get(
        "CLAUDE_SYNC_DIR", os.path.expanduser("~/.claude"))
    home = sys.argv[2] if len(sys.argv) > 2 else os.path.expanduser("~")
    text = rules(claude_dir, home)
    if text is None:
        return
    written = [t for t in TARGETS
               if os.path.isdir(os.path.dirname(os.path.join(home, t)))
               and write(os.path.join(home, t), text)]
    if written:
        log(f"agent rules: wrote {', '.join('~/' + t for t in written)}")
    gemini_md = os.path.join(home, ".gemini/GEMINI.md")
    if os.path.islink(gemini_md):
        os.unlink(gemini_md)
        log("agent rules: removed the ~/.gemini/GEMINI.md symlink; agy reads ~/.gemini/AGENTS.md")
    elif os.path.isfile(gemini_md) and os.path.getsize(gemini_md) > 0:
        log("agent rules: ~/.gemini/GEMINI.md has rules of its own; agy reads it besides ~/.gemini/AGENTS.md")


if __name__ == "__main__":
    try:
        main()
    except Exception as e:  # a sync hook must never fail the session
        log(f"agent rules: {type(e).__name__}: {e}")
