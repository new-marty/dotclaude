# Marty の見た目の好み: beautifului.dev を起点に保存物から読む

調査日: 2026-10-26。対象は beautifului.dev(ライト・ダーク両方、全 21 部品)、GoodLinks 保存のサイト約 50 件、X 投稿 12 件、GitHub README 5 件。スクリーンショットは 1440x900 で撮り、beautifului は全画面、他のサイトは先頭画面(一部は 2 画面目)を目で見た。実測値は `agent-browser eval` で computed style から取った。推測は【推論】と書く。

## 結論

1. 好みの核は「明るい off-white の地に、Inter 13px、1px の薄い輪郭線、意味のある色の小さな chip を並べた、静かで密度の高い業務 UI」だ。Linear 以降の design engineer 系の見た目にあたる。
2. 輪郭は border ではなく「不透明度 6% の黒の 1px リング(box-shadow)」で描く例が、実測した 7 サイトのうち 6 つにあった(userinterface.wiki だけ影なし)。見た目は hairline で、実装だけが shadow だ。
3. 色は無彩色の面に、状態ごとの意味色(緑=完了、橙=未着手、青=進行、赤=削除)を淡い tint + 濃い文字で置く。アクセントは青 1 色。
4. ダーク UI、等幅フォント + ピクセル装飾、暖色の紙風、イラスト付きの宣伝サイトは、同じ保存群の中で外れ値だった。
5. 日本語に合わせた実測はない(どのサイトも英語のみ)。Noto Sans JP との組み合わせは【推論】で、検証していない。

## 共通点(実測値つき)

共通の「核の一族」は後述の一覧で定義する。数値は 7 サイト(beautifului、fluidfunctionalism、agentation、transitions.dev、jakub.kr、userinterface.wiki、shadcn)を `eval` で測った値。

### 1. 地と文字の色: off-white と、ほぼ黒と中間グレーの 3 段

