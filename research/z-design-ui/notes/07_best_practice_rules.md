# 07 好みではなく定石で決まるもの: 判断規則(文字サイズと密度・説明文・動き・構造・数字・ライト/ダーク)

調査日: 2026-10-26。02〜04 の続き。重複は避け、「どの文脈でどの値か」に絞った。
表記: 出典の後ろの「読了」は本文を取得して確認、「検索のみ」は検索結果の要約だけ。【弱】は二次情報・ベンダー記事・未検証。【推論】は筆者の解釈。

## 結論

1. サイズ・動き・数字・ダーク/ライトは、一次資料(Carbon・DADS・NN/g・論文)に具体値と適用条件がある。好みで決める領域ではない。決め手は「使う頻度」「情報量」「読む(長文)か走査する(表)か」の三つ。
2. 文字サイズは「情報量優先の業務画面」と「読む画面」で別の規則を持つ。Carbon は 14px(productive)と 16px(expressive)、DADS は日本語で本文 16px 以上・密な表は 14〜17px+行間 1.2〜1.3、GOV.UK は 14px 以下を廃止した。日本語は 14px 未満を作らない。
3. 動きは「頻度が高いほど短く・無く」。Carbon の productive は 70〜240ms、NN/g は 100〜400ms で 500ms を超えると遅い。Apple と Emil は高頻度の操作に付けない。最後に必ず `prefers-reduced-motion`。
4. 数字は、桁を比べる場所(表・金額・カウンター・タイマー)では tabular(桁幅固定)+右寄せ+小数桁そろえ、文章中ではプロポーショナル、コード・ID は等幅。ただし tabular が読みやすいことを測った実験は見つからず、根拠は組版の慣習と実装者の経験にとどまる。
5. ライト/ダークは実験が一貫して「ライト(ポジ極性)が成績で勝つ。小さい字ほど差が開く。本人は差に気づかない」。NN/g は一般向けの既定をダークにしないよう勧め、Apple は OS 設定に従うよう求める。既定は「OS に従う。信号がなければライト」。Marty の「ダークは読みにくい」は研究と整合する。

---

## (1) 文字サイズと密度

### 事実

**日本語(最重要)**
- デジタル庁 DADS: 「本文やUIにおいては16 CSS px以上が基準値」。14px は「フッターなど付随情報や領域的な制約で16pxが使えない場合のみ」。「14 CSS px未満の大きさの使用は原則として許容されません」。読了。https://design.digital.go.jp/dads/foundations/typography/
- DADS のスタイル区分(読了、同上): Standard は 16px で行高 170%(175%も可)・字間 2%、17px で 170%。26px 以下の字間は 2%、28〜36px は 1%、45px は 0。Dense は「管理画面や業務システムなど限られた画面領域での表示情報量を優先」し、14/16/17px・行高 130% または 120%・字間 0。Oneline(ボタンなど1行)は行高 100%・字間 2%。Mono は 150%。
- DADS の行高の使い分け(読了、同上): 120% は「大量の情報を一覧表示する、表示情報量を最優先する画面」、130% は管理画面・業務システム、150% は本文の最低限、160% は一般的な本文、170% は「心理的負荷を抑えた本文」。見出しなど大きな文字は本文より狭く(140%)。
- SmartHR Design System: 基準 16px。XS=12px、S=13.71px、M=16px、L=19.2px。段落テキストの行間 1.5、見出し 1.25、ラベルテキスト(ボタンなど)は 1。段落では S と XS を積極的に使わず、ラベルでも S は例外のみ。表は段落テキストと同じスタイル。読了。https://smarthr.design/products/design-tokens/typography/
- DADS の行長の記述はなし(読了で確認)。WCAG 1.4.8(AAA)は CJK 40 字以内。03 で読了済み。

**欧文・プラットフォーム**
- IBM Carbon: productive は「製品画面で、凝縮した表現でタスクに集中させる」、expressive は「編集・マーケティング・長文の読み」。製品では expressive を使うと邪魔になる。body-compact-01 は 14/18px(コンポーネント内の4行以下の短文)、body-01 は 14/20px(productive の長い段落)、body-02 は 16/24px(expressive の4行以上の段落)、label-01 と helper-text-01 は 12/16px(フィールドのラベル・補足。本文には使わない)。読了。https://carbondesignsystem.com/elements/typography/type-sets/ 、https://carbondesignsystem.com/elements/typography/overview/
- Fluent 2(web): Body 1 が 14/20px、Caption 1 が 12/16px、Caption 2 が 10/14px。最小サイズの規定はなし。読了。https://fluent2.microsoft.design/typography
- Material 3(トークン値。material-web リポジトリ): body-large 16/24px、body-medium 14/20px、body-small 12/16px、label-large 14/20px、label-small 11/16px。読了(トークン定義)。https://raw.githubusercontent.com/material-components/material-web/main/tokens/versions/v0_192/_md-sys-typescale.scss
- Apple HIG: 既定/最小は iOS・iPadOS 17pt/11pt、macOS 13pt/10pt、visionOS 17/12pt、watchOS 16/12pt。軽いウェイト(Ultralight/Thin/Light)は小さい字で見えにくいので避ける。読了(HIG の JSON)。https://developer.apple.com/design/human-interface-guidelines/typography
- GOV.UK: 本文は全画面幅で 19px/25px、小さい本文は 16px/20px。以前あった 14px(大画面)・12px(小画面)を廃止した。理由は「14px 以下はアクセシビリティ上よくない」という利用者の声と、英国ディスレクシア協会の「12pt(約16px)を下回らない」。読了。https://design-system.service.gov.uk/styles/type-scale/ 、https://designnotes.blog.gov.uk/2022/12/12/making-the-gov-uk-frontend-typography-scale-more-accessible
- 密度の行高さ: Carbon のデータテーブルは xs 24px、sm 32px、md 40px、lg 48px、xl 64px(xl は1セルに2行入る場合のみ)。読了。https://carbondesignsystem.com/components/data-table/style/ 。Pencil & Paper は Condensed 40px、Regular 48px、Relaxed 56px。密度の切替は表の外に置き、選択を保存する。読了。https://www.pencilandpaper.io/articles/ux-pattern-analysis-enterprise-data-tables 【弱】(事例分析の記事)
- NN/g: 複雑なアプリでは「機能を減らさず散らかりを減らす」。重要でない要素を取り除くほうが、強調するより目立たせられることがある(数字の横の装飾アイコンが例)。詳細は段階的開示(staged disclosure)に回す。読了。https://www.nngroup.com/articles/complex-application-design/

