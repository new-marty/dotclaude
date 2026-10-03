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

# CLAUDE_SYNC_DIR exists so tests can run against a scratch clone.
DIR="${CLAUDE_SYNC_DIR:-$HOME/.claude}"
[ -d "$DIR/.git" ] || exit 0

# A rebase already in progress means an earlier sync stopped on a conflict.
# Touching the repository again would only bury it.
if [ -n "$(git -C "$DIR" ls-files --unmerged 2>/dev/null | head -1)" ] \
   || [ -d "$DIR/.git/rebase-merge" ] || [ -d "$DIR/.git/rebase-apply" ]; then
    echo "[claude-sync] ~/.claude has an unresolved conflict; skipping pull." >&2
    exit 0
fi

# A pull-only device (git config dotclaude.role pull-only) never rebases or
# autostashes: on main it only fast-forwards, on any other branch it only
# fetches and says how far behind it is. See README "Pull-only devices".
role=$(git -C "$DIR" config dotclaude.role 2>/dev/null || true)
if [ -n "$role" ] && [ "$role" != pull-only ]; then
    echo "[claude-sync] unknown dotclaude.role '$role'; treating this machine as a writer" >&2
fi
if [ "$role" = pull-only ]; then
    if ! out=$(git -C "$DIR" fetch -q origin 2>&1); then
        echo "[claude-sync] pull failed:" >&2
        echo "$out" >&2
        echo "[claude-sync] inspect with: git -C ~/.claude status" >&2
        exit 0
    fi
    branch=$(git -C "$DIR" branch --show-current 2>/dev/null)
    if [ "$branch" = main ]; then
        if ! out=$(git -C "$DIR" -c advice.diverging=false merge --ff-only origin/main 2>&1); then
            echo "[claude-sync] pull failed:" >&2
            echo "$out" >&2
            echo "[claude-sync] local edits to shared files block a fast-forward; see README \"Pull-only devices\"" >&2
        fi
    else
        behind=$(git -C "$DIR" rev-list --count HEAD..origin/main 2>/dev/null || echo 0)
        if [ "${behind:-0}" -gt 0 ]; then
            echo "[claude-sync] on ${branch:-a detached HEAD}, $behind commits behind origin/main; run: git -C ~/.claude merge origin/main" >&2
        fi
    fi
    exit 0
fi

if ! out=$(git -C "$DIR" pull --rebase --autostash 2>&1); then
    echo "[claude-sync] pull failed:" >&2
    echo "$out" >&2
    echo "[claude-sync] inspect with: git -C ~/.claude status" >&2
    exit 0
fi

# git pull exits 0 even when restoring the autostash conflicts: the rebase
# itself succeeded and only the replay of the local edits failed. Check the
# index directly rather than trusting the exit status.
if [ -n "$(git -C "$DIR" ls-files --unmerged 2>/dev/null | head -1)" ]; then
    echo "[claude-sync] ~/.claude changed on another machine and the local edits" >&2
    echo "[claude-sync] could not be replayed on top. Resolve the conflict:" >&2
    git -C "$DIR" diff --name-only --diff-filter=U | sed 's/^/[claude-sync]   /' >&2
    echo "[claude-sync] Your pre-pull state is also kept in 'git -C ~/.claude stash list'." >&2
fi
exit 0
