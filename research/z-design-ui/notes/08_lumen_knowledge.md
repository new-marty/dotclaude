# 08. Lumen に残る Marty のデザイン知見(蒸留)

## 結論

1. Marty が最初に突っ込むのは、美しさではなく「見えるか」「スケールはあるか」「その数字は何の判断に効くか」「一貫しているか」の4つ。この4問に答えられない画面は見せる前に直す。
2. 長期で変わらなかった規則は、チャートに単位・最小・最大を図の内側に出す、色は1意味1色、ブランド色は1色、ヒーローに濃色ベタを使わない、プロンプト提案や機能説明文を出さない、メイン画面は縦横ともスクロールさせない、の6つ。
3. 数字だけの羅列と、同じ情報の二重表示と、行き先のないボタンは、毎回指摘された。「何を見せるか」を決めてから形を選ぶ。
4. Lumen の規則の約6割は一般化できる(色・チャート・密度・コピー・プロセス)。ダッシュボード固有なのは、タブ構成、Aria、ドメイン別の指標選び、AI レポートの配置。
5. 後の判断が前の判断を覆した例が多い(Today のスクロール、AI の位置、クロスドメイン分析、ヒーローのグラデ、チャートの範囲ラベル)。古い方を規則に採ると誤る。覆された経緯は第5節にある。

## 0. 読み方と限界

- 出典は `lumen-design`(m0194〜m0505)と `lumen-app/packages/design-system/src/docs/DECISIONS.md` と `CHANGELOG.md`(〜m0507-d。DECISIONS は 3178 行で、旧版 1322 行の続き)。`SKILL.md` は新版を正とした。
- 証拠の種類を3つに分ける。
  - **V** = Marty の逐語(DECISIONS が `verbatim` と明記した引用)。
  - **P** = 記録者(エージェント)の要約。m0506-x/y/z/ad/ae は `paraphrased` と書かれている。
  - **D** = 設計記述。Marty が承認したと読めるが、本人の言葉ではない。
- マイルストーン ID は原文のまま。m0504-j/k/l/n/o/p は Money スレッドと Body スレッドで文字が衝突している。本稿では「(Body)」「(Money)」を付けて区別する。
- 読んでいないもの:
  - `ui_kits/**/*.html` の実装(SKILL.md、CHANGELOG の記述で代用)
  - `BACKEND_GAPS.md`
  - `AI_REPORTS.md`(参照されているがリポジトリに無い)
  - FLOWS.md の旧版 200 行目以降と新旧の差分
- `uploads/` の画像は約25枚のうち5枚だけ見た(Copilot Money のデスクトップとモバイル、Fitonist 風ダッシュボード、フィットネスのモバイル3画面、Lucide の確認画面)。見た範囲のムードボードはダーク系が多い。それでも Marty は m0194 で「No dark mode needed」と指示した。参照画像の見た目より、本人の指示を優先する。

## 1. 規則(テーマ別)

書式は「規則 — 理由 — 証拠(引用、マイルストーン、V/P/D)」。引用は原文のまま。

### 1-1. 色

**C1. 同じデータは、全画面で同じ色にする。**
- 理由: 色は意味を運ぶ。同じ指標が場所によって色を変えると、別物に見える。
- 証拠:
  - "Coloring is inconsistent across the whole design" (m0194, V)
  - "I hate how the color doesn't have consistency." (m0506-m, V)
  - "I hate the coloring here too. why green and blue bar?" (m0506-n, V)
  - "why is composition not consistent" / "the coloring is terrible" (m0506-j refinement, V)
- 実装: カテゴリ色はトークン経由にする(`--cat-*`)。Food は Money でも Body でもオレンジ(D)。

**C2. 1つのカード、1つのチャートでは、色の系統を1つにする。**
- 理由: 色の体系が2つ同居すると、ノイズに見える。
- 証拠:
  - m0506-l は、リングの色を指標の同一性色にし、状態ピルの色を良し悪しにした(Sleep 89 は紫のスパークラインと緑の GOOD)。
  - m0506-m は「I hate how the color doesn't have consistency.」を受けて、同じカード内では状態色に一本化した。ラベルが「どの指標か」を、色が「どれだけ良いか」を担当する(V)。
- 原因の例: `color-mix(in oklch, brand 28%, bg-3)` が暖色の紙の上でオリーブ色になった(m0506-n)。色は混ぜて作らず、定義済みの tint を使う。

**C3. 濃い色ベタの上に文字を載せない。ヒーローは白カードにする。**
- 理由: コントラストが落ちる。カテゴリ色のチャートとも衝突する(m0504-d の診断)。
- 証拠:
  - "I like A's hero section but blue background is hard to see." (m0504-l Body, V)
  - "Hero's blue background makes it stand out but makesi it hard to read." (m0504-n Body, V)
  - "just white with blue background is not easy to see." (m0504-u Body, V)
  - "I dont like the blue background card." (m0507-d, V)
- 同じ指摘が4回出た。最終形は「ヒーローに色付きの塗りはない。重みはサイズ・文章・KPI グリッドで出す」(SKILL.md 新版)。

