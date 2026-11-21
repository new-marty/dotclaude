#!/usr/bin/env bash
# Scenarios for link-agent-rules.py against a scratch claude dir and home.
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
T=$(mktemp -d); trap 'rm -rf "$T"' EXIT
fail() { echo "FAIL: $*"; exit 1; }
H="$T/home"; C="$H/.claude"
mkdir -p "$C" "$H/server" "$H/.gemini" "$H/.codex" "$H/.pi/agent"
printf '@~/.claude/AGENTS.md\n\nCLAUDE ONLY\n\n@~/.claude/CLAUDE.machine.md\n' > "$C/CLAUDE.md"
printf 'GLOBAL\n' > "$C/AGENTS.md"
printf 'MACHINE TOP\n@~/server/AGENTS.md\nMACHINE BOTTOM\n@~/.claude/AGENTS.md\n' > "$H/server/machine.md"
ln -s "$H/server/machine.md" "$C/CLAUDE.machine.md"
printf 'SERVER\n' > "$H/server/AGENTS.md"
ln -s "$H/server/AGENTS.md" "$H/.codex/AGENTS.md"
ln -s "$H/server/AGENTS.md" "$H/.gemini/GEMINI.md"
printf 'hand-written\n' > "$H/.pi/agent/AGENTS.md"
run() { python3 -I "$HERE/link-agent-rules.py" "$C" "$H" 2> "$T/err" || fail "exit status $?"; }

run
for f in .gemini/AGENTS.md .codex/AGENTS.md; do
    [ -f "$H/$f" ] && [ ! -L "$H/$f" ] || fail "1: $f not written as a plain file"
    body=$(grep -v '^<!--' "$H/$f" | grep -v '^$' | tr '\n' ' ')
    [ "$body" = "GLOBAL MACHINE TOP SERVER MACHINE BOTTOM " ] || fail "1: $f has '$body'"
done
grep -q 'CLAUDE ONLY' "$H/.codex/AGENTS.md" && fail "1: CLAUDE.md's own text leaked"
[ "$(cat "$H/server/AGENTS.md")" = SERVER ] || fail "1: a symlink target was overwritten"
[ ! -e "$H/.gemini/GEMINI.md" ] || fail "1: GEMINI.md symlink not removed"
[ "$(cat "$H/.pi/agent/AGENTS.md")" = hand-written ] || fail "1: a hand-written file was replaced"
grep -q 'agent/AGENTS.md is not ours' "$T/err" || fail "1: hand-written file not reported"

printf 'GLOBAL 2\n' > "$C/AGENTS.md"
run
grep -q 'GLOBAL 2' "$H/.codex/AGENTS.md" || fail "2: our copy not rewritten after an edit"
run
[ ! -s "$T/err" ] || [ "$(grep -vc 'not ours' "$T/err")" = 0 ] || fail "3: an unchanged run wrote again: $(cat "$T/err")"

rm -rf "$H/.codex"; printf 'x\n' > "$H/.gemini/GEMINI.md"
run
[ ! -e "$H/.codex" ] || fail "4: a missing agent dir was created"
grep -q 'GEMINI.md has rules of its own' "$T/err" || fail "4: a non-empty GEMINI.md not reported"
echo "ok link-agent-rules"
