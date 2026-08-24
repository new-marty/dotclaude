#!/usr/bin/env bash
# Commit and push this machine's Claude Code configuration at session end,
# so the next machine picks it up via scripts/sync-pull.sh.
#
# Only files allowed by ~/.claude/.gitignore are staged; session logs, caches
# and OAuth tokens are ignored there and never reach the remote.
set -uo pipefail

DIR="$HOME/.claude"
[ -d "$DIR/.git" ] || exit 0

# Serialise concurrent sessions. mkdir is atomic on every filesystem macOS ships.
LOCK="$DIR/.git/claude-sync.lock"
if ! mkdir "$LOCK" 2>/dev/null; then
    # A lock older than five minutes is a leftover from a killed session.
    if [ -n "$(find "$LOCK" -maxdepth 0 -mmin +5 2>/dev/null)" ]; then
        rmdir "$LOCK" 2>/dev/null && mkdir "$LOCK" 2>/dev/null || exit 0
    else
        exit 0
    fi
fi
trap 'rmdir "$LOCK" 2>/dev/null' EXIT

# Never commit a half-resolved merge: staging conflict markers would publish
# broken configuration to every machine.
if [ -n "$(git -C "$DIR" ls-files --unmerged 2>/dev/null | head -1)" ] \
   || [ -d "$DIR/.git/rebase-merge" ] || [ -d "$DIR/.git/rebase-apply" ]; then
    echo "[claude-sync] ~/.claude has an unresolved conflict; skipping commit." >&2
    exit 0
fi

git -C "$DIR" add -A
if ! git -C "$DIR" diff --cached --quiet; then
    files=$(git -C "$DIR" diff --cached --name-only | sed 's/^/  /')
    git -C "$DIR" commit -q -m "Sync Claude Code configuration from $(hostname -s)

$files"
fi

# An offline machine or a locked SSH agent makes this fail. That is recoverable:
# the commits stay local and the statusline reports how many are unpushed.
if ! out=$(git -C "$DIR" push origin HEAD:main 2>&1); then
    echo "[claude-sync] push failed:" >&2
    echo "$out" >&2
fi
exit 0