**C4. 「二次的だが消えていない」要素は、同じ色相の薄色で描く。中立グレーは使わない。**
- 理由: 暖色の紙の上では、中立グレーが背景に溶ける。
- 証拠:
  - "hard to see the bottom bar with this color" (m0506-ab, V)。`--bg-3` を `--cat-orange` 22% の混色に変えて解決した。
  - "hard to see without any background colors" (m0504-n Money, V)。カード枠が無くて構造が読めなかった。

**C5. グリッド線は、知覚の閾値を少し超える濃さにする。**
- 証拠: 7%黒は「見えない」、`--fg-4` のベタは "now the line is too visible."。最終は18%黒で 1px(`--line-3`)。"I dont see any changes." (m0506-ay, V)。
- 理由: 7%黒は線が引かれていても読み手には「無い」に見える。濃さの調整は線幅より色の濃さで行う。

**C6. ブランド色は1色。「いまここ」と主アクションだけに使い、カテゴリ色にしない。**
- 証拠: パレット方針(D)。ダークモードなし、キャンバスは暖色の紙 1 色(m0194, V)。
- 付記: 8色のカテゴリ色は Okabe-Ito 由来の色覚配慮。1チャートは6色以内で、残りは「Other」に畳む(CSS コメント, D)。

**C7. 1ページの同一性色が単色だと、単調に読まれる。ページ内部のエンコーディングは別に持つ。**
- 証拠: "I hate how workout exersise only has one orange color. fixi it." (m0506-am, V)。心拍ゾーンを Z1 青〜Z5 朱の標準的な虹色にして解決した。
- 注意: C1(色の一貫)と緊張する。ページの同一性色は固定し、内側のサブエンコーディングだけ変える。指標をまたいで同じ色を別の意味に使わない(紫は睡眠専用。ランに紫を使って "1/10" の一因になった, m0506-am)。

### 1-2. 情報設計・階層

**H1. 手元の API ではなく、理想の UI から設計する。足りない機能は書き出して後で作る。**
- 証拠:
  - "Do not think from the features we have now. Think of the ideal UI and UX from the data we have. All the backend features can be built later or thrown away." (m0504, V)
  - "whatever that is not implemented yet write it down and I will" (m0504, V)

**H2. 画面を分ける前に、まず見せ方を良くする。**
- 証拠: "...Make use of tabs, modals, pages if you have to but you should think about improving how you are displaying the data first." (m0194, V)
- 規則名: 「ページ分割より先に密度」。

**H3. 数字だけを並べない。その数字が何を意味するか(比較・範囲・目標)を、見た瞬間に分かる形で添える。**
- 証拠: "Just having numbers listed is not good. What do those numbers mean?" (m0505, V)
- 実装: 平均だけの数字に 7 日ミニバー、パーソナルレンジ、目標へのプログレスを付けた(m0505 の表, D)。

**H4. 比較基準がなく、日々の判断を動かさない指標は載せない。**
- 証拠:
  - "not useful data SAVINGS / 38% / of income / RUNWAY / 22 mo / liquid" (m0504-c, V)
  - "Next 14 days forcast is not useful." (m0504-b, V)
  - "we do not need forecast." (m0504-t, V)
  - "calorie burned. dont care about steps i care more about calories" / "I dont care about water" (m0504-j Body, V)
  - "HRV 52ms RECOV 87 recov can be a ring too so double donut ring but hrv what is this info useful for?" (m0506-e, V。HRV は Recovery の入力であって独立した行動信号ではない、という整理)
- 判定法: 「この数字を見て今日何が変わるか」が答えられなければ載せない。エージェントが「睡眠の安心感を作る」と擁護した Runway(m0504-c の Note)も採用されなかった。作り手の擁護は証拠にならない。

**H5. 信用できないデータは、降格して責めない見せ方にする。**
- 証拠: "calorie in data will be unreliable. i tend to forget to log" (m0504-j Body, V)。入力不足を恥にする UI は避ける(D)。
- 注意: 同じ人が「meal tracking が消えた」(m0504-o Body)とも言った。降格はしても機能は落とさない。

**H6. ホームは入口(リンク集)にしない。要約を見せ、詳細はモーダルで開く。**
- 証拠:
  - "I really like this UX. have summary or short version and open modal to reveal the full details with good UX. I want this for money and body. ... I dont waht the home page to be link entrance" (m0504-z, V)
  - "have a headline and open modal to reveal further info." (m0504-y, V)
- 規則名: 要約カード → モーダル(ヘッダ、主役の数字、主要な図、副次的な一覧、任意の補足、具体的な遷移 1 行のフッタ)。

**H7. 画面間の重複を消す。同格のものは同格に扱う。入力にすぎないものを同じ階層に置かない。**
- 証拠:
  - "There's lots of duplicate in today page nad body page. re-consider layout and what page shows what." (m0506-k, V)
  - "Why is recovery and sleep treated different? Shouldnt sleep, revocery, stress treated like equal?" (m0506-k, V)
  - "HRV and RHR has its own section so why is it in the your morning card? and why is stress not getting its won section?" (m0506-k, V)
  - "why is order flipped?" (m0506-o, V。同じ指標ペアを、同じページで逆順に並べたことへの指摘)
- 理由: 同じ 89 が Today、Body、睡眠詳細に3回出た。見る人は「違う数字か?」と探す。
- 補足: 指標の間にも階層がある。生の生理指標(HRV, RHR)は詳細ページ、ピア同士のスコアはカードに置く(m0506-k, D)。

