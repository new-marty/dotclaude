#!/usr/bin/env bash
# Commit and push this machine's Claude Code configuration at session end,
# so the next machine picks it up via scripts/sync-pull.sh.
#
# Only files allowed by ~/.claude/.gitignore are staged; session logs, caches
# and OAuth tokens are ignored there and never reach the remote.
set -uo pipefail

# CLAUDE_SYNC_DIR exists so tests can run against a scratch clone.
DIR="${CLAUDE_SYNC_DIR:-$HOME/.claude}"
[ -d "$DIR/.git" ] || exit 0

# A pull-only device never pushes (README "Pull-only devices").
[ "$(git -C "$DIR" config dotclaude.role 2>/dev/null)" = pull-only ] && exit 0

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

# The marker tells the statusline that the last push did not land for a reason
# only a human can fix. A successful push removes it.
MARK="$DIR/.git/claude-sync-diverged"

# SessionEnd shows stderr to the user only when the hook exits 2 (hooks docs,
# "Exit code 2 behavior per event"); stdout and exit 0 stay in the debug log.
# So a failure the user must act on ends with exit 2.
diverged() {
    echo "[claude-sync] $1" >&2
    echo "[claude-sync] inspect with: git -C ~/.claude log --oneline origin/main..HEAD" >&2
    echo "$1" > "$MARK"
    exit 2
}

# Another machine may have pushed since this session started. Replay our commits
# on top of it; a plain push would be rejected as non-fast-forward. An offline
# fetch is not an error here: the push below fails the same way and the
# statusline shows the unpushed count.
if git -C "$DIR" fetch -q origin main 2>/dev/null; then
    if ! git -C "$DIR" merge-base --is-ancestor origin/main HEAD 2>/dev/null; then
        if ! out=$(git -C "$DIR" rebase origin/main 2>&1); then
            git -C "$DIR" rebase --abort >/dev/null 2>&1
            echo "$out" >&2
            diverged "rebase onto origin/main conflicted; local commits were not pushed (tree restored)."
        fi
    fi
fi

# An offline machine or a locked SSH agent makes this fail. That is recoverable:
# the commits stay local and the statusline reports how many are unpushed.
if out=$(git -C "$DIR" push origin HEAD:main 2>&1); then
    rm -f "$MARK"
else
    echo "$out" >&2
    case "$out" in
        *"non-fast-forward"*|*"fetch first"*|*rejected*)
            diverged "push rejected: origin/main moved during the push." ;;
        *) echo "[claude-sync] push failed (see above); commits stay local." >&2 ;;
    esac
fi
exit 0
