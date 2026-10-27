# 04 UI 実装者(UI エンジニア / デザインエンジニア)が考えること

調査日: 2026-10-26。UX スキルが画面・フロー・状態を決めた後、見た目と操作を作る側が何を見るかを調べた。
記号: 【弱】=ベンダー資料・個人ブログ・二次要約など根拠が弱い。【推論】=出典から私が導いた判断。【未確認】=原文を読めていない。

## 結論

1. UI の品質の多くは「ネイティブ HTML を壊さない」「状態を全部作る」「測れる基準(24px、4.5:1、INP 200ms)を守る」で決まり、基準は機械で検査できる。
2. 「感触(feel)」は、入力への即応、中断できるアニメーション、使用頻度に応じたアニメーションの省略で作る。具体値は 300ms 未満、押下 scale 0.97 など。
3. 日本語フォームは autocomplete・inputmode・全角半角の正規化・分割しない入力欄が要点で、全角を強制しない(ブラウザの自動入力と両立するため)。
4. 自動検査(axe、Lighthouse)が拾うのは課題の約 57%(Deque 調べ【弱】)で、キーボード操作、フォーカス順、文言、見た目の崩れは人かスクリーンショットで見るしかない。
5. スキルには「作る前の基準表」「複数幅のスクリーンショットと axe による検証ループ」「未検査項目の明示」を入れるのがよい【推論】。

## 1. インタラクションの細部