**H8. 画面ごとに「これが答える問い」を持ち、その答えの場所を示せるようにする。**
- 証拠: "Where can I see all my assets, accounts? Where is the breakdown of my spendings? How about my crypto wallet?" (m0504-b, V)。FLOWS.md の Money は「7つの問い」の表を持つ(D)。
- 付随: 画面は目的の1文で決める(Today =「how am I doing on the things that matter?」)。

**H9. 触れるものすべてに行き先がある。**
- 証拠: "check for ui that is not thought of in money pages. Like clicking this button does notthing now, menu modal is not though of, etc." (m0504-s, V)
- 派生: 子ページ、フィルタ、行タップの詳細、kebab メニューを網羅する(m0504-s の監査)。"We dont have subscriptions detail page" で、シートから専用ページへ格上げされた。

**H10. 最も大事な情報を、最初に見る場所に置く。ユーザーの関心は聞き出す。**
- 証拠:
  - "what is the most important in this app? think through" (m0504-w, V)
  - "I would like to see weight loss and gym progress in the top level page." (m0504-j Body, V)
  - "body fat, muscle mass are more important than actual weight" (m0504-l Body, V)
  - "move body before money." (m0506-c, V)
  - "bring these more to the top" (m0504-p Body, V。入力ボタンが下すぎた)
  - "AI related stuff should not be in bottom where it is hard to reach." (m0506-j refinement, V)

**H11. その人固有の前提で設計する。他社のユーザー向けの定型を持ち込まない。**
- 証拠: "you did not design what needs to be in the profile page. this is a personal app that only i will be using." / "I have all data available to me. Im running the backend and db in my own homelab." (m0506-a, V)
- 結果: メールの管理、サインアウト、プライバシーポリシー、データのエクスポートを削り、バックアップとサービス状態を足した。
- 規則名: 誰が・何台で・どこから使うかを確認してから、定型の画面を足す。

**H12. 要素を足す前に、取得できるデータかどうか確認する。**
- 証拠: "are you sure all these data are collectable?" (m0504-l Money, V)

**H13. 目標が関わる指標は、始点・現在・目標を見せる。目標の方向でグループ化する。**
- 証拠:
  - "add goal to the body composition card or in a new card. I cant see the progress." (m0506-z, P)
  - "one group i want to lose one i want to gain" (m0506-ay, V)
  - "is the trajectory working?" (m0506-ap で自問した問い, D)

**H14. ヘッダ、ナビ、並び順は共通部品にする。**
- 証拠: "theres no consisitency in headers and navbar. make them a component and make it consistent" (m0504-f, V)、"header is inconsistent" (m0504-j Money, V)、"how about header? I thought there was a task to align headers" (m0506-a, V)。
- 規則名: 同じ位置に同じ要素。タブバーは必ず共有部品。

### 1-3. チャート・データ可視化

**D1. すべてのチャートに、単位と最小・最大を図の内側に印字する。**
- 証拠:
  - "there is no scale." (m0504-c, V)
  - "there are so many graphs and charts without label so I dont know the scale. Check all of them" (m0506-aa, V)
  - "make it an explicit rule. this keeps happening" (m0506-ae, P)
  - "I've been telling you to have the unit for charts and graphs… make it a strict rule and fix everything, check everything and fix it. I want it in the graph and charts. Like to the side. On the bottom and on the top." (m0507-b, V)
- 理由: 高い棒はそれだけでは大きさを語らない。週内の相対スケールで伸ばしたスパークバーは、絶対値を何も伝えない(m0506-aa の診断)。
- 最終形(SKILL.md 新版): 最大を左上、最小を左下に、単位付きで図の枠の内側に置く。左に余白を設けてデータと重ならせない。置けないほど小さいなら、図が小さすぎる。
- 例外: カテゴリ軸、二値の達成ストリップ(N/7 が尺度)、分母が数値表示に出ているリング(390 / 600 kcal)、凡例付きドーナツ、36px 以下の小さなスパークライン。
- 履歴: 同じ規則が4回の掃除でも漏れた(aa → z → ad → ae → 0507-b)。規則の置き場所が DECISIONS だけで、エージェントが最初に読む SKILL.md に無かった。

**D2. チャートが「ただの線」では足りない。軸、極値、基準線、期間の端を載せて、問いに答えさせる。**
- 証拠:
  - "Hero chart contains almost no data. It's just a line." (m0504-b, V)
  - "Lacking visual data" (m0504-c, V)
- 対応: 薄い点線の基準線 3 本、ツールチップ、期間端のラベル。

**D3. 大きさの尺度と成長の見え方は別物。問いが変われば、軸とチャートの型を切り替える。**
- 証拠: "youshould think about how to present the data more. hard to see the growth for 3M (i also want 1m growth option too) since the scale is 0 - 4million and growth is little." (m0504-h, V)
- 対応: 短期は自動ズームの線グラフ、長期は ¥0 起点の積み上げ(組成を見せるには底を切れない)。

**D4. データの粒度に正直な形にする。月次の点を滑らかな曲線で補間しない。点を密に打った折れ線を使う。**
- 証拠:
  - "smooth like is not a good fir for this usecase." (m0504-e, V)
  - "Dont use bar chart. looks even worse. just use straight line with a lot of plots." (m0504-f, V)
