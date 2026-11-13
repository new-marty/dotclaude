#!/usr/bin/env bash
# Scenarios for link-agent-skills.py against a scratch claude dir and agents dir.
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
T=$(mktemp -d); trap 'rm -rf "$T"' EXIT
fail() { echo "FAIL: $*"; exit 1; }
C="$T/c"; A="$T/agents/skills"; P="$C/plugins/cache"
skill() { mkdir -p "$1"; printf -- '---\nname: %s\ndescription: d\n---\nbody\n' "$2" > "$1/SKILL.md"; }
skill "$C/skills/own" own
skill "$T/server/linked" linked; ln -s "$T/server/linked" "$C/skills/linked"
mkdir -p "$C/skills/synced/x" "$C/skills/no-skill-md"; printf -- '---\nname: x\n---\n' > "$C/skills/synced/x/SKILL.md"
skill "$P/m/a/1.0/skills/alpha" alpha
skill "$P/m/a/1.0/skills/own" own
skill "$P/m/b/abc" bravo
skill "$P/m/c/2.0/skills/group/charlie" charlie
mkdir -p "$P/m/c/2.0/.claude-plugin"; printf '{"skills":["./skills/group/charlie"]}\n' > "$P/m/c/2.0/.claude-plugin/plugin.json"
skill "$P/pstack-mirror/pstack/1/skills/arena" arena
skill "$T/orca/orchestration" orchestration
mkdir -p "$A"; ln -s "$T/orca/orchestration" "$A/orchestration"; mkdir "$A/real-dir"
skill "$P/m/d/1.0/skills/orchestration" orchestration
printf '{"enabledPlugins":{"a@m":true,"b@m":true,"c@m":true,"d@m":true,"off@m":false,"pstack@pstack-mirror":true}}\n' > "$C/settings.json"
installed() {
    printf '{"plugins":{"a@m":[{"installPath":"%s"}],"b@m":[{"installPath":"%s"}],"c@m":[{"installPath":"%s"}],"d@m":[{"installPath":"%s"}],"pstack@pstack-mirror":[{"installPath":"%s"}]}}\n' \
        "$P/m/a/$1" "$P/m/b/abc" "$P/m/c/2.0" "$P/m/d/1.0" "$P/pstack-mirror/pstack/1" > "$C/plugins/installed_plugins.json"
}
installed 1.0
run() { python3 -I "$HERE/link-agent-skills.py" "$C" "$A" "$T/agy" 2> "$T/err" || fail "exit status $?"; }

run
[ "$(readlink "$A/own")" = "$C/skills/own" ] || fail "1: own skill not linked to ~/.claude/skills"
[ "$(readlink "$A/linked")" = "$C/skills/linked" ] || fail "1: symlinked own skill not linked by its stable path"
[ "$(readlink "$A/alpha")" = "$P/m/a/1.0/skills/alpha" ] || fail "1: default skills/ not linked"
[ "$(readlink "$A/bravo")" = "$P/m/b/abc" ] || fail "1: root SKILL.md plugin not linked by its frontmatter name"
[ "$(readlink "$A/charlie")" = "$P/m/c/2.0/skills/group/charlie" ] || fail "1: plugin.json skills path not linked"
[ ! -e "$A/arena" ] || fail "1: a CLAUDE_ONLY plugin was linked"
[ ! -e "$A/x" ] && [ ! -e "$A/no-skill-md" ] || fail "1: synced bundle or a dir without SKILL.md was linked"
[ "$(readlink "$A/orchestration")" = "$T/orca/orchestration" ] || fail "1: another tool's link was replaced"
[ -d "$A/real-dir" ] && [ ! -L "$A/real-dir" ] || fail "1: a real directory was touched"
grep -q 'orchestration is not ours' "$T/err" || fail "1: clash with another tool's entry not reported"
grep -q 'already has the name own' "$T/err" || fail "1: own-vs-plugin clash not reported"
echo "ok 1: own skills, the three plugin layouts and clashes; other tools' entries untouched"

mkdir -p "$P/m/a/1.1"; cp -R "$P/m/a/1.0/skills" "$P/m/a/1.1/"; installed 1.1
printf '{"enabledPlugins":{"a@m":true,"b@m":false,"c@m":true,"d@m":true}}\n' > "$C/settings.json"
run
[ "$(readlink "$A/alpha")" = "$P/m/a/1.1/skills/alpha" ] || fail "2: link did not follow the new version"
[ ! -L "$A/bravo" ] || fail "2: a disabled plugin's link stayed"
grep -q 'removed bravo' "$T/err" || fail "2: removal not reported: $(cat "$T/err")"
echo "ok 2: an update is followed and a disabled plugin's link removed"

run
! grep -q 'linked\|removed' "$T/err" || fail "3: a run with no change reported one: $(cat "$T/err")"
echo "ok 3: a second run changes nothing"

ln -s "$C/skills" "$T/alias"
python3 -I "$HERE/link-agent-skills.py" "$C" "$T/alias" "$T/agy" 2> "$T/err"
[ ! -L "$C/skills/alpha" ] || fail "4: linked into the claude dir through an alias"
grep -q 'resolves into' "$T/err" || fail "4: alias not reported"
echo "ok 4: an agents dir that resolves into the claude dir is refused"

[ ! -e "$T/agy" ] || fail "5: agy's config dir was created"
mkdir "$T/agy"; printf '{"entries":[{"path":"/elsewhere"}],"inherits":[]}\n' > "$T/agy/skills.json"
run; run
[ "$(python3 -c 'import json,sys; print([e["path"] for e in json.load(open(sys.argv[1]))["entries"]])' "$T/agy/skills.json")" = "['/elsewhere', '$A']" ] \
    || fail "5: skills.json entries: $(cat "$T/agy/skills.json")"
grep -q '"inherits"' "$T/agy/skills.json" || fail "5: another key in skills.json was lost"
printf 'not json' > "$T/agy/skills.json"; run
[ "$(cat "$T/agy/skills.json")" = "not json" ] || fail "5: an unreadable skills.json was overwritten"
echo "ok 5: agy's skills.json gains the agents dir once, keeps the rest, and is left alone when unreadable"
