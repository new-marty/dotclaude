#!/usr/bin/env bash
# Have Gemini turn a draft into Japanese prose. Prints the text on stdout and the backend
# that produced it on stderr.
#
#   gemini-write.sh DRAFT [BRIEF]          through Antigravity CLI (agy), no extra charge
#   gemini-write.sh --paid DRAFT [BRIEF]   through OpenRouter, billed per token; only after
#                                          the user has approved it for this call
#   gemini-write.sh --status               what each route can do right now
#   gemini-write.sh --setup-openrouter     paste an OpenRouter key into the Keychain
#
# The OpenRouter key comes from the Keychain, unless the machine renders it into a key file
# (GEMINI_WRITE_KEY_FILE, default ~/.config/secrets/gemini-write.env, as the Mac mini does from
# 1Password). The file then wins, so a key changed at its source reaches this script too.
#
# BRIEF holds the reader, the purpose, and any revision notes.
# Exit codes: 0 done, 2 usage, 3 agy quota used up, 4 agy signed out, 5 other agy error,
# 6 OpenRouter not usable (no key, or a key without a spending limit), 7 OpenRouter error.
# There is no automatic fallback from agy to OpenRouter: that decision is the user's.
set -euo pipefail

here=$(cd "$(dirname "$0")/.." && pwd)
# Tried in order; a model with no capacity hands over to the next one.
read -ra agy_models <<<"${GEMINI_WRITE_AGY_MODEL:-gemini-3.8-flash-high gemini-4-hydrogen-medium}"
or_model=${GEMINI_WRITE_OPENROUTER_MODEL:-google/gemini-3.8-flash}
keychain_service=openrouter
key_file=${GEMINI_WRITE_KEY_FILE:-$HOME/.config/secrets/gemini-write.env}
self=$0

die() { echo "$2" >&2; exit "$1"; }

# --- agy ------------------------------------------------------------------------------

# Run agy in an empty directory, so the agent has no files to read or edit.
agy_run() {
  local work rc=0
  work=$(mktemp -d)
  (cd "$work" && agy "$@" 2>&1) || rc=$?
  rm -rf "$work"
  return $rc
}

# The work Google account is for ~/starup only, the same split Claude Code uses there.
agy_profile() {
  [[ $PWD == "$HOME/starup" || $PWD == "$HOME/starup/"* ]] && echo work || echo personal
}

# agy reads one token from the Keychain, so a profile switch applies to the whole machine.
# Machines without ~/.gemini/switch-profile.sh have a single account and skip this.
agy_use_profile() {
  local switch=$HOME/.gemini/switch-profile.sh
  [[ -x $switch ]] || return 0
  "$switch" "$(agy_profile)"
}

agy_signed_out() {
  local where="$HOME/starup の外"
  [[ $(agy_profile) == work ]] && where="$HOME/starup の中"
  die 4 "agy の $(agy_profile) のアカウントが未ログインです。${where}でターミナルから agy を起動してログインしてください。"
}

