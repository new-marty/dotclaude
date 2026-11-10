#!/usr/bin/env bash
# Scenarios for check-plugins.py with fixture files instead of the network.
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
T=$(mktemp -d); trap 'rm -rf "$T"' EXIT
fail() { echo "FAIL: $*"; exit 1; }
mkdir -p "$T/c/plugins" "$T/fx/o_r/.claude-plugin" "$T/fx/o_s"
printf '{"enabledPlugins":{"p@m":true,"q@inline":true,"off@m":false},"extraKnownMarketplaces":{"m":{"source":{"source":"github","repo":"o/r"}},"inline":{"source":{"source":"settings","name":"inline","plugins":[{"name":"q","source":{"source":"github","repo":"o/s"}}]}}}}\n' > "$T/c/settings.shared.json"
printf '{"plugins":[{"name":"p","source":"./"}]}\n' > "$T/fx/o_r/.claude-plugin/marketplace.json"
printf '{"version":"1.1.0"}\n' > "$T/fx/o_r/.claude-plugin/plugin.json"
printf 'abcdef1234567890\n' > "$T/fx/o_s/HEAD"
printf '{"plugins":{"p@m":[{"scope":"user","version":"1.0.0"}],"q@inline":[{"scope":"user","version":"abcdef123456"}]}}\n' > "$T/c/plugins/installed_plugins.json"
run() { rc=0; PLUGIN_SHARED="$T/c/settings.shared.json" CLAUDE_SYNC_DIR="$T/c" XDG_STATE_HOME="$T/state" PLUGIN_CHECK_FETCH="$T/fx" PLUGIN_CHECK_TODAY="$1" \
        python3 -I "$HERE/check-plugins.py" > "$T/out" || rc=$?; }

run 2026-11-10
[ "$rc" = 0 ] || fail "1: exit $rc"
grep -q '^pending  plugin:p@m .* 1.0.0 -> 1.1.0' "$T/out" || fail "1: no pending line: $(cat "$T/out")"
grep -q '^current  plugin:q@inline ' "$T/out" || fail "1: commit-versioned plugin not current"
! grep -q 'off@m' "$T/out" || fail "1: a disabled plugin was checked"
echo "ok 1: a fresh gap is pending, commit prefixes match, disabled plugins are skipped"

run 2026-11-12
[ "$rc" = 1 ] || fail "2: exit $rc"
grep -q '^CHANGED  plugin:p@m  https://github.com/o/r  1.0.0 -> 1.1.0$' "$T/out" || fail "2: no CHANGED line: $(cat "$T/out")"
echo "ok 2: a gap older than the lag is CHANGED in check-upstream.sh's format"

printf '{"plugins":{"p@m":[{"scope":"user","version":"1.1.0"}],"q@inline":[{"scope":"user","version":"abcdef123456"}]}}\n' > "$T/c/plugins/installed_plugins.json"
run 2026-11-13
[ "$rc" = 0 ] || fail "3: exit $rc"
[ ! -s "$T/state/dotclaude-plugins/lag.tsv" ] || fail "3: caught-up plugin left in the lag file"
echo "ok 3: catching up clears the gap"

rm "$T/fx/o_r/.claude-plugin/marketplace.json"
run 2026-11-13
[ "$rc" = 2 ] || fail "4: exit $rc"
grep -q '^ERROR    plugin:p@m' "$T/out" || fail "4: no ERROR line"
echo "ok 4: an unreadable upstream is an ERROR (exit 2)"
