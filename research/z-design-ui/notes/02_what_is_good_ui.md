# 02. いいUIとは何か: 原則と判断

調査日: 2026-10-26。範囲は「原則と判断」。一次情報を優先し、ベンダー・ブログ・AI生成のミラーは【弱】、筆者の解釈は【推論】と書く。

## 結論

1. 「いいUI」は一つの性質ではない。こぎそ氏の整理では「綺麗(規則から外れていない)」「使いやすい(文脈つきで測る)」「美しい(感性に届く)」は別物で、綺麗は必要条件にすぎない。
2. 古典(Nielsen / Rams / Norman / Tognazzini / Apple HIG)は表現が違うだけで、同じ核に収束する。状態を見せる、要点を前に出す、余計なものを削る、規約に従う、細部まで手を抜かない。
3. 職人系の書き手(Refactoring UI / Rauno / Emil / Jakub / Linear)が言う「いい」は具体的で検査できる。階層は「弱めて強調する」、余白と色は有限の尺度から選ぶ、動きは頻度と目的で決める、細部は積み上がる。
4. 論争の答えは「文脈による」。装飾の美は使いやすさの錯覚を生む(審美性ユーザビリティ効果。ただし再現は一様でない)。高密度は削減でなく視覚的な重みづけで扱う。表現力は基本機能を壊さない範囲で効く。
5. 生成UIが凡庸に見える原因は「平均への収束」と「哲学・文脈の欠如」で、ルール文だけでは直らない。スキルは判断の「手順」(目的・参照・批評・検証)を固定し、好みの中身は実行時に決める。

## 1. 古典的な原則と一次情報