# Exits with 3/4/5 when agy cannot take a request. Spends no quota.
agy_check() {
  command -v agy >/dev/null ||
    die 5 "agy が入っていません (brew install --cask antigravity-cli)。"
  agy_use_profile
  local out
  out=$(agy_run --output-format json -p=/quota) || true
  if [[ $(jq -r '.status // empty' <<<"$out" 2>/dev/null) != SUCCESS ]]; then
    grep -qi 'sign in' <<<"$out" && agy_signed_out
    die 5 "agy の状態を取れませんでした: ${out:0:300}"
  fi
  local empty
  empty=$(jq -r '.command.data.groups[]?.buckets[]?
            | select(.id | startswith("gemini"))
            | select(.disabled == true or (.remaining_fraction // 1) <= 0)
            | "\(.id) (リセット \(.reset_time))"' <<<"$out")
  [[ -z $empty ]] || die 3 "agy の Gemini 枠を使い切っています: $empty"
  jq -r '.response' <<<"$out" | sed '/^$/d; s/^/agy quota: /' >&2
}

# agy keeps retrying a model that has no capacity (HTTP 503) until --print-timeout runs
# out, so watch its log and move to the next model as soon as the 503 appears.
agy_write() {
  local model work log out_file out pid
  for model in "${agy_models[@]}"; do
    work=$(mktemp -d); log=$(mktemp); out_file=$(mktemp)
    (cd "$work" && exec agy --model "$model" --disable-slash-commands --output-format json \
       --print-timeout 300s --log-file "$log" -p "$prompt") >"$out_file" 2>&1 &
    pid=$!
    while kill -0 "$pid" 2>/dev/null && ! grep -q 'No capacity available' "$log"; do
      sleep 1
    done
    if kill -0 "$pid" 2>/dev/null; then
      kill "$pid"; wait "$pid" 2>/dev/null || true
      rm -rf "$work" "$log" "$out_file"
      echo "agy: $model に空きがないので、次のモデルを試します" >&2
      continue
    fi
    wait "$pid" || true
    out=$(cat "$out_file"); rm -rf "$work" "$log" "$out_file"
    if [[ $(jq -r '.status // empty' <<<"$out" 2>/dev/null) == SUCCESS ]]; then
      jq -r '.response' <<<"$out"
      echo "backend: agy ($model, $(agy_profile))" >&2
      return
    fi
    grep -qE 'RESOURCE_EXHAUSTED|quota reached' <<<"$out" &&
      die 3 "agy の枠を使い切りました: $(grep -oE 'Resets in[^."]*' <<<"$out" | head -1)"
    grep -qi 'sign in' <<<"$out" && agy_signed_out
    die 5 "agy が失敗しました: ${out:0:300}"
  done
  die 5 "agy のどのモデルにも空きがありません: ${agy_models[*]}"
}

# --- OpenRouter -----------------------------------------------------------------------

or_key() {
  if [[ -r $key_file ]]; then
    (set +u; . "$key_file" && [[ -n ${OPENROUTER_API_KEY:-} ]] && printf '%s' "$OPENROUTER_API_KEY")
  else
    security find-generic-password -a "$USER" -s "$keychain_service" -w 2>/dev/null
  fi
}

# Prints the key's limit line. Exits 6 when there is no key or the key has no limit,
# so a runaway loop can never spend more than the cap set on openrouter.ai.
or_check() {
  local key info
  key=$(or_key) || die 6 "OpenRouter のキーがありません ($self --setup-openrouter)。"
  info=$(curl -sS --max-time 30 https://openrouter.ai/api/v1/key -H "Authorization: Bearer $key") ||
    die 7 "OpenRouter に接続できませんでした。"
  jq -e '.data' >/dev/null 2>&1 <<<"$info" ||
    die 6 "キーが通りません: $(jq -c '.error // .' <<<"$info" | head -c 300)"
  [[ $(jq -r '.data.limit' <<<"$info") != null ]] ||
    die 6 "このキーには使用額の上限がありません。openrouter.ai/settings/keys で上限を付けてから使ってください。"
  jq -r '.data | "openrouter: 上限 $\(.limit) (リセット: \(.limit_reset // "なし")), 残り $\(.limit_remaining)"' <<<"$info"
}

or_write() {
  local key out
  or_check >&2
  key=$(or_key)
  out=$(jq -n --arg model "$or_model" --arg content "$prompt" \
          '{model: $model, messages: [{role: "user", content: $content}]}' |
        curl -sS --max-time 300 https://openrouter.ai/api/v1/chat/completions \
          -H "Authorization: Bearer $key" -H "Content-Type: application/json" -d @-) ||
    die 7 "OpenRouter に接続できませんでした。"
  if jq -e '.choices[0].message.content' >/dev/null 2>&1 <<<"$out"; then
    jq -r '.choices[0].message.content' <<<"$out"
    echo "backend: openrouter ($or_model, 従量課金)" >&2
    return
  fi
  case $(jq -r '.error.code // empty' <<<"$out") in
    402) die 7 "キーの上限かクレジット残高に達しました。上限のリセットを待つか、openrouter.ai で見直してください。" ;;
    429) die 7 "OpenRouter のレート制限に当たりました。時間をおいてください。" ;;
    *)   die 7 "OpenRouter が失敗しました: $(jq -c '.error // .' <<<"$out" | head -c 300)" ;;
  esac
}

setup_openrouter() {
  local key
  [[ ! -e $key_file ]] || die 2 "このマシンはキーを $key_file から読みます。キーはそのファイルの元で替えてください。"
  printf 'OpenRouter の API キーを貼り付けて Enter (画面には表示されません): ' >&2
  IFS= read -rs key
  echo >&2
  key=$(printf '%s' "$key" | tr -d '[:space:]')
  [[ $key == sk-or-* ]] || die 2 "sk-or- で始まるキーではありません。保存しませんでした。"
  # `security -i` reads the command from stdin, so the key never appears in argv.
  printf 'add-generic-password -U -a %s -s %s -l "OpenRouter API key" -w %s\n' \
    "$USER" "$keychain_service" "$key" | security -i >/dev/null
  echo "キーチェーンに保存しました (service: $keychain_service)。" >&2
  or_check
}

status() {
  (agy_check 2>&1 && echo "agy: 使える ($(agy_profile), ${agy_models[*]})") || true
  (or_check 2>&1) || true
}

# --- main -----------------------------------------------------------------------------

paid=false
case ${1:-} in
  --setup-openrouter) setup_openrouter; exit ;;
  --status) status; exit ;;
  --paid) paid=true; shift ;;
esac
[[ -n ${1:-} ]] || { sed -n '2,15p' "$self" | sed 's/^# \{0,1\}//'; exit 2; }

draft=$1
brief=${2:-}
[[ -r $draft ]] || die 2 "読めません: $draft"
[[ -z $brief || -r $brief ]] || die 2 "読めません: $brief"

prompt=$(cat "$here/assets/prompt.md")
[[ -z $brief ]] || prompt+=$'\n読み手と目的、直してほしい点:\n\n'"$(cat "$brief")"
prompt+=$'\n\n下書き:\n\n'"$(cat "$draft")"

if $paid; then
  or_write
else
  agy_check
  agy_write
fi
