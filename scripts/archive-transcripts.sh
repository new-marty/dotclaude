#!/usr/bin/env bash
# Copy Claude Code's conversation logs to an archive at session end, so they
# outlive cleanupPeriodDays. Opt-in per machine: does nothing unless
# DOTCLAUDE_ARCHIVE_DIR is set, e.g. in settings.json:
#   "env": { "DOTCLAUDE_ARCHIVE_DIR": "/Volumes/media/backups/claude-history" }
#
# Each machine writes under <DOTCLAUDE_ARCHIVE_DIR>/<host>/, so several machines
# can share one archive. The directory must already exist: when it is a network
# share that is not mounted, the run is skipped instead of filling a local
# directory of the same name, and the next session catches up.
#
# The whole projects/ tree is mirrored, not only the ending session, so a
# session killed without a SessionEnd is picked up by the next one. Nothing is
# ever deleted from the archive.
set -uo pipefail

base="${DOTCLAUDE_ARCHIVE_DIR:-}"
[ -n "$base" ] || exit 0
base="${base/#\~/$HOME}"
[ -d "$base" ] || exit 0

host=$(scutil --get LocalHostName 2>/dev/null || hostname -s)
dest="$base/$host"
src="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
mkdir -p "$dest/projects" || exit 0

# Detached so a slow share never delays the session's exit.
nohup sh -c '
    rsync -a --include="*/" --include="*.jsonl" --exclude="*" "$1/projects/" "$2/projects/"
    [ -f "$1/history.jsonl" ] && cp -p "$1/history.jsonl" "$2/history.jsonl"
' _ "$src" "$dest" >/dev/null 2>&1 &
exit 0