- 注意: m0504-f の「密な点」は月次24点から日次720点を合成したモックだった。実データが無い点を補う作り物で、本番では日次データが要る。

**D5. 比率は、小さい区分も見える形で描く。**
- 証拠:
  - "circular graph might be better for this usecase" (m0504-e, V)
  - "this should be a ring or whatever else. hard to see details" (m0504-l Money, V。8px の横棒で 3.4% が細い線になった)
- 理由: 横棒は幅で、ドーナツは角度で量を符号化する。小さい区分は角度のほうが太く残る(m0504-l の診断)。

**D6. 重なった面は、薄い塗りと同色の上端線で描く。**
- 証拠: "still difficult to see. what is the difference between origina mf me ui and ours? Why is ours hard to see?" (m0504-g, V)
- 診断: 競合製品は半透明の塗り(約28%)と上端の細い実線を併用していた。うちは不透明な塗りだけで、小さい帯が潰れた。チャート内は淡色、凡例の点は飽和色にする。

**D7. 同じ情報を2つの形で描かない。**
- 証拠:
  - "I dont like the layout graphs and charts represent the same thing?" (PFC カード, m0506-d, V)
  - "theres too much info here and i dont know what im looking at" (m0506-aw, V)。進捗バーと目標チップが同じ数字を二度出していた。
- 対応: 1行あたりの要素数を約13から約9に減らした。

**D8. 意味の読めないバーを描かない。数字の無いゲージ、他社 UI の写しを避ける。**
- 証拠:
  - "I dont like arms and legs purple bar. Not sure what it means just remove it." (m0506-z, P)
  - "I dont know where it is pointing to because left and right don't have number. You just copied the inbody UI but terrible. think again." (m0506-z, P)
  - "I hate these horizontal bars. never do this." (m0506-ao, V)
  - "I hate bar representing the score. use circle donut graph like everywhere else." (m0506-k, V)
- 規則: スコアはドーナツで統一する。範囲の中の位置は、値と小さな差分(`↑ +6.2 km in 90d`)か、スパークラインで示す。

**D9. 帯の端の数字を、そのまま印字するだけでは足りない。それが何の端かを書く。**
- 証拠: m0506-ad の整理(P)。min/max を図の角に置くと x 軸ラベルに読める。最新点に注記し、下の帯は「開始日 · 範囲 · 終了日」の3セルにする。いまの最終形は D1 の角ラベル。

**D10. 二値の達成表示でも、大きさが判断に効くなら添える。**
- 証拠: BurnGoalStrip の「380–720 kcal」チップ(m0506-ad, P)。達成と未達の差の大きさが見えなかった。

**D11. 重ならない。切れない。**
- 証拠: "make it so that it doesnt overlap with the bar" / "did you check all places?" (m0506-ae, P)。値ラベルが上端で欠けた例(m0506-ax)。

**D12. 他社アプリのラッパーなら、元より良く作る。元より悪くなるなら出さない。**
- 証拠:
  - "OK this is just a wrapper of oura ring right? 1, I dont like it when it is just a wrapper 2, the ui is better in the oura app." (m0504-q, V)
  - "I want the sleep chart? graph? that oura has. I want every bit of detail." (m0504-t, V)
- 補足: 同時に「Wrapper is fine if that is all we can do. link to app defeats the whole point of this app.」(V)。外部アプリへ飛ばす案は不可。

### 1-4. 密度・スクロール

**S1. メイン画面はスクロールさせない。詳細ページとモーダルだけは可。**
- 証拠: "Try to not have any scroll for main pages (ok in details page/modal). ... User should not have to scroll to find an information." (m0194, V)、"ideally i want no scroll for this page. modal is fine." (m0506-c, V)
- 付記: ボタンやアイコンボタンは必ずスクロールなしで届く(m0194, V)。"I should not have to scroll to access these buttons." (m0504-o Body, V)。

**S2. 横スクロールは禁止。凡例は折り返す。**
- 証拠: "useless horizontal scroll" (m0504-c, V)。チップが溢れて Crypto と Pension が切れた。

**S3. 縮めるときは、機能を落とさずに縮める。**
- 証拠: "you completely dropped meal tracking too" (m0504-o Body, V)。圧縮案で PeriodTabs と脚注を削り、食事の状態は AI 要約に吸収するはずが、見た目では消えていた。

**S4. 一番見られる画面は、情報が少なすぎてもいけない。**
- 証拠: "Theres way too little infor in the home page. This is the page that will be seen the most. it should contain more info than this." (m0504-y, V)
- 結末: 次の m0506-c で、Net Worth を落として再びスクロールなしに戻した。S1 と S4 の両方を満たす道は「情報を減らす」ではなく「モーダルに送る」だった。

**S5. 賑やかさと情報量の両立が難しいときは、別ページに分ける。**
- 証拠: "Not sure how to not make it too noisy but informative at the same time. maybe we should have it in a different page? or a sub page?" (m0504-k Body, V)

**S6. 重複しているカードは削る。**
- 証拠: "I dont need these 2 cards in Body › Exercise" / "dont need workout history git-like stuff. we laready have this week card" (m0506-y, m0506-d)。

### 1-5. タイポグラフィ

