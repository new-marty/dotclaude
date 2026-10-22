# Senior practitioners: how they see, question, and propose (research notes, 2026-10-22)

Coverage note: 30 tool calls (cap reached). Many requested primaries were NOT reachable: guessed URLs 404'd (lg.substack.com how-to-be-a-better-designer, linear.app/now/how-we-build-product, emilkowal.ski/ui/invisible-details...), note.com articles by 深津 were not surfaced by search, and search returned nothing citable for 渡邊恵太 (自己帰属感), 安藤昌也 (4つの側面), 長谷川恭久, Goodpatch/freee/SmartHR/Cookpad/メルカリ design blogs, Jared Spool (exact quotes), Tobias van Schneider, Josh Clark. Those are in Gaps; nothing about them is claimed. WebFetch output is a small-model summary, so "quotes" below are as returned by that tool, not verified against the page text; marked where thin. Items tagged [INFERENCE] are mine.

## Q1. Japanese practitioners: how do they describe their way of seeing and questioning?

### Takeaway
Only 深津貴之 was verifiable, via secondary lecture reports (2014 era, mobile UI). His stance: design is 設計 (engineering), start from 誰が・何を・いつ・どう使うか, decide what to leave out, and every visual/motion/sound element must have a purpose. 安藤昌也's time-axis view of UX is partly verified; 渡邊恵太, 長谷川恭久 and company blogs yielded nothing citable.

