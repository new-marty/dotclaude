#!/usr/bin/env bash
# skills/z-concise carries a copy of output-styles/concise.md from "## Two rules" on, for
# places the output style does not reach. Fails when the copy has drifted.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
rules() { sed -n '/^## Two rules$/,$p' "$1"; }
style=$(rules "$ROOT/output-styles/concise.md")
skill=$(rules "$ROOT/skills/z-concise/SKILL.md")
[ -n "$style" ] || { echo "FAIL: no '## Two rules' in the output style"; exit 1; }
if [ "$style" != "$skill" ]; then
  echo "FAIL: skills/z-concise/SKILL.md differs from output-styles/concise.md:"
  diff <(echo "$style") <(echo "$skill") || true
  exit 1
fi
echo "ok: z-concise matches the output style"