**T1. 書体は有名なオープンソース1種に、等幅を1種足すだけ。装飾書体は足さない。**
- 証拠:
  - "For fonts and icons, just use whatever is out there in the world" (V)
  - "Choose a font too." → 「Font choice good」 (V)
  - "I don't like Instrument Serif. Get rid of it." (m0185, V)
- 実装(D): Geist と Geist Mono。強調は太さ・字間・色で作る(700、-0.03em)。
- 付記: 数字は等幅(tnum)、画面で最大の文字にする。見出しは文頭のみ大文字、全大文字は 10〜11px の小見出しだけ(D)。
- 注意: 書体は Marty が決めなかった領域で、エージェントに任された。あとから "Missing brand fonts" 警告が出て、実体を同梱した(m0190)。

### 1-6. アイコン

**I1. 有名なアイコンセットを使う。自作しない。置く場所は、情報が増える所に限る。**
- 証拠:
  - "just use famous icons not custom" (V)
  - "Use icons more effectively." (m0504-b, V)
  - "can we use icons? or is there not a corresponding icons?" (m0504-p Money, V。色の点より種類が分かる)
- 実装(D): Lucide。線幅 1.75px、塗りなし、currentColor。種類ごとに同じ記号を全画面で固定する。

**I2. 作る前に、既存のライブラリを探す。ただし更新の止まったものは避ける。**
- 証拠: "Is there like a library for this kind of stuff?" (m0506-y, P)。結果は、MIT の筋肉図ポリゴンを一度だけ取り込み、帰属を残して自前で描画した。理由は "they can be deleted at any moment"(P)。

### 1-7. モーション・楽しさ

**M1. 楽しさは、動きと「見せ方の順序」で作る。拡張現実風の質感ではない。**
- 証拠:
  - "Make it fun." (m0219, V)
  - "I want to make this ring more fun ui. maybe have animation? have a big ring and networth, progress in the middle? any ideas?" (m0504-o Money, V)
- 実装(D): 数字のカウントアップ(900ms)、リングが描かれる(1100ms)、ホバーで他を 28% に落とす、ストリークの祝い。標準 220ms ease-out、値の変化にはバネ、押下で scale(0.97)。
- 注意: 提案された「次のキリの良い目標」案は、目標を置かないとそれらしく見えるだけだと反論された(m0504-o Money)。動きは本物の目標に結びつける。

### 1-8. 文言・声

**V1. 数字は主役。意味を添える。1文先行、友人の口調。**
- 証拠: 「$268 under」「Should I buy this?」(README の表, D)。"You're sleeping 24 minutes less than last month" > "Sleep avg: 7h 12m"(D)。
- 規則: 第2人称。文頭のみ大文字。感嘆符は祝いの場面だけ。

**V2. 提案・説明・サンプル質問を一切出さない。**
- 証拠:
  - "We dont ever need these suggestions. assume user knows all about the features." (m0504-r, V)
  - "Never have suggestions in this app" (m0504-x, V)
  - "I thought I was clear I never need suggestions" (m0506-y, P)
- 範囲: プロンプトチップ、「Ask Aria — '...'」行、機能説明の副題、"you might want to..."。空の状態は「何が空か」だけ言う。名詞の遷移(Open in Sleep)は可、動詞で誘う(Mix in Aria)は不可。
- 注意: 言い換えの形で2回再発した。禁止規則は「この箇所」でなく「この型」で書く。

**V3. 通貨は円が既定。画面をまたいで単位を揃える。**
- 証拠: "Default should be yen." (m0504, V)。Today も円に揃えた(D)。

**V4. 同じ表示は、全行で同じ形にする。**
- 証拠: "why does cache have no plus label?" / "I want percentage up/down as well." (m0506-j refinement, V)。

**V5. どこが AI で、どこがバックエンドの計算か、読めるようにする。**
- 証拠: "which part of these reports are AI generated and which are generated in our backedn? We made UI first so these are not clear now." (m0507-d, V)。
- 付随: "AI-est." ラベル、SourceBadge(InBody/Eufy/Apple Health)(D)。

**V6. 責めない言葉にする。誘導する聞き方をしない。**
- 証拠: エージェントが "was it necessary?" は罪悪感を煽ると指摘した(m0504-m, D)。ストリークが切れたときも恥の文言を出さない(FLOWS, D)。
- AI の口調: ぼかさない、未来予測をしない、ユーザーに質問を返さない(m0506-j, D)。

### 1-9. プロセス

**P1. 言われたまま実装しない。考えて、反論するか相談する。**
- 証拠: "do not just blindly implement what I say. make sure you think about it and push back or discuss if unsure." (m0504-m, V)
- 反論してよい場面と、してはいけない場面は lumen-iterate の SKILL に書いてある。後者は、理由が具体的で修正が機械的な指摘と、本人の専門領域の好み。

**P2. 調べて、考えて、計画してから作る。**
- 証拠:
  - "did you do research about oura numbers?" / "Did you actually think about everything? or are you just changing because i told you?" / "stop just working on things" / "plan first." (m0506-l, V)
  - "You should first understand the concept, taste and the vibe of the project before you make any decisions" (m0506-b, V)
- 背景: m0506-k で作った閾値が、Oura の公開モデルを調べずに直感で決めたものだった。

