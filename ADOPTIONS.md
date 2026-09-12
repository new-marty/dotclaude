# 取り込みの記録

外部から持ち込んだスキル・規範・設定について、どこから取り、何を変え、なぜそうしたかを
一件ずつ記録する。検討して採用しなかったものも同じ形式で残す。

## なぜ記録するか

`skills/` には自作のものと外部から取り込んだものが混在する。取り込んだものをそのまま
置くことは少なく、訳し直す、節を足す、既存のスキルに統合する、といった手が入る。数か月
経つと、どれが自作でどれが借り物か、上流のどこをなぜ変えたのかが分からなくなる。

git の履歴はこの用途には使えない。同期フック（`scripts/sync-push.sh`）が
`Sync Claude Code configuration from Marty` という同一のメッセージで自動コミットするため、
一件ごとの意図がコミットに残らない。

採用しなかったものも書く。記録がないと、同じ記事や同じリポジトリを半年後にもう一度評価
することになる。判断を覆すときも、前回の理由が残っているほうが速く決まる。

## 記録の置き場所

二層に分ける。

- **このファイル** — 全件の索引。採用・不採用の両方、判断の理由、上流との差分の要約。
- **各 `SKILL.md` 冒頭の HTML コメント** — 出典 URL とライセンス、上流の範囲と自分の加筆の
  境界。ファイル単体を他所へ渡しても帰属が失われないよう、ライセンス上必要な情報はここにも
  重複して書く。

## 書き方

新しいエントリを各節の先頭に足す。日付は判断した日。

採用したものに書く項目:

- **出典** — URL。記事で知ったなら記事の URL も併記する
- **ライセンス**
- **形態** — ベンダリング / 部分引用 / 既存スキルへの統合 / プラグイン
- **上流との差分** — 何を変えたか。変えていないなら「なし」
- **採用理由**

採用しなかったものに書く項目:

- **出典**、**ライセンス**
- **判定理由**
- **部分的に取り入れたもの** — あれば、どこへ何を入れたか

### 形態について

プラグインとして入れたものは、有効・無効のフラグだけが `settings.json` の `enabledPlugins`
で同期され、プラグイン本体はマシンごとにマーケットプレイスから取得される。`plugins/` は
`.gitignore` で追跡対象外にしてあるため、このリポジトリを clone しただけでは本体は入らない。

---

## 採用したもの

### 出力スタイルと CLAUDE.md の作り直し — 2026-09-13

- **出典**: https://github.com/ayghri/i-have-adhd (MIT)、
  https://www.aihero.dev/skills-code-review、
  https://uhyeon.dev/blog/ai-agent-assumption-prevention、
  公式ドキュメント https://code.claude.com/docs/en/output-styles と
  https://code.claude.com/docs/en/memory
- **形態**: `output-styles/concise.md` の全面書き直し、`CLAUDE.md` の縮小、
  `skills/z-writing-for-readers/` の新設
- **内容**: 判定できる規則だけを書く方針に切り替えた。禁止する言い回しの名指し、
  行数と項目数の上限、送信前に消すもののチェックリスト、指摘の件数上限と nit の定義、
  着手前の前提確認の手順、変動する数字の禁止。「簡潔に」「本質を」のような、守ったか
  自分で判定できない規範は全部捨てた。
  `CLAUDE.md` は公式の分類（プロジェクトの規約とコードベースの文脈）に合わせ、言語の
  規約とスキルを読む場面だけを残した。応答の書き方と作業の進め方は output style 側へ
  移した。「読者のために書く」は文書を書くときだけ要るので、スキルに切り出した。
- **採用理由**: 抽象的な規範をいくら足しても守られないことが、この設計を決めた日の
  会話自体で確認できた。調べた既存の解法（i-have-adhd、code-review スキルの severity
  ラベル、assumption を構造で止める手法）は例外なく判定できる形をしていた。
- **未検証**: i-have-adhd の効果測定は英語で行われたもので、日本語に書き直した本文で
  同じ効果が出るかは確かめていない。

### z-show-me — 2026-09-13

- **出典**: https://github.com/humanlayer/skills/blob/main/plugins/show-me/skills/show-me/SKILL.md
- **ライセンス**: MIT (Copyright (c) 2026 HumanLayer)
- **形態**: ベンダリング（`skills/z-show-me/SKILL.md`）
- **上流との差分**: `name` を `z-show-me` に改名。`description` に日本語のトリガー語を追記。
  HTML 出力の項を書き換え、`Bash(open *.html)` の代わりに Artifact / SendUserFile を使う
  「この環境での出し方」節を追加した。
