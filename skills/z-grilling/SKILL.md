---
name: z-grilling
description: Grill the user relentlessly about a plan, decision, or idea. Use when the user wants to stress-test their thinking, or uses any 'grill' trigger phrase. 日本語でも同じく使う - 「grill me」「壁打ちして」「この計画を詰めたい」「穴がないか叩いて」など、案を検証したい意図があれば呼ぶ。
---

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

### 3. わかりやすく書く

- 専門用語・略語・社内用語をいきなり使わない。使うなら、その場で一行の言い換えを添える
- 結論から書き、根拠を後ろに置く
- 識別子や記号(`foo.bar()`、`['a', 'b']`)を並べただけで説明を終えない。
  それが何を意味し、ユーザーから見て何が変わるのかを普通の言葉で書く
- 表や箇条書きに細分化する前に、まず散文で言い切る
- 1問の分量は、前提と選択肢と推奨を合わせて画面1つに収まる程度にする

### 4. 形式

```
❓ **<質問のタイトル>**

<前提: いま何がどうなっていて、なぜ判断が要るのか>

<選択肢と、それぞれを選んだときの帰結>

➡️ **推奨**: <推奨と、その理由>

残り <n> 問
```
