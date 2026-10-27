# 03 視覚デザインの基礎(具体値つき)

調査日: 2026-10-26。記号: 【弱】=ベンダー・ブログ・二次情報。【推論】=調査者の推論。
出典は各文末の URL。WebFetch で本文を読んだものは「読了」、検索結果の要約だけのものは「検索のみ」と書く。

## 結論(5行)

1. 見た目の良さは「少数の決めた値」から出る。余白・文字・色・影・角丸・動きは、先に有限の目盛り(トークン)を決め、そこからしか選ばない。
2. 色は WCAG 2.2 AA(本文 4.5:1、非テキスト 3:1)を合格線にする。APCA は WCAG 3 から外れており(2026-04 時点でアルゴリズム未定)、補助の物差しに留める。
3. 日本語は欧文の既定値をそのまま使えない。本文は行間 1.7〜2・ベタ組み(palt なし)、見出しだけ palt と `word-break: auto-phrase`、`font-family` に `system-ui` を使わない。
4. 動きは「頻度が高いほど無くす」。出すなら 300ms 未満・ease-out、`prefers-reduced-motion` を必ず見る。
5. トークンは shadcn/ui 流の `background`/`foreground` ペア + OKLCH + Tailwind v4 `@theme` が事実上の標準。DTCG 2025.10 は安定版だが W3C 標準ではなく、DESIGN.md は alpha。

## 1. 階層・レイアウト・余白

- **近接で関係を示す**: 近い要素は同じグループ、離れた要素は別物と知覚される。余白の意味は「区切り」ではなく「グルーピング」。グループ内は狭く、グループ間は広く取る。【弱】解説ブログ。https://www.banani.co/ja/definitions/law-of-proximity (検索のみ) / 日本語の入門: https://dev.classmethod.jp/articles/whatsui6/ (検索のみ)
- **間隔は有限の目盛りから選ぶ**: Material は全コンポーネントを 8dp の正方グリッドに載せ、アイコンや文字は 4dp を使ってよいとする。https://material.io/design/layout/spacing-methods.html (検索のみ)。8pt は「規則」でなく判断を減らす指針で、アイコンの微調整は意図的なら可。【弱】https://designcodeui.com/components/spacing ほか(検索のみ)
- **余白は多めに始めて削る / グレースケールで先に階層を作る / 強調は大きさ・太さ・色を重ねがけしない**: Refactoring UI の要約。原典未確認の二次要約のため【弱】。https://playbooks.com/skills/wondelai/skills/refactoring-ui (検索のみ)
- **行長**: WCAG 1.4.8 の理解文書は「80 字以内、CJK は 40 字」。読了。https://www.w3.org/WAI/WCAG22/Understanding/visual-presentation.html 。ただし 1.4.8 は AAA。
- **行間・段落間の下限**: WCAG 1.4.12 は、ユーザーが上書きしても崩れないことを要求(行間 1.5 倍、段落間 2 倍、字間 0.12em、語間 0.16em)。読了。https://www.w3.org/TR/WCAG22/#contrast-minimum (同ページ内の 1.4.12)。レイアウトは固定高さを避けて、この上書きに耐える作りにする。
- **リフロー**: 幅 320 CSS px で 2 次元スクロールなし(1.4.10)。同上。
- **ターゲットサイズ**: WCAG 2.2 AA 2.5.8 は最小 24×24 CSS px(または 24px 円が他と重ならない間隔)。読了。https://www.w3.org/WAI/WCAG22/Understanding/target-size-minimum.html 。Material は 48dp 推奨(間隔 8dp 以上)、Apple は 44pt。【弱】検索のみ(Apple 原典は未確認)。
- **走査パターン**: F パターンは NN/g が 232 人・数千ページのアイトラッキングで報告した「大まかな形」。実際は E 型・逆 L 型にも変わり、被験者や課題の内訳は記事に無い。読了。https://www.nngroup.com/articles/f-shaped-pattern-reading-web-content-discovered/ 。NN/g 自身は、見出しで拾い読みする「レイヤーケーキ」が最も効率的と整理している。読了。https://www.nngroup.com/articles/text-scanning-patterns-eyetracking/ 。【推論】F/Z を理由にレイアウトを決めるより、「意味のある小見出し・箇条書き・文頭に要点」を守る方が根拠が強い。Z パターンの一次根拠は今回見つけていない(Gaps)。

