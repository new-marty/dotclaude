#!/usr/bin/env bash
# Compares the upstream revisions recorded in scripts/upstream.tsv with each
# upstream's current head, so a change in something we adopted gets noticed.
# It then runs check-plugins.py, which reports a shared plugin that
# auto-update has left behind its upstream for more than two days.
# The mac-mini runs it every morning in daily-maintenance (~/server T-459);
# any machine can also run it by hand.
#
# Exit status: 0 all current, 1 something changed, 2 a fetch failed
# (2 wins over 1 when both happen).
set -uo pipefail

LIST="$(cd "$(dirname "$0")" && pwd)/upstream.tsv"
changed=0
failed=0

while IFS=$'\t' read -r skill url rev; do
    case "$skill" in ''|'#'*) continue ;; esac

    remote="$url"
    case "$url" in
        https://gist.github.com/*) remote="${url}.git" ;;
        *) remote="${url%.git}.git" ;;
    esac

    if ! head=$(git ls-remote "$remote" HEAD 2>/dev/null | cut -f1) || [ -z "$head" ]; then
        echo "ERROR    $skill  $url  (could not fetch head)"
        failed=1
        continue
    fi

    if [[ "$head" == "$rev"* ]]; then
        echo "current  $skill  $url  @ $rev"
        continue
    fi

    changed=1
    short="${head:0:7}"
    case "$url" in
        https://gist.github.com/*)
            hint="$url/revisions" ;;
        https://github.com/*)
            hint="${url%.git}/compare/$rev...$short" ;;
        *)
            hint="git log $rev..$short (in a clone of $url)" ;;
    esac
    echo "CHANGED  $skill  $url  $rev -> $short"
    echo "         $hint"
done < "$LIST"

PLUGINS="$(dirname "$LIST")/check-plugins.py"
if [ -f "$PLUGINS" ] && command -v python3 >/dev/null 2>&1; then
    prc=0
    python3 -I "$PLUGINS" || prc=$?
    case "$prc" in 0) ;; 1) changed=1 ;; *) failed=1 ;; esac
fi

[ "$failed" -eq 1 ] && exit 2
exit "$changed"
