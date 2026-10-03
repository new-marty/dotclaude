#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

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

build_bar() {
    local pct="$1" width="${2:-12}"
    local filled=$(( pct * width / 100 ))
    local bar=""
    for i in $(seq 1 "$width"); do
        if [ "$i" -le "$filled" ]; then bar="${bar}█"; else bar="${bar}░"; fi
    done
    echo "$bar"
}

# Time until a reset, from Unix epoch seconds (what Claude Code sends) or an
# ISO 8601 timestamp (what the usage endpoint returns).
format_reset_time() {
    local when="$1" epoch
    if [[ "$when" =~ ^[0-9]+$ ]]; then
        epoch="$when"
    else
        local clean="${when%%.*}"
        clean="${clean%%+*}"
        epoch=$(TZ=UTC date -jf "%Y-%m-%dT%H:%M:%S" "$clean" "+%s" 2>/dev/null || echo "")
        if [ -z "$epoch" ]; then echo "$when"; return; fi
    fi

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
    result="${result% }"
    echo "${result:-now}"
}

# Which billing path this session runs on. Claude Code does not say so in the
# JSON, so follow its authentication precedence
# (https://code.claude.com/docs/en/authentication#authentication-precedence):
# a cloud provider, then ANTHROPIC_AUTH_TOKEN / ANTHROPIC_API_KEY, then an
# apiKeyHelper, and only then the claude.ai login. rate_limits in the JSON is
# sent only to Pro and Max subscribers, so its presence settles the question.
is_truthy() { case "${1:-}" in 1|true|TRUE|True|yes) return 0;; *) return 1;; esac; }
# The ~/.claude checkout; CLAUDE_SYNC_DIR lets tests point at a scratch clone.
SYNC_DIR="${CLAUDE_SYNC_DIR:-$HOME/.claude}"
BILLING="subscription"
if is_truthy "${CLAUDE_CODE_USE_BEDROCK:-}"; then BILLING="Bedrock"
elif is_truthy "${CLAUDE_CODE_USE_VERTEX:-}"; then BILLING="Vertex"
elif is_truthy "${CLAUDE_CODE_USE_FOUNDRY:-}"; then BILLING="Foundry"
elif [ -n "${ANTHROPIC_AUTH_TOKEN:-}${ANTHROPIC_API_KEY:-}" ]; then BILLING="API"
else
    for f in "$SYNC_DIR/settings.json" "$DIR/.claude/settings.json" "$DIR/.claude/settings.local.json"; do
        if [ -f "$f" ] && jq -e '.apiKeyHelper // empty' "$f" >/dev/null 2>&1; then
            BILLING="API"; break
        fi
    done
fi
echo "$input" | jq -e '.rate_limits.five_hour // .rate_limits.seven_day // empty' >/dev/null 2>&1 &&
    BILLING="subscription"

# --- Line 1: Account | Model | Dir | Git | ~/.claude sync ---
sep="${C_OVERLAY}|${R}"
model_s="${C_BLUE}${MODEL}${R}"
dir_s="${C_YELLOW}${DIR}${R}"

# Which account this session is signed in as. Work directories select a
# non-default account through CLAUDE_SECURESTORAGE_CONFIG_DIR; name it after
# that directory (~/.claude-work reads as "work"). The default account
# needs no label, so the marker only appears where it carries information.
ACCOUNT_S=""
if [ -n "${CLAUDE_SECURESTORAGE_CONFIG_DIR:-}" ]; then
    account_name="${CLAUDE_SECURESTORAGE_CONFIG_DIR##*/}"
    account_name="${account_name#.claude-}"
    ACCOUNT_S="${BOLD}${C_MAUVE}${account_name}${R} ${sep} "
fi

# Pay-per-token sessions name their provider, so they are never mistaken for
# a subscription session.
BILLING_S=""
[ "$BILLING" != "subscription" ] && BILLING_S="${BOLD}${C_PEACH}${BILLING}${R} ${sep} "