- **Vercel Web Interface Guidelines**(ルール集。出典は WebFetch の要約で全文の逐語確認ではない【未確認部分あり】): [vercel-labs/web-interface-guidelines](https://github.com/vercel-labs/web-interface-guidelines)。主な項目は次のとおり。
  - アイコンだけのボタンにはラベルを付ける。操作にはボタン、遷移にはリンクを使う。クリックできる div や span を作らない。
  - フォーカスの輪郭を代替なしに消さない。`:focus-visible` を使う。固定 UI が、フォーカス中の要素を隠さない。
  - フォームは autocomplete と正しい type / inputmode を付ける。貼り付けを禁止しない。ラベルをクリックできるようにする。エラーは項目の横に出し、送信時に最初のエラーへフォーカスを移す。
  - アニメーションは transform と opacity だけ。`transition: all` は使わない。reduced-motion を守る。ユーザー入力で中断できるようにする。
  - 長いテキストに備える(truncate、clamp、`min-width: 0`)。空状態を作る。短い・平均・非常に長いユーザー内容で試す。
  - 画像に width と height を付ける。50 件を超える一覧は仮想化する。
  - URL に UI 状態(フィルタ、タブ)を載せる。破壊的操作には確認か undo を付ける。
  - 数値の桁そろえには tabular numerals を使う。日付と数値は Intl で整形する。
  - ズームを無効にしない。モーダルでは overscroll を閉じ込める。ジェスチャーにはクリックとキーボードの代替を用意する。
- **Rauno の Interaction design**: [rauno.me/craft/interaction-design](https://rauno.me/craft/interaction-design)。
  - 動きは中断できるようにする。
  - 入力は即座に反映し、アニメーションはしきい値を超えてから使う。
  - 破壊的な操作は、ジェスチャーが終わってから実行する。
  - 使用頻度が高く新規性の低い操作(コマンドメニューなど)はアニメーションをなくす。
  - 指で隠れる部分を見せる。Fitts の法則を使う。
- **Emil Kowalski**: [You don't need animations](https://emilkowal.ski/ui/you-dont-need-animations)、[7 practical animation tips](https://emilkowal.ski/ui/7-practical-animation-tips)。
  - 1 日に何度も使う UI(Raycast のコマンドメニュー)にはアニメーションを付けない。キーボード起点の操作はアニメーションさせない。
  - UI のアニメーションは 300ms 未満(180ms の select は 400ms より速く感じる)。
  - 押下時は `scale(0.97)`。出現は `scale(0)` からでなく 0.9 以上から始める(例は 0.93)。
  - 出入りには ease-out を使う。ツールチップは、1 つ開いたら隣は遅延なしで開く。
  - 数値の裏付けは個人ブログ【弱】。ただし Rauno・Vercel のルールと向きは一致している。
- **ヒット領域**: WCAG 2.5.8 は 24×24 CSS px 以上(AA)。例外は間隔、同等の別操作、文中のインライン、ブラウザ標準、本質的な配置。[W3C 2.5.8](https://www.w3.org/WAI/WCAG22/Understanding/target-size-minimum.html)。iOS の 44pt はよく引かれる数値だが、Apple の原文を取得できていない【未確認】。見た目が小さくても、余白で当たり判定を広げる【推論】。
- **待ち時間の知覚**: [NN/g Response Times](https://www.nngroup.com/articles/response-times-3-important-limits/)。
  - 0.1 秒以内は「即時」で、結果を出す以外のフィードバックは要らない。
  - 0.2〜1 秒は遅れに気づく。約 1 秒を超えたら処理中であることを示す。
  - 10 秒は注意を保てる限界で、これを超えるなら進捗率と中止手段を出す。
  - Doherty しきい値は 400ms(1982 年の IBM の論文を LawsOfUX が引用。[Laws of UX](https://lawsofux.com/doherty-threshold/))。
- **スケルトンとスピナー**: [NN/g Skeleton screens](https://www.nngroup.com/articles/skeleton-screens/)。
  - 1 秒未満なら何も出さない。
  - 約 2〜10 秒のページ読み込みにはスケルトンを使い、単一モジュールにはスピナーを使う。
  - 10 秒を超えるなら進捗バー。
  - 枠だけで中身のないスケルトンは避ける。
- **楽観的 UI(optimistic UI)**: 公式の基準を見つけられなかった【未確認】。【推論】低リスクで取り消しやすい操作(いいね、並べ替え、既読)に限る。失敗時は元に戻して理由を出す。決済や削除のように戻せないものには使わない。
- **送信ボタン**: Vercel は、リクエストが始まるまで有効にしておき、始まったらスピナーを出すと書く。Web Interface Guidelines の項目。無効にして理由を隠す作りは避ける【推論】。
- **スクロールとキーボード**: Vercel の overscroll 封じ込め、見出しアンカーの scroll margin、固定ヘッダーによるフォーカス遮蔽の禁止。キーボードで使えることは「状態・フォーカス・操作」の 3 点を確認する【推論】。
- **ネイティブを壊さない**: [azukiazusa「今すぐできるアクセシビリティ改善」](https://azukiazusa.dev/blog/accessibility-improvements-you-can-make-now)【弱: 個人ブログ】。
  - `<div onClick>` をやめて `<button type="button">` にする。
  - 正の tabIndex は使わない。
  - `outline: 0` を全体にかけない。
  - ラベルは `<label for>` で結ぶ。アイコンボタンには aria-label を付ける。
  - 依頼文にあった「本来の機能を損なってはいけない」という見出しそのものは見つからなかった。趣旨は上の記事と同じ【未確認】。

## 2. フォーム(日本語を含む)

- **汎用**: [web.dev Sign-up form best practices](https://web.dev/articles/sign-up-form-best-practices)。
  - autocomplete は `email`・`tel`・`username`・`new-password`。
  - 入力した時点でインラインに検証する。パスワード欄への貼り付けを許す。
  - メールや電話を 2 回入力させない(確認コードを送る)。
  - 必要なものだけを聞く。
- **ICS MEDIA**: [モダンなフォームの書き方 input 要素](https://ics.media/en/entry/11221/)(全文を取得して確認)。
  - `type="email"` と `type="tel"` でキーボードを切り替える。`inputmode` は type より細かく指定できる。
  - ユーザー名などは `autocorrect="off"` と `autocapitalize="off"` にする。
  - `autocomplete` は標準値(`family-name`、`given-name`、`postal-code`、`tel`)を使い、`name` も合わせる。現在のブラウザは `autocomplete="off"` をほぼ無視する。
  - 都道府県は select でなく input にする(自動入力が効かないことがある)。
  - ふりがなの標準 autocomplete 値はない。Chrome はラベル中のカタカナ・ひらがなから判定する。Edge は非対応(2026-05 時点との記載)。
  - 全角数字を強制しない。半角・全角の両方と、半角・全角スペースを受け付け、変換はサーバー側で行う。
  - 電話番号と郵便番号を複数の欄に分割しない(自動入力が壊れ、モバイルで使いにくい)。
- **ICS MEDIA(検証)**: [HTML 標準機能のフォーム検証](https://ics.media/en/entry/240418/)、[React Hook Form と Zod](https://ics.media/en/entry/240611/)。
  - 入力ルールはエラーが出る前に示す。
  - `:user-invalid` を使い、`aria-invalid`・`aria-describedby`・`role="alert"` でエラーを伝える。CSS の状態は支援技術の状態と自動では同期しない。
  - 検証タイミングは初回 blur のあと入力ごと(React Hook Form の `onTouched` 相当)。
  - 17 項目の記事によれば、iOS Safari は font-size が 16px 未満の入力欄で拡大する。スニペットのみで全文は未確認【弱】。
- **27 か条**: [ユーザー登録フォームを作るとき、プログラマーが絶対に知っておくべきこと27か条](https://note.activetk.jp/etc/readme-before-you-make-a-freaking-signup-form)【弱: 個人 note。全文を取得】。UI 側で効く項目は次のとおり。
  - 氏名を姓と名で分けない、文字数制限を付けない(1・2)。
  - パスワードの貼り付けを許す、再入力を求めない、パスワードマネージャーを妨げない(8・11・13)。
  - 住所を細かく分割しない、郵便番号と住所は補い合う(16・17)。
  - 生年月日はドロップダウンでなくカレンダー(18)。
  - 電話番号のハイフンや全角・半角の統一をユーザーに任せない(20)。
  - 不要な項目を必須にしない(22)。
- **全角・半角**: [ITmedia 2021](https://www.itmedia.co.jp/news/article/2111/05/1211105079/)。住所に漢字と数字が混ざるから全角を求める、旧システムの制約などが理由。開発側は入力値を自動変換するか(InputManJS など)、自前で変換する。次の欄へ自動で移ること、ハイフンを要求しないことも例に挙がる。
- **人に優しいフォームを作ろう、特に日本人に**: 検索では見つからなかった【未確認】。置き換えとして上の ICS MEDIA・27 か条・ITmedia を使った。
- **住所**: [web.dev Address forms](https://web.dev/learn/forms/address)(日本語版)は、氏名を 1 欄にして多様な名前に備える考え方を示す。郵便番号から住所を補完するときは、自動入力欄と手入力欄を分ける(All About の例)【弱】。

## 3. アクセシビリティを UI 品質の一部として扱う

- **コントラスト**: 通常テキスト 4.5:1、大きい文字(18pt 以上、または 14pt の太字)は 3:1([1.4.3](https://www.w3.org/WAI/WCAG22/Understanding/contrast-minimum.html))。非テキストは 3:1(1.4.11。1.4.3 ページの記述からの推定【推論】で、1.4.11 の原文は未読)。
- **フォーカス**: 2.4.11 Focus Not Obscured(AA)は、フォーカスされた部品が作者の作るコンテンツで完全には隠れないこと([原文](https://www.w3.org/WAI/WCAG22/Understanding/focus-not-obscured-minimum.html))。2.4.13 Focus Appearance(2 CSS px 周の面積、3:1)は AAA。AA の必須ではない([原文](https://www.w3.org/WAI/WCAG22/Understanding/focus-appearance.html))。
- **動き**: `prefers-reduced-motion`([web.dev](https://web.dev/articles/prefers-reduced-motion))。
  - 視差、背景動画、自動再生、出現演出などの装飾の動きを取り除く。通常のスクロールなど基本的な動きは残す。
  - `animation: none` は `animationend` を待つスクリプトを壊すことがある。その場合は極短い duration にする。
  - Web Animations API や JS のアニメーションは、`matchMedia` で自分で止める。
- **自動検査が拾う範囲**: Deque は 2,000 件超の監査(約 30 万件の課題)で axe が量の 57% を検出したと報告する([Deque](https://www.deque.com/blog/automated-testing-study-identifies-57-percent-of-digital-accessibility-issues/))【弱: 販売元、2021 年】。Storybook の a11y アドオンも「最大 57%」と書き、`Incomplete` は手動確認とする([Storybook](https://storybook.js.org/docs/writing-tests/accessibility-testing))。Lighthouse のスコアは axe の影響度による重みで、手動監査を除く([Chrome](https://developer.chrome.com/docs/lighthouse/accessibility/scoring))。
  - 拾える【推論: 上の資料のルールの性質から】: 名前のないボタン、ラベルなしの入力、コントラスト、alt、重複 ID。
  - 拾えない: 見出しやラベルの意味の妥当性、キーボードでの操作順、フォーカス管理、スクリーンリーダーでの読み上げ、動きの酔い、文言のわかりやすさ。

## 4. コンポーネントの状態とコンテンツの端

- 状態の洗い出し: 空・読み込み中・エラー・一部成功・無効・権限なし、hover・active・focus・選択・ドラッグ中。Vercel は hover/active/focus を通常状態より目立たせると書く。UX 側が決めた状態一覧を、実装側はコンポーネント単位に割り当てる【推論】。
- 内容の端: 短い・平均・非常に長い、0 件・1 件・大量(50 件超は仮想化)、`min-width: 0` による truncate、数値の桁そろえ、Intl による日付・数値・通貨。
- 無効ボタン: 理由を示さず無効にするより、押せる状態でエラーを返すほうがよい(Vercel の送信ボタンの記述の延長)【推論】。
- 国際化: React Aria は 30 以上の言語、13 の暦、5 つの数字体系、RTL を持つ([React Aria](https://react-aria.adobe.com/))【弱: 製品ページ】。日本語は折り返しの `word-break`・`line-break`、文字サイズ、和欧混植を確認する【推論。出典は未取得】。

## 5. レスポンシブと適応

- **コンテナクエリ**: 再利用するコンポーネントにはコンテナクエリ、ページ全体のレイアウトにはメディアクエリ([MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_containment/Container_queries))。`cqi` などの単位は、`container-type` を持つ祖先が必要。
- **タッチとポインター**: Vercel は `touch-action: manipulation`、タップハイライトの意図的な設定、微細ポインターのみのラバーバンド抑止を挙げる。hover はマウス限定にする(React Aria はマウスのときだけ hover 効果)。`@media (hover: hover)` の記述は MDN 等で未確認【推論】。
- **セーフエリア / ダークモード**: Vercel は、全画面レイアウトで safe-area inset を守る、dark では `color-scheme` を html に設定する、theme-color を背景に合わせる、と書く。
- **入力欄は 16px 以上**: iOS のズーム回避(ICS MEDIA の 17 項目記事、スニペットのみ【弱】)。

## 6. パフォーマンスを UX として扱う

- **Core Web Vitals**: LCP 2.5 秒以下、INP 200ms 以下、CLS 0.1 以下。いずれも 75 パーセンタイル([web.dev Vitals](https://web.dev/articles/vitals))。INP は 200〜500ms が要改善、500ms 超が不良([web.dev INP](https://web.dev/articles/inp))。CLS は 0.1〜0.25 が要改善、0.25 超が不良([web.dev CLS](https://web.dev/articles/cls))。
- **UI コードが悪化させる典型**:
  - CLS: 寸法のない画像・動画、フォントの差し替え、サードパーティ広告・ウィジェットの後からのリサイズ、既存コンテンツの上への挿入。対策は領域の確保と、`transform` によるアニメーション(web.dev CLS)。
  - INP: メインスレッドの長いタスク(50ms 超)。処理を分けて `scheduler.yield()` で譲る。前回の yield から約 50ms ごとにまとめる(web.dev [Optimize long tasks](https://web.dev/articles/optimize-long-tasks))。
  - LCP: 重要な画像を優先する、下の画像は lazy(Vercel)。
- **アニメーション**: コンポジターだけで処理できるプロパティは `transform` と `opacity` の 2 つ。`will-change` は必要な要素だけに付ける([web.dev](https://web.dev/articles/stick-to-compositor-only-properties-and-manage-layer-count))。

## 7. コンポーネント構成

- **ヘッドレス部品**: Radix は aria・role・フォーカス管理・キーボード操作を担い、スタイルを持たず、`asChild` で描画要素を差し替える([Radix](https://www.radix-ui.com/primitives/docs/overview/introduction))。React Aria は ARIA Authoring Practices に沿い、マウス・タッチ・キーボード・スクリーンリーダーに最適化する([React Aria](https://react-aria.adobe.com/))【弱: 製品ページ】。Base UI は調べていない【未確認】。
- **shadcn/ui**: 「ライブラリではなく、自分のライブラリの作り方」。コード本体を持ち、スキーマと CLI で配布する([shadcn/ui](https://ui.shadcn.com/docs))。上位のコードを直接編集でき、LLM が読める点を売りにする【弱: 自己説明】。
- **トークン**: 色・余白・角丸・影・動きの時間をトークン化し、ライト・ダークで同じ名前を保つ【推論。出典は未取得】。
- **Storybook / 視覚回帰**: Storybook の a11y アドオンは axe ベース。Playwright の `toHaveScreenshot` は、連続した 2 回のスクリーンショットが同じになるまで待ち、`animations: "disabled"` で CSS アニメーションを止められる。`threshold` の既定は 0.2([Playwright API](https://playwright.dev/docs/api/class-pageassertions)。要約を通した確認で、既定値の細部は第三者記事との食い違いあり【弱】)。OS・ブラウザ・ヘッドレスの違いで描画が変わるので、基準画像は同じ環境(固定の CI イメージ)で作る(第三者記事【弱】)。

## 8. デザインエンジニアという役割

- 検索では、デザインエンジニアは「デザインもコードも書き、静的な仕様でなくコードで試作する人」と説明された。試作は暗黙の前提を早く表に出し、会議を減らす(Adobe の記事、求人票。いずれも二次資料【弱】)。
- Vercel・Linear・Rauno・Emil の働き方そのものを述べた一次資料は取得できていない【未確認】。Rauno と Emil の公開記事(上記)が、「感触」の具体例として使える。
- 【推論】スキルに写すなら、「作る前にコードで動かして触る」「使用頻度でアニメーションの有無を決める」「中断可能性を確かめる」を手順に入れる。

## 9. 検証の方法

- スクリーンショット: 複数の幅で撮る(幅の具体値は出典なし。320・375・768・1280 など【推論】)。Playwright で撮り、目視と基準画像で見る。
- 自動: axe(Storybook または Playwright 経由)、Lighthouse。ブラウザ操作は dotclaude の `browsing-web` スキルで可能【推論】。
- 手動: Tab だけで全操作、200% ズーム、`prefers-reduced-motion`、ダークモード、長文・空・大量のデータ。
- デザイン QA チェックリスト: [checklist.design](https://www.checklist.design/) は取得できず、中身は確認できなかった【未確認】。

## チェックリスト

| 項目 | 基準 | 出典 | 自動検査できるか |
|---|---|---|---|
| ポインター対象の大きさ | 24×24 CSS px 以上、または間隔の例外 | [WCAG 2.5.8](https://www.w3.org/WAI/WCAG22/Understanding/target-size-minimum.html) | 一部(axe に target-size ルール。有無は未確認【弱】) |
| テキストのコントラスト | 4.5:1、大きい文字は 3:1 | [WCAG 1.4.3](https://www.w3.org/WAI/WCAG22/Understanding/contrast-minimum.html) | 可(背景が画像・グラデーションだと不完全) |
| フォーカスが見える | `:focus-visible` で見える輪郭。固定 UI が覆わない(2.4.11) | Vercel、WCAG 2.4.11 | 一部(表示の有無は人が見る) |
| 操作要素の意味 | button / a / label を使う。div クリックなし | Vercel、azukiazusa【弱】 | 一部(lint、axe) |
| アイコンボタンの名前 | accessible name あり | Vercel | 可 |
| キーボードで全操作 | Tab・Enter・Esc で完結、tabIndex は 0 か -1 | azukiazusa【弱】 | 不可(手動か E2E) |
| 動きの抑制 | reduced-motion で装飾の動きを止める | [web.dev](https://web.dev/articles/prefers-reduced-motion) | 一部(CSS の grep、JS は手動) |
| アニメーション | transform と opacity、`transition: all` なし、300ms 未満 | Vercel、[web.dev](https://web.dev/articles/stick-to-compositor-only-properties-and-manage-layer-count)、Emil【弱】 | 一部(grep、lint) |
| 待ち時間の表示 | 1 秒未満なし、約 2〜10 秒はスケルトン / スピナー、10 秒超は進捗 | [NN/g](https://www.nngroup.com/articles/skeleton-screens/) | 不可 |
| 状態の網羅 | 空・読込・エラー・一部・無効・権限 | Vercel(空・長文)、他は【推論】 | 不可(Storybook に状態を並べて目視) |
| 長文・多言語 | truncate か折り返し、`min-width: 0`、Intl | Vercel | 一部(長文データでスクリーンショット) |
| フォームの入力支援 | autocomplete、type、inputmode、貼り付け可、分割しない | [ICS MEDIA](https://ics.media/en/entry/11221/)、web.dev | 一部(lint、axe の autocomplete-valid) |
| 全角・半角 | 両方受け付け、サーバー側で正規化 | ICS MEDIA、[ITmedia](https://www.itmedia.co.jp/news/article/2111/05/1211105079/) | 不可(E2E で全角入力して確認) |
| エラー表示 | 項目の横に表示、最初のエラーへフォーカス、対処を書く | Vercel、ICS MEDIA | 一部(`aria-invalid` などは検査可) |
| 入力欄の大きさ | font-size 16px 以上(iOS) | ICS MEDIA【弱】 | 一部(computed style) |
| CLS | 0.1 以下。画像に寸法 | [web.dev](https://web.dev/articles/cls) | 可(Lighthouse、ラボ値) |
| INP | 200ms 以下。長いタスク 50ms 以下 | [web.dev](https://web.dev/articles/inp) | 一部(ラボでは近似、実測は RUM) |
| LCP | 2.5 秒以下 | [web.dev](https://web.dev/articles/vitals) | 可(Lighthouse、ラボ値) |
| レイアウト | 複数幅で横スクロールなし、safe-area、コンテナクエリ | Vercel、[MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_containment/Container_queries) | 可(幅別スクリーンショット、横スクロール検出) |
| ダークモード | `color-scheme`、両テーマでコントラスト | Vercel | 一部 |
| 視覚回帰 | 同一環境で基準画像、`animations: disabled` | [Playwright](https://playwright.dev/docs/api/class-pageassertions) | 可 |

## スキルへの示唆

1. 手順は「基準表を先に読む → 実装 → 検証」。基準表は上の表をそのまま使い、「自動で確かめた / 人が確かめた / 確かめていない」を最後に必ず報告させる【推論】。
2. 検証ループを組み込む: 複数幅のスクリーンショット、axe、キーボード操作、reduced-motion、ダークモード、長文データ。自動の合格を「完了」と書かせない(57% の限界)。
3. 「作らない」規則を持たせる: div クリック、`transition: all`、貼り付け禁止、`outline: 0`、全角強制。Vercel の anti-patterns を禁止リストとして使える。
4. 感触の規則は数値と使用頻度で書く(300ms 未満、押下 0.97、高頻度の操作は動きなし、中断可能)。ただし数値は Emil のブログ【弱】なので「初期値」として扱う。
5. 日本語フォーム用の別ブロックを置く: 氏名 1 欄または姓名 2 欄の判断(27 か条と web.dev は分けない側)、ふりがな、郵便番号と住所の補完、全角・半角の正規化、電話と郵便番号は分割しない。
6. 部品は既存のヘッドレス部品(Radix、React Aria)か shadcn/ui を既定にし、自作はしない。目的は a11y と操作の作り込みを再発明しないこと【推論】。
7. UX スキルとの接点: 状態一覧を受け取り、コンポーネントごとに割り当てる。UX 側が決めていない状態は、実装前に UX 側へ戻す。

## Gaps

- 依頼で挙がった「人に優しいフォームを作ろう、特に日本人に」は見つからなかった。
- checklist.design の中身、Base UI、Apple HIG の 44pt の原文は未取得。
- Vercel Guidelines は GitHub の要約(WebFetch)で読んだ。逐語の原文は未確認。
- 楽観的 UI、ふりがなの入力補助(IME 変換結果の取得)、`@media (hover: hover)`、日本語の折り返し(`word-break` / `line-break`)、トークン設計は一次資料を見ていない。
- Vercel / Linear のデザインエンジニアの働き方は一次資料なし。
- ラボと実測(RUM)の INP 差、axe のルール別カバー範囲(どのルールが target-size や autocomplete を見るか)は未確認。
- 複数幅の具体値はウェブ上の出典なし。
