#!/usr/bin/env bash
# Scenarios for ja-reply-gate.py --agy against scratch agy transcripts.
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
T=$(mktemp -d); trap 'rm -rf "$T"' EXIT
fail() { echo "FAIL: $*"; exit 1; }
EN='Here is the full answer in English, which is long enough to count as prose for the gate.'
JA='これは日本語の返事です。十分な長さがある文章として扱われるはずです。'
step() { printf '{"type":"%s","content":"%s"}\n' "$1" "$2"; }
{ step USER_INPUT q; step PLANNER_RESPONSE "$EN"; step PLANNER_RESPONSE ""; } > "$T/en.jsonl"
{ step USER_INPUT q; step PLANNER_RESPONSE "$JA"; } > "$T/ja.jsonl"
{ step USER_INPUT q; step PLANNER_RESPONSE "$EN"; step USER_INPUT q2; step PLANNER_RESPONSE ""; } > "$T/empty.jsonl"
gate() { printf '%s' "$1" | python3 -I "$HERE/ja-reply-gate.py" --agy || fail "exit status $?"; }
input() { printf '{"terminationReason":"%s","lastUserInput":"%s","transcriptPath":"%s"%s}' "$1" "$2" "$T/$3" "${4:-}"; }
ASK='日本語で答えてください'

gate "$(input NO_TOOL_CALL "$ASK" en.jsonl)" | grep -q '"decision": "continue"' || fail "1: English reply to a Japanese prompt passed"
echo "ok 1: an English reply to a Japanese prompt is sent back"

for c in "$(input NO_TOOL_CALL "$ASK" ja.jsonl)" "$(input NO_TOOL_CALL 'please answer' en.jsonl)" \
         "$(input NO_TOOL_CALL "$ASK" en.jsonl ',"executionNum":1')" \
         "$(input NO_TOOL_CALL "$ASK" en.jsonl ',"continuationActive":true')" \
         "$(input USER_CANCELED "$ASK" en.jsonl)" "$(input NO_TOOL_CALL "$ASK" empty.jsonl)" \
         "$(input NO_TOOL_CALL "$ASK" missing.jsonl)" '[]' '' 'not json' '{"lastUserInput":5}'; do
    [ "$(gate "$c")" = '{"decision": ""}' ] || fail "2: did not pass: $c"
done
echo "ok 2: Japanese replies, English prompts, continued stops, other endings, an empty last reply and bad input pass with JSON"