# ~/.claude is a git repository synced across machines by the SessionStart and
# SessionEnd hooks. Surface the two states a hook cannot resolve on its own:
# an unresolved merge conflict, and commits that failed to reach the remote.
CLAUDE_SYNC=""
if [ -d "$SYNC_DIR/.git" ]; then
    if [ -n "$(git -C "$SYNC_DIR" ls-files --unmerged 2>/dev/null | head -1)" ]; then
        CLAUDE_SYNC=" ${sep} ${BOLD}${C_RED}⚠ .claude CONFLICT${R}"
    elif [ "$(git -C "$SYNC_DIR" config dotclaude.role 2>/dev/null)" = pull-only ]; then
        # A pull-only device never pushes. Show how far behind the last fetch it is,
        # and that it sits on the "local" branch when it keeps edits to shared files.
        behind=$(git -C "$SYNC_DIR" rev-list --count 'HEAD..@{u}' 2>/dev/null || echo 0)
        parts=""
        [ "$(git -C "$SYNC_DIR" branch --show-current 2>/dev/null)" != main ] && parts="local"
        [ "${behind:-0}" -gt 0 ] && parts="${parts:+$parts }⇣${behind}"
        [ -n "$parts" ] && CLAUDE_SYNC=" ${sep} ${C_YELLOW}.claude ${parts}${R}"
    else
        ahead=$(git -C "$SYNC_DIR" rev-list --count '@{u}..HEAD' 2>/dev/null || echo 0)
        [ "${ahead:-0}" -gt 0 ] && CLAUDE_SYNC=" ${sep} ${C_YELLOW}.claude ⇡${ahead}${R}"
        # sync-push.sh leaves this marker when it could not rebase or push.
        if [ -f "$SYNC_DIR/.git/claude-sync-diverged" ]; then
            CLAUDE_SYNC=" ${sep} ${BOLD}${C_RED}⚠ .claude DIVERGED${R}"
        fi
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

printf '%b\n' "${BILLING_S}${ACCOUNT_S}${model_s} ${sep} ${dir_s}${GIT_INFO}${CLAUDE_SYNC}"

# --- Line 2: Context bar ---
ctx_bar=$(build_bar "$PCT" 25)
printf '%b\n' "${C_SUBTEXT}ctx${R}  ${C_BLUE}${ctx_bar}${R}  ${C_BLUE}${PCT}%${R}"

# --- Lines 3-4: Usage limits ---
# Claude Code keeps one credential per account in the login Keychain. The
# default account uses the service name "Claude Code-credentials"; setting
# CLAUDE_SECURESTORAGE_CONFIG_DIR selects a second account whose service name
# carries the first eight hex digits of the SHA-256 of that directory's
# absolute path. Read the credential belonging to the account this session is
# actually signed in as, and cache its usage separately, so the two accounts do
# not report each other's limits.
KEYCHAIN_SERVICE="Claude Code-credentials"
ACCOUNT_TAG=""
if [ -n "${CLAUDE_SECURESTORAGE_CONFIG_DIR:-}" ]; then
    ACCOUNT_TAG=$(printf '%s' "$CLAUDE_SECURESTORAGE_CONFIG_DIR" |
        openssl dgst -sha256 2>/dev/null | awk '{print substr($NF, 1, 8)}')
    [ -n "$ACCOUNT_TAG" ] && KEYCHAIN_SERVICE="${KEYCHAIN_SERVICE}-${ACCOUNT_TAG}"
fi

CACHE_FILE="/tmp/claude-usage-cache${ACCOUNT_TAG:+-$ACCOUNT_TAG}.json"
CACHE_TTL=300
FETCH_LOCK="/tmp/claude-usage-fetch${ACCOUNT_TAG:+-$ACCOUNT_TAG}.lock"

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
        token=$(security find-generic-password -s "$KEYCHAIN_SERVICE" -w 2>/dev/null || true)
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

# Pay-per-token: the session's estimated cost replaces the subscription
# limits, plus the spend limit when a Claude apps gateway sets one.
if [ "$BILLING" != "subscription" ]; then
    cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0' | awk '{printf "%.2f", $1}')
    printf '%b\n' "${C_SUBTEXT}cost${R}  ${C_PEACH}\$${cost}${R}  ${C_OVERLAY}this session, at list price${R}"
    spend_pct=$(echo "$input" | jq -r '.rate_limits.spend_limit.used_percentage // empty' | awk '{printf "%d", $1}')
    if [ -n "$spend_pct" ]; then
        spend_reset=$(echo "$input" | jq -r '.rate_limits.spend_limit.resets_at // empty')
        print_usage_line "spend" "$spend_pct" "$(format_reset_time "${spend_reset:-?}")" "$C_RED"
    fi
    exit 0
fi

# Subscription: Claude Code sends the limits itself after the first API
# response. Before that, fall back to the usage endpoint.
five_hour_util=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty' | awk '{printf "%d", $1}')
if [ -n "$five_hour_util" ]; then
    five_hour_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
    seven_day_util=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // 0' | awk '{printf "%d", $1}')
    seven_day_reset=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')
    print_usage_line " 5h" "$five_hour_util" "$(format_reset_time "${five_hour_reset:-?}")" "$C_MAUVE"
    print_usage_line " 7d" "$seven_day_util" "$(format_reset_time "${seven_day_reset:-?}")" "$C_PEACH"
    exit 0
fi

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