**小さい字ほどポジ極性が有利**
- Piepenbrock ら(Human Factors 2014): 校正課題で 8〜14pt を比較し、ポジ極性の優位は文字が小さいほど直線的に大きくなる。検索のみ(抄録要約)。https://metatoc.com/papers/26930-positive-display-polarity-is-particularly-advantageous-for-small-character-sizes-implications-for-display-design

### 規則(スキルが使う形)

| 文脈 | 規則 | 値 | 出典 |
|---|---|---|---|
| 日本語の本文・UI 全般 | 基準は 16px 以上。14px 未満は作らない | 16px、行高 1.5〜1.7(読ませる本文は 1.7) | DADS、SmartHR(読了) |
| 日本語の業務画面・毎日使う密な表・一覧 | 14px まで下げてよい。代わりに行高を詰め、余白でなく行高で密度を作る。ラベル・補足も 14px を下限にする | 14〜16px、行高 1.2〜1.3(一覧最優先は 1.2) | DADS Dense(読了) |
| 日本語の読み物(記事・ドキュメント) | 16〜18px、行高 1.7〜1.75、行長 40 字前後 | 16〜18px / 1.7 / 約 40 字 | DADS(サイズ・行高)、WCAG 1.4.8(行長。AAA)。40 字は【推論】 |
| 日本語の見出し | 本文より行高を狭める | 1.25〜1.5 | DADS、SmartHR(1.25) |
| 日本語のボタン・1行ラベル | 行高 1。縦の余白はパディングで取る | line-height 1(DADS は 100%) | DADS Oneline、SmartHR |
| 欧文の製品 UI(デスクトップ・毎日使う) | productive の 14px 本文、12px のラベル・補足 | 14/20、12/16 | Carbon、Fluent(読了) |
| 欧文の公共・一般向け・小画面 | 本文 16〜19px。小画面で縮めない | 19/25(GOV.UK)、16/20 | GOV.UK(読了) |
| Apple 各プラットフォーム | 既定サイズ以上。軽いウェイトを避ける | iOS 17pt、macOS 13pt | HIG(読了) |
| マーケティング・LP | expressive。本文 16px 以上、見出しはブレークポイントで変える | body 16/24、見出しはレスポンシブ | Carbon expressive(読了) |
| 補足・脚注・キャプション | 日本語は 14px を下限。欧文は 12px まで | 日本語 14px、欧文 12/16 | DADS、Carbon |
| 表の行高 | 毎日使う業務は 32〜40px、通常 48px、2行入るなら 64px | 32/40/48/64 | Carbon、Pencil & Paper【弱】 |
| ダークテーマの小さい字 | 小さい字ほどポジ極性が有利なので、ダークでは本文を小さくしない。最小でも 1段上げる | 14→15〜16px | Piepenbrock 2014(検索のみ)。数値は【推論】 |

### スキルへの示唆
- 「密度」は一つの数字でなく文脈の選択として持たせる。業務の毎日使う画面は Dense、読ませる画面は Standard。DADS の Dense/Standard、Carbon の productive/expressive が同じ二分法。
- 日本語で 14px 未満を禁止する検査は機械で書ける(`font-size` の grep)。
- 密度は余白でなく行高と行高さのトークンで切り替える(Carbon の xs〜xl、DADS の 120%/130%)。ユーザーが選べる密度は表の外のスイッチ(Pencil & Paper【弱】)。

### Gaps
- DADS の Dense の「17px+行高 130%」と Standard の「16px+170%」のどちらを選ぶかは、利用頻度の数値基準がない。【推論】で「毎日・一覧中心なら Dense」とした。
- freee Vibes と SmartHR の密度(表の行高)は公式ページから取れなかった。Japanese 業務 UI の行高さの実例が足りない。
- iOS Safari が 16px 未満の入力欄でズームする挙動は今回確認していない(04 の領域)。

---

## (2) 説明文・ラベルをどれだけ出すか

