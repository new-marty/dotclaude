# 取り込みの記録

外部から取り込んだもの、検討して見送ったものを1行ずつ記録する。git の履歴は同期フックの
自動コミットで埋まっていて、一件ごとの意図が残らないため。

各 `SKILL.md` の冒頭には出典とライセンスをコメントで書く。ファイル単体を渡しても帰属が
失われないようにするため。このファイルはその索引で、見送ったものも載せる。

新しい行を表の上に足す。

## 採用
2026-09-13 に全体を監査し、実害のあるバグ（`allowed-tools` の不足、内部参照の誤り、呼ぶスキルの
取り違え、上流の `open` コマンド前提）を潰した。同じ規則が複数ファイルにあったものは、出力言語を
`CLAUDE.md`、日本語の文章規則を `z-japanese-proofreading`、判定テストを `z-writing-for-readers`、
応答の長さを `output-styles/concise.md` に寄せた。


| 名前 | 出典 | ライセンス | 手を入れたところ |
| --- | --- | --- | --- |
| `output-styles/concise.md` | [i-have-adhd](https://github.com/ayghri/i-have-adhd) | MIT | 規則を3つに絞って日本語化。同時に守れる制約は3つ程度という研究に合わせた |
| `z-show-me` | [humanlayer/skills](https://github.com/humanlayer/skills) | MIT | HTML の出し方を Artifact / SendUserFile に差し替え。日本語トリガー |
| `z-teach` | [mattpocock/skills](https://github.com/mattpocock/skills) | MIT | 教材を作るディレクトリを確認する節、HTML の渡し方を追加。日本語トリガー、`disable-model-invocation`、`argument-hint` |
| `z-to-questionnaire` | 同上 | MIT | 質問票の書き出し先を確認する節を追加。日本語トリガー、`disable-model-invocation` |
| `z-prototype` | 同上 | MIT | 本文は上流のまま。日本語トリガー、`disable-model-invocation` |
| `z-grilling` | 同上 | MIT | 日本語で全面的に書き直し。1問ずつ訊く・[SOCCR](https://jacobian.org/2021/jan/30/soccr/) 形式・答えられないときの分岐 |
| `z-wait-what` | 同上 | MIT | 日本語に書き直し。`z-japanese-proofreading` の条件を追加、`disable-model-invocation` |
| `z-unstuck` | [oi-owarasero](https://github.com/nwiizo/oi-owarasero) | MIT | 末尾に独自の節 |
| `z-review-finding` | [p3bot/library](https://github.com/p3bot/library) の Per-item Template | MPL-2.0 | 日本語で全面的に書き直し |
| `z-eli5` | [claude-plugins-community](https://github.com/anthropics/claude-plugins-community) | Apache-2.0 | 出力言語の指定を追加。日本語トリガー、`argument-hint` |
| `frontend-design` | claude-plugins-official | 上流 | プラグイン。本体は同期されない |

## 見送り

| 名前 | 出典 | 理由 |
| --- | --- | --- |
| natural-japanese | [coji/natural-japanese](https://github.com/coji/natural-japanese) | 規範が `z-japanese-proofreading` と競合する。lint が検出するのは翻訳調と文長で、困っている長さと抽象度には効かない |
| i-have-adhd（スキルとして） | 同上 | output style と目的が重なる。二重に持つとどちらが効いているか分からない |

## 自作

`z-japanese-proofreading` / `z-cognitive-rhythm-writing` / `z-create-pr` / `z-start-task` /
`z-writing-for-readers`

`skills/` 直下のシンボリックリンク（`computer-use`、`find-skills`、`orca-cli`、`orchestration`）は
Orca がマシンごとに作るもので、`.gitignore` で追跡対象から外してある。
