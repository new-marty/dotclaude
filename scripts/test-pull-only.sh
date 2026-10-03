#!/usr/bin/env bash
# Scenarios for a pull-only device (README "Pull-only devices"). Builds a bare
# upstream, a writer clone and a device clone in a scratch directory; never touches
# ~/.claude. Needs git and jq.
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$HERE/.." && pwd)"
T=$(mktemp -d); trap 'rm -rf "$T"' EXIT
export GIT_AUTHOR_NAME=t GIT_AUTHOR_EMAIL=t@t GIT_COMMITTER_NAME=t GIT_COMMITTER_EMAIL=t@t
g() { git -C "$1" "${@:2}"; }
fail() { echo "FAIL: $*"; exit 1; }
commit_push() { g "$T/w" add -A; g "$T/w" commit -qm "$1"; g "$T/w" push -q origin HEAD:main; }
# Run sync-pull.sh on the device; sets rc and leaves stderr in $T/err.
pull() { rc=0; CLAUDE_SYNC_DIR="$T/d" "$HERE/sync-pull.sh" 2>"$T/err" || rc=$?; }
has() { grep -q -- "$1" "$T/err"; }

git init -q --bare -b main "$T/up.git"
git clone -q "$T/up.git" "$T/w" 2>/dev/null
cp "$ROOT/.gitignore" "$T/w/.gitignore"      # the real device block is under test
mkdir -p "$T/w/skills/z-a"
printf 'one\ntwo\nthree\n' > "$T/w/CLAUDE.md"
echo readme > "$T/w/README.md"
echo skill > "$T/w/skills/z-a/SKILL.md"
echo other > "$T/w/skills/z-a/other.md"
commit_push base
git clone -q "$T/up.git" "$T/d"
g "$T/d" config dotclaude.role pull-only

# 1. Files at every reserved path survive a pull that changes shared files.
mkdir -p "$T/d/rules" "$T/d/skills/local-x" "$T/d/skills/adding-services" "$T/d/output-styles"
echo m > "$T/d/CLAUDE.machine.md"; echo s > "$T/d/statusline.local.sh"; echo r > "$T/d/rules/r.md"
echo l > "$T/d/skills/local-x/SKILL.md"; echo o > "$T/d/output-styles/local-o.md"
echo a > "$T/d/skills/adding-services/SKILL.md"; ln -s "$T/d/rules" "$T/d/skills/reading-x"
echo "two changed" > "$T/w/CLAUDE.md"; mkdir -p "$T/w/skills/z-b"; echo b > "$T/w/skills/z-b/SKILL.md"
commit_push upstream-1
pull
[ "$rc" = 0 ] || fail "1: exit $rc"
[ "$(cat "$T/d/CLAUDE.md")" = "two changed" ] || fail "1: CLAUDE.md not updated"
[ -f "$T/d/skills/z-b/SKILL.md" ] || fail "1: new skill missing"
for f in CLAUDE.machine.md statusline.local.sh rules/r.md skills/local-x/SKILL.md \
         output-styles/local-o.md skills/adding-services/SKILL.md; do
    [ -f "$T/d/$f" ] || fail "1: $f lost"
done
[ -L "$T/d/skills/reading-x" ] || fail "1: symlinked skill lost"
[ -z "$(g "$T/d" status --porcelain)" ] || fail "1: local layer shows in status"
[ ! -s "$T/err" ] || fail "1: a clean pull printed something"
echo "ok 1: local layer survives a pull"