### 事実
- GOV.UK: すべての入力に「たいてい見える」ラベルを付け、上に置く。ヒントは「多数の利用者に関係する助け」だけ。「1つの短い文、句点なし」で、それより長い説明をヒントに入れない。ヒントにリンクを置かない。スクリーンリーダーは操作のたびにヒント全体を読むため。読了。https://design-system.service.gov.uk/components/text-input/
- DADS(インプットテキスト): サポートテキストは「入力形式の条件や例を簡潔かつ具体的に」書き、「必要十分なサポートテキストをあらかじめ提示しなければならない」。項目ラベルと入力欄の間に置く。「サポートテキストを企図してプレースホルダーテキストを使用してはならない」(値を入れると説明が消えるため)。悪い例は「エラーが出て初めて入力条件が分かる」状態。必須/任意は「※必須」「※任意」。読了。https://design.digital.go.jp/dads/components/input-text/usage/
- SmartHR: ヘルプメッセージ(入力欄の上)と入力例(上)は「入力内容に迷いが生じそうなとき」。補足メッセージ(下)は「入力時に把握しなくても操作に影響のない情報」だけ。placeholder は原則非推奨。読了。https://smarthr.design/products/components/form-control/
- Polaris: 操作に必須の指示はラベルに入れ、ヘルプテキストとプレースホルダーは非必須の案内。プレースホルダーだけに必須情報を載せない。検索のみ。https://polaris-react.shopify.com/components/selection-and-input/text-field
- NN/g: プレースホルダーは有害。ラベル・ヒント・指示は入力欄の外に常時表示する。検索のみ(要約)。https://www.nngroup.com/articles/form-design-placeholders/ 。ツールチップは補足専用で、必須情報を入れない。短く、キーボードでも出し、タッチでは避ける。読了。https://www.nngroup.com/articles/tooltip-guidelines/
- NN/g(オンボーディング): 起動時のチュートリアルは「利用者はよく飛ばす」「すぐ忘れる」。出すなら、その場の操作に紐づく文脈ヘルプ(pull)にする。簡単に閉じられ、再度見つけられる。慣習(歯車=設定)は説明しない。割合や人数は記事にない。読了。https://www.nngroup.com/articles/onboarding-tutorials/
- NN/g: アイコンは普遍的な少数を除き、常に見えるテキストラベルを付ける(03 で読了)。マイクロコピーは3文未満で、最も処理されやすい。読了。https://www.nngroup.com/articles/ux-copy-sizes/
- Vercel Web Interface Guidelines: 簡潔に、インラインの説明を優先し、ツールチップは最後の手段、アイコンにはラベル。ただし文中の好みは「普遍的なガイドではない」と断っている。読了。https://vercel.com/design/guidelines
- Carbon: helper-text-01(12/16)は「フィールド名の下の説明」専用の文字スタイル。読了(上記)。
- Krug「Happy talk must die」「Instructions must die」: 二次要約のみ。【弱】 https://blog.codinghorror.com/happy-talk-must-die/

### 規則

| 文脈 | 規則 | 値 | 出典 |
|---|---|---|---|
| 入力欄の形式・制約(桁数、使える文字、例) | 入力前から見える位置に短く書く。エラーで初めて分かる状態にしない | 項目ラベルと欄の間(DADS)または上(SmartHR)に1文 | DADS、SmartHR(読了) |
| 多数の利用者に当てはまらない説明 | 出さない、またはヘルプへのリンクにする | ヒントは1文・句点なし・リンクなし | GOV.UK(読了) |
| 操作に必須の情報 | ラベル本体か常設テキストに入れる。placeholder・ツールチップに入れない | — | DADS、Polaris、NN/g |
| 操作に影響しない補足 | 欄の下の補足(任意)。多数に必要でなければ削る | — | SmartHR(読了) |
| 毎日使う業務画面 | 画面の使い方の説明文は出さない。ラベルは常に見せる。補足は hover/ヘルプに退避(ただし必須情報は除く) | 説明は1項目1文以下 | NN/g の複雑アプリ(散らかりを減らす)、Vercel【弱】 |
| 初回・まれにしか使わない画面(申請、設定) | 説明を増やしてよい。手順は具体的に、先に見せる | — | DADS(必要十分を先に)。【推論】 |
| アイコンだけのボタン | 普遍的な 4 種(home/print/search/close)以外は常設ラベル。密なツールバーのみツールチップ+aria-label | — | NN/g(03)、Vercel |
| オンボーディング・使い方の説明 | 最初に全部見せない。操作の瞬間に文脈ヘルプとして出す。閉じられる | — | NN/g onboarding(読了) |
| エラー | 欄の近く(日本語は DADS では欄の下)に、原因と直し方 | — | SmartHR、DADS(読了) |
| 日本語の必須/任意 | 「※必須」「※任意」。必須が大多数なら任意だけ付ける【推論】 | — | DADS(読了) |

### スキルへの示唆
- 「説明文を足す前に、(a) 多数の利用者が迷うか、(b) 入力を誤りやすい制約か、を確かめる」を判定の手順にする。どちらでもなければ削る。
- 説明が複数の画面で同じなら、各画面に書かず、ヘルプへ一本化する(GOV.UK の「長い説明はヒントに入れない」)。
- 生成 UI が説明文を足し過ぎる傾向への対策として、画面の見出しの下に説明段落を置く前に「この段落を消すと、誰が何に迷うか」を一行書かせる。【推論】

### Gaps
- 「どれだけ説明を減らすと完了率が上がる」という定量実験は見つからなかった。規則の根拠は各デザインシステムの指針と NN/g の観察に限られる。
- Krug の原文、freee の文言ガイド(Groove)は未読。

---

## (3) 動き