## 2. タイポグラフィ

### 欧文・共通
- **数字**: 表・金額・カウンター・タイマーは `font-variant-numeric: tabular-nums`(桁幅が揃う)。Baseline Widely available(2020-01〜)。フォントが tnum を持つ場合のみ効く。読了。https://developer.mozilla.org/en-US/docs/Web/CSS/font-variant-numeric
- **text-wrap**: `balance` は Baseline 2024、`pretty` は Chrome/Edge 130・Safari 26 で、Firefox は未対応(2026 初頭の情報。現在は未確認)。【弱】検索のみ(MDN ミラー)。https://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-wrap-style
- **justify は避ける**: WCAG 理解文書も、`text-align: justify` は川(rivers)と不均一な語間を生むとして片側揃えを推奨。上記 visual-presentation。
- **text-box-trim**: 半行間を除去できる。Firefox 154 の対応で 2026-08 に Baseline Newly available。【弱】検索結果の web.dev 記事の要約のみ。https://web.dev/blog/web-platform-08-2026

### 日本語(最重要)
- **一次に近い資料**: tak-dcxi の gist(日本語 CSS リセット的な推奨集)。読了。https://gist.github.com/tak-dcxi/0f8b924d6dd81aaeb58dc2e287f2ab3a 。個人の gist なので【弱】だが、内容が具体的でブラウザ差まで書いてある。ICS MEDIA の palt 記事は読了。https://ics.media/en/entry/14087/
  - **行間**: 日本語本文 1.7〜2、日本語見出し 1.25〜1.5(欧文本文 1.5〜1.8、見出し 1.2〜1.4)。`line-height: 1` は折り返しで崩れるので使わない。
  - **本文**: ベタ組み。`palt` を付けない、`font-kerning: none`。
  - **見出し**: `font-feature-settings: "palt"` + `word-break: auto-phrase` + `text-wrap: balance`(中央揃い)/`pretty`(左揃い)。`@supports` で囲む。
  - **改行**: `:root` に `line-break: strict` と `overflow-wrap: anywhere`、`word-break` は初期値のまま。
  - **フォント指定**: `system-ui` を日本語では避ける(Windows で Yu Gothic UI になる)。`sans-serif` で終える。明朝は Android に無いので Noto Serif JP を読み込む。
  - **約物**: `text-spacing-trim: trim-start`(Chrome 系のみ)、`hanging-punctuation: last allow-end`(Safari のみ)。
  - **Safari の `text-wrap: pretty` は日本語で `balance` 相当に動くので使わない**、と gist は書く。W3C 日本語 i18n ML や Webkit の議論で `palt`/`kern` の実装差が報告されている。https://lists.w3.org/Archives/Public/public-i18n-japanese/2023JanMar/0004.html (検索のみ)