**P3. 文章で先に合意し、それから作る。**
- 証拠: 「Design in words first」は交渉不可(m0504)。Marty が "i dont have a good image of the layout yet" と言ったら、質問を重ねず、具体案を出して反応を取る(m0504-k Body の診断)。
- 同じ人が "Let's just build it out and review in batch. I dont think there are too many decisions we need t o make." (m0504-t, V) とも言った。判断の少ない作業は一括で作ってまとめて確認してよい。

**P4. 入力した本人の言葉を残す。**
- 証拠: "Keep going and dont stop. document everything along the way. especially my input." (V)。

**P5. UI ではなく UX を書く。**
- 証拠: "Make sure to document user flows and use cases too. This is not just about UI. It is about UX too." (m0194, V)。

**P6. 一括の掃除は、全箇所を見る。規則は最初に読まれる場所に書く。**
- 証拠: "did you check all places?" (m0506-ae, P)、"did we do all 3?" (m0504-p, V)。
- 理由: 掃除を4回やっても漏れた原因は、規則の置き場所と、同じ意味の書式が5種類あったこと(m0506-ae, D)。名前を付けた落とし穴の一覧(Common pitfalls)が有効だった。

**P7. 既存の部品を流用するだけでは、品質が出ない。データの形から考える。**
- 証拠: "this is what was done in last session and the UI does not follow the concept of this app. … it is just following the UI from other pages and it is not thought through. Good starting point but it is 1/10 and not the quality I expect." (m0506-am, V)
- 背景: ランを、重量挙げの部品(サマリーグリッドと PR トロフィー)にそのまま載せた。ランは時系列の物語で、重量挙げは種目の集計だった。

**P8. 全画面を1か所で見て、保存で即反映される環境を使う。**
- 証拠: "Can we have all pages in one html?" / "also, can we have hot reload?" (m0504-d, V)、"I want all pages and sub pages in http://localhost:8765/" (m0506-d, V)、"I want preview in the kits wall." (m0506-y, V)。
- 付随: "stop building parallel exploration files" (m0504-l Body, D)。案は並べて見せ、決まったら本体を直接直す。

**P9. 「やるべきでない」ことを、「いらない」と言われたら消す。**
- 例: Attention ゾーン、Discoveries カード、跳び縄ページ(「I am not counting how many I do. I will only be tracking min. we dont need a page for jump ropes.」m0506-am, V)、地図ポリゴン("we dont need map polygon")。

### 1-10. AI 機能

**A1. 入力の痛みを取る(ゼロ入力)。自動で分類し、人は確認か上書きだけにする。**
- 証拠: "Take pain away of input from the user as much as possible." (m0219, V)、"Maybe this is for later in the stage, I want auto categorization, and correct it if it is wrong manually." (m0504-l Money, V)
- 入力の層: "Chat is the input layer; pages are visualization." (m0506-x, P)

**A2. AI 要約は、目立つ上の方に置く。ただし画面の主役(可視化)を押しのけない。**
- 証拠:
  - "AI findings (HOW YOUR xxx is yyy) should be at the very bottom if they should be there at all. core concept of this app is presenting the important data visually..." (m0505, V)
  - "AI analysis shoudl be on the top ..." (m0506-d, V)
  - "Never place the AI summary on the bottom of the page" (m0506-j refinement, V)
  - "I don't like how the AI stuff is taking 80%, 90% of the page, and I am visualization in this page." (m0506-aq, V)
  - "I hate having 2 consecutive ai summary cards." (m0506-j refinement, V)
- 現在の規則: AI カードは1画面に1枚。連続させない。コンパクト版(padding 10px 14px、13px)を用意する。下端に置かない。

**A3. 使えないクロスドメインの洞察を出さない。**
- 証拠: "although these are interesting povs but i dont think some of them are useful like SLEEP × SPEND, SLEEP × LISTEN" (m0504-r, V)
- 基準: 因果の筋が通っている、行動に変えられる、すでに自明でない、の3つ(m0504-r, D)。最終的には m0506-j で分析ごと落とした(第5節)。

**A4. AI の出力に、AI の推定だと分かる印を付ける。実測のように見せない。**
- 証拠: "is vs Yoyogi Park loop on Apr 8 — today is −8 s /km and +0.6 km ... something you get from strava? if not this is ai stuff so not applicable here" (m0506-am, V)。
- 付随: "Also I want you to add a very small label where we should use AI to analyze or suggest so that it would be easier to remember when we implement backend." (m0504-u, V)

**A5. 生成は毎日ゼロからにしない。固定スロットと既定の型にして、バックエンドが作れる範囲に収める。**
- 証拠: "have templates and let AI generate these every day? no that is way too much. it is hard to implement the backned when the frontend doesnt have structure and changes everyday." (m0504-r, V)

**A6. AI が「出力として」話すのは良い。「入力の例」を出すのは悪い。**
- 証拠: "I also want suggenstions, progress encouragement for training. not just facts." (m0504-t, V)。V2 と矛盾に見えるが、区別は「Aria が自分の分析を語る」と「何を聞けるかを教える」。
- チャットの最小形: "first, just keep it a simple chat with toolcalling." / "I dont need prompt suggestions." (m0505-a, V)

## 2. 繰り返される批判パターン(見せる前に通す問い)