### Cited Findings
- Fukatsu: "デザインの語源は「設計」" and "デザインは、センスではなくエンジニアリングの一つだと認識しよう" (tool-summarised from a BRIDGE report of his MOVIDA SCHOOL talk, 2014-03-07). — [THE BRIDGE](https://thebridge.jp/2014/03/movidajapan-takayukifukatsu)
- Fukatsu on defining the core: "誰が、何を、いつ、どう使うかを考えなければいけない"; narrow features by "90%のユーザが必要な機能だけを入れる"; use 4 thinking tools: pro/con list, statement sheet (app essence in one line), fishbone (decompose problem), image board. — [THE BRIDGE](https://thebridge.jp/2014/03/movidajapan-takayukifukatsu)
- Fukatsu on prototyping: start with paper because non-designers can join and it is cheap; PC tools limit who can take part; "フェーズによって最適な手法を採用することが大切だ"; prototype only the core, build several approaches and compare with pro/con. — [THE BRIDGE](https://thebridge.jp/2014/03/movidajapan-takayukifukatsu); [Classmethod report](https://dev.classmethod.jp/articles/uiux-talk-by-fladdict/)
- Fukatsu's UI principles per the Classmethod report: visuals must fit function (like a dress code); consistency of operation/colour/icon meaning across app, other apps and old versions, change gradually; always give feedback ("どこで何が起きている(起きた)かをユーザーに必ず伝える"); metaphors but do not import real-world flaws; "意思決定を奪わない" with undo/cancel or deeper placement for dangerous actions; iOS7 blur is a status cue (temporary screen, can go back), not decoration; "位置・色・動き・音のすべてに目的がある". — [Classmethod](https://dev.classmethod.jp/articles/uiux-talk-by-fladdict/)
- Fukatsu on waiting: a screen that just dims makes users think it froze; loading motion softens perceived wait. — [THE BRIDGE](https://thebridge.jp/2014/03/movidajapan-takayukifukatsu)
- Ando Masaya (via interview summary, secondary): UI is about the moment, UX is service, so think over a longer time span. A Fujitsu document splits UX by time: anticipated (before use), momentary (during), episodic (after), cumulative (overall); same document says UX is subjective so it cannot itself be designed. Whether this is Ando's own framework was NOT confirmed. — search listing [ict360.pdf](https://jp.fujitsu.com/family/familyroom/syuppan/family/papers/p360/pdf/ict360.pdf); interview via [sbbit](https://www.sbbit.jp/article/cont1/106128) (search snippet only)
- Hasegawa Atsushi (a different person, not 恭久) in a 2013 interview: UX's core is grasping what users truly value, not just stated needs. — [Web担](https://webtan.impress.co.jp/e/2013/03/06/14122) (snippet only)
- Goodpatch job listing (not a practitioner essay) lists "クライアントの事業課題や「なぜやりたいのか」を言語化しPJ課題を定義" as a designer duty. — [HRMOS](https://hrmos.co/pages/goodpatchhr/jobs) (snippet only)

### Inferences
- [INFERENCE] Fukatsu's "what NOT to include" and "state the essence in one line" are directly convertible to agent steps. His explicit "paper first so non-designers can join" implies the proposal medium should be one the stakeholder can edit (text/ASCII wire), matching the pre-UI-coding stage.
- [INFERENCE] The time-axis model (before/during/after/cumulative) is a good prompt for 家計簿 (day 1 vs day 30 drop-off). Cite Fujitsu doc, not Ando, until verified.

### Gaps
- 渡邊恵太 自己帰属感 / 融けるデザイン: no source reached (scrapbox profile only gives bibliography). Needs the book or his own blog/papers.
- 安藤昌也「体験の4つの側面」, 長谷川恭久, Cookpad/メルカリ/SmartHR/freee blogs, 坂田一倫, and any 深津 note.com article: not found.

## Q2. International practitioners: seeing, questioning, craft

### Takeaway
Verified: Cagan's four risks (with owner split), Wroblewski's evidence that hidden navigation loses engagement, Zhuo's three-lens critique anchored on user task, Saarinen's quality-as-choice stance and small-team practices, Kowalski/Freiberg interaction rules, Saffer's four-part structure, Wen's prototype-as-hypothesis stance.

### Cited Findings
- Cagan: four risks. Value ("whether customers will buy it or users will choose to use it", owner PM), usability ("whether users can figure out how to use it", owner product designer), feasibility (engineers, "time, skills and technology we have"), business viability (PM). — [SVPG](https://www.svpg.com/four-big-risks/)
- Wroblewski: "Obvious Always Wins": Polar replaced a segmented control with a toggle menu and engagement fell; Zeebox's drawer put "critical parts of the app ... out of sight and thereby out of mind"; Facebook and Redbooth moved to visible bottom tabs and engagement rose; the design question is what is "important enough to be visible". The phrase itself is the article's title only. — [LukeW](https://www.lukew.com/ff/entry.asp?1945)
- Zhuo (secondary summary of her essay "How to Do a Product Critique"): judge a screen at three moments (first impression, first use, after several weeks); "Judge a screen against what the user is actually trying to do, not your intent"; make critique a repeatable habit. — [echai summary](https://echai.ventures/startingup/from/julie-zhuo-the-year-of-the-looking-glass); original (not read): https://medium.com/the-year-of-the-looking-glass/how-to-do-a-product-critique-98b657050638
- Zhuo, podcast paraphrase (low confidence): feedback order is valuable and solves the problem, then easy to use, then delight; aesthetics feedback waits until value is validated. — [skillselion summary](https://skillselion.com/skills/refoundai/lenny-skills/running-design-reviews)
- Saarinen (Linear), "Why is quality so rare?": "many don't care, many opt for cost, and many just do what's easy"; "Quality creates gravity"; "Technology makes it faster to build, but harder to care"; "craft ... can never be fully outsourced"; practices: ask whether a decision improves quality, not only speed; trust intuition and direct user feedback alongside metrics; small teams with good judgment; no assembly-line handoffs; test incomplete products internally; fix all bugs within seven days. — [Linear blog](https://linear.app/blog/why-is-quality-so-rare)
- Kowalski, animation decision framework: ask "what's the purpose of this animation?" (explain, smooth a change, confirm input, delight); frequency is "a key factor"; Raycast, used hundreds of times a day, has no open animation ("the optimal experience"); never animate keyboard-initiated actions; keep UI animation under ~300ms; "sometimes the best animation is no animation". — [Emil Kowalski](https://emilkowal.ski/ui/you-dont-need-animations)
- Freiberg, "Invisible Details of Interaction Design": reuse metaphors so users transfer knowledge; interruptibility mirrors physical objects (a page turn you must wait for would feel wrong); trigger lightweight actions mid-gesture but destructive ones on gesture end; apply gesture effect immediately, before the threshold, or there is "zero affordance or confidence"; preserve momentum; animate from the source to show spatial relationship; skip animation for high-frequency menus; Fitts's law and screen corners; show what is under the finger; use context as implicit input; "fidgetability". — [rauno.me](https://rauno.me/craft/interaction-design)
- Saffer, Microinteractions: trigger (manual or system; same trigger, same action each time), rules (invisible flow and limits), feedback (how users learn the rules), loops and modes (e.g. "get data every 30 seconds"; preferences). Book-level facts from reviews, not the text. — [uxdesign.cc review](https://bootcamp.uxdesign.cc/book-review-microinteractions-designing-with-details-by-dan-saffer-a0cdc61dd1fc), [i-programmer](https://www.i-programmer.info/bookreviews/159-uiux/7510-microinteractions.html)
- Wen (Anthropic, ex-Figma), "Don't Trust the Process" (Hatch 2025), per a lessons summary: prototype to test a hypothesis rather than defend in a deck; ask whether each step adds value; match method to the problem (heavy research for new healthcare product, not for a well-understood consumer feature); frameworks like Double Diamond are tools; "frame prototypes as hypotheses"; use gut when data is missing, then test fast; invest in polish. Not a rejection of research (Willison write-up). — [Buteau summary](https://www.antoinebuteau.com/lessons-from-jenny-wen/), [Simon Willison](https://simonwillison.net/2026/Jan/24/dont-trust-the-process)
- Spool, "experience rot" (podcast blurb): "if one is good, more is better" feature accretion; resist by focusing on user problems before solutions. Exact wording unverified. — [CPO Club](https://cpoclub.com/sv/podcast/sa-anvander-du-ux-som-en-konkurrensfordel/)

### Inferences
- [INFERENCE] Wen's "skip heavy process" and a UX-before-UI skill are in tension; her own caveat (match method to problem) is the reconciliation: the skill should scale ceremony to risk and prefer a one-page, falsifiable hypothesis over a document set.
- [INFERENCE] Kowalski's frequency rule and Freiberg's interruptibility/threshold rules show "feel" decisions that need upstream inputs: how often the action occurs, whether it is destructive, keyboard vs touch. These are questions an agent can ask before any code.

### Gaps
- Not obtained: Tobias van Schneider, Josh Clark, Jenny Wen's own transcript, Spool primary text, Karri's "opinionated software" wording (a third-party description only), Zhuo's critique questions list, Kowalski's "invisible details" and Freiberg's latency-perception content (only interaction essay summarised).

## Q3. How seniors present proposals that hit the mark

### Takeaway
Evidence is thin and mostly secondary. Convergent points: tie rationale to the user's task and the business problem (Zhuo, Monteiro), present a hypothesis not an artifact tour (Wen, Monteiro), compare options with pro/con (Fukatsu), decide what to omit (Fukatsu, Wroblewski).

### Cited Findings
- Monteiro (secondary summaries of Design Is a Job): good design does not sell itself; a designer must explain decisions and answer the client's question; the "real estate tour" (walking through every element) is a presentation failure; clients hire designers to solve problems, and wanting production without strategy is not really asking for design. "Never show" wording unverified. — [Creative Bloq](https://creativebloq.com/web-design/13-ways-designers-screw-client-presentations-61620900), [UX Planet](https://uxplanet.org/sell-your-design-to-clients-in-4-steps-42e1a7a1cfab), [Zeldman](https://zeldman.com/2013/12/08/design-is-a-relationship/) (search snippets only)
- Wen: show a working prototype rather than a deck; focus on the product not personas/journey-map artifacts. — [Buteau summary](https://www.antoinebuteau.com/lessons-from-jenny-wen/)
- Fukatsu: compare multiple approaches with a pro/con list before choosing. — [Classmethod](https://dev.classmethod.jp/articles/uiux-talk-by-fladdict/)

### Inferences
- [INFERENCE] I found no verbatim source for "how I disagree with a client's requested solution." Practical synthesis from Monteiro (problem over production) + Cagan (name the risk) + Zhuo (judge against user task): restate the request as the underlying problem, name the risk the requested solution leaves open, offer the requested solution as one option.

### Gaps
- No primary Japanese source on proposal style. No sourced "what I chose not to do" practice beyond Fukatsu's feature narrowing and Linear's small-team opinionation.

## Q4. Practices converted to agent behaviour (deliverable 1)

### Takeaway
20 practices, each with source strength: V = verified in a fetched/summarised source, S = secondary only.

### Cited Findings (practice, source, agent behaviour, example output line)
1. Fukatsu (V): define 誰が・何を・いつ・どう使うか. Behaviour: before any screen, write one-line statement sheet; ask for missing slots. Output: 「誰が・いつ・何のために開くか、まだ決まっていません。仮に『月末に使途不明金が気になる共働き世帯が、レシート入力の直後に開く』と置きます。違えば教えてください」 — [THE BRIDGE](https://thebridge.jp/2014/03/movidajapan-takayukifukatsu)
2. Fukatsu (V): decide what to leave out (90% rule). Behaviour: list "やらないこと" with reason. Output: 「やらない: 口座連携。90%の人に要らず、初回の離脱要因になるため」 — same.
3. Fukatsu (V): pro/con compare several approaches before choosing. Behaviour: 2-3 options, one recommended. Output: 「A 手入力 / B レシート撮影 / C 口座連携。推しは B。理由は…」 — [Classmethod](https://dev.classmethod.jp/articles/uiux-talk-by-fladdict/)
4. Fukatsu (V): every position/colour/motion/sound has a purpose. Behaviour: each UI decision carries a "なぜ" line. Output: 「この赤は警告ではなく『予算超過』の意味に限定します」 — Classmethod.
5. Fukatsu (V): do not take decisions from the user; give undo/cancel; hide dangerous actions. Behaviour: for each destructive action, ask undo vs confirm. Output: 「削除は確認ダイアログでなく取り消しトースト(5秒)を提案。頻度が高く、確認疲れを招くため」 [INFERENCE on the example]
6. Fukatsu (V): never leave the user wondering if it froze. Behaviour: list waiting states and what the screen says. Output: 「集計に2秒以上かかる場合、前回値を薄く残して更新中と示します」
7. Fukatsu (V): choose method by phase, paper first so non-designers join. Behaviour: propose text/ASCII flow the user can edit. — THE BRIDGE.
8. Fujitsu doc / Ando (S): UX over time (予期・一時・エピソード・累積). Behaviour: ask about day 1, day 7, day 30. Output: 「30日後に開く理由は何ですか?」 — [Fujitsu](https://jp.fujitsu.com/family/familyroom/syuppan/family/papers/p360/pdf/ict360.pdf)
9. Cagan (V): name which of four risks a decision carries. Behaviour: tag each open question value/usability/feasibility/viability. Output: 「最大のリスクは価値(続ける理由があるか)で、画面設計より先に確認したい」 — [SVPG](https://www.svpg.com/four-big-risks/)
10. Wroblewski (V): what must be visible vs hidden; hidden = unused. Behaviour: rank features by "must be seen"; challenge hamburger/drawer. Output: 「『今月の残り』は常時表示。メニュー内に隠すと見られなくなります」 — [LukeW](https://www.lukew.com/ff/entry.asp?1945)
11. Zhuo (S): judge against the user's task, three moments (first impression, first use, weeks later). Behaviour: critique own proposal in three passes. Output: 「初見で何の画面か分かるか / 初回に最初の1件を入れられるか / 3週間後に飽きないか」 — [echai](https://echai.ventures/startingup/from/julie-zhuo-the-year-of-the-looking-glass)
12. Zhuo (S, low): value, then usability, then delight; delay aesthetics. Behaviour: do not discuss visual polish until value and flow are agreed. — [skillselion](https://skillselion.com/skills/refoundai/lenny-skills/running-design-reviews)
13. Saarinen (V): ask "does this improve quality", not only "does it ship faster"; care cannot be outsourced to AI. Behaviour: for each shortcut, state the quality cost. Output: 「速さ優先で空状態を省くと初回体験が弱くなります。省略せず1行文言で対応する案」 — [Linear](https://linear.app/blog/why-is-quality-so-rare)
14. Saarinen (V): small team with judgment, opinionated stance. Behaviour: give one recommendation, not a menu of equals. [INFERENCE: "opinionated" is third-party description]
15. Kowalski (V): animate only with a purpose; frequency decides; never on keyboard actions; under ~300ms. Behaviour: ask how often the action occurs. Output: 「入力は1日に何十回も起きるので、アニメーションなしを既定にします」 — [Emil Kowalski](https://emilkowal.ski/ui/you-dont-need-animations)
16. Freiberg (V): trigger by weight (light mid-gesture, destructive on release); immediate feedback before threshold; interruptible. Behaviour: for each gesture, state trigger point and whether it can be interrupted. Output: 「スワイプ削除は指を離した時点で確定、閾値前から行が追従します」 — [rauno.me](https://rauno.me/craft/interaction-design)
17. Freiberg (V): use context as implicit input. Behaviour: ask what the system already knows (time, location, last category). Output: 「入力欄に直前の支出カテゴリを既定入力できますか?」
18. Saffer (S): trigger, rules, feedback, loops/modes per small interaction. Behaviour: spec each recurring micro-interaction in those four fields. Output: 「トリガー: FABタップ / ルール: 金額必須・カテゴリ任意 / フィードバック: 合計が動く / ループ: 毎月1日に締め」 — [review](https://bootcamp.uxdesign.cc/book-review-microinteractions-designing-with-details-by-dan-saffer-a0cdc61dd1fc)
19. Wen (S): prototype as hypothesis; match method to problem. Behaviour: end with "this proposal is wrong if X"; scale effort to risk. Output: 「前提が外れる条件: 入力が3回続かないなら、この案は捨てます」 — [Buteau](https://www.antoinebuteau.com/lessons-from-jenny-wen/)
20. Monteiro (S): explain decisions rather than tour the screen; restate the problem behind a requested solution. Behaviour: lead with problem and decision, not an element list. Output: 「画面の説明より先に、決めたことを3つ述べます」 — [Creative Bloq](https://creativebloq.com/web-design/13-ways-designers-screw-client-presentations-61620900)
21. Spool (S, wording unverified): feature accretion ("more is better") is rot; stay on user problems before solutions. Behaviour: when asked to add, ask what problem it removes. — [CPO Club](https://cpoclub.com/sv/podcast/sa-anvander-du-ux-som-en-konkurrensfordel/)

### Inferences
- [INFERENCE] "Unexpected-angle" questions come from the practices above, not from a single quote: time axis (8), frequency (15), what is hidden (10), what user already knows (17), what happens when it fails or waits (6), what we won't do (2), what would make this wrong (19).

### Gaps
- Items 12, 14, 21 rest on weak sources; do not present them as direct quotes in the skill.

## Q5. Proposal template and two example responses (deliverable 2)

### Takeaway
Template [INFERENCE, assembled from practices 1-3, 9, 11, 19, 20]: Observation → Reframe → Recommendation (one, with why) → Not doing → Trade-off / alternatives → Riskiest assumption and how to test → One question. Keep it to about one screen.

### Cited Findings
Template and examples are synthesis, not sourced quotes. Underlying sources: [THE BRIDGE](https://thebridge.jp/2014/03/movidajapan-takayukifukatsu), [SVPG](https://www.svpg.com/four-big-risks/), [Zhuo summary](https://echai.ventures/startingup/from/julie-zhuo-the-year-of-the-looking-glass), [Buteau](https://www.antoinebuteau.com/lessons-from-jenny-wen/).

### Inferences
Example A: 「家計簿アプリを作りたい」
- 観察: 家計簿は「作る人が多く、続く人が少ない」領域です。続かない原因は機能不足より、入力の手間と、入力して何が返るかの薄さにあることが多いです(仮説、未検証)。
- 再定義: 作るものは「記録帳」でなく「月末に『使いすぎたか』が分かる状態を、最小の入力で作る道具」ではないでしょうか。
- 推奨: 初回は1件の入力だけで「今月の残り」が動く画面にします。理由: 価値(入力に見合う見返り)を最初の1分で見せられるため。
- やらない: 口座連携、グラフ多種、予算の細分化。初期の離脱要因になるため後回し。
- トレードオフ: 手入力中心は正確さで劣るが、始めやすさで勝つ。レシート撮影は手間が減るが認識精度のリスク(実現性)がある。
- 最大の前提: 利用者は3日続けて入力する。ここが外れるなら案を捨てる。
- 質問: 誰の、どんな場面のための家計簿ですか(単身か世帯か、既存アプリをやめた理由は)?

Example B: 「会員登録の離脱が多いので改善したい」
- 観察: 「離脱が多い」はどの段階か、誰かで意味が変わります。ファネルのどこで落ちるか分からないまま画面を直すと、外れやすいです。
- 再定義: 課題は登録フォームの使いやすさではなく、「登録する理由が登録前に伝わっているか」かもしれません(価値リスクと使いやすさリスクの切り分け)。
- 推奨: まず段階別の離脱率と、離脱者が直前に見ていたページを見る。登録が必須のタイミングを「価値を見せた後」へ後ろ倒しできるかを第一案にします。フォーム項目削減は第二案。
- やらない: 登録ボタンの色や文言だけの調整。原因が価値側だと効果が出ないため。
- トレードオフ: 後ろ倒しは離脱を減らすが、メール取得が遅れる。ソーシャルログインは手間を減らすが、依存先の障害と個人情報の懸念が出る。
- 最大の前提: 離脱はフォーム画面で起きている。違えばフォームは触らない。
- 質問: 離脱が最も多いのは、フォーム表示前、入力中、確認メール前のどこですか。データがなければ、まず計測を入れる案を出します。

### Gaps
- Examples are illustrative; numbers and causes are hypotheses. No source says this template is used by any named practitioner.