### 事実
- IBM Carbon: productive は「効率的で応答が速く控えめ」、ボタンの状態・ドロップダウン・追加情報の表示・表やグラフの描画に使う。expressive は「重要な場面」(新しいページを開く、主要な操作、意味を伝える動き、システムのアラート)に限り、「まれな重要な場面に取っておく」。読了。https://carbondesignsystem.com/elements/motion/overview/
  - 時間: fast-01 70ms(ボタン・トグル)、fast-02 110ms(フェード)、moderate-01 150ms(小さい展開・短い移動)、moderate-02 240ms(展開・システム通知・トースト)、slow-01 400ms(大きな展開・重要な通知)、slow-02 700ms(背景を暗くする)。動く距離や大きさに応じて長くする。
  - イージング: productive の標準 `cubic-bezier(0.2, 0, 0.38, 0.9)`、入場 `(0, 0, 0.38, 0.9)`、退場 `(0.2, 0, 1, 0.9)`。expressive の標準は `(0.4, 0.14, 0.3, 1)`。
  - 「よく見かける動きは取り除くか最小にする」。モバイルでは動きだけに頼らない。
- Material 3(material-web のトークン値): short1〜4 = 50/100/150/200ms、medium1〜4 = 250/300/350/400ms、long1〜4 = 450〜600ms、extra-long = 700〜1000ms。standard と emphasized の easing は `cubic-bezier(0.2, 0, 0, 1)`、emphasized-decelerate は `(0.05, 0.7, 0.1, 1)`、emphasized-accelerate は `(0.3, 0, 0.8, 0.15)`。読了(トークン)。https://raw.githubusercontent.com/material-components/material-web/main/tokens/versions/v0_192/_md-sys-motion.scss 。M3 の公式ページ(m3.material.io)は JS 描画で本文を取れず、使い分けの文章は未確認。
- NN/g: 全体は 100〜400ms(長くても 500ms)。単純なフィードバック(チェックボックス、トグル)は約 100ms。画面が大きく変わる(モーダル)は 200〜300ms。400ms は「大画面の大きな移動」だけ。入場は退場より少し長く(例 300ms/200〜250ms)。500ms では「重荷」。頻度が高いほど短く控えめに。ease-out を基本にする。読了。https://www.nngroup.com/articles/animation-duration/
- NN/g(効く場面・害になる場面): 効くのは、注意を向けさせる、原因と結果を示す(依存項目が現れる)、状態の連続性を示す。害になるのは、周辺視野の動き(スライドインするチャット誘導)、繰り返し(2回目は「うんざり」、3回目は「腹立たしい」)、目的のない装飾、メニューのような頻用要素の長い演出、読んでいる文章を動かす動き。原因と結果の関係は操作から 0.1 秒以内に始める。再生を飛ばせるようにする。動きなしが最も邪魔にならない。読了。https://www.nngroup.com/articles/animation-usability/
- Atlassian: 頻度が高い操作ほど短く。トークンは 0ms(フォーカス)、50ms(リスト項目の hover)、100ms(押下・ポップアップ退場)、150ms(強調した hover・ポップアップ入場)、200ms(モーダル退場)、250ms(モーダル入場)、400ms(ページ遷移)、600ms(オンボーディング・全画面)。退場は入場より 50〜100ms 短く。layout を起こす width/height/top をアニメしない。1遷移で動かすのは 1〜2 プロパティ。エラーやフォーカスを遅い入場の後ろに置かない。読了。https://atlassian.design/foundations/motion/applying-motion
- Apple HIG: 目的のある動きだけ。頻繁に起きる UI 操作には原則付けない。動きを唯一の伝達手段にしない。待たせない(キャンセル可能)。簡潔で正確なフィードバック。読了(HIG の JSON)。https://developer.apple.com/design/human-interface-guidelines/motion
- Vercel: 因果の説明か意図した喜びのときだけ。キャンセル可能。`transition: all` 禁止。`prefers-reduced-motion` を守る。読了。
- Emil Kowalski(03 で読了済み): 300ms 未満、押下 `scale(0.97)`、入場は `scale(0)` から始めない。【弱】(個人ブログ)
- 前庭障害: 視差・カルーセル・スクロール乗っ取りは回避。NN/g(上記)。WCAG 2.3.3 は 03 で読了済み。

### 規則

| 文脈 | 規則 | 値 | 出典 |
|---|---|---|---|
| 毎日・何十回も使う業務 UI(コマンド、キーボード操作、リスト選択) | 動きなし、または極短 | 0〜70ms(リスト hover は 50ms) | Apple、Emil(03)、Atlassian、Carbon fast-01 |
| ボタン・トグル・チェックの状態変化 | 色/不透明度の短い遷移 | 70〜110ms、ease-out | Carbon、NN/g(約 100ms) |
| ドロップダウン・ポップオーバー・小さい展開 | フェード+短い移動 | 150ms | Carbon moderate-01、Atlassian |
| モーダル・ドロワー・トースト | 入場は少し長く、退場は短く | 入場 200〜250ms/退場 150〜200ms | NN/g、Atlassian、Carbon 240ms |
| ページ遷移・大きな領域の移動 | ここだけ長めを許す | 300〜400ms。500ms を超えない | NN/g、Atlassian 400ms |
| 初回のみ・まれな場面(オンボーディング、達成) | expressive を許す | 400〜600ms | Carbon expressive、Atlassian 600ms |
| 入場/退場/画面内の移動 | 入場 ease-out、退場 ease-in、画面内の位置変更 ease-in-out | 例 Carbon `(0,0,0.38,0.9)` / `(0.2,0,1,0.9)` / `(0.2,0,0.38,0.9)` | Carbon、Atlassian、NN/g |
| 読んでいる最中の本文・表 | 動かさない。周辺で動かさない | — | NN/g |
| 長い待ち・読込 | 表示遅延と最小表示時間でちらつきを防ぐ | — | Vercel |
| 全ての動き | `prefers-reduced-motion` で位置・拡大を除き、フェードは残す。動きだけで状態を伝えない | — | Apple、NN/g、WCAG 2.3.3。フェードを残す点は【推論】 |
| 禁止 | `transition: all`、layout プロパティのアニメ、1遷移で3つ以上のプロパティ | — | Vercel、Atlassian |

