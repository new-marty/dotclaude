#!/usr/bin/env bash
# Two-clone test for sync-push.sh. Runs in a scratch directory, never ~/.claude.
set -euo pipefail
SCRIPT="$(cd "$(dirname "$0")" && pwd)/sync-push.sh"
T=$(mktemp -d); trap 'rm -rf "$T"' EXIT
export GIT_AUTHOR_NAME=t GIT_AUTHOR_EMAIL=t@t GIT_COMMITTER_NAME=t GIT_COMMITTER_EMAIL=t@t
g() { git -C "$1" "${@:2}"; }
fail() { echo "FAIL: $*"; exit 1; }

git init -q --bare -b main "$T/remote.git"
git clone -q "$T/remote.git" "$T/a" 2>/dev/null
echo base > "$T/a/shared.txt"; g "$T/a" add -A; g "$T/a" commit -qm base; g "$T/a" push -q origin HEAD:main
git clone -q "$T/remote.git" "$T/b"

# Case 1: A pushes, B has an unpushed change to another file -> rebased and pushed.
echo a1 > "$T/a/a.txt"; g "$T/a" add -A; g "$T/a" commit -qm a1; g "$T/a" push -q origin HEAD:main
echo b1 > "$T/b/b.txt"
CLAUDE_SYNC_DIR="$T/b" "$SCRIPT" || fail "case 1 exit $?"
[ "$(g "$T/remote.git" show main:b.txt)" = b1 ] || fail "b.txt not on remote"
[ "$(g "$T/remote.git" show main:a.txt)" = a1 ] || fail "a.txt lost"
[ ! -e "$T/b/.git/claude-sync-diverged" ] || fail "marker after success"
echo "ok 1: rebased and pushed"

# Case 2: conflicting edit of shared.txt -> no push, not mid-rebase, marker, exit 2.
g "$T/a" pull -q --rebase origin main
echo from-a > "$T/a/shared.txt"; g "$T/a" add -A; g "$T/a" commit -qm a2; g "$T/a" push -q origin HEAD:main
echo from-b > "$T/b/shared.txt"
before=$(g "$T/remote.git" rev-parse main)
rc=0; CLAUDE_SYNC_DIR="$T/b" "$SCRIPT" 2>"$T/err" || rc=$?
[ "$rc" = 2 ] || fail "case 2 exit $rc, want 2"
[ "$(g "$T/remote.git" rev-parse main)" = "$before" ] || fail "remote moved"
[ ! -d "$T/b/.git/rebase-merge" ] && [ ! -d "$T/b/.git/rebase-apply" ] || fail "mid-rebase"
[ -z "$(g "$T/b" ls-files --unmerged)" ] || fail "unmerged files"
[ -f "$T/b/.git/claude-sync-diverged" ] || fail "no marker"
grep -q "conflicted" "$T/err" || fail "no stderr message"
[ "$(g "$T/b" log -1 --format=%s)" = "Sync Claude Code configuration from $(hostname -s)" ] || fail "local commit lost"
echo "ok 2: conflict -> no push, tree clean, marker, exit 2"
