#!/usr/bin/env bash
# ~/.claude is a git repository (github.com:new-marty/dotclaude) holding this
# machine's Claude Code configuration. Run at session start to bring in changes
# made on another machine.
#
# Local edits are preserved: --autostash shelves them before the rebase and
# restores them afterwards. If restoring conflicts, the rebase stops and the
# conflict is left for a human to resolve; the statusline shows ".claude
# CONFLICT" until then.
set -uo pipefail

DIR="$HOME/.claude"
[ -d "$DIR/.git" ] || exit 0

# A rebase already in progress means an earlier sync stopped on a conflict.
# Touching the repository again would only bury it.
if [ -n "$(git -C "$DIR" ls-files --unmerged 2>/dev/null | head -1)" ] \
   || [ -d "$DIR/.git/rebase-merge" ] || [ -d "$DIR/.git/rebase-apply" ]; then
    echo "[claude-sync] ~/.claude has an unresolved conflict; skipping pull." >&2
    exit 0
fi

if ! out=$(git -C "$DIR" pull --rebase --autostash 2>&1); then
    echo "[claude-sync] pull failed:" >&2
    echo "$out" >&2
    echo "[claude-sync] inspect with: git -C ~/.claude status" >&2
fi
exit 0