### スキルへの示唆
- 既定は「動きなし」。付ける理由を一つ言えるときだけ付け(注意・因果・連続性)、理由を言えなければ付けない。
- 時間はデザインシステムのトークン体系(Carbon の6段、Atlassian の8段、M3 の16段)のうち、スキルは4段程度に絞って持つ。【推論】例: 100 / 150 / 250 / 400ms。
- 検査できるもの: `transition: all`、500ms 超、`prefers-reduced-motion` の有無。grep で書ける。

### Gaps
- M3 公式の使い分け文(どのトークンをいつ使うか)は取れなかった。
- Apple のスプリング指針、Emil のスプリング解説は未確認。
- 「高頻度ほど動きなし」の定量的な実験は見つからなかった。NN/g の観察と各社の指針による。

---

## (4) 構造の見せ方: 余白だけ・区切り線・見出し帯・番号付き

### 事実
- **余白(近接)**: DADS は「関連が強い要素には小さい余白、弱い要素には大きい余白」で構造を示す。基準単位は 8px、スケールは 3〜5 段。例は 8/24/64px。読了。https://design.digital.go.jp/dads/foundations/spacing/ 。NN/g のフォーム: 同じグループ内より、グループ間の余白を広く取る。15 項目を 4〜6 項目の 3 グループに分けると「3つの短いフォーム」のように感じられる(Walgreens の例。測定値ではない)。グループ見出しは任意。読了。https://www.nngroup.com/articles/form-design-white-space/
- **区切り線**: DADS のディバイダーは「補助的な要素」。「リストでは 8px 以上、セクションでは 16px 以上の十分な余白を取る」。「ディバイダーがなければ内容が伝わらない構成は避ける」。全幅タイプはセクション・リストの区切りとインタラクティブな領域の区別、インセットタイプは同じセクション内の関連要素のまとめ。読了。https://design.digital.go.jp/dads/components/divider/usage/ 。Material の旧ガイドは「余白で分けられないときだけ、項目の間でなくグループの間に」。検索のみ【弱】。https://material.io/go/design-dividers
- **コンテナ/背景(共通領域)**: NN/g は、明確な境界は近接など他のグルーピングに勝つ強い手がかり。使う場面は、クロームとコンテンツの分離(ヘッダ、ナビ)、キャプションと画像のような組、異種の要素を一つにまとめるとき、余白を調整できないとき。「念のため」の枠は「ごちゃついた画面」を生み、全幅の色帯は「偽の床」になってスクロールを止める。枠を足す前の問い: 理解に必要か、余白で足りないか、枠なしで利用者が困ったか。表のゼブラは横の行を結び、列は余白や線で分ける。読了。https://www.nngroup.com/articles/common-region/
- **表の区切り**: 軽い罫線(背景に溶ける程度)が望ましい。縦罫は任意で 1px の薄いグレー以下。ゼブラは、hover・無効・選択の状態と背景が衝突するので対話型の表では避ける。中央揃えは使わない。読了、【弱】(事例記事)。https://www.pencilandpaper.io/articles/ux-pattern-analysis-enterprise-data-tables 。Carbon の行は下罫線(`$border-subtle`)で、ゼブラ用に `$layer-accent` もある。読了。
- **Refactoring UI**: 枠を使い過ぎると「忙しく散らかる」ので、影・背景色のコントラスト・余白を増やして代替する。公式サイトの紹介文(検索のみ)。https://www.refactoringui.com/
- **番号付き**: 順序が必要なときに数字を使う。GOV.UK の step-by-step ナビゲーションは、必要な順序で並べる。順序がなければ有用な順に並べ、順序のない「および/または」は番号を付けず下位見出しにする。検索のみ(要約)。https://design-system.service.gov.uk/patterns/step-by-step-navigation/ 。GOV.UK のタスクリストは番号でなく状態(「まだ始められません」)で依存を示し、「できるだけ任意の順で終えられるようにする」。読了。https://design-system.service.gov.uk/patterns/complete-multiple-tasks/ 。NN/g のウィザード: 順序が決まった手順にのみ。どの順でもよいなら向かない。検索のみ。https://www.nngroup.com/articles/wizards/ 。NN/g の事例: Eventbrite の番号付き手順で、Step 7 を終えて残りは重要でないと誤解した利用者が Step 8(プライバシー設定)を飛ばした。「後続の手順を無視してよいと示さない」。読了。https://www.nngroup.com/articles/best-application-designs/
- **見出し帯(ヘッダバンド)**: 一次資料での使い分けは見つからなかった。NN/g の共通領域は「ヘッダ・フッタ・ナビはクロームとして背景か枠で分ける」まで。

### 規則

