#!/usr/bin/env bash
# The first line of statusline.sh: host, effort, and ultracode read from the
# transcript. The sample carries rate_limits, so the script makes no keychain or
# network call. Needs jq.
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$HERE/.." && pwd)"
T=$(mktemp -d)
SID="test-statusline-$$"
trap 'rm -rf "$T" "/tmp/claude-ultracode-$SID"' EXIT
fail() { echo "FAIL: $*"; exit 1; }
mkdir -p "$T/sync"
TR="$T/transcript.jsonl"
: > "$TR"
line1() {
    jq -n --arg sid "$SID" --arg tr "$TR" --arg effort "${1:-}" '{
        model: {display_name: "M"}, workspace: {current_dir: "/tmp"},
        context_window: {used_percentage: 10}, session_id: $sid, transcript_path: $tr,
        rate_limits: {seven_day: {used_percentage: 6, resets_at: 4102444800}}
    } + (if $effort == "" then {} else {effort: {level: $effort}} end)' |
        CLAUDE_SYNC_DIR="$T/sync" "$ROOT/statusline.sh" | sed -n 1p | sed $'s/\033\\[[0-9;]*m//g'
}
stdout() { jq -cn --arg c "<local-command-stdout>$1</local-command-stdout>" '{type: "user", message: {role: "user", content: $c}}' >> "$TR"; }

out=$(line1 xhigh)
case "$out" in "$(hostname -s) | M xhigh | /tmp"*) ;; *) fail "1: host and effort: $out" ;; esac
case "$out" in *ultracode*) fail "1: ultracode shown while off: $out" ;; esac
out=$(line1)
case "$out" in *"| M | /tmp"*) ;; *) fail "1: no effort field: $out" ;; esac
echo "ok 1: host and effort"

stdout "Ultracode on (this session only): dynamic workflows on every task. Effort stays xhigh."
case "$(line1 xhigh)" in *"M xhigh ultracode |"*) ;; *) fail "2: on not shown: $(line1 xhigh)" ;; esac
case "$(line1 xhigh)" in *ultracode*) ;; *) fail "2: on lost once the cache is read" ;; esac
stdout "Ultracode off. Effort stays xhigh."
case "$(line1 xhigh)" in *ultracode*) fail "2: off still shows ultracode" ;; esac
echo "ok 2: /effort ultracode on and off, read past the cached offset"

# A render that lands while a line is half written still sees it once it is complete.
line=$(jq -cn '{type: "user", message: {role: "user", content: "<local-command-stdout>Ultracode on (this session only): x</local-command-stdout>"}}')
cut=${line%%Ultracode*}; cut=$(( ${#cut} + 3 ))   # inside the marker
printf '%s' "${line:0:cut}" >> "$TR"; line1 >/dev/null
printf '%s\n' "${line:cut}" >> "$TR"
case "$(line1)" in *ultracode*) ;; *) fail "2: toggle split across renders lost" ;; esac
stdout "Ultracode off. Effort stays xhigh."
echo "ok 2b: a line split across two renders"

# The same words quoted in a tool result are not a toggle.
jq -cn '{type: "user", message: {content: [{type: "tool_result", content: "\"content\":\"<local-command-stdout>Ultracode on (this session only)"}]}}' >> "$TR"
case "$(line1)" in *ultracode*) fail "3: quoted text counted" ;; esac
echo "ok 3: quoted text ignored"

echo '{"ultracode": true}' > "$T/sync/settings.json"
: > "$TR"; rm -f "/tmp/claude-ultracode-$SID"
case "$(line1)" in *ultracode*) ;; *) fail "4: setting not used" ;; esac
stdout "Ultracode off. Effort stays high."
case "$(line1)" in *ultracode*) fail "4: off did not override the setting" ;; esac
echo "ok 4: the ultracode setting is the starting state"
