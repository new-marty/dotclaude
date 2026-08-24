#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
MODE=$(echo "$input" | jq -r '.permission_mode // empty')
# Older Claude Code releases do not send permission_mode; a PreToolUse hook
# mirrors it to /tmp/claude-mode as a fallback.
[ -z "$MODE" ] && MODE=$(cat /tmp/claude-mode 2>/dev/null)

# Colors — Catppuccin Mocha
C_BLUE='\033[38;2;137;180;250m'      # blue
C_GREEN='\033[38;2;166;227;161m'     # green
C_YELLOW='\033[38;2;249;226;175m'    # yellow
C_RED='\033[38;2;243;139;168m'       # red
C_MAUVE='\033[38;2;203;166;247m'     # mauve
C_PEACH='\033[38;2;250;179;135m'     # peach
C_TEXT='\033[38;2;205;214;244m'      # text
C_SUBTEXT='\033[38;2;166;173;200m'   # subtext0
C_OVERLAY='\033[38;2;108;112;134m'   # overlay0
BOLD='\033[1m'
R='\033[0m'

bar_color() {
    local pct="$1"
    if [ "$pct" -ge 80 ]; then echo "$C_RED"
    elif [ "$pct" -ge 50 ]; then echo "$C_YELLOW"
    else echo "$C_GREEN"; fi
}

build_bar() {
    local pct="$1" width="${2:-12}"
    local filled=$(( pct * width / 100 ))
    local bar=""
    for i in $(seq 1 "$width"); do
        if [ "$i" -le "$filled" ]; then bar="${bar}█"; else bar="${bar}░"; fi
    done
    echo "$bar"
}

format_reset_time() {
    local iso="$1"
    local clean="${iso%%.*}"
    clean="${clean%%+*}"
    local epoch
    epoch=$(TZ=UTC date -jf "%Y-%m-%dT%H:%M:%S" "$clean" "+%s" 2>/dev/null || echo "")
    if [ -z "$epoch" ]; then echo "$iso"; return; fi

    local now diff
    now=$(date "+%s")
    diff=$(( epoch - now ))
    if [ "$diff" -le 0 ]; then echo "now"; return; fi

    local days hours mins result=""
    days=$(( diff / 86400 ))
    hours=$(( (diff % 86400) / 3600 ))
    mins=$(( (diff % 3600) / 60 ))

    [ "$days" -gt 0 ] && result="${days}d "
    [ "$hours" -gt 0 ] && result="${result}${hours}h "
    [ "$mins" -gt 0 ] && result="${result}${mins}m"
    echo "${result:-now}"
}

# --- Line 1: Mode | Model | Dir | Git | ~/.claude sync ---
sep="${C_OVERLAY}|${R}"
model_s="${C_BLUE}${MODEL}${R}"
dir_s="${C_YELLOW}${DIR}${R}"

# Permission mode. bypassPermissions skips every confirmation prompt, so it
# must stay visible at all times.
case "$MODE" in
    plan)               mode_s="${BOLD}${C_MAUVE}⏸ PLAN${R}" ;;
    bypassPermissions)  mode_s="${BOLD}${C_RED}⚡ YOLO${R}" ;;
    acceptEdits)        mode_s="${BOLD}${C_YELLOW}✎ AUTO-EDIT${R}" ;;
    auto)               mode_s="${C_GREEN}◈ AUTO${R}" ;;
    *)                  mode_s="${C_OVERLAY}● NORMAL${R}" ;;
esac

# ~/.claude is a git repository synced across machines by the SessionStart and
# SessionEnd hooks. Surface the two states a hook cannot resolve on its own:
# an unresolved merge conflict, and commits that failed to reach the remote.
CLAUDE_SYNC=""
if [ -d "$HOME/.claude/.git" ]; then
    if [ -n "$(git -C "$HOME/.claude" ls-files --unmerged 2>/dev/null | head -1)" ]; then
        CLAUDE_SYNC=" ${sep} ${BOLD}${C_RED}⚠ .claude CONFLICT${R}"
    else
        ahead=$(git -C "$HOME/.claude" rev-list --count '@{u}..HEAD' 2>/dev/null || echo 0)
        [ "${ahead:-0}" -gt 0 ] && CLAUDE_SYNC=" ${sep} ${C_YELLOW}.claude ⇡${ahead}${R}"
    fi
fi