### Nielsen の10ヒューリスティクス
- 10項目は状態の可視化、現実との一致、操作の自由、一貫性と標準、エラー予防、再認優先、柔軟性と効率、美的で最小限のデザイン、エラーからの回復、ヘルプ。1994年4月公開、2024年1月確認([NN/g](https://www.nngroup.com/articles/ten-usability-heuristics/))。
- 「美的で最小限」は「フラットにせよ」の意味ではなく、本質でない情報と視覚を除くこと(同上)。
- 応答時間の3つの限界は0.1秒(即時と感じる)、1秒(思考の流れが切れない)、10秒(注意が持つ限界)([NN/g、1993年の著書の抜粋](https://www.nngroup.com/articles/response-times-3-important-limits/))。Tognazzini は「ボタン操作には50ms以内に視覚か音で応答する」とする([AskTog](https://asktog.com/atc/principles-of-interaction-design/))。
- 段階的開示はアプリの基本指針。ただし3段以上の階層は迷子になりやすい([NN/g、2006年](https://www.nngroup.com/articles/progressive-disclosure/))。

### Dieter Rams の10か条
- 革新的、有用、美的、理解しやすい、控えめ、誠実、長持ち、細部まで徹底、環境に配慮、「できるだけ少ないデザイン」([Vitsœ](https://www.vitsoe.com/gb/about/good-design))。
- UIに写すと「理解しやすい」は自己説明的、「控えめ」は道具として中立、「細部まで徹底」は「配慮は使う人への敬意」、「誠実」は約束できないことを見せない、となる。【推論】

### Norman・Tognazzini
- Norman の語彙(アフォーダンス / シグニファイア / フィードバック / マッピング / 制約 / 概念モデル)の要約はあるが、取得できたのは二次ソースのみ【弱】([図書要約の検索結果](https://scottburleson.substack.com/p/book-summary-the-design-of-everyday))。原典(The Design of Everyday Things 改訂版)では未確認。
- Tognazzini の改訂版(2014年3月)は19の見出しを持つ(Aesthetics, Anticipation, Discoverability, Fitts's Law, Latency Reduction, Simplicity, Readability, State, Protect Users' Work 等)。Aesthetics は「美的な設計はそれを学んだ人に任せ、見た目の変更も振る舞いと同じだけユーザーテストせよ」と述べる([AskTog](https://asktog.com/atc/principles-of-interaction-design/))。

### Gestalt・視覚デザイン
- NN/g の視覚デザイン5原則は scale / hierarchy / balance / contrast / Gestalt。サイズは3段程度、ラベルはフィールドの近くに置く(近接)。コントラストを下げて弱める手法は可読性を損なう([NN/g](https://www.nngroup.com/articles/principles-visual-design/))。
- Laws of UX には近接、共通領域、類似、連結、Prägnanz、Fitts、Hick、Jakob、Doherty(約400ms)、Miller などが並ぶ([Laws of UX](https://lawsofux.com/))。これは編集された二次的まとめ【弱】で、Fitts / Hick の原論文は未確認。数値(Miller の7±2など)は設計規則として機械的に使わない。【推論】

### Apple HIG と Liquid Glass
- Apple の Liquid Glass 概要は目的を「階層をつくり、調和させ、プラットフォームをまたいで一貫させる」と書く。指針は、最重要コンテンツを前に出す、コントロールと内容を分ける、色の使用は控えめに、標準アイコンと予測可能な配置([Apple Developer](https://developer.apple.com/documentation/technologyoverviews/liquid-glass.md))。
- Materials ガイダンスは「Liquid Glass はコンテンツ層に使わない」「カスタムコントロールには控えめに」「明るい下地には35%の暗いディミングを検討」「透明度低減・コントラスト増加の設定でテスト」と書く(HIG Materials の JSON を取得して要約、逐語は未確認。[HIG data](https://developer.apple.com/tutorials/data/design/human-interface-guidelines/materials.json))。
- iOS 設計の現行ページは「主要タスクに集中し、副次的な操作は最小の操作で発見できるようにする」を筆頭に置く([HIG data](https://developer.apple.com/tutorials/data/design/human-interface-guidelines/designing-for-ios.json))。旧来の clarity / deference / depth の語は現行ページに見つからなかった。表現が変わったのか私の取得範囲外かは未確認。
- 批判: NN/g は iOS 26 について、透過で操作が見えにくい、動きが気を散らす、タップ領域が詰まる、場所が動いて予測できない、再学習コストが高いと評価し「Motion for motion's sake is not usability」と書く(Budiu、[2025年10月10日](https://www.nngroup.com/articles/liquid-glass/))。【推論】標準システムの文脈では「新規性より一貫性と可読性」が最後は効く、という実例。

### Material 3 / M3 Expressive
- Google は46の調査、数百のデザイン、1.8万人超の参加者を挙げ、表現の手段を色・形・大きさ・動き・コンテインメントの5つとする。主要要素を最大4倍速く見つけられたと報告([Google Design](https://design.google/library/expressive-material-design-google-research))。数値はベンダー自身の報告【弱】で、公開時期は2025年5月頃(ページに日付なし。後日の記述は「dozens」と弱められたという二次報道あり)。
- 同ページの注意書きが重要。「文脈が重要」、「基本機能を超える表現はない」、慣れた型(縦リスト、テキストラベル)を外すとユーザビリティが下がった例がある、穏やかな版を好む少数派がいる。
- CHI 2026 の追試論文(Google と Ipsos、48人)で注視が33%、完了が20%速いとする二次報道があるが、本文は未確認【弱】。

## 2. 審美性ユーザビリティ効果

- 原典は Kurosu & Kashimura(Hitachi、CHI '95)。ATM画面26案で、見た目の美しさは実際の操作性より「見かけの操作性」と強く相関した。参加者数は252人と書く二次ソースが多いが、他の数字を挙げる資料もあり、原典の数字は未確認([Laws of UX](https://lawsofux.com/aesthetic-usability-effect/)、[NN/g](https://www.nngroup.com/articles/aesthetic-usability-effect/))。
- 追試: Tractinsky(CHI '97)は別文化で基本結果を支持。ただし相関の大きさは国で違い、原研究に方法上の偏りの可能性も指摘した([CHI 97](https://chi1997.acm.org/proceedings/paper/nt.html))。2000年の Tractinsky ほかは使用後も美しさの水準が使いやすさ評価を左右し、実測のユーザビリティは左右しなかったと報告([OUP abstract](https://academic.oup.com/iwc/article/13/2/127/898608))。
- 反証: Grishin & Gillan(2019)は美しさと使いやすさを独立に操作し、SUS が美しさの影響を受けるという仮説は示されなかった([UXPA Journal](https://uxpajournal.org/wp-content/uploads/sites/7/pdf/JUS_Grishin_Feb2019.pdf))。Otten ほか(2020)は「視覚的な明瞭さ」が媒介変数だと提案(検索結果の要約のみ、本文未確認【弱】)。
- NN/g の実務上の結論: 見た目は軽微な問題への許容を上げるが、大きな問題は許されず、テストでは言葉でなく行動を見るべき。裏づけの事例は単発の観察で、統制データではない([NN/g、2024年](https://www.nngroup.com/articles/aesthetic-usability-effect/))。
- 【推論】効果は「あるかないか」でなく「条件つき」。確実に言えるのは、見た目の評価をユーザビリティの根拠にしてはいけないという点。

## 3. 「綺麗」とは何か(日本語)

- こぎそ「UIデザインが『綺麗』とはどういうことか」(note、2026年10月11日)([note](https://note.com/kgsi/n/nd739362cbbae))
  - 「綺麗」は破綻していない、標準どおり。ルールブックと画面1枚で客観的に判定できる。
  - 「使いやすい」はISO 9241-11のとおり、利用者・目標・状況が決まって初めて測れる。文脈を外した画面1枚では判定できない。
  - 「美しい」は見る人の感性を揺さぶる体験で、規則に書き切れない。
  - 綺麗は必要条件の一つで十分条件ではない。体験の成否を分ける多くは画面に写らない(遷移の前後、権限、エラー、通信遅延、通知文、運用手順)。
  - 見かけの綺麗さが操作性の欠陥を覆い隠す(黒須・鹿志村 1995)。
- 依頼で挙がった「このスロップ時代に良きデザインをつくるには」は、note の kgsi の記事一覧(page 1〜3の確認範囲)に見つからず、未確認。近い論考は次の2つ。
  - こぎそ「DESIGN.mdのもたらす効能と勘違い」(2026年9月11日): DESIGN.md は「ただのMarkdown」で拘束力も検査能力もない。デザインは視覚・情報設計・インタラクション・ドメインの4階層で、DESIGN.md が扱うのは視覚の一部。AIは「8pxグリッド」と書いてあっても `margin: 13px` を出す。コードの強制は型とlint、体験の整合性は人の判断とテストで守る([note](https://note.com/kgsi/n/n3cc2a7e4fc9a))。
  - takanorip「AI-Slopなデザインを生まないためのデザインプロセス戦略」(Speaker Deck、2026年7月22日、カンム): スロップは「哲学のないデザイン」。原因は哲学が言語化されていない、デザインを文章で説明できるという思い込み、AIなしで仕上げる実技の不足。ハーネスは品質を-1から0に上げるが上限は人の哲学と審美眼が決める。レビューはルール準拠だけでなくデザインの質を見る([Speaker Deck](https://speakerdeck.com/takanorip/ai-slopnadezainwosheng-manaitamenodezainpurosesuzhan-lue))。
- 日本語の余白論は実務記事が中心で、余白には決まった正解がなく「見てどう感じるか」を数ピクセルで調整するという立場と、4・8・12…の倍数で尺度を固定する立場が併存する([Zenn(jinjer)](https://zenn.dev/jinjer_techblog/articles/bcdc545c895263)【弱】、[braindetox](https://braindetox.kr/ja/posts/small_ui_design_tips_2026.html)【弱】)。ソシオメディアのHIG、usagimaru 氏の資料は検索で原典に到達できなかった。

## 4. 職人系の「いい」の具体像

### Refactoring UI(Wathan & Schoger、2018年)
- 公式サイトの目次: 「すべての要素は同じではない」「サイズだけではない」「弱めて強調する」「ラベルは最後の手段」「余白は多めから始める」「間隔とサイズの体系を決める」「画面を埋めなくていい」「グリッドは過大評価」「曖昧な間隔を避ける」「色は思うより多く要る」「色だけに頼らない」「影で高さを示す」「罫線を減らす」([refactoringui.com](https://www.refactoringui.com/))。
- 本文は未読で、目次ベース。要約記事には「グレースケールで先に作り色は最後」「主要ボタンは1ページに原則1つ」とあるが【弱】(AIスキル化された二次要約)。

### Rauno Freiberg「Invisible Details of Interaction Design」(2023年7月)
- 「意図に流れるように応える技芸」。操作の重みで発火のタイミングを変える(軽い動作は途中、破壊的なものは終了後)。ジェスチャは即座に追従する。物理世界の性質(中断可能性など)を手本にする。高頻度の操作は動かさないほうが速く感じる。「美しい形と構成だけでは足りない」([rauno.me](https://rauno.me/craft/interaction-design))。

### Emil Kowalski
- 動きの目的を問う。高頻度の要素とキーボード操作は動かさない。UIの動きは概ね300ms未満。ボタンの押下は scale 0.97、`scale(0)` から始めない、入退場は ease-out、ポップオーバーは起点から広がる([You don't need animations](https://emilkowal.ski/ui/you-dont-need-animations)、[7 practical animation tips](https://emilkowal.ski/ui/7-practical-animation-tips))。
- 「Developing Taste」: 良い趣味は好みでなく「訓練された直感」。優れた作品に囲まれる、なぜ好きかを分析する、作って批評を受ける([emilkowal.ski](https://emilkowal.ski/ui/developing-taste))。
- 「見えない細部は積み上がる」「Paul Graham の千の声」は、本人の文章でなく AI スキルの二次資料にあった表現【弱】([instagit](https://instagit.com/emilkowalski/skills/what-is-emil-design-eng-skill/))。

### Jakub Krehel
- 記事「Details that make interfaces feel better」: `text-wrap: balance/pretty`、`tabular-nums`、同心の角丸(外半径=内半径+余白)、見た目の位置合わせ(光学補正)、境界線の代わりに重ねた影、中断可能な transition、退出は入場より控えめに([jakub.kr](https://jakub.kr/writing/details-that-make-interfaces-feel-better))。日付はページになし。

### Linear
- 2024年3月の再設計: 逆L字のグローバルクロームの密度と階層を整理、HSLからLCHへ、テーマ定義を98変数から3入力(基調色・アクセント・コントラスト)へ、見出しだけ Inter Display([Linear](https://linear.app/now/how-we-redesigned-the-linear-ui))。
- 2026年3月12日の更新: 「情報密度の高い製品では、すべての要素が同じ視覚的重みを持つべきではない」。ナビと補助を弱め、アイコンとタブを小さくし、増殖した罫線を削り、やや暖かい低彩度のグレーへ。「暖かすぎると濁る」([Linear](https://linear.app/now/behind-the-latest-design-refresh))。
- Karri Saarinen は Config の基調講演「Crafting quality that endures」で、プロセスよりクラフトを優先し、拡大してもクオリティを保つことを語る(セッション説明のみ確認。[Figma Config](https://config.figma.com/san-francisco/session/99c03fe0-dfa5-458f-9703-4c0d9615cbd4))。

### Vercel Web Interface Guidelines
- 項目はアクセシビリティ、フォーカス、フォーム、アニメーション、タイポグラフィ、コンテンツ処理(長文・空状態)、画像、パフォーマンス、ナビゲーション、タッチ、セーフエリア、ダークモード、i18n、文言、アンチパターン。例: 「`transition: all` 禁止」「transform/opacity のみ動かす」「貼り付けを塞がない」「破壊的操作は確認か取り消し」「エラーには次の一手を書く」([vercel-labs/web-interface-guidelines](https://raw.githubusercontent.com/vercel-labs/web-interface-guidelines/main/command.md)。要約経由で、逐語は一部のみ)。
- 【推論】コードで検査できる品質の床。判断を要する「いい」ではなく、「悪くない」の下限を機械化したもの。

### Jony Ive・Julie Zhuo
- Ive: 人は理由を言えなくても「配慮」と「無頓着」を感じ取る(2017年 New Yorker TechFest。複数の二次報道【弱】)。
- Zhuo: 「いい仕事は意図どおりで、能力の限界で作られたもの」(Looking Glass、有料記事の冒頭のみ【弱】)。「Good design」の要点を「何が一番大事かを決め、はっきり見せる」と要約する二次資料があるが原文は未確認【弱】。
- Paco Coursey の個別エッセイは、検索でも一覧(paco.me/writing)でも該当が見つからず、未確認。

## 5. 論争

### 美は必要か
- 上の第2節のとおり。美は信頼と許容を生むが、ユーザビリティの代わりにならない。こぎそ氏の三分割(綺麗/使いやすい/美しい)が整理に役立つ。

### 良い vs 偉大
- Rauno は形と構成だけでは足りず、応答性・中断可能性・文脈の読みが加わって「自分の延長」になるとする。Emil は趣味を訓練可能な技能とする。Ive は配慮が見えない部分にまで及ぶとする。三者とも、規則への準拠(良い)の上に「見えない細部」の層(偉大)を置く点で一致する。【推論】

### ミニマルか密度か
- Linear は密度を保ったまま視覚的な重みを不均等にする([2026年3月](https://linear.app/now/behind-the-latest-design-refresh))。NN/g は段階的開示でエキスパートが稀な機能を飛ばせると述べる([2006年](https://www.nngroup.com/articles/progressive-disclosure/))。Bloomberg は数万の機能を持つ端末で、密度を前提にして階層・一貫性・検索で扱う([Financial Planning](https://www.financial-planning.com/news/bloomberg-datas-step-change-simplicity-uniformity-MME227732)、二次報道)。こぎそ氏は、無骨でもショートカットで業務が一瞬で終わる管理画面を「極めて使いやすい」とする。
- 反対側: 機能をメニューに隠すと遷移の手間が視覚的な単純さの利益を食うという指摘がある([UX Collective](https://uxdesign.cc/designing-for-information-density-69775165a18e)【弱】)。
- 【推論】密度の高低を決めるのは利用者の頻度と熟練度。高密度は「削る」でなく「重みを配る」で扱う。

### 一貫性 vs 感動
- Material の調査は、慣れた型を外すと使いやすさが下がることを自ら報告している([Google Design](https://design.google/library/expressive-material-design-google-research))。NN/g の Liquid Glass 評は、動く・場所が変わるUIが学習コストを生むとする。感動(動き・表現)は、低頻度・非破壊の場面で効き、高頻度では邪魔になる(Emil、Rauno)。【推論】感動は一貫性の例外であって代替ではない。

### 生成UIが凡庸になる理由と見分け方(2025〜2026)
- 原因の説明は一致している。AIは「平均的なWebデザイン」を出力する(TOKIUM、2026年6月4日の個人ブログ【弱】、[Zenn](https://zenn.dev/tokium_dev/articles/04387b258ba54e))。takanorip は哲学の欠如を原因とする。
- 典型の兆候(すべて実務者のブログ・ツールの列挙で、系統的な計測はない【弱】):
  - 紫系グラデーションと半透明ガラス、Inter、3枚の丸角カード、左側に太い色枠のカード(TOKIUM、[superdesign](https://www.superdesign.dev/blog/how-to-make-ai-ui-look-less-generic))。
  - Impeccable の62のチェック: 「AI beige」、カードの入れ子、アイコンタイルの積み重ね、番号つきセクションラベル、ヒーローの eyebrow チップ、曖昧な見出し、汎用CTA、「すべて同じ重み」の階層、ステータスチップだらけ([impeccable.style](https://impeccable.style/))。
- Anthropic の frontend-design スキル(GitHub 公開版の内容を要約して取得、逐語・日付は未確認): 先に設計(スタジオのデザインリードとして対象の語彙から視覚を選ぶ)、書体はページの個性を担い2系統まで、4〜6色を先に決める、動きは一箇所に集中、「SaaSカードの定型」を避ける、最低水準としてモバイル対応・フォーカス可視・reduced-motion・コントラスト、「見せ場は一箇所に使う」「アクセサリーを一つ外す」テスト([anthropics/skills](https://github.com/anthropics/skills/blob/main/skills/frontend-design/SKILL.md))。
- 反動: 2026年は「AIスロップは退屈」が合言葉になり、あえて粗さや個性を出す潮流があるとの国内記事([Qiita](https://qiita.com/kenimo49/items/084594d0be4dc034a605)【弱】)。【推論】反動の意匠もすぐ「次の平均」になるので、模倣すべき見た目でなく、避ける手順(参照を決めてから作る)として使う。

## 6. 熟練デザイナーはどう批評するか

- 進め方(NN/g): 目的と対象ユーザーを先に合意する。感想でなく目標に結びついた質問にする(「レイアウトが微妙」でなく「主要タスクを見つけやすいか」)。ファシリテーター、記録、事後のフォローアップ([NN/g](https://www.nngroup.com/articles/design-critiques/))。
- 見る順序の実務(AIスキル・ブログの共通項で標準規格ではない【弱】): 主要アクションはどれか、目が最初にどこへ行くか(2秒で分かるか)、スクイントテスト(目を細めて主従が残るか、グルーピングが保たれるか)、競合する要素の重みを下げる(主を強めるより他を弱める)、可視の問題 → 主要タスクへの影響 → 具体的修正の順で、観察と推測を分ける([polypane](https://polypane.app/blog/debug-your-visual-hierarchy-with-the-squint-test/)、[playbooks i-critique](https://playbooks.com/skills/steveclarke/dotfiles/i-critique))。
- 床の検査(WCAG AA 4.5:1 / 3:1、タッチ44px、フォーカス可視)は機械で行える。「質」の判定(階層・リズム・抑制)は人か、基準を持たせたレビューが要る。takanorip はレビューを「ルール準拠」と「質」に分け、後者に訓練された審美眼を要求する。
- 公開された「これで採点する」ルーブリックの権威ある標準は見つからなかった。

## スキルへの示唆

プロセスとして固定すべきこと(手順・順序・検査):
1. **目的とコンテキストの確認**: 誰が、どの頻度で、どの熟練度で使うか。密度・動き・表現の強さはここから決める。UXスキルの引き継ぎ(画面・状態・フロー)を前提にする。「綺麗」でなく「使いやすい」は文脈なしに判定できない(こぎそ)。
2. **参照を先に決める**: プラットフォーム/既存デザインシステム(HIG、Material、プロジェクト既存のトークン)か、具体的な参照プロダクトを決めてから作る。決めずに作ると平均に収束する(takanorip、TOKIUM、Anthropic スキル)。
3. **設計(計画)→ 作る → 批評 → 直す**の順。計画段階で書体・4〜6色・間隔尺度・角丸・動きの方針を言葉にし、批評は「主要アクション」「最初に目が行く所」「スクイント」「他を弱めて強調」の順で行う。
4. **有限の尺度**(間隔・文字・色・影・角丸)を先に定義し、そこから選ぶ。
5. **床の機械検査**: コントラスト、フォーカス、タッチ領域、reduced-motion、`transition: all` 禁止、空・長文・エラー状態、画像寸法。Vercel のガイドライン型のチェックリストと、アンチパターンのlint(Impeccable型)。DESIGN.md のようなMarkdownは拘束力がないので、強制は型・lint・テストに持たせる(こぎそ)。
6. **状態の完全性**: 空・読み込み・エラー・権限・遅延を画面と同時に作る(「画面に写らないもの」)。
7. **動きの判断基準**: 目的を一文で言えるか、頻度は高いか、キーボード操作か、300ms未満か、中断できるか。
8. **完了前の確認**: 実際に描画して見る(スクリーンショット)、モバイル幅、ダーク、キーボード。見た目の自己評価は言葉でなく観察で行う(NN/g の「言うことでなく行動を見る」の類推)。

実行時の判断に残すべきこと:
- 表現の強さ(控えめか大胆か)、書体と色の選択、密度の水準、「見せ場」を置く場所。ここをルール化すると新しい平均を生む。【推論】
- 好みでなく根拠で選ぶ。根拠は文脈(使う人・頻度)と参照にある。分析の仕方(なぜ良いのかを言葉にする)を促し、結論は固定しない(Emil の「趣味は訓練された直感」)。
- 一貫性と感動のトレードオフ(慣れた型を外すのは低頻度・低リスクの場面だけ)。
- 迷ったときに「アクセサリーを一つ外す」「見せ場は一箇所」で削る方向に倒す。

スキルに書かない方がよいこと:
- 流行の見た目のリスト(「紫グラデを避ける」だけを並べると別の定型に移る)。避けるべき兆候は短い例示にとどめ、手順(参照を決める)に重きを置く。
- 個別のピクセル値や数値の機械的適用(7±2、固定の余白値)。尺度は製品ごとに決める。

## Gaps

- Apple HIG の現行の設計原則ページ(clarity / deference / depth が残っているか)を取得できなかった。Material 3 の m3.material.io 本体と、Expressive の公開日・46調査の方法も未確認。
- Norman の原典、Fitts / Hick / Doherty の原論文、Gestalt の原典は未確認(二次ソースのみ)。
- 黒須・鹿志村 1995 の原典の数字(参加者数など)が資料によって異なる。メタ分析は見つからなかった。
- 依頼にあった「このスロップ時代に良きデザインをつくるには」、ソシオメディアHIG、usagimaru、Paco Coursey のエッセイは原典に到達できなかった。Jakub、Rauno、Linear の一部は日付が不明または本文の一部のみ。
- Refactoring UI は本文でなく目次ベース。Karri Saarinen の講演内容は説明文のみ。Julie Zhuo は二次資料のみ。
- 熟練者の批評の公開ルーブリック(標準)は見つからず、実務ブログとAIスキルの共通項で代用した。
- 生成UIの「凡庸さ」を計測した研究は見つからなかった。兆候の列挙はすべて実務者の観察。