| 文脈 | 規則 | 値 | 出典 |
|---|---|---|---|
| フォーム内のグループ | 余白だけで分ける。グループ間 > グループ内 | 例: グループ内 8〜16px、グループ間 24〜32px【推論】。比率は DADS の 8px 基準 | NN/g、DADS |
| 文章・記事 | 余白と見出しだけ。罫線・枠は付けない | — | NN/g(余白で足りる)、DADS |
| 複数行の一覧・リスト | 余白が足りるなら線なし。行が長く複数行、または行ごとに操作があるときは薄い区切り線 | 余白は 8px 以上、線は 1px の薄いグレー | DADS、Pencil & Paper【弱】、Material【弱】。「行が複数行なら線」は Uxcel の経験則【弱】 |
| セクション間 | 余白 16px 以上。線は補助 | 16px 以上 | DADS(読了) |
| 業務の表(毎日使う、比較する) | 行に薄い下罫線。ゼブラは非対話の閲覧用だけ。縦罫は付けないか 1px の極薄 | 罫線 1px | Carbon、Pencil & Paper【弱】 |
| 異種の要素をまとめる、クロームとコンテンツを分ける(ヘッダ、サイドバー、ドロワー) | 背景色または枠のコンテナ | — | NN/g 共通領域(読了) |
| ページ全体を縦に区切る全幅の色帯 | 避ける。続きがあると分かる余白と見出しを残す(偽の床) | — | NN/g(読了) |
| 手順に決まった順序がある(申請、セットアップ、レシピ) | 番号付き。現在位置を示し、全手順を出す | 1.2.3.… | GOV.UK、NN/g ウィザード |
| 順序がない、または任意の順で終えられる(設定、リファレンス) | 番号なしの見出し。状態バッジ(未入力・完了)で進捗を示す | — | GOV.UK タスクリスト(読了) |
| 後続の手順が任意に見えると困る | 色や言い回しで「ここで終わり」と錯覚させない | — | NN/g Eventbrite(読了) |
| 見出し帯(色付きの帯に見出し) | 一次の使い分けなし。使うなら「クロームとコンテンツを分ける」用途(表のヘッダ行、カードの頭)に限る | — | 【推論】NN/g 共通領域から |

### スキルへの示唆
- 構造の道具は「余白 → 薄い線 → 背景/枠 → 帯」の順に強くなる。必要になるまで強い手段を使わない、が共通の指針(NN/g の4問、DADS の補助原則、Refactoring UI)。
- 何を使うかは「何をグルーピングするか(近い項目か、異種の要素か)」「毎日スキャンするか」「順序が必須か」の三問で決まる。

### Gaps
- 余白と線のどちらが速く読めるかを比べた実験は見つからなかった(NN/g も直接比較なし)。
- 見出し帯、番号付き「見出し」(文書の 1. 2. 3.)の一次根拠は見つからなかった。
- DADS の線の太さ・色は記載なし。

---

## (5) 数字: プロポーショナル / tabular / 等幅

### 事実
- MDN: `tabular-nums` は全ての数字を同じ幅にし「表のように揃えやすくする」。`proportional-nums` は各数字が自然な幅。フォントが OpenType の `tnum` を持たないと効かない。`slashed-zero` は O と 0 の区別が要る場面(コード、ID、シリアル)。読了。https://developer.mozilla.org/en-US/docs/Web/CSS/font-variant-numeric
- Butterick: 本文ではプロポーショナル(間隔が均等に見える)、縦に揃える列では tabular が必須。グリッドでは lining(縦の一貫性)。ほとんどのシステムフォントは既定で tabular lining。検索のみ(要約)。https://practicaltypography.com/alternate-figures.html
- Apple: SF の数字は既定でプロポーショナルなので、変化するタイマーなどは桁が揺れる。`monospacedDigit()` で数字だけ等幅にし、他の文字は比例のまま。`monospaced`(SF Mono)は全文字等幅で、スラッシュ付き0など「コンピューター的」な見た目になるので、いつも求められるわけではない。読了(解説記事)。https://useyourloaf.com/blog/monospace-digits/ 。HIG 本文に数字の記述は見つからなかった。
- 反対の見え方(iOS 時計の分析): tabular の「1」は周りが広がり書体の印象が変わるので、ロック画面の大きな時計は比例のほうがよいと判断した例もある。検索のみ【弱】。https://pimpmytype.com/ios-clock/
- Vercel: 比較する数字は `tabular-nums` か Geist Mono。通貨の小数桁は 0 か 2 に統一し混ぜない。単位との間は non-breaking space。読了。
- SmartHR: 表の数字は桁数を縦に比較できるよう右揃え。読了。
- Pencil & Paper: 量(金額・計測値・割合)は右揃え、日付・郵便番号・電話番号は左揃え可。小数桁を揃える。中央揃えは使わない。数字には等幅か tabular。プロポーショナルだと「$1,111.11 が $999.99 より小さく見える」。読了【弱】(事例記事)。
- DADS: Mono(コード用 Noto Sans Mono)は行高 150%。表の数字の扱いは記載なし(読了で確認)。
- 効果の実証: tabular と proportional で表の読み取り速度・正確さを比べた実験は見つからなかった(検索のみ)。W3C TTML の議論で「比例のほうが目に優しいとする人がいるが、根拠は要調査」という発言があるのみ。【弱】

### 規則

| 文脈 | 規則 | 値 | 出典 |
|---|---|---|---|
| 表・一覧の金額/数量/割合(比べる、桁を揃える) | tabular + 右揃え + 小数桁を統一 | `font-variant-numeric: tabular-nums; text-align: right` | MDN、Butterick、SmartHR、Pencil & Paper |
| 日付・郵便番号・電話番号の列 | 左揃え。tabular は付けてよい | — | Pencil & Paper【弱】 |
| 値が更新される表示(カウンター、タイマー、進捗%、リアルタイム金額) | tabular(桁が揺れてレイアウトが動くのを防ぐ) | `tabular-nums` / SwiftUI `.monospacedDigit()` | Apple/useyourloaf、Vercel |
| 文章中の数字 | プロポーショナル(既定) | — | Butterick |
| 大きな装飾的な数字(ヒーロー、時計) | プロポーショナルでもよい。更新で揺れるなら tabular | — | pimpmytype【弱】。【推論】 |
| コード、ID、ハッシュ、ログ、O と 0 の判別が要る値 | 等幅フォント。スラッシュ付き0 | `font-family: mono; font-variant-numeric: slashed-zero` | MDN |
| 通貨 | 小数桁を文脈で 0 か 2 に統一。ロケールで整形 | `Intl.NumberFormat` | Vercel |
| 日本語 UI の数字 | 英数字は半角、桁区切りはロケール整形。日本語フォントの数字が tnum を持つかは未確認なので、数字用に tnum を持つ欧文フォントを指定する | `font-family: "Inter", "Noto Sans JP", sans-serif` の順など【推論】 | 未確認(Gaps) |
| フォントが tnum を持たない | CSS を足しても効かない。tnum 対応のフォントを選ぶか等幅にする | — | MDN |