- **採用理由**: 作業中の話題を最小の図で示す型。擬似コード・呼び出し木・ファイル木・
  mermaid・diff の使い分けが具体的に書かれている。前提知識ゼロの相手向けの `z-eli5` とは
  用途が分かれる。

### z-teach / z-to-questionnaire / z-prototype — 2026-09-13

- **出典**: https://github.com/mattpocock/skills （`skills/productivity/teach`,
  `skills/productivity/to-questionnaire`, `skills/engineering/prototype`）。
  組み合わせ方を知った記事: https://tech.algomatic.jp/entry/2026/08/31/185832
- **ライセンス**: MIT (Copyright (c) 2026 Matt Pocock)
- **形態**: ベンダリング（参照される `LOGIC.md` / `UI.md` / `*-FORMAT.md` も一緒に取り込み）
- **上流との差分**: `name` をそれぞれ `z-` 付きに改名。`z-to-questionnaire` の
  `description` に日本語のトリガー語を追記。`z-teach` に「作業ディレクトリ」節を追加した
  （上流は現在のディレクトリに `MISSION.md`・`lessons/`・`learning-records/` を作るため、
  作業中のリポジトリで呼ぶと教材が散る）。`z-prototype` は上流のまま。
- **採用理由**: `z-grilling` の分岐先として使う。下の「z-grilling の分岐」を参照。

### z-grilling の分岐 — 2026-09-13

- **出典**: https://tech.algomatic.jp/entry/2026/08/31/185832 （記事は mattpocock/skills の
  スキル群の組み合わせ方を述べたもので、上流の `grilling/SKILL.md` にこの節は無い）
- **形態**: 既存スキルへの統合（`skills/z-grilling/SKILL.md` の日本語節に「5. 答えが返って
  こないときの分岐」を追加）
- **内容**: ユーザーが答えられない問いを、理由で3つに分類する。概念の欠落なら `z-teach`、
  権限・情報の欠落なら `z-to-questionnaire`、経験の欠落なら `z-prototype` へ分岐し、証拠を
  持ち帰ってから同じ問いを訊き直す。
- **採用理由**: 改変前の `z-grilling` は、答えが返ってこないとき黙って止まるだけで、その先の
  規定がなかった。推測で埋めた前提が仕様・チケット・実装へ流れるのを止める。

### concise.md への i-have-adhd の取り込み（第1版・上のエントリで置き換え済み） — 2026-09-13

- **出典**: https://github.com/ayghri/i-have-adhd （記事:
  https://qiita.com/suwa_nobu/items/cec37ce5a6141bb3eefc）
- **ライセンス**: MIT
- **形態**: 部分引用（`output-styles/concise.md` に3節を追加）
- **取り込んだもの**: 手順は番号付きで1手順1動作 / 所要時間は具体的な単位で / 完了は
  「何が動くようになったか」で示す / エラー時は淡々と原因と直し方を書く / 最後に2分以内で
  始められる次の一手を1つだけ書く。
- **スキルとして入れなかった理由**: 目的が `concise.md` と完全に重なる。`concise.md` は常時
  有効で、i-have-adhd は `/i-have-adhd` の明示起動。二重に持つと、どちらが効いているのかが
  応答から判別できなくなる。

### z-unstuck — 2026-09-10

- **出典**: https://github.com/nwiizo/oi-owarasero （書籍『おい、とりあえず終わらせろ』に基づく）
- **ライセンス**: MIT (Copyright (c) 2026 nwiizo)
- **形態**: ベンダリング（`skills/z-unstuck/SKILL.md`）
- **上流との差分**: `name` を `z-unstuck` に改名。末尾の最終ルール以降に独自の節を追記。
  それ以外の本文は上流のまま。
- **採用理由**: 止まっているタスクを扱う対話型スキルが手元になかった。

### z-review-finding — 2026-09-10

- **出典**: https://github.com/p3bot/library/blob/main/tasks/review/pre-commit/task.md の
  "Per-item Template" 節
- **ライセンス**: MPL-2.0
- **形態**: 部分引用（当該節の日本語による書き直し）
- **上流との差分**: 全面的に書き直した日本語版。MPL-2.0 の派生物として同ライセンスが及ぶ。
- **採用理由**: レビュー指摘を「コードを開いていない読者」向けに書く規範が必要だった。