# 2. On main: an edit upstream also changed blocks the pull, and is kept.
echo "device edit" >> "$T/d/README.md"
echo "upstream edit" >> "$T/w/README.md"; commit_push upstream-2
pull
[ "$rc" = 0 ] || fail "2: exit $rc"
has "would be overwritten by" || fail "2: no 'would be overwritten by'"
has "pull failed" || fail "2: no 'pull failed'"
has "local edits to shared files block a fast-forward" || fail "2: no explanation"
grep -q "device edit" "$T/d/README.md" || fail "2: edit lost"
[ "$(g "$T/d" rev-parse HEAD)" != "$(g "$T/d" rev-parse origin/main)" ] || fail "2: moved anyway"
# An edit upstream did not touch does not block.
g "$T/d" checkout -q README.md; echo edit >> "$T/d/skills/z-a/other.md"
pull
{ [ "$rc" = 0 ] && [ ! -s "$T/err" ]; } || fail "2: unrelated edit blocked the pull"
[ "$(g "$T/d" rev-parse HEAD)" = "$(g "$T/d" rev-parse origin/main)" ] || fail "2: did not fast-forward"
grep -q edit "$T/d/skills/z-a/other.md" || fail "2: unrelated edit lost"
g "$T/d" checkout -q skills/z-a/other.md
# A network failure is "pull failed", not a report of local edits.
g "$T/d" remote set-url origin "$T/nowhere.git"
pull
[ "$rc" = 0 ] || fail "2: offline exit $rc"
has "pull failed" || fail "2: offline: no 'pull failed'"
! has "local edits to shared files" || fail "2: offline reported as local edits"
g "$T/d" remote set-url origin "$T/up.git"
echo "ok 2: main fast-forwards; local edits refuse with the strings cron greps for"

# 3. On local: fetch and report only; merging is manual.
g "$T/d" switch -q -c local
g "$T/d" branch -q -u origin/main
g "$T/d" config merge.conflictStyle zdiff3
printf 'one\nlocal two\nthree\n' > "$T/d/CLAUDE.md"
echo "local note" >> "$T/d/skills/z-a/SKILL.md"
g "$T/d" commit -qam "local: edits"
g "$T/d" branch -q -D main
echo more >> "$T/w/skills/z-a/other.md"; commit_push upstream-3
head=$(g "$T/d" rev-parse HEAD)
pull
[ "$rc" = 0 ] || fail "3: exit $rc"
has "on local, 1 commits behind origin/main; run: git -C ~/.claude merge origin/main" || fail "3: no behind message"
[ "$(g "$T/d" rev-parse HEAD)" = "$head" ] || fail "3: pull moved HEAD"
g "$T/d" merge -q origin/main >/dev/null || fail "3: non-overlapping merge stopped"
grep -q more "$T/d/skills/z-a/other.md" || fail "3: merge did not bring the change"
# Same-line change: stops with UU and markers; the documented steps resolve it.
printf 'one\nupstream two\nthree\n' > "$T/w/CLAUDE.md"; commit_push upstream-4
g "$T/d" fetch -q
if g "$T/d" merge origin/main >/dev/null 2>&1; then fail "3: same-line change merged silently"; fi
[ "$(g "$T/d" status --porcelain CLAUDE.md)" = "UU CLAUDE.md" ] || fail "3: no UU"
{ grep -q '^<<<<<<< HEAD' "$T/d/CLAUDE.md" && grep -q '^>>>>>>> origin/main' "$T/d/CLAUDE.md"; } || fail "3: no markers"
printf 'one\nboth two\nthree\n' > "$T/d/CLAUDE.md"
g "$T/d" add CLAUDE.md; g "$T/d" commit -q --no-edit
[ -z "$(g "$T/d" status --porcelain)" ] || fail "3: tree not clean after resolving"
# Upstream deletes a file the device edited: UD; "git rm" takes the deletion.
g "$T/w" rm -q skills/z-a/SKILL.md; commit_push upstream-5
g "$T/d" fetch -q
if g "$T/d" merge origin/main >/dev/null 2>&1; then fail "3: delete merged silently"; fi
[ "$(g "$T/d" status --porcelain skills/z-a/SKILL.md)" = "UD skills/z-a/SKILL.md" ] || fail "3: no UD"
g "$T/d" rm -q skills/z-a/SKILL.md; g "$T/d" commit -q --no-edit
[ ! -e "$T/d/skills/z-a/SKILL.md" ] || fail "3: file still there"
[ -f "$T/d/CLAUDE.machine.md" ] || fail "3: local layer lost"
echo "ok 3: local branch reports only; merge clean, UU and UD resolved by the documented steps"