### スキルへの示唆
- 「数字が縦に並ぶ、または値が更新される」なら tabular、と一文で判断できる。フォント側の `tnum` 対応は検査項目にする(Inter、IBM Plex、SF は対応。Noto Sans JP は未確認)。
- 等幅フォントは「コードと ID」の用途に限り、金額の桁揃えに安易に使わない(印象が変わる)。【推論】

### Gaps
- Noto Sans JP、BIZ UDPゴシック、游ゴシックの `tnum` 対応の有無と、日本語フォント内の数字が既定でプロポーショナルかを実測していない。
- 日本語の全角/半角数字の使い分けの UI 向け指針は見つからなかった。
- tabular が読みやすさ・誤読率に効くという実験は見つからなかった。

---

## (6) ライトモード vs ダークモード

### 事実(実験)
- NN/g(Budiu、2020 年の記事): 視力が通常(矯正を含む)の人はライトモードのほうが成績がよい。Piepenbrock ら(2013)は視力課題と校正課題でポジ極性(暗い字・明るい背景)が若年・高齢とも優れていた。参加者は成績が違っても「読みやすさの感じ方に差はない」と答えた。白内障など水晶体が濁る人は暗いモードで成績が上がることがある(Legge ら 1985、7 人全員。ただし当時の CRT はライトモードでちらつきやすく、偏りの可能性)。読了。https://www.nngroup.com/articles/dark-mode/
- Piepenbrock ら(Ergonomics 2013): 検索のみ(カタログ抄録)では、視力表と校正課題で、ポジ極性の優位が両年齢群で出て、「全年齢にポジ極性を推奨」と結論。PubMed 本文は取得できず、標本サイズは未確認。https://documentacion.fundacionmapfre.org/documentacion/bib/143702.do
- Piepenbrock ら(Human Factors 2014): 8〜14pt の4サイズ。ポジ極性の優位は文字が小さいほど直線的に大きくなり、「特に小さい文字ではネガ極性を避けるべき」。輝度が高いほど細部が見えるという説明。検索のみ(抄録要約)。https://metatoc.com/papers/26930-positive-display-polarity-is-particularly-advantageous-for-small-character-sizes-implications-for-display-design
- Dobres ら(Ergonomics 2016): 瞬時に読み取る課題(lexical decision)。暗い部屋(約 23 lux)で、ポジ極性の閾値(読み取りに要する表示時間)がネガ極性より 38.6% 低い。48 人分析(20〜75 歳)。書体はヒューマニスト系が 8.8% 速い。小さくすると(4mm→3mm)閾値が 26〜62% 悪化し、角ゴシック(Eurostile)のほうが悪化が大きい。原因は暗い環境での瞳孔の拡大と推測(検証していない)。結論は暗い実験室の条件に限ると著者が明記。読了(PMC)。https://pmc.ncbi.nlm.nih.gov/articles/PMC5213401
- NN/g の記事が引く Dobres ら(2017): 昼は極性に有意差なし、夜はライトが優れる。2017 年の原論文は取得できていない(NN/g の引用のみ)。
- 環境光と快適性: 暗い環境(50 lux)ではダークの快適さの評価が高く、明るい環境(500 lux)では逆という報告(Hazadi & Kamaruzaman)。二次記事のみで原論文未確認【弱】。https://android.gadgethacks.com/news/dark-mode-vs-light-mode-what-research-says-about-when-each-works-best/ 。2020〜2025 年の論文 25 本の系統的レビューは「読みやすさはライト、低照度の快適さはダーク、好みは年齢・機器・環境・気分で分かれる」とする。検索のみ(要約)【弱】。https://doaj.org/article/449f4dd4e9e14e5584f777600e5320f0
- 長期影響: Aleman ら(2018)は 7 人で 1 時間読ませ、ライトで眼の膜が薄くなり(近視に関連するとされる。部位名は NN/g の抜粋で未確認)、ダークで厚くなった。標本が極めて小さい。NN/g が「長期のコスト」の可能性として紹介。読了(NN/g 経由)。
- 乱視とハレーション: レベルアクセス(アクセシビリティ企業)は、乱視の人は黒背景の白文字が「にじむ(halation)」、純黒に白文字は避ける、自動コントラスト検査では拾えない、と述べる。読了。https://www.levelaccess.com/blog/accessibility-for-people-with-astigmatism/ 。瞳孔拡大の機序の一次研究は見つからず、検索で出るのはブログ・フォーラムの転載。Bauer & Cavonius(1980)の「暗い字で26%正確」も二次引用のみ。【弱】。NN/g の記事本文には乱視もハレーションも出てこない(読了で確認)。
- 日本語の漢字を白抜きにしたときの読みやすさ(画数が多いと潰れるか)を測った研究は見つからなかった。ダーク時に変換候補が見づらいという OS の不具合報告があるのみ。