GIT_INFO=""
if git -C "$DIR" rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git -C "$DIR" branch --show-current 2>/dev/null)
    STAGED=$(git -C "$DIR" diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
    MODIFIED=$(git -C "$DIR" diff --numstat 2>/dev/null | wc -l | tr -d ' ')

    git_detail=""
    [ "$STAGED" -gt 0 ] && git_detail="${git_detail}${C_GREEN}+${STAGED}${R} "
    [ "$MODIFIED" -gt 0 ] && git_detail="${git_detail}${C_PEACH}~${MODIFIED}${R}"
    GIT_INFO=" ${sep} ${C_BLUE}${BRANCH}${R} ${git_detail}"
fi

printf '%b\n' "${mode_s} ${sep} ${model_s} ${sep} ${dir_s}${GIT_INFO}${CLAUDE_SYNC}"

# --- Line 2: Context bar ---
ctx_bar=$(build_bar "$PCT" 25)
printf '%b\n' "${C_SUBTEXT}ctx${R}  ${C_BLUE}${ctx_bar}${R}  ${C_BLUE}${PCT}%${R}"

# --- Lines 3-4: Usage limits (Anthropic API) ---
CACHE_FILE="/tmp/claude-usage-cache.json"
CACHE_TTL=300
FETCH_LOCK="/tmp/claude-usage-fetch.lock"

# Background fetch: retries with backoff, writes to cache file
bg_fetch_usage() {
    # Prevent concurrent fetches
    if [ -f "$FETCH_LOCK" ]; then
        local lock_age lock_ts
        lock_ts=$(cat "$FETCH_LOCK" 2>/dev/null || echo 0)
        lock_age=$(( $(date "+%s") - lock_ts ))
        # Stale lock (>60s) — remove it
        [ "$lock_age" -gt 60 ] && rm -f "$FETCH_LOCK"
        [ -f "$FETCH_LOCK" ] && return
    fi
    date "+%s" > "$FETCH_LOCK"

    (
        token=$(security find-generic-password -s "Claude Code-credentials" -w 2>/dev/null || true)
        if [ -z "$token" ]; then rm -f "$FETCH_LOCK"; exit 1; fi
        access_token=$(echo "$token" | jq -r '.claudeAiOauth.accessToken // .accessToken // .access_token // empty' 2>/dev/null || true)
        if [ -z "$access_token" ]; then rm -f "$FETCH_LOCK"; exit 1; fi

        for delay in 0 2 5 10; do
            [ "$delay" -gt 0 ] && sleep "$delay"
            result=$(curl -s --max-time 5 \
                -w '\n%{http_code}' \
                -H "Authorization: Bearer ${access_token}" \
                -H "anthropic-beta: oauth-2025-04-20" \
                "https://api.anthropic.com/api/oauth/usage" 2>/dev/null)
            http_code=$(echo "$result" | tail -1)
            body=$(echo "$result" | sed '$d')

            if [ "$http_code" = "200" ]; then
                echo "$body" | jq -e '.five_hour' > /dev/null 2>&1 && \
                    jq -n --arg d "$body" --argjson t "$(date '+%s')" \
                        '{cached_at: $t, data: ($d | fromjson)}' > "$CACHE_FILE" 2>/dev/null
                break
            fi
        done
        rm -f "$FETCH_LOCK"
    ) </dev/null >/dev/null 2>&1 &
}

get_usage_data() {
    if [ -f "$CACHE_FILE" ]; then
        local cached_at now age
        cached_at=$(jq -r '.cached_at // 0' "$CACHE_FILE" 2>/dev/null || echo 0)
        now=$(date "+%s")
        age=$(( now - cached_at ))
        if [ "$age" -lt "$CACHE_TTL" ]; then
            jq -r '.data' "$CACHE_FILE" 2>/dev/null
            return
        fi
        # Cache is stale — trigger background refresh, but still use stale data
        bg_fetch_usage
        jq -r '.data' "$CACHE_FILE" 2>/dev/null
        return
    fi

    # No cache at all — trigger background fetch, no data to show yet
    bg_fetch_usage
    return 1
}

print_usage_line() {
    local label="$1" pct="$2" reset_str="$3" color="$4"
    local bar
    bar=$(build_bar "$pct" 25)

    printf '%b\n' "${C_SUBTEXT}${label}${R}  ${color}${bar}${R}  ${color}${pct}%${R}  ${C_OVERLAY}resets in ${reset_str}${R}"
}

usage_data=$(get_usage_data 2>/dev/null)
if [ -n "$usage_data" ]; then
    five_hour_util=$(echo "$usage_data" | jq -r '.five_hour.utilization // 0' | awk '{printf "%d", $1}')
    five_hour_reset=$(echo "$usage_data" | jq -r '.five_hour.resets_at // empty')
    seven_day_util=$(echo "$usage_data" | jq -r '.seven_day.utilization // 0' | awk '{printf "%d", $1}')
    seven_day_reset=$(echo "$usage_data" | jq -r '.seven_day.resets_at // empty')

    five_hour_reset_display="?"
    [ -n "$five_hour_reset" ] && [ "$five_hour_reset" != "null" ] && five_hour_reset_display=$(format_reset_time "$five_hour_reset")
    seven_day_reset_display="?"
    [ -n "$seven_day_reset" ] && [ "$seven_day_reset" != "null" ] && seven_day_reset_display=$(format_reset_time "$seven_day_reset")

    print_usage_line " 5h" "$five_hour_util" "$five_hour_reset_display" "$C_MAUVE"
    print_usage_line " 7d" "$seven_day_util" "$seven_day_reset_display" "$C_PEACH"
fi