- **palt の効き方(ICS MEDIA)**: OpenType のプロポーショナルメトリクスを使うので、フォントが対応している必要がある(ヒラギノ角ゴ・游ゴシック・Noto Sans CJK JP は対応、メイリオは非対応)。まず見出しだけに適用する、約物が詰まりすぎるなら `pwid`/`pkna`、詰めすぎは `letter-spacing` で微調整。読了。
- **word-break: auto-phrase**: 文節単位で折り返す。Chrome 119 から、日本語のみ、BudouX 由来の機械学習で境界を決める。`lang="ja"` が必要。短い見出し向けで、誤りは `<wbr>` で直す。読了。https://developer.chrome.com/blog/css-i18n-features?hl=ja 。Firefox/Safari の現状は今回未確認(Gaps)。
- **text-autospace**: 和欧文間に小さな空きを入れる。text-spacing-trim は Chrome 123 以降で対応、Firefox・Safari は未対応。Baseline ではない。【弱】caniuse / modern-css.com の検索要約。https://caniuse.com/wf-text-spacing-trim
- **行長**: WCAG は CJK 40 字(AAA)。【推論】日本語 UI の本文は 35〜45 字(`max-width: 40em` 前後)を初期値にし、画面幅で伸ばさない。実測の根拠は今回無い。
- **字間**: 日本語は印刷でもベタ組みが基本。0.05em を本文の標準とする根拠は見つからなかった。検索のみ。
- **書体の選び方**: Noto Sans JP は 100〜900 の可変フォントで本文の基準。BIZ UDPゴシックは視認性が高いが詰まって見えるので行間を広めに。Zen Kaku Gothic New は見出し専用が無難、M PLUS 2 はやや UI 寄り、とされる。【弱】SEO ブログ群(https://lifestyle.assist-all.co.jp/web-font-complete-guide-font-list-selection/ ほか、検索のみ)。依頼にあった SOMPO Digital Lab の note は見つからなかった。日本語フォントは 1 ウェイト数百 KB〜1MB になるので、ウェイトを絞り、サブセット化・`display=swap`・フォールバックを整える(同上【弱】)。

## 3. 色

- **コントラスト**: WCAG 2.2 AA は通常テキスト 4.5:1、大きい文字(18pt、太字 14pt、CJK 相当)3:1、UI 部品・状態の識別 3:1(1.4.11)。読了。https://www.w3.org/TR/WCAG22/#contrast-minimum
- **APCA の現状(2026)**: WCAG 3 は未完成のドラフト。APCA は 2023-07 のドラフトで外れ、2026-04-08 の編集者草案でも「アルゴリズムは未定」。Roselli は WCAG 2 の要件を使い続けること、満たさない色を使うなら理由を先に記録することを勧める。読了。https://adrianroselli.com/2026/04/wcag3-contrast-as-of-april-2026.html 。完成は早くて 2030 頃との見立て。APCA 側からは BridgePCA(WCAG 2 を満たしつつ APCA も適用)の提案があるが、コメント欄の主張。
- **APCA の目安(参考値)**: Lc 90=本文の推奨、75=本文の下限、60=本文以外の内容テキスト、45=大きく太い見出し、30=プレースホルダー等の絶対下限。実装により補正が違う。【弱】npm / achecks の検索要約。https://github.com/paularmstrong/apca-w3 。【推論】使うなら WCAG 2 の合否の後に「薄すぎる」検知として足す。
- **OKLCH**: L が色相をまたいでも知覚的に揃うので、段階パレットや明暗の調整が予測しやすい。HSL は色相ごとにL の見え方が違う。P3 では sRGB より彩度が上がり、範囲外は丸められる(Chrome/Safari はクリップして色相がずれうるので、`color-gamut: p3` で明示する)。OKLCH だけではアクセシビリティの保証にならない。読了。https://evilmartians.com/chronicles/oklch-in-css-why-quit-rgb-hsl
- **Tailwind v4**: 既定パレットを rgb から oklch に変更、`@theme` のトークンが CSS 変数として出る、グラデーション補間は OKLAB が既定。読了。https://tailwindcss.com/blog/tailwindcss-v4
- **Radix Colors の 12 段階**: 1-2 背景、3-5 部品の背景(通常/hover/押下)、6-8 境界線(8 はフォーカスリング)、9-10 ソリッド背景、11 低コントラスト文字、12 高コントラスト文字。11 と 12 は同系の 2 段背景の上で APCA Lc 60 と Lc 90 を保証。読了。https://www.radix-ui.com/colors/docs/palette-composition/understanding-the-scale 。【推論】用途で段を割り当てる考え方そのものが、自作パレットにも使える。
- **セマンティックトークン**: shadcn/ui は `background`/`foreground`、`primary`/`primary-foreground` のように「面の色 + その上の文字色」をペアにし、`.dark` で同名トークンを上書きする。読了。https://ui.shadcn.com/docs/theming
- **ダークモード**: 純黒でなく暗いグレー。M2 は暗い面と白本文で 15.8:1 以上、標高は白オーバーレイで表現(0〜16%)。M3 は標高連動をやめ surface container 系の役割に置換。【弱】検索のみ。https://m2.material.io/design/color/dark-theme / https://material.io/blog/tone-based-surface-color-m3 。「暗い背景では彩度を落とす」は Material 原典で確認できず【弱】。
- **アクセントの数を絞る**: 一次根拠は見つからなかった。【推論】ブランド色 1 + 中立色 + 状態色(成功・警告・危険)に限り、Radix の段階割り当てで足りる範囲に収める。

## 4. 奥行き・面

- **標高の影**: 低・中・高の 3 段に絞り、各段を複数レイヤー・低不透明度・共通の色味で作る。Josh Comeau の記事とジェネレーター(2026-04 更新)が引用される。【弱】検索のみ。https://www.joshwcomeau.com/css/designing-shadows
- **同心円の角丸**: 外側の角丸 = 内側の角丸 + 余白(例: 外 24、余白 8、内 16)。0 や完全な丸のときは不要。境界線がある場合は枠の太さも距離に含めるという流儀もある。【弱】ブログ群。https://jakub.kr/work/concentric-border-radius 、https://30secondsofcode.org/css/s/nested-border-radius
- shadcn/ui は `--radius` を基準にして `radius-*` の目盛りを導く。読了(theming)。
- 影は後工程(レイアウトと階層が決まってから)という Refactoring UI の助言。【弱】二次要約。

## 5. アイコンとラベル

- NN/g: 普遍的に通じるアイコンは home・print・虫眼鏡の少数。標準的なアイコンにも、常に見えるテキストラベルを付ける。hover のみのラベルは操作コストが高くタッチで使えない。5 秒ルール(探して 5 秒超なら通じていない)。読了。https://www.nngroup.com/articles/icon-usability/
- 反対の立場: 「ラベルは最後の手段」はクラッター削減の議論(SSW のルールページが言及、検索のみ)。「ラベルは常に勝つ」(Bokardo 2013)は逆の立場。https://bokardo.com/archives/labels-always-win/ (検索のみ)。日本語の一次的な議論は見つからなかった。
- 【推論】対立は文脈で解ける。アクションを担う操作(ボタン、ナビ)はラベルを残し、繰り返し現れる補助情報(フォーム項目の説明など)から説明文を削る。アイコンのみにするなら普遍 4 種(home/print/search/close)か、ツールチップと `aria-label` を付けた密なツールバーに限る。
- アクセシビリティ: ラベルのないボタンは支援技術から見えなくなる。【弱】uxcel。https://uxcel.com/glossary/labels

## 6. モーション

- **目的がなければ付けない / 頻度が高いほど無くす**: キーボード起点の反復操作やコマンドメニューは無アニメが最適。楽しい動きは稀にしか見ないときだけ効く。Emil Kowalski 本人の記事。読了。https://emilkowal.ski/ui/you-dont-need-animations
- **数値**: UI は 300ms 未満。180ms のセレクトが 400ms より応答が良い。押下ボタンは `scale(0.97)`、入場は `scale(0)` から始めず 0.9 以上(例 0.93)、入退場は ease-out、CSS 組み込みの easing は弱いのでカスタム曲線、`transform-origin` はトリガー基準、最後の手段で `blur(2px)`。ツールチップは最初だけ遅延、隣は即時。読了。https://emilkowal.ski/ui/7-practical-animation-tips
- **Apple HIG**: 目的を持った動き、装飾目的は不可、動きは任意にする(情報を動きだけで伝えない)、Reduce Motion のときは最小化または除去。大振幅の振動や、物が画面外へ飛ぶ大きな動きがリスク。ただし不必要に消すと分かりにくくなる場合もある。【弱】ミラーと二次要約のみ。https://developer-mdn.apple.com/design/human-interface-guidelines/foundations/motion
- **WCAG**: 2.3.3 Animation from Interactions(AAA)は、操作で起きる動きを無効にできること。読了(WCAG 2.2)。CSS では `@media (prefers-reduced-motion: reduce)`。【推論】位置・拡大の動きは消し、不透明度の遷移は残す、が現実的。
- **Material 3 の duration/easing 値**: 公式ページから数値を取得できなかった。未確認(Gaps)。
- **スプリング**: 一次資料を今回読めていない(Gaps)。

## 7. トークンとデザインシステム

- **DTCG Format Module 2025.10**: 2025-10-28 公開の Final Community Group Report。「安定」とされるが W3C 標準化トラックではなく、今後は後継仕様で更新。型は dimension(px/rem)、duration(ms/s)、cubicBezier、fontFamily、fontWeight、複合型の shadow・border・transition・typography など。`$value` 必須、`$type` は親から継承。色は別の Color module(OKLCH・Display P3 対応)。Style Dictionary、Tokens Studio、Terrazzo が参照実装。読了(仕様)+ 検索(採用状況)。https://www.w3.org/community/reports/design-tokens/CG-FINAL-format-20251028/ 、https://www.w3.org/community/design-tokens/2025/10/28/design-tokens-specification-reaches-first-stable-version/
- **shadcn/ui + Tailwind**: CSS 変数が既定(`components.json` の `tailwind.cssVariables`)、`:root`/`.dark`、独自トークンは `@theme inline` で公開。読了(theming)。
- **DESIGN.md**: google-labs-code/design.md。YAML フロントマターの機械可読トークン(`colors`/`typography`/`rounded`/`spacing`/`components`)+ 散文。節の順序は Overview → Colors → Typography → Layout → Elevation & Depth → Shapes → Components → Do's and Don'ts。CLI `lint`(参照切れと WCAG コントラスト)・`diff`・`export`(tailwind/DTCG)・`spec`。バージョンは alpha、Apache-2.0。読了。https://github.com/google-labs-code/design.md 。デファクトとは言えず、2026-04 公開の新しい規約【弱】(報道は二次)。

## 既定値の候補と出典

| 項目 | 既定値の候補 | 出典・確度 |
|---|---|---|
| 間隔の基準 | 4px 刻み、主に 8px の倍数 | Material 8dp/4dp【弱】検索のみ |
| タッチ/クリック領域 | 最小 24×24 px(AA)、実用は 44〜48 px | WCAG 2.5.8 読了 / Apple・Material【弱】 |
| 本文の行間(日本語) | 1.7〜2(下限 1.5) | tak-dcxi gist【弱】/ WCAG 1.4.12 |
| 見出しの行間(日本語) | 1.25〜1.5 | tak-dcxi gist【弱】 |
| 行長(日本語) | 約 40 字以内 | WCAG 1.4.8(AAA)読了 |
| 日本語本文 | palt なし、ベタ組み | gist【弱】、ICS MEDIA |
| 日本語見出し | palt + auto-phrase + balance(`@supports`) | gist【弱】、Chrome blog 読了 |
| 日本語フォント指定 | `system-ui` を避け `sans-serif` で終える | gist【弱】 |
| 数値表示 | `tabular-nums` | MDN 読了 |
| 通常テキストのコントラスト | 4.5:1 以上 | WCAG 2.2 読了 |
| UI 部品・フォーカス表示 | 3:1 以上 | WCAG 1.4.11 読了 |
| 色空間 | OKLCH でトークン定義 | Tailwind v4 / Evil Martians 読了 |
| 色の段階 | 12 段(1-2 背景、6-8 線、9-10 ソリッド、11-12 文字) | Radix 読了 |
| 色トークン命名 | `x` と `x-foreground` のペア | shadcn/ui 読了 |
| 影 | 3 段、複数レイヤー、共通の色味 | Comeau【弱】 |
| 角丸(入れ子) | 外 = 内 + 余白 | 各種ブログ【弱】 |
| UI アニメ時間 | < 300ms(ホバー/ポップオーバーは 125〜200ms 台) | Emil 読了 |
| イージング | 入退場は ease-out のカスタム曲線 | Emil 読了 |
| 押下スケール | `scale(0.97)` | Emil 読了 |
| 入場の初期スケール | 0.9 以上(`scale(0)` を避ける) | Emil 読了 |
| 高頻度操作 | アニメなし | Emil 読了 |
| 動きの配慮 | `prefers-reduced-motion` で位置・拡大を消す | Apple HIG【弱】、WCAG 2.3.3 |
| アイコン | 常に見えるラベルを付ける | NN/g 読了 |
| トークン形式 | CSS 変数が主、DTCG は書き出し先 | shadcn / DTCG 読了 |

## スキルへの示唆

1. **先にトークンを決める**。UI を書く前に、間隔・文字・色・角丸・影・動きの目盛りを(DESIGN.md か CSS 変数で)書き出し、以降はそこからだけ選ぶ。既存プロジェクトにトークンがあればそれを読む。
2. **日本語かどうかを最初に判定**し、日本語なら上の日本語既定値(行間、palt は見出しのみ、`system-ui` 回避、`auto-phrase` は `@supports`)を適用する。未対応ブラウザでは劣化しても崩れないこと。
3. **色の合否は機械で見る**。WCAG 2.2 AA を合格線にし、DESIGN.md の `lint` かコントラスト計算スクリプトを検証手順に入れる。APCA は補助。
4. **階層はグレースケールと間隔で作る**。強調は大きさ・太さ・色のうち 1〜2 本に限る。色は最後。
5. **アニメは「頻度と目的」で判断**し、既定は無し。付けるなら 300ms 未満・ease-out・`prefers-reduced-motion`。
6. **説明文より構造と命名で伝える**。ただしアイコン単体は避け、操作系にはラベルを残す(NN/g)。
7. **検証は実画面で**。スクリーンショットを複数幅(320px を含む)・ライト/ダーク・日本語の長文/短文・空/エラー状態で見る。【推論】これらは機械で拾えない崩れ(折り返し、トークン外の値)の検出手段。
8. 数値の「既定」は出典の確度つきで SKILL に書き、【弱】の項目は「初期値。プロジェクトの実測が優先」と明記する。

## Gaps(未確認・未調査)

- 池田泰延(ICS MEDIA)の「日本語を美しく表示する CSS」本体は取得できず、ICS の palt 記事と tak-dcxi の gist で代替。SOMPO Digital Lab の Noto Sans JP の note は見つからなかった。
- Material 3 の duration/easing トークンの数値、Apple の spring 指針、Emil の spring 解説は一次資料で未確認。
- Z パターンの根拠、アクセント色を絞る根拠(60-30-10 など)、日本語の最適行長・字間の実証データは未発見。
- `auto-phrase`・`text-autospace` の Firefox/Safari 現況、`text-wrap: pretty` の Firefox 現況は 2026-10 時点で未確認。
- Apple HIG は原典(developer.apple.com)ではなくミラーの要約。44pt の根拠も未確認。
- DESIGN.md の普及度(Claude Code 等での実利用)は二次報道のみ。DTCG の Color module 本文と theming の詳細は読めていない。
- Refactoring UI は書籍の原典ではなく二次要約。