| サイト | 地 | 主文字 | 副文字 |
|---|---|---|---|
| beautifului | oklch(98.5%) | oklch(24.7%) | 50.6% / 69.5% |
| fluidfunctionalism | #fafafa | #171717 | #737373 |
| transitions.dev | #fdfdfd | #0d0d0d | #767676 |
| jakub.kr | #fcfcfc | L12(ほぼ黒) | L47 |
| userinterface.wiki | (地は透明、#fafafa 相当) | #202020 | #838383 |
| agentation | ほぼ白(透明) | #333 | #737373 |

- 純白(#fff)の地も純黒の文字も使わない。純白は「面(カード)」にだけ使う。beautifului は地 98.5%、キャンバス(部品を置く台)96.1%、面 100% の 3 段で、白いカードが灰色の台の上に載る。
- グレーは 3 段(ink / ink-2 / ink-3)で、薄い 3 段目は説明文と補助数字に使う。
- beautifului の線は --line 94.6%、--line-strong 91.2%、--line-soft 96.6% の 3 段。

### 2. 輪郭は「6% の黒リング」。影は足しても極薄

- beautifului: `--shadow-hairline: 0 0 0 1px var(--line)`、`--shadow-card: 0 0 0 1px line + 6 段重ねの極薄ぼかし`(不透明度 1〜3%)、`--shadow-xs: 0 0 4px #0000000a`。
- fluidfunctionalism: `0 0 0 1px rgba(0,0,0,.06)` + `0 1px 2px rgba(0,0,0,.04)`。transitions.dev、jakub.kr、agentation も同型(リング .06 + 影 .04〜.08)。shadcn は .05。
- jakub.kr 自身がこの手法を記事にしている(「Using Shadows Instead of Borders」。ring .06、hover で .08 に上げる。https://jakub.kr/work/shadows)。理由は、影は透明度で作るので背景が何色でも馴染むこと、hover で寸法が動かないこと。
- beautifului の `border` そのものは 1px solid が 439 要素、1px dashed が 2 要素(セクション区切りの破線)。
- 【推論】Marty の「影や塗りより hairline が好き」は、この「リング + 極薄の影」を指している可能性が高い。beautifului のカード(白、ring、極薄の影)も彼の好きなものに含まれる。重い影と、色のついた塗りの箱は含まれない。

### 3. 書体: Inter 一択、サイズは 13px 中心、字間はわずかに詰める

- beautifului: 本文 13px/500(表のセル 560 要素)、ナビ 12.5px/400、chip 11.5px/500、補助 12px/400、索引番号 JetBrains Mono 11px/400、h1 は 21px/600、字間 -0.42px(-0.02em)。全体に -0.14px(約 -0.011em)。`font-feature-settings: "cv11", "ss01"`(Inter の別字形)。
- fluidfunctionalism: Inter 13px/400 が 358 要素、12px、11px。見出し 28px/400 の 1 件だけ。
- transitions.dev: Inter 13px/400・500。agentation: Inter 14px、重さは 450 と 550(可変フォント)。userinterface.wiki も 450 と 550。「400 と 500」でなく中間の重さを使う癖がある。
- 文字は 10〜14px に大半が収まり、見出しも 21〜28px 止まり。大きな見出しは宣伝サイトの hero だけ。
- shadcn のみ Geist(14px)。【推論】Marty の「Inter が好き」は、この一族の標準と一致する。
- 数字の桁(tabular-nums)は別ノート(01)で好みの確認済み。今回の実測では未確認。

### 4. 角丸は 8px を基本に、ボタンと chip だけ pill

- beautifului: 8px が 395、6px が 300、pill(最大値)が 100、14px が 25、7px が 28、ステージ(台)は 22px。
- fluidfunctionalism: 8px が 241、pill 56、12px 39。agentation は 6px / 4px。shadcn は 8 / 10px。transitions.dev は pill と 14 / 24px が混在。
- 使い分け: 入れ物と行は 8px、ボタン・chip・segmented control・タブは pill。大きな面(台)は 14〜24px。
- 同心円の角丸(外側 = 内側 + 余白)は jakub.kr 流の作法で、beautifului の 22px 台 → 14px カード → 8px 行 にも見える【推論】。測っていない。

### 5. 色は状態の意味で付ける。半透明の tint + 同色相の濃い文字

- beautifului の意味色: 緑 oklch(60.3% .155 151)、橙 (68.9% .179 50)、赤 (62.1% .192 23)、青アクセント (62.6% .205 255)。tint は明度 95〜96%、彩度 .017〜.021 の極淡色。
- 使い方の実例: 状態 chip(To do=橙、In Progress=青、Completed=緑)、差分(削除行=薄赤 + 取り消し線、追加行=薄緑)、確信度、diff の +74 −41、タグ(紫、橙、黄緑、桃、水色の 8 種ほど。Records Table)。
- 状態 chip は pill、高さ約 20px、横余白 8px、文字 11.5px/500、tint の地。リングは状態色の 28% 不透明度(例: 緑 0.28)。
- アクセント(青)は主ボタン(Accept、Apply)と、選択中、リンクにだけ使う。それ以外の主ボタンは黒(fluidfunctionalism の Copy install prompt、transitions.dev の送信ボタン)。
- gr8r の README 画像、kargul の kanban、Capy の Guided Review も同じ: 色は優先度・状態・差分の意味だけに使い、面は無彩色。

### 6. 密度: 行 35px、余白は 4 の倍数、台と部品を分ける

- beautifului の Records Table は 1 行約 35px(文字 13px)。タスク行(capsule)は約 52px。ナビ項目は 12.5px、縦 5px 8px の余白、高さ約 28px。
- gr8r(README のダッシュボード画像)も同程度の密度で、4 枚の KPI カード、表、右列にタイムラインを並べる。kargul の kanban はカードをやや大きく(文字 15px 前後)取る。
- 部品の見せ方(台に白カードを 1 つ置く)は beautifului 固有。agentation はカードを台に置かず、ページ地に直接置く。

### 7. アイコンと動き

- beautifului のアイコンは stroke 線(線幅 1.8 / 2 / 2.2 / 2.5 の混在)で、塗りは使わない。線幅は Lucide 系に見えるが、ライブラリ名は確認していない。fluidfunctionalism は設定欄に `Icons: Untitled UI`、`Primitive: Base UI`、`Heading font: Inter` と明記している(選択肢として Marty が挙げた Untitled UI と一致)。
- 動き: beautifului の transition は 100 / 150 / 200 / 300ms の 4 種(クラス名から)。hover で行のアイコンが opacity で入れ替わる。fluidfunctionalism は「hover の背景が行間を滑る」(Fluid Hover)を標語にしている。動きの詳細は 04、05 のノートが扱う。

## 一族の定義と保存日

「核の一族」(light、Inter 系、リング hairline、意味色の chip、製品 UI が主役)は次の 14 件。保存日は GoodLinks の `addedAt`。2026-03-02 は一括取り込みで保存時期の情報を持たない(01 の注意を参照)。

| サイト | 保存日 | 一族か |
|---|---|---|
| beautifului.dev | 2026-09-11 | 起点 |
| diffs.com(Pierre) | 2026-09-05 | 準一族: 宣伝部は light、製品画面は dark |
| agentation.com | 2026-09-13 | 一族(最も静か) |
| jakub.kr | 2026-08-24 | 一族(書き手) |
| userinterface.wiki | 2026-03-02 | 一族 |
| transitions.dev | 2026-10-14 | 一族 |
| fluidfunctionalism.com | 2026-10-24 | 一族(最も近い) |
| ui.shadcn.com | 2026-03-02 | 土台 |
| gr8r-studio(README 画像) | 2026-10-14 | 一族(X の動画は dark) |
| kargulstudio/kanban | 2026-10-07 | 一族(Linear 型の看板) |
| kargulstudio/sales-crm | 2026-10-07 | 画像なし。同じ起点リポ【推論】で kanban と同系 |
| pulls.review | 2026-10-07 | 準一族(等幅の見出し、diff の意味色) |
| crit.md | 2026-09-29 | 準一族(light、青 1 色、等幅) |
| Capy の Guided Reviews(X: 0xluffy) | 2026-10-08 | 一族(動画の 2 フレームを確認) |
| neverbeforeseen.co の製品画面 | 2026-03-02 | 一族(スタジオの作品。Linear / SaaS 型の画面が並ぶ) |

- 準一族: light の SaaS の製品画面は、attio、amie、mintlify、midday、cap.so、cleanshot が同じ方向(Inter、1px 線、青い主ボタン)。ただし 2026-03-02 の一括保存で、時期の信号がない。また landing しか見ていない。
- 9〜10 月の手動保存では、一族が増えている(agentation、diffs、crit、pulls.review、Capy、kargul、gr8r、transitions.dev、fluidfunctionalism)。一族を意識して集め始めた可能性がある【推論】。

## 外れ値

次は一族から外した。数の多いものから挙げる。

- **dark の開発者向け宣伝サイト**: blackboard.sh/dash(2026-10-19)、agentsdock(09-29)、languine(03-02)、ponytail(09-12)、cheaperinference(09-11)、kiro.dev(09-12)、atlas-sysdes(09-29、React Flow の図)、ossinsight(03-02)、effect.kitlangton(03-02)、screen.studio(03-02)、inbound.new(03-02)。dark 一色 + 等幅 + ピクセル/グリッド装飾。Marty は「アプリの dark は見にくい」と述べており、これらは「記事・ツールとして読む」ために保存した可能性がある【推論】。
- **warm な紙/イラスト調**: jaste.app(09-29)、zen-browser、mem.ai、marta.sh、craft.do、getnoir、openship、usemotion。暖色の地、serif や斜体の見出し、写真、グラデーション。製品を見せるより雰囲気を見せる。
- **等幅の大文字見出し**: factory.ai(08-24)、warp.dev(08-24)。light だが等幅 + 大文字 + 製図風で、Inter の一族とは別の系統。
- **信号なし**: getden(アニメ作品アプリ、dark)、supa.vote(失効ドメインの売り出し)、deepdocs(サイト消滅)、textarea.my(意図的な空白ページ)、cmux(白黒の説明文のみ)、todometer(dark の小アプリ)、dimeApp(家計アプリ。白地・黒・赤緑で近いが、数字を大きく見せる iOS で別物)、nikolatoy と Pavyon(玩具店と Framer テンプレ。UI の信号ではない)。
- **X 投稿**: 12 件のうち画像で見た目を読めたのは Capy(一族)と gr8r(一族、動画は dark)だけ。omer_assa は dark のノードエディタ(色付きの線、グロー)。cody(code review)の画像は dark の小さな吹き出し(+55 −7 の緑と赤)で、色の使い方は一族と同じ。poteto、GitTrend、s4yonnara、tenhkspark、carm1nee、wsvn53、iwashi86、VullnetAdemaj の投稿は、視覚の信号を持たない(リスト、ツール紹介、講演メモ)。

## 系譜と呼び名

一語の定訳は見つからなかった。近い呼び名と出典は次のとおり。

- **「design engineer」の流派**: jakub.kr の肩書きが「Design Engineer at Interfere」で、書いた記事とスキル(`/skills`、interfaces.dev、loading.dev)が一族の中心。neverbeforeseen は自らを「boutique product & design engineering studio」と名乗る。transitions.dev(Jakub Antalik)、userinterface.wiki(Raphael Salaja)、fluidfunctionalism(@micka_design)は同じ世代の個人発。いずれも自分のページを見て確認。
- **「Linear / Vercel 風の minimal」**: 近縁の説明として、AI 向けスキル集は「ほぼ無彩色、Inter か Geist、アクセント 1 色、影の代わりに hairline の輪郭、余白は広く、動きは少なく」と書く(二次資料。[skills.cat の ui-craft-minimal](https://skills.cat/skills/educlopez/ui-craft/ui-craft-minimal))。Vercel の説明も同様(近黒の文字、off-white の地、hairline が構造を担う)。Raycast は「Inter を全面に、近黒の青みの背景に薄い白枠」(いずれも [Refero](https://styles.refero.design/)、[hagicode の DESIGN.md](https://design.hagicode.com/designs/raycast/DESIGN.md) など第三者の要約で、公式の記述は未確認)。
- **輪郭を shadow で描く手法**: [jakub.kr「Using Shadows Instead of Borders」](https://jakub.kr/work/shadows)(リング .06 + 影 .06 / .04、hover で .08 / .08 / .06)。UX Planet の記事も同じ手法を「hairline border trick」と呼び、Vercel のパネルを例に挙げる(会員限定で本文は未読。検索結果の要約のみ)。
- **beautifului の作り手 Turbo**: ブルックリンの product design studio。「AI 世代のプロダクトを設計する」「VC の出資を受けたスタートアップ向けの embedded product design」と自称し、顧客に ramp、Jeep、StockX、ROI、Whop、KICK を並べる(https://turbodesign.co/ の本文)。作品は Ramp の旅行予約、iOS の学習アプリなどの画面で、スタジオ自身のサイトは dark。beautifului は MIT ライセンスで、デモ用の「Ice Cream Harness」(https://www.beautifului.dev/harness)を備える。Turbo の他の公開物は今回見つからなかった。
- **Pierre(diffs.com)**: 「The Pierre Computer Company」製。diffs と trees を OSS で出し、GitHub の差分・PR 画面を置き換える DiffsHub を作った、との第三者要約がある(traeai.com の集約ページ。公式未確認)。創業者名は確認できなかったので書かない。

【推論】系譜は「Vercel / Linear / Raycast の見た目 → design engineer が自作の部品集と記事にして広める(Jakub Krehel、Emil Kowalski、Raphael Salaja、Jakub Antalik)→ AI エージェントの画面部品に適用(beautifului、Capy、Pierre、agentation)」の順に見える。Linear、Vercel、Raycast の公式デザイン記述は読んでいないため、起源は確定できない。

## ライトモードでの姿

この一族は元から light が標準で、beautifului は dark を後から足している(`.dark` で全トークンを張り替える)。Marty が light を好むなら、そのまま使える。値は beautifului の light トークン(oklch)に基づく。

- 地 98.5%(約 #fafafa)、台 96.1%(約 #f3f4f6)、面 100%(白)、凹み 97.9%、hover 97%、押下 93.3%。
- 文字: 主 24.7%(約 #1f2329)、副 50.6%(約 #6b7280)、補助 69.5%(約 #9ca3af)。
- 線: 94.6%(通常)、91.2%(強調)、96.6%(弱)。リング `0 0 0 1px` はこの線色か `rgba(0,0,0,.06)`。
- 意味色: 緑 (60.3% .155 151)、橙 (68.9% .179 50)、赤 (62.1% .192 23)、青 (62.6% .205 255)。tint は (95〜96% .017〜.021)。chip の文字は tint と同色相の濃色を使う。
- 面の重なりは 3 段まで: 地 → 台(任意) → カード(白 + リング + 極薄の影)。入れ子のカードは作らない(impeccable の禁止項目と一致。01 のノート)。
- 日本語向けの調整は【推論】で未検証: 本文 13px の Inter に Noto Sans JP を合わせるなら、日本語の行間は欧文より広め(1.6 前後)、`palt` と `text-autospace` を使う(01 のノートの保存記事に沿う)。beautifului は欧文の行間 1.5(13px で 19.5px)で、そのままでは日本語は詰まる。

## まだ好みとして決まっていない点

保存物の中で互いに矛盾していて、Marty に聞かないと決まらない分岐だけを挙げる。

1. **部品の置き場**: 灰色の台に白カードを 1 つ載せる(beautifului、Capy の Guided Review)か、ページ地にそのまま線だけで置く(agentation、fluidfunctionalism の本文、jakub.kr)か。前者は面が 3 段で立体感があり、後者は線だけで平らに見える。
2. **ボタンの形**: pill(beautifului の全ボタン、transitions.dev、shadcn の新しいボタン)か、8px の角丸の四角(attio、kargul の看板、gr8r)か。同じ一族の中で割れている。
3. **密度**: 行 35px・文字 13px の詰めた表(beautifului、gr8r)か、カード 1 枚を大きく取る看板(kargul の kanban、agentation の説明ページ)か。前者は一覧性、後者は読み取りやすさが勝つ。

動きの大きさ、等幅フォントを使うか、アクセント色(青かほぼ黒か)は、決まった傾向があるので分岐に含めない(青は beautifului、黒は fluidfunctionalism と transitions.dev で、ボタンの重要度で使い分けて矛盾しない)。

## Gaps

- 日本語での実測がない。Inter と Noto Sans JP の併用は、保存物にも実測にも根拠がない。
- beautifului は light と dark の画面を全部見たが、hover と動きの実測(duration 以外のイージング曲線、スプリング値)は取っていない。
- 保存日は 2026-03-02 の一括取り込みが 3 分の 1 強を占め、「いつから好きか」は 9〜10 月の手動保存でしか言えない。10 月は件数自体が増えており、一族の増加が好みの変化か、保存量の増加かは区別できない【推論】。
- Capy と gr8r と Omerico は動画の 2 フレームだけを見た。X 投稿のうち、画像が無いもの、リンク先がリストだけのものは視覚の判断ができない。
- pr-lens の README 画像は SVG の相対パスで取得できず、見ていない(保存は 10-19、code-review タグ)。kargulstudio/sales-crm は画像・デモとも見つからず、kanban(https://kanban-blue-beta.vercel.app/)だけ見た。
- Turbo の他の作品は、スタジオの landing の画像だけ。誰が作ったかの個人名は確認していない。
- 「Linear / Vercel / Raycast の見た目」の記述は第三者の要約で、公式のデザイン記述や Linear 自身の画面は見ていない。UX Planet の記事は本文を読めていない。
- attio、midday、amie などの SaaS は landing だけを見た。製品画面そのものの実測はしていない。
- 一族の判定は私の目による。数値で測ったのは 7 サイトで、他は見た目の判断。