頻度の高い順。各問いに、Marty の実際の言葉を付ける。

1. **見えるか。** 背景と文字のコントラスト、細い線、薄い棒、潰れた小区分。「hard to see」「difficult to see」(10回前後。正確な回数は数えていない)、"still difficult to see"、"I dont see any changes."
2. **スケールは何か。** 軸、単位、最小・最大、基準線。"there is no scale." / "I dont know the scale." / "unit for charts"(最も長く続いた指摘。5回の掃除でも漏れた)
3. **この数字は、何の判断に効くか。比較する相手はあるか。** "not useful data" / "what is this info useful for?" / "What do those numbers mean?" / "what is this bar"
4. **同じものは、同じ見た目と同じ位置か。** 色、ヘッダ、並び順、デルタの出し方。"no consisitency" / "why is order flipped?" / "why does cache have no plus label?"
5. **スクロールしないと届かないものはないか。横スクロールもないか。** "I should not have to scroll" / "useless horizontal scroll"
6. **同じ情報を二度出していないか。他の画面と重複していないか。** "represent the same thing?" / "lots of duplicate" / "Why is recovery and sleep treated different?"
7. **情報は足りているか、多すぎないか。** どちらの方向にも言われた。"almost no data. It's just a line." と "too much info here and i dont know what im looking at"。答えは「その画面が答える問い」を決めてから要素を選ぶこと。
8. **全部の操作に行き先があるか。圧縮で機能を落としていないか。** "clicking this button does notthing" / "you completely dropped meal tracking too" / "did we do all 3?"
9. **提案文・説明文・サンプル質問が紛れていないか。** "Never have suggestions in this app"(言い換えで2回再発)
10. **AI の量と位置は適切か。** 下端、連続、8〜9割占有のどれも不可。
11. **他アプリの写し、ただのラッパーになっていないか。** "just a wrapper" / "You just copied the inbody UI but terrible."
12. **実際に考えたか、調べたか。** "did you do research" / "are you just changing because i told you?" / "it is not thought through" / "1/10"
13. **自分(この人)のデータと関心に合っているか。** "i tend to forget to log" / "I dont care about water" / "this is a personal app that only i will be using."
14. **全部の箇所を直したか。** "did you check all places?" / "this keeps happening"

見せる前の最短チェック: 1(見えるか)→ 2(スケール)→ 3(判断)→ 4(一貫)→ 5(スクロール)→ 6(重複)→ 9(提案文)→ 14(全箇所)。

## 3. Lumen 固有か、汎用か

**汎用(どの UI にも使える)**
- C1〜C5、C7(色の一貫、系統1つ、濃色ベタに文字を載せない、同色相の薄色、グリッド線の濃さ、サブエンコーディング)
- H2〜H4、H7、H9、H11、H12、H14(密度優先、数字に意味、不要な指標を載せない、重複排除、全操作に行き先、誰のための画面か確認、可能性の確認、共通ヘッダ)
- D1〜D3、D5〜D8、D11(チャート全般)
- S1〜S3(スクロール、ただし「モバイルのメイン画面」前提。デスクトップでは調整が要る)
- T1、I1、I2、V3、V4、V6(書体、アイコン、通貨、一貫した表示、責めない言葉)
- P1〜P9(プロセス全般)
- V2(提案・説明文を出さない)は「ユーザー本人が作った・使い込む道具」に限る。初めて使う人向けの製品では、オンボーディングは別に要る。

**条件付き(前提が合うときだけ)**
- C6:「ブランド色は1色」は、色数の少ない個人用ツール向け。複数ブランドや複数製品には当てはまらない。
- H6:「ホームは要約 + モーダル」は、深さのある情報の画面向け。単機能のフォームには過剰。
- M1:「楽しさ」は、毎日開くことが目的の製品向け。業務ツールには重い。
- D4:「補間しない」は、データが離散的なとき。連続計測値なら滑らかな線でよい。
- A1〜A6:AI 機能を持つ製品のみ。
- S4:「一番見られる画面は情報を多く」は、モーダルに送れる前提。

**Lumen 固有(他の UI へは転用しない)**
- タブ構成(Today / Money / Body / Aria)、「Today = how am I doing」の定義
- Aria、Discoveries、ストーリーシート、スワイプのレビュー案
- 指標の選択(睡眠・回復・ストレスを同格に、HRV と RHR は詳細だけ、歩数ではなく消費カロリー)
- 8色のカテゴリのマッピング(Food = オレンジ、睡眠 = 紫 など)
- 暖色の紙 `#F7F5F0`、Lumen Blue `#2563EB`、半径 20px、Geist
- AI レポートの配置と日・週・月の周期、`AriaBadge` の見た目

汎用規則を使うときは、**規則本体だけでなく「理由」を一緒に見る**。理由が自分の UI に当てはまらなければ規則も当てはまらない。

## 4. 暗黙の設計原則(Marty の言葉の背後にある一貫性)

- 5つの合格条件(V、m0194 前後): 楽しい / 一目で分かる / 深く掘れる / ドメインをまたぐ / 判断を変える。画面が「判断を変えるか」を最初に問う。
- "Think of the ideal UI and UX from the data we have." データの性質から形を決める(積み上げ面を作る前に、データは月次のスナップショットだと確認する)。
- 「何を見せるか」が先、「どう描くか」が後。形(リング/棒/線)の好みは強いが、すべて「読めるか」の理由に帰着している(D5、D8、D4)。
- 見えない構造を嫌う。カード枠、グリッド線、軸、背景色がないと「構造が無い」と言う。ただし線が濃すぎても言う(C5)。

