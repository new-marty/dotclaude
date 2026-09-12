# dotclaude

Claude Code のユーザーレベル設定（`~/.claude`）を、複数のマシン間で同期するための
リポジトリ。

Claude Code はグローバルな指示・スキル・出力スタイル・設定をホームディレクトリの
`~/.claude` に置く。同じディレクトリには会話ログ、キャッシュ、認証トークンといった
実行時の状態も溜まる。このリポジトリは前者だけを追跡し、後者は一切含めない。

## 追跡しているもの

| パス | 内容 |
| --- | --- |
| `CLAUDE.md` | 全プロジェクトに適用されるグローバル指示 |
| `settings.json` | 出力スタイル、権限、フック、statusline、有効プラグイン、MCP の拒否設定 |
| `statusline.sh` | statusline の描画スクリプト（`settings.json` から呼ばれる） |
| `skills/` | スキル。自作と取り込みのどちらも `z-` で始まる |
| `output-styles/` | 応答の書き方を上書きする出力スタイル |
| `scripts/` | フックから呼ばれるスクリプト |
| `ADOPTIONS.md` | 外部から取り込んだもの・検討して見送ったものの記録 |

`.gitignore` は**既定ですべてを無視し、追跡するものだけを明示的に許可する**方式で書いてある。
Claude Code が新しい実行時ファイルを作っても追跡対象に紛れ込まない。認証トークン
（`personal-oauth-token` など）、会話ログ（`history.jsonl`、`sessions/`、`projects/`）、
キャッシュはすべて除外される。許可しているのは上の表のほかに `.gitignore` 自身と `README.md`。

`skills/` 直下には Orca がマシンごとに作るシンボリックリンク（`computer-use`、`find-skills`、
`orca-cli`、`orchestration`）が置かれる。許可行のあとに再度の無視指定を書いて追跡対象から外して
ある。追跡すると Orca のない環境でリンク切れになるため。

追跡対象を増やすときは `.gitignore` に許可行を足す。ディレクトリは2行必要
（`!name/` と `!name/**`）。

`skills/` には自作のものと、外部リポジトリから取り込んだものが混在する。取り込んだ
スキルは本文の先頭に、出典の URL とライセンスをコメントで記す。そのまま持ってきた
場合は `name` 以外を上流と一致させる。手を入れた場合（訳し直した、節を足した）は、
どこまでが上流でどこからが自分のものかを同じコメントに書く。`name` を書き換えるのは、
このリポジトリのスキルがすべて `z-` で始まる規約に合わせるためである。

冒頭コメントはそのファイル単体の帰属を守るためのもので、全体の見通しは持たない。
何をどこから取り、何を変え、何を検討して見送ったかは `ADOPTIONS.md` に一件ずつ
記録する。取り込みや見送りを決めたら、スキルの追加と同じタイミングでこのファイルにも
エントリを足す。

## 同期の仕組み

`settings.json` に登録されたフックが自動で動く。手動の pull / push は要らない。

| タイミング | 実行されるもの | 動作 |
| --- | --- | --- |
| セッション開始 | `scripts/sync-pull.sh` | `git pull --rebase --autostash` |
| セッション終了 | `scripts/sync-push.sh` | 変更があれば commit して push |
| `EnterWorktree` の直後 | `scripts/sync-worktree-env.sh` | 新しい worktree へ `.env` を複製する |

`sync-worktree-env.sh` は同期とは無関係で、`example-app` リポジトリだけを対象に決め打ちしている。
複製するのは `backend/.env`、`backend/workers/.env`、`frontend/.env` の3本で、複製先に同名の
ファイルが既にあれば上書きしない。それ以外のリポジトリでは何もせずに終了する。

`--autostash` により、ローカルの編集は pull の前に退避され、あとで戻される。
`sync-push.sh` はロックを非ブロッキングで取る。他のセッションが先に走っていれば、後から来た
セッションは何もせずに終わる。待って順番に実行するわけではないので、そのセッションの変更は次に
push が走るまで残る。未解決の衝突がある間は commit しない（衝突マーカーごと push するのを防ぐため）。

## statusline の表示

`statusline.sh` は最大4行を描画する。1行目がアカウント・モデル・ディレクトリ・git、
2行目がコンテキスト使用率、3〜4行目が利用量リミット（5時間枠と7日枠）。利用量を取得できないとき
（初回起動、キーチェーン未取得、API 失敗）は3〜4行目が出ず、2行になる。

1行目の先頭には、既定以外のアカウントを使っているときだけその名前を出す。
`~/work` 配下では `CLAUDE_SECURESTORAGE_CONFIG_DIR=~/.claude-work` が
設定され、`work` と表示される。既定のアカウントでは何も出ない。

1行目の末尾には、このリポジトリの同期状態を出す。正常時は何も表示しない。

- `.claude ⇡N` — push できていないコミットが N 件ある
- `⚠ .claude CONFLICT` — 未解決の衝突がある

### アカウントごとの利用量

Claude Code はアカウントごとに別の認証情報をログインキーチェーンへ保存する。
既定のアカウントはサービス名 `Claude Code-credentials`、
`CLAUDE_SECURESTORAGE_CONFIG_DIR` で選ばれるアカウントは
`Claude Code-credentials-<tag>` で、`<tag>` はそのディレクトリの絶対パスの
SHA-256 の先頭8桁である。

statusline はこの規則でサービス名を組み立て、いま実際にサインインしている
アカウントの利用量を表示する。キャッシュ（`/tmp/claude-usage-cache*.json`）も
アカウントごとに分けてあるため、2つのアカウントが互いの数値を上書きしない。

`⇡N` が消えないときは push が失敗している。SSH エージェントがロックされている、
ネットワークが繋がっていない、リモートが先に進んでいる、のいずれか。

## 衝突が起きたとき

`⚠ .claude CONFLICT` が出たら、2台のマシンが同じファイルを変更している。
フックは衝突を検出すると何もせずに終了するので、自分で解決する。

```bash
git -C ~/.claude status          # 衝突しているファイルを確認
git -C ~/.claude diff            # 衝突箇所を見る
# ファイルを編集して衝突マーカーを取り除く
git -C ~/.claude add <file>
git -C ~/.claude rebase --continue
```

pull 前の状態は stash にも残っている（`git -C ~/.claude stash list`）。

## 新しいマシンでの初期化

dotfiles リポジトリ（`github.com:<you>/dotfiles`）の
`run_once_before_bootstrap-dotclaude.sh` が自動で実行する。手順は
`chezmoi init --apply git@github.com:<you>/dotfiles.git` だけ。

このスクリプトは `~/.claude` をその場で git リポジトリ化する。clone は使えない。
Claude Code のインストーラが `~/.claude/downloads/` などを先に作るため、
`git clone` が「ディレクトリが空でない」として失敗するからである。

既にそのマシンに存在するファイルは上書きされない。リモートと内容が違う場合は
ローカル版が残り、`git status` に変更として現れる。どちらを採るかは手で決める。

手動で実行する場合:

```bash
mkdir -p ~/.claude && cd ~/.claude
git init -b main
git remote add origin git@github.com:new-marty/dotclaude.git
git fetch origin main
git branch -f main origin/main && git symbolic-ref HEAD refs/heads/main
git branch -u origin/main main
git reset origin/main
git checkout-index -a          # 存在しないファイルだけ書き出す
```
