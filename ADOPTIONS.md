# 取り込みの記録

外部から取り込んだもの、検討して見送ったものを1行ずつ記録する。git の履歴は同期フックの
自動コミットで埋まっていて、一件ごとの意図が残らないため。

各 `SKILL.md` の冒頭には出典とライセンスをコメントで書く。ファイル単体を渡しても帰属が
失われないようにするため。このファイルはその索引で、見送ったものも載せる。

新しい行を表の上に足す。

## 採用

| 名前 | 出典 | ライセンス | 手を入れたところ |
| --- | --- | --- | --- |
| `output-styles/concise.md` | [i-have-adhd](https://github.com/ayghri/i-have-adhd) | MIT | 規則を3つに絞って日本語化。同時に守れる制約は3つ程度という研究に合わせた |
| `z-show-me` | [humanlayer/skills](https://github.com/humanlayer/skills) | MIT | HTML の出し方を Artifact / SendUserFile に差し替え |
| `z-teach` | [mattpocock/skills](https://github.com/mattpocock/skills) | MIT | 教材を作るディレクトリを確認する節を追加 |
| `z-to-questionnaire` | 同上 | MIT | 日本語トリガーのみ |
| `z-prototype` | 同上 | MIT | 日本語トリガーのみ |
| `z-grilling` | 同上 | MIT | 日本語で全面的に書き直し。1問ずつ訊く・[SOCCR](https://jacobian.org/2021/jan/30/soccr/) 形式・答えられないときの分岐 |
| `z-wait-what` | 同上 | MIT | 日本語に書き直し |
| `z-unstuck` | [oi-owarasero](https://github.com/nwiizo/oi-owarasero) | MIT | 末尾に独自の節 |
| `z-review-finding` | [p3bot/library](https://github.com/p3bot/library) の Per-item Template | MPL-2.0 | 日本語で全面的に書き直し |
| `z-eli5` | [claude-plugins-community](https://github.com/anthropics/claude-plugins-community) | Apache-2.0 | 出力言語の指定を追加 |
| `frontend-design` | claude-plugins-official | 上流 | プラグイン。本体は同期されない |

## 見送り

| 名前 | 出典 | 理由 |
| --- | --- | --- |
| natural-japanese | [coji/natural-japanese](https://github.com/coji/natural-japanese) | 規範が `z-japanese-proofreading` と競合する。lint が検出するのは翻訳調と文長で、困っている長さと抽象度には効かない |
| i-have-adhd（スキルとして） | 同上 | output style と目的が重なる。二重に持つとどちらが効いているか分からない |

## 自作

`z-japanese-proofreading` / `z-cognitive-rhythm-writing` / `z-create-pr` / `z-start-task` /
`z-writing-for-readers`

`skills/` 直下のシンボリックリンクは Orca が注入するもので、管理対象外。