# 4. sync-push.sh on the device exits 0 and creates no commit.
echo x >> "$T/d/CLAUDE.md"
head=$(g "$T/d" rev-parse HEAD); up=$(g "$T/up.git" rev-parse main)
rc=0; CLAUDE_SYNC_DIR="$T/d" "$HERE/sync-push.sh" 2>"$T/err" || rc=$?
{ [ "$rc" = 0 ] && [ "$(g "$T/d" rev-parse HEAD)" = "$head" ] && [ "$(g "$T/up.git" rev-parse main)" = "$up" ]; } \
    || fail "4: push script acted on a device"
g "$T/d" checkout -q CLAUDE.md
echo "ok 4: sync-push.sh does nothing on a device"

# 5. Without the role, sync-pull.sh keeps its rebase behaviour.
git clone -q "$T/up.git" "$T/e"
echo w1 > "$T/w/skills/z-a/w1.md"; commit_push upstream-6
rc=0; CLAUDE_SYNC_DIR="$T/e" "$HERE/sync-pull.sh" 2>"$T/err" || rc=$?
{ [ "$rc" = 0 ] && [ -f "$T/e/skills/z-a/w1.md" ] && [ ! -s "$T/err" ]; } || fail "5: writer pull changed"
echo "ok 5: writer pull unchanged (test-sync-push.sh covers the push side)"

# 6. statusline.sh in three roles. The sample carries rate_limits, so the script
# takes its early exit and makes no keychain or network call.
SAMPLE='{"model":{"display_name":"M"},"workspace":{"current_dir":"/tmp"},"context_window":{"used_percentage":10},"rate_limits":{"five_hour":{"used_percentage":5,"resets_at":4102444800},"seven_day":{"used_percentage":6,"resets_at":4102444800}}}'
line1() { echo "$SAMPLE" | CLAUDE_SYNC_DIR="$1" "$ROOT/statusline.sh" | sed -n 1p; }
echo s1 > "$T/w/skills/z-a/s1.md"; commit_push s1
echo s2 > "$T/w/skills/z-a/s2.md"; commit_push s2
g "$T/e" fetch -q
out=$(line1 "$T/e"); case "$out" in *"⇣"*|*"local"*) fail "6: writer shows device segment: $out" ;; esac
echo x > "$T/e/skills/z-a/unpushed.md"; g "$T/e" add -A; g "$T/e" commit -qm u
out=$(line1 "$T/e"); case "$out" in *".claude ⇡1"*) ;; *) fail "6: writer lost ⇡: $out" ;; esac
g "$T/e" config dotclaude.role pull-only; g "$T/e" reset -q --hard origin/main~2
out=$(line1 "$T/e"); case "$out" in *".claude ⇣2"*) ;; *) fail "6: device on main: $out" ;; esac
case "$out" in *"local"*) fail "6: device on main shows local: $out" ;; esac
g "$T/e" switch -q -c local; g "$T/e" branch -q -u origin/main
out=$(line1 "$T/e"); case "$out" in *".claude local ⇣2"*) ;; *) fail "6: device on local: $out" ;; esac
echo "ok 6: statusline segments for writer, device on main, device on local"

# 7. A diverged main refuses without git's rebase/merge hints, and an unknown role warns.
git clone -q "$T/up.git" "$T/f"
g "$T/f" config dotclaude.role pull-only
echo fl > "$T/f/skills/z-a/f.md"; g "$T/f" add -A; g "$T/f" commit -qm f
echo up7 > "$T/w/skills/z-a/up7.md"; commit_push upstream-7
rc=0; CLAUDE_SYNC_DIR="$T/f" "$HERE/sync-pull.sh" 2>"$T/err" || rc=$?
[ "$rc" = 0 ] || fail "7: exit $rc"
has "pull failed" || fail "7: no 'pull failed'"
! has "hint:" || fail "7: git advice leaked: $(cat "$T/err")"
g "$T/f" config dotclaude.role bogus
rc=0; CLAUDE_SYNC_DIR="$T/f" "$HERE/sync-pull.sh" 2>"$T/err" || rc=$?
has "unknown dotclaude.role 'bogus'; treating this machine as a writer" || fail "7: no unknown-role warning"
echo "ok 7: diverged main prints no git hints; unknown role warns"
