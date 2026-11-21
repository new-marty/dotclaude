#!/usr/bin/env bash
# agy.shared.json merges into agy's settings.json, keeps its other keys, and writes only on change.
set -euo pipefail
HERE="$(cd "$(dirname "$0")/.." && pwd)"
T=$(mktemp -d); trap 'rm -rf "$T"' EXIT
fail() { echo "FAIL: $*"; exit 1; }
mkdir -p "$T/c" "$T/agy"; cp "$HERE/agy.shared.json" "$T/c/"
printf '{"trustedWorkspaces":["/x"]}\n' > "$T/agy/settings.json"
run() { python3 -I "$HERE/scripts/apply-shared-settings.py" "$T/c" "$T/agy" 2> "$T/err"; }
run
python3 -c 'import json,sys; d=json.load(open(sys.argv[1])); assert d["toolPermission"]=="always-proceed" and d["trustedWorkspaces"]==["/x"], d' "$T/agy/settings.json" || fail "1: not merged"
run
[ ! -s "$T/err" ] || fail "2: an unchanged run wrote again"
rm -rf "$T/agy"; run; [ ! -e "$T/agy" ] || fail "3: created agy's directory"
echo "ok apply-shared-agy"