## 5. 矛盾・覆された規則

古い記述を拾うと誤る。新しい方が現行。

| # | 論点 | 経緯 | 現行 |
|---|---|---|---|
| 1 | Today のスクロール | m0194 全メイン画面スクロールなし → m0504-y「way too little infor」で Today だけ許可 → m0506-c "ideally i want no scroll for this page. modal is fine." | Today もスクロールなし。README と FLOWS(lumen-design 版)は許可のまま古い |
| 2 | Today の主役 | Lumen Score → m0504-v で廃止 → m0504-w で Net Worth + ストリーク → m0504-y で3+2タイル → m0506-b で Burn 追加 → m0506-c で "we dont need net worth in today page" | Body を先、Money は This Month と Subs の2つ |
| 3 | AI 要約の位置 | m0504-t で Training 上に AriaCoaching → m0505 で「at the very bottom」 → m0506-d "AI analysis shoudl be on the top" → m0506-j "Never place the AI summary on the bottom" → m0506-aq 8〜9割占有は不可 | 上寄り、1画面1枚、コンパクト版あり |
| 4 | クロスドメイン分析 | m0504-j(Body)「後回し」 → m0504-q「最優先」 → m0504-r で Sleep×Spend を削除 → m0505 で最下部へ → m0506-j「No cross-domain analysis」 → m0506-y "lets remove these ai-analysis stuff completely from everywhere now that we have contents to display" | 分析カードは出さない。実データで代替。FLOWS 等に「Discoveries」の記述が残るのは古い |
| 5 | ヒーローのグラデーション | m0194 の SKILL に「唯一の濃色ヒーロー」と明記 → m0504-d(Money)で廃止 → Body と Today も → m0507-d(復習 Cover)で削除 | グラデなし。ただし lumen-design 版の `docs/SKILL.md` は旧記述のまま |
| 6 | チャートの範囲表示 | m0506-aa 数値を図の脇 → m0506-ae「low–high unit」→ m0507-b 最大左上・最小左下を図の内側 | 角ラベル2つを内側。36px 以下のスパークラインは例外 |
| 7 | 範囲ゲージ(横棒) | m0505 で VO2 のパーソナルレンジバー追加 → m0506-z でゾーンバーに数字追加 → m0506-ao "I hate these horizontal bars. never do this." | 横棒ゲージ全廃 |
| 8 | InBody の「正常範囲」 | m0506-z で帯の端を印字 → m0506-ap で人口の正常範囲を捨てた(目標が既にある) → m0506-ar で "I want to see if these are normal" と言われチップで復活 | 値は行のチップで出す。バーに重ねない |
| 9 | 指標の色 | m0506-l 同一性色 + 状態ピル → m0506-m "I hate how the color doesn't have consistency." → 状態色に一本化 | 睡眠詳細のカードのみ状態色。Today と Body ホームは同一性色(別の文脈) |
| 10 | AI バッジ | m0504-u で追加 → m0505 で全削除(要約文は残す) → m0506-j で `Aria` バッジを標準に | `AriaBadge`(スパークル + Aria)をカード単位に。復習 Cover は不要 |
| 11 | 「提案」の範囲 | m0504-r は Sleep のみ → m0504-x "Never have suggestions in this app" → m0506-y に再発 | 全体規則 |
| 12 | 同じ薄い単色 | m0506-ac で紫に → m0506-am "1/10" | ストレングスも有酸素もオレンジ。アイコンと文字で区別 |
| 13 | 積み上げチャート | m0504-d 面 → -e 棒 → -f "Dont use bar chart..." 日次の折れ線の積み上げ面 → -h 期間で切替 | 期間で型を切替(短期は線、長期は積み上げ面) |
| 14 | Runway / ATH | エージェントは「安心の数字」と推した → Marty が却下(m0504-c) | 載せない |

**ドキュメントの内部矛盾(まだ残っているもの)**
- README の「情報階層 5段」の第1段が Lumen Score のまま(m0504-v で廃止済み)。
- CSS コメントは「Greens are good, reds are bad」、README は拡散パレットで「Never red/green」。実装は良し悪しのデルタに緑と朱を使っている。色覚への配慮と実装が食い違う(Marty は指摘していない)。
- m0506-ae(2 行以内の範囲)と m0507-b(角ラベル)で、規則の書式が変わった。古い DECISIONS の記述は参照しない。

## 6. z-design-ui に取り込むときの勧め

1. 第1節の規則は「規則 + 理由」の形で、第2節の問いは「提出前チェックリスト」として使う。引用は一次証拠として残す。
2. 第5節の覆された規則は、取り込まない(または「過去に覆された」と明記する)。
3. 第3節の「固有」は、デザイン知識ではなく Lumen のブランド資料として別に置く。
4. 規則を SKILL.md に置く。DECISIONS 側に置くと、掃除が漏れる(m0506-ae の教訓)。落とし穴は名前を付けて一覧にする(`Common pitfalls`)。
