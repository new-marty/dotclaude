---
name: z-grilling
description: Grill the user relentlessly about a plan, decision, or idea. Use when the user wants to stress-test their thinking, or uses any 'grill' trigger phrase. 日本語でも同じく使う - 「grill me」「壁打ちして」「この計画を詰めたい」「穴がないか叩いて」など、案を検証したい意図があれば呼ぶ。
---

<!-- Vendored from https://github.com/mattpocock/skills/blob/main/skills/productivity/grilling/SKILL.md
     (MIT License, Copyright (c) 2026 Matt Pocock). The English body is
     upstream's, unchanged. The Japanese section below it is a local addition
     and overrides upstream where the two conflict. The `name` field is renamed
     to `z-grilling`. -->

Interview the user relentlessly until you reach a shared understanding. Map this as a **design tree**: every decision branches into the decisions that hang off it.

Work the tree in **rounds**. The **frontier** is every decision whose prerequisites are already settled: the questions you can ask _now_ without guessing at answers you haven't heard yet. Ask the whole frontier in one round: number each question and give your recommended answer. Then wait for the user's answers before the next round.

Format a round like so:

```
❓ **Q1** - **<question title>**: <question body, might be multiple paragraphs, including multiple choices>

➡️ <your recommended answer>

---

❓ **Q2** - **<question title>**: <question body, might be multiple paragraphs, including multiple choices>

➡️ <your recommended answer>
```

Each round the user answers reshapes the tree: settled decisions push the frontier outward and unblock questions that depended on them. Recompute the frontier and ask the next round. A question whose answer depends on another question still open in this round belongs to a _later_ round, not this one.

Finding _facts_ is your job, never the user's. When a frontier question needs a fact from the environment (filesystem, tools, etc.), dispatch a sub-agent to find it; don't ask the user for anything you could look up yourself. Don't block on it: a running exploration is an unsettled prerequisite, so only the questions downstream of it wait for the sub-agent to report; ask the rest of the frontier now. The _decisions_ are the user's: put each to them and wait.

The session is done when the frontier is empty: every branch of the design tree visited, nothing left silently assumed. Do not act on it until the user confirms you have reached a shared understanding.

---

## 進め方(上の英語本文に優先する)

矛盾したら、以下を採る。

### 0. 言語

ユーザーが書いている言語で訊く。この節が日本語で書かれているのは指示だからで
あって、出力の見本だからではない。下の形式の見出しやラベルも訳す(英語なら
`残り <n> 問` は `<n> questions left`)。

### 1. 質問は1つずつ出す

上の本文は frontier をまとめて1ラウンドで訊けと書いているが、そうしない。
frontier の計算はそのまま行い、**訊く順に並べたうえで、1回の発言につき1問だけ出す**。
ユーザーが答えたら、次の1問を出す。番号を振って並べない。

順序は、答えが他の問いの前提になるものを先にする。
残りが何問あるかは各問の末尾に一行で示す(例: `残り 4 問`)。全体像が見えないと答えづらいため。

### 2. 前提を先に説明する

質問だけを投げない。その質問が成り立つ前提を、質問の前に説明する。
読み手はあなたの調査結果を知らない。1問ごとに次を含める。

- **いま何がどうなっているか** — 調べて分かった事実。ファイル名・件数など、確かめられる根拠を添える
- **なぜ判断が要るのか** — このまま進めると何が困るか
- **選択肢と、それぞれの帰結** — 選んだ結果どこがどう変わるか
- **推奨とその理由**

調べれば分かることはユーザーに訊かない。先に自分で調べ、その結果を前提として示す。
事実の一括提示(「facts を先に集めました」)で始めない。事実は、それが必要になる質問の中で出す。

**1問出す前に、その問いに関する調査を終える。** 質問を出したあとに調べて前提が変わると、
ユーザーは同じ問いに二度答えることになる。調べ残しがある状態で問いを出さない。
調査に時間がかかるなら、その問いは後のラウンドに回し、調査の要らない問いを先に出す。

### 3. わかりやすく書く

- 専門用語・略語・社内用語をいきなり使わない。使うなら、その場で一行の言い換えを添える
- 結論から書き、根拠を後ろに置く
- 識別子や記号(`foo.bar()`、`['a', 'b']`)を並べただけで説明を終えない。
  それが何を意味し、ユーザーから見て何が変わるのかを普通の言葉で書く
- 表や箇条書きに細分化する前に、まず散文で言い切る
- 1問の分量は、前提と選択肢と推奨を合わせて画面1つに収まる程度にする

### 4. 形式

Jacob Kaplan-Moss の SOCCR（https://jacobian.org/2021/jan/30/soccr/）に沿う。
順序を入れ替えない。特に**基準を比較より先に出す**。基準なしで選択肢だけ並べると、
読み手には判断材料がない。

```
❓ **<質問のタイトル>**

<Situation: いま何がどうなっているか。調べて分かった事実だけを書く。ここではまだ
主張しない。読み手はこちらの調査結果も思考過程も知らないので、そこへ至った道筋を
省かずに書く>

<Criteria: 何を基準に選ぶのか。選択肢より先に出す>

<Options: 選択肢。現状維持を必ず含める。5つ以下。本気で推せる案だけを出し、
当て馬を置かない。各案について、選んだ結果どこがどう変わるかを書く>

➡️ **推奨**: <はっきり言い切る。「たぶん〜がいいと思います」と書かない>

残り <n> 問
```

書き終えたら次を確かめる。どれか1つでも当てはまるなら書き直す。

- 推奨が最後まで読まないと分からない
- 背景の説明が、分析より長い
- 立場を取らずに「どちらも一長一短です」で終わっている
- 何を決めてほしいのかが明示されていない
- 選択肢の中に、自分が推せない当て馬が混じっている

### 5. 答えが返ってこないときの分岐

ユーザーが「分からない」と答えたら、その問いを取り下げず、**答えられない理由を分類する**。
分類を一行で言葉にして確認を取ってから分岐する。

| 答えられない理由 | 分岐先 | 持ち帰るもの |
| --- | --- | --- |
| 判断の前提になる仕組み・用語を知らない | `z-teach` | 学んだ内容の記録 |
| 自分の管掌外、または他人しか持っていない情報が要る | `z-to-questionnaire` | 回答済みの質問票 |
| 作って動かしてみないと分からない | `z-prototype` | 試した結果と結論 |

分岐先の3つはユーザーが明示的に起動するスキルである。こちらから呼ばず、分類を伝えたうえで
「別のセッションで `/z-teach` を使ってほしい」のように、打つコマンドを名指しで伝える。

この grilling セッションでは、その問いを未決のまま開いておき、依存していない他の問いを先に
進める。分岐先から戻ったら、持ち帰った証拠を前提として提示し、同じ問いを訊き直す。

推測で埋めない。「たぶんこうだろう」で進めると、その推測が仕様になり、チケットになり、
実装になる。分類して分岐するのは、推測が下流へ流れるのを止めるためである。

ユーザーが「そこは任せる」と明示した場合は分岐しない。推奨を採って進み、何を仮定したかを
その場で記録する。
