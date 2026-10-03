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

# Case 3: a pull-only device exits 0 without committing, staging or pushing.
git clone -q "$T/remote.git" "$T/c"
g "$T/c" config dotclaude.role pull-only
mkdir -p "$T/c/scripts"; echo c1 > "$T/c/scripts/c.sh"
before=$(g "$T/remote.git" rev-parse main); head=$(g "$T/c" rev-parse HEAD)
rc=0; CLAUDE_SYNC_DIR="$T/c" "$SCRIPT" 2>"$T/err" || rc=$?
[ "$rc" = 0 ] || fail "case 3 exit $rc, want 0"
[ "$(g "$T/c" rev-parse HEAD)" = "$head" ] || fail "pull-only device committed"
[ "$(g "$T/remote.git" rev-parse main)" = "$before" ] || fail "pull-only device pushed"
[ -z "$(g "$T/c" diff --cached --name-only)" ] || fail "pull-only device staged"
[ ! -s "$T/err" ] || fail "pull-only device printed something"
echo "ok 3: pull-only exits 0, no commit, no push"

# Case 4: the device block of .gitignore holds. For each path in it, a sample path
# must be ignored (catches a "!" line that re-includes it) and nothing under it may
# be tracked (catches a force-add). This repository's own .gitignore is checked.
ROOT="$(cd "$(dirname "$SCRIPT")/.." && pwd)"
n=0
while IFS= read -r line; do
    case "$line" in
        "# --- Device-local layer"*) inblock=1; continue ;;
    esac
    [ -n "${inblock:-}" ] || continue
    [ -n "$line" ] || break                # the block ends at the next blank line
    case "$line" in '#'*) continue ;; esac
    spec="${line#/}"                       # anchored root entries: same path, no "/"
    sample="${spec//\*/x}"                 # skills/local-* -> skills/local-x
    case "$sample" in */) sample="${sample}x.md" ;; *) sample="$sample/SKILL.md" ;; esac
    case "$spec" in *.md|*.sh) sample="${sample%/SKILL.md}" ;; esac
    g "$ROOT" check-ignore -q -- "$sample" || fail "$sample is not ignored (line: $line)"
    [ -z "$(g "$ROOT" ls-files -- "$spec")" ] || fail "tracked files under $spec"
    n=$((n+1))
done < "$ROOT/.gitignore"
[ "$n" -eq 10 ] || fail "device block: only $n entries read"
g "$ROOT" check-ignore -q -- skills/z-a/rules/x.md && fail "skills/z-a/rules/x.md must stay trackable"
echo "ok 4: $n device-block paths ignored and untracked; skills/*/rules/ stays trackable"