### 事実(指針)
- NN/g: 「一般の利用者を対象にするなら、既定をダークモードにすることは勧めない」「人はめったに既定を変えない」。一方、長期影響・視覚障害・好みのために「利用者が切り替えられるようにすることを強く勧める」。長文を読むアプリはダークを用意する。OS に API があれば使う。読了(上記)。
- Apple HIG(Dark Mode): 多くの人がダークを既定にしており、アプリは OS 設定を尊重すると期待される。「アプリ固有の外観設定を提供するのは避ける」(設定が二重になり、壊れていると思われる)。両方で見やすいか確認する。常にダークでよいのは、没入的なメディアの閲覧など「まれな場合」(Stocks アプリが例)。コントラストは最低 4.5:1、独自色では特に小さい字で 7:1 を目指す。白い背景の画像は少し暗くして光らないようにする。読了(HIG の JSON)。https://developer.apple.com/design/human-interface-guidelines/dark-mode
- Material 2(ダークテーマ): 主面は純黒でなく #121212 級の暗いグレー。白本文との比 15.8:1 で AA を満たす。検索のみ【弱】(M3 での変更は未確認)。https://m2.material.io/design/color/dark-theme
- Vercel: ダークでは `<html>` に `color-scheme: dark`、`theme-color` を背景に合わせる。読了。
- DADS(カラー): ダークモードの記述はなし。コントラストの前提は「白または黒の背景」、テキストは 4.5:1 以上。読了。https://design.digital.go.jp/dads/foundations/color/

### 規則

| 文脈 | 規則 | 値 | 出典 |
|---|---|---|---|
| 既定のテーマ(一般向け、信号なし) | ライト | — | NN/g(読了) |
| OS/ブラウザの設定がある | `prefers-color-scheme`(Apple は OS 設定)に従う。アプリ独自の外観設定は Apple 系では作らない | `color-scheme: light dark` | Apple、NN/g、Vercel(読了) |
| web アプリ/長文を読む製品 | 両テーマを用意する。web では OS に従う+手動切替を併設してよい | — | NN/g。手動切替の併設は【推論】(Apple は Apple 系アプリで非推奨) |
| 小さい字・密な表・長時間の読解 | ライトを既定にし、ダークでは字を大きく・太くする。細いウェイト(Light 以下)を避ける | ダークの本文は 1段上げる(例 14→15〜16px)【推論】 | Piepenbrock 2014(検索のみ)、Apple HIG(軽いウェイトを避ける。読了) |
| 暗い環境で使う・動画/写真/没入メディア・開発/コード編集(夜間) | ダークを既定にしてよい(ただし OS 設定を優先) | — | Apple(没入メディアの例外)。夜間の優位は Hazadi【弱】 |
| ダークの色 | 純黒+純白は避け、暗いグレーの面と少し落とした白の文字。ただしコントラストは 4.5:1 以上、小さい字は 7:1 を目指す | 面 #121212 級、本文は 4.5:1 以上 | Material 2【弱】、Apple、レベルアクセス【弱】 |
| ダークの画像・イラスト | 白背景の画像は少し暗くする。アイコンは必要なら縁取りを足す | — | Apple(読了) |
| 白内障など低視力、夜間、まぶしさに弱い利用者 | ダークも選べるようにする(NN/g)。ライトでまぶしい利用者のために必ず切替を用意 | — | NN/g(読了) |
| 検証 | 両テーマで、スクリーンショット、コントラスト、Increase Contrast、色の彩度を確認 | — | Apple、Vercel |

### スキルへの示唆
- Marty の「ダークは読みにくい」は研究と整合する(ポジ極性が成績でも勝ち、小さい字ほど差が開く)。ただし本人が差を感じにくいという知見もあるので、個人の感覚を「好み」として扱わず、成績で勝つ側を既定にしてよい根拠になる。
- スキルの既定は「ライト。OS がダークなら従う」。ダークを作るときは別物として作る(面の色・字の太さ/サイズ・コントラストを個別に設計)。トークンを反転するだけにしない。
- Apple の「アプリ独自の設定を作らない」と NN/g の「切替を用意する」は対象が違う。Apple 系アプリでは OS に従う。web は OS 信号に従い、必要なら手動切替を併設する。【推論】
- 乱視・ハレーション・瞳孔拡大の機序は一次の裏づけが弱い。スキルに書くときは「報告されているが機序は未確認」とする。

### Gaps
- Piepenbrock 2013 の標本サイズ・効果量(PubMed が cookie を要求して取れなかった)。Dobres 2017 の原論文。Buchner & Baumgartner 2007 の結果。
- 乱視とダークモードの査読論文(瞳孔・調節の測定)。
- 日本語(漢字・仮名の混在)でのポジ/ネガ極性の実験。
- M3 のダークテーマの現行値(M2 のみ確認)。Apple HIG の純黒回避の記述(JSON 内では見つからなかった)。

---

## 全体の Gaps(次に調べるなら)

1. 日本語フォントの数字(tnum、半角/全角)と日本語 UI の実測。
2. freee Vibes、SmartHR の余白・密度ページ(行高さ、表)。DADS は color/typography/spacing/divider/input-text を読了したが、表やデータ密度のコンポーネントは未読。
3. M3 の動きの使い分け文と、ダークテーマ現行値(m3.material.io は JS 描画で本文が取れず)。
4. 「説明文を減らすと完了率が上がる」の定量研究、構造(余白 vs 罫線)の読み取り速度比較。