### z-wait-what — 2026-09-10

- **出典**: https://github.com/mattpocock/skills/blob/main/skills/productivity/wait-what/SKILL.md
- **ライセンス**: MIT (Copyright (c) 2026 Matt Pocock)
- **形態**: ベンダリング（日本語への書き直し）
- **上流との差分**: `name` を `z-wait-what` に改名。本文は上流の一文の日本語訳で、
  「日本語なら `z-japanese-proofreading` の規範に沿う」の条件を足した。上流は
  ASD-STE100 Simplified Technical English のみを指定している。
- **採用理由**: 説明が伝わらなかったときに言い直しを求める一手。

### z-grilling — 2026-08-24 以前（2026-08-27 に日本語節を追加、2026-09-13 に分岐を追加）

- **出典**: https://github.com/mattpocock/skills/blob/main/skills/productivity/grilling/SKILL.md
- **ライセンス**: MIT (Copyright (c) 2026 Matt Pocock)
- **形態**: ベンダリング＋日本語の上書き節
- **上流との差分**: 英語本文は上流のまま。末尾に「進め方（上の英語本文に優先する）」節を
  追加し、**質問を1問ずつ出す**、**質問の前に前提を説明する**、**平易に書く**、出力形式、
  **答えが返ってこないときの分岐**、の5点で上流の挙動を上書きしている。上流は frontier を
  まとめて1ラウンドで訊く設計。
- **採用理由**: 計画・設計の壁打ち相手として `z-start-task` から呼ぶ。

### z-eli5 — 2026-08-24 以前

- **出典**: https://github.com/anthropics/claude-plugins-community の `eli5` スキル
- **ライセンス**: Apache-2.0
- **形態**: ベンダリング（`skills/z-eli5/SKILL.md`）
- **上流との差分**: `name` を `z-eli5` に改名。`description` に日本語のトリガー語を追記。
  本文に「ユーザーが書いている言語で artifact を書く」の一文を追記。
- **採用理由**: 前提知識ゼロの相手への説明を HTML artifact で行う型として使える。

### frontend-design プラグイン — 時期不明

- **出典**: `claude-plugins-official` マーケットプレイス
- **ライセンス**: 上流に従う
- **形態**: プラグイン（`settings.json` の `enabledPlugins` で有効化）
- **上流との差分**: なし
- **採用理由**: UI を新規に作るときの視覚設計の指針。

---

## 検討して採用しなかったもの

### coji/natural-japanese — 2026-09-13

- **出典**: https://github.com/coji/natural-japanese
- **ライセンス**: MIT
- **内容**: 12条の文体憲法、`sudachipy` による形態素解析 lint、0〜100 のスコア。
  `SKILL.md` 20KB、`references/` 計 160KB、`scripts/lint.py` 119KB。
- **判定理由**: 規範部分が `z-japanese-proofreading` と `z-cognitive-rhythm-writing` に
  正面から競合する。両方を置くと、どちらに従うのかが応答ごとに揺れる。検査層（lint と
  スコア）は自作規範にない要素だが、検出対象は翻訳調・禁止語・文長で、実際に困っている
  「長さと抽象度」には効かない。設定同期リポジトリに 280KB を持ち込む理由が立たなかった。
- **再検討の条件**: 翻訳調や文長の機械検出が必要になったとき。その場合も `~/.claude` には
  置かず、別リポジトリに置いて `z-japanese-proofreading` から参照する。

### ayghri/i-have-adhd（スキルとして） — 2026-09-13

`concise.md` への部分取り込みとして採用済み。スキルそのものを入れなかった理由は
「採用したもの」側のエントリに書いた。

---

## 自作のもの

出典を持たない。参考までに一覧を置く。

- `z-japanese-proofreading` — 日本語を人に出す前の推敲規範
- `z-cognitive-rhythm-writing` — 日本語の説明文に緩急を設計する規範
- `z-create-pr` — PR 作成
- `z-writing-for-readers` — セッションの外の読者が読む文章の規範
- `z-start-task` — タスク選定から実装・セルフレビューまで

`skills/` 直下のシンボリックリンク（`computer-use`, `find-skills`, `orca-cli`,
`orchestration`）は Orca が注入するもので、このリポジトリの管理対象ではない。
