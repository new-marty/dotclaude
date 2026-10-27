# GoodLinks 保存リンクから読む Marty の UI の好み

調査日: 2026-10-26。対象は GoodLinks の UI 系タグ付き 169 件とキーワード抽出 9 件(計 178 件)。保存ページの本文は読んだ範囲だけを根拠にし、推測は【推論】と書く。

## 結論

1. 直近 3 か月(8〜10 月)の保存 53 件のうち 22 件が `dev/ai*` タグで、関心の中心は「AI に良い UI を作らせる方法」に移っている。
2. 好みの核は「細部の作法を数値と規則で守る」ことだ。同心円の角丸、tabular-nums、イージング、余白の意味づけ、日本語の文字組などが並ぶ。
3. 同時に「綺麗は十分条件ではない。最後は人が判断する」という立場の記事(kgsi、Money Forward)を繰り返し保存している。見た目の整いより、文脈・状態・例外の設計を重く見る。
4. 説明文やラベルを足さずに減らす方向が一貫している(stop-describing-ui、ラベルは最後の手段、アイコンだけのサイドバーへの批判)。
5. 技術スタックは shadcn/ui + Tailwind + React/Next + Motion が中心(後述)。ダークで派手な演出より、静かな動きと機能的な動きを好む。

## 時系列の傾向

- 【注意】保存日(`added`)は Unix 秒で、2026-03-02 16 時台に 124 件が集中している。1 時間に 124 件は手で保存した数ではなく、別アプリからの一括取り込みと見るのが自然だ【推論】。したがって「3 月に何を保存したか」は読み取れず、この 124 件は保存時期の情報を持たない「過去の蓄積」として扱う。
- 取り込み以降の手動保存は 54 件。5 月 1 件、8 月 6 件、9 月 10 件、10 月 37 件で、10 月に急増している。
- 一括取り込み分(古い蓄積)は、UI 心理学・配色・UI 参考集(Mobbin、Happy Hues、fumufumuUI、App Motion、Rosepine)・デザインシステム事例・React/フロント設計・アイコンや UI キット・Figma/v0/Stitch/Lovart などの AI デザインツール、という広く浅い構成。
- 8 月: jakub.kr、detail.design、boneyard(スケルトン自動生成)。「細部で良く感じさせる」ものが最初に現れる。
- 9 月: beautifului.dev(AI エージェント向け UI 部品)、m3e-canvas、better-ui スキル、Refero の DESIGN.md、emil-design-eng スキル。AI 向けデザインスキルを集め始める。
- 10 月: 動き(kumagi の「動きの引き出し」、モーション・イージング辞典、transitions.dev、beUI、Arc UI)、日本語組版、AI 時代のデザイン論(kgsi 2 件、Money Forward、NestUI)、スキル/リポジトリ紹介の X 投稿が多数。
- スター付きは 1 件(uiprint のプリント用モックアップ)だけ、ハイライトは 0 件。既読フラグは 70 件だが、大半は一括取り込み分についたもので、関心の強さの指標としては使えない【推論】。そのため「強い/弱い」は、件数・新しさ・内容の一貫性で判断した。

## 好みの傾向

### 1. 細部の作法を、具体的な数値で守る【強】
- jakub.kr「Details That Make Interfaces Feel Better」https://jakub.kr/writing/details-that-make-interfaces-feel-better : text-wrap: balance/pretty、同心円の角丸(外側の radius = 内側の radius + padding)、アイコンの出現時に opacity・scale・blur を同時にかける、macOS の `-webkit-font-smoothing: antialiased`。
- better-ui スキル https://www.skills.sh/jakubkrehel/skills/better-ui : 値は範囲ではなく固定値(`cubic-bezier(0.2,0,0,1)` と `(0.4,0,0.2,1)` は別物、0.96 と 0.95 も別物)。光学的な中心合わせ、当たり判定の拡張。
- lintapple https://github.com/gholtzap/lintapple : フォント、コントラスト、操作領域、gap、角丸の入れ子、数字の桁幅などを ui-policy.json と Playwright で機械検査する。
- good-css(X 投稿) https://x.com/Voxyz_ai/status/2108875199164871053 : `(hover: hover)` 内だけに hover を書く、`:user-invalid`、scroll-padding、tabular-nums、44px の当たり判定。
- 「見た目の規則を守る」ことを、人の注意ではなく検査の仕組みに寄せる志向がある。これは上の傾向と合わせて 3 件以上あり、直近でもある。

### 2. 動きは「情報」であり、イージングを選んで使う【強】
- 動き系の保存が 10 月に集中: kumagi「動きの引き出し」https://kumagi.com/motions/ (139 の動きと 13 の AI スキル)、モーションリファレンス https://motion-reference.takayustudio.jp/ (782 件のイージング辞典)、transitions.dev https://github.com/Jakubantalik/transitions.dev (43 以上の CSS トランジション、prefers-reduced-motion 対応つき)、emil-design-eng https://www.skills.sh/emilkowalski/skills/emil-design-eng 、emilkowalski/skills https://github.com/emilkowalski/skills 、userinterface.wiki https://www.userinterface.wiki/ 、beUI https://beui.dev/ 、Arc UI https://uiarc.dev/ 。
- Fluid Functionalism https://www.fluidfunctionalism.com/docs/sidebar?preset=sa1FQfCxG4 は「motion is information, not decoration」と掲げ、スプリング物理で、途中で逆向きにされても破綻しない動きにする。
- 注意: 同じ保存物の中に、impeccable のようにバウンスやエラスティックを禁じる立場と、モーションリファレンスのようにオーバーシュートやバウンスを辞典として並べる立場が混在する。どちらを好むかはこのデータでは決められない。【推論】辞書として知識を集めている段階で、採用基準は未確定。

### 3. 説明文・ラベルを足すより減らす【強】
- artouc/stop-describing-ui https://github.com/artouc/stop-describing-ui : 9 つの規則。機能を説明せず動詞で操作を名指す、「New / Create / Manage」のような汎用動詞を避ける、空状態に「まだありません」と書かない、有効化の方法は文でなくボタンで見せる、記号区切りに頼らない。
- 「ラベルは最後の手段」https://photoshopvip.net/160498 : 形式で分かる値にラベルを付けない、「在庫: 12」でなく「残り在庫12個」、ラベルは小さく薄く。
- Fluid Functionalism のサイドバー: 「アイコンだけに畳むモードは意図的に作らない。半分のサイドバーは誰にとっても分かりにくい」。
- これらは少なくとも 3 件が一致しており、うち 2 件は直近。

### 4. 余白は意味であり、数値でなく視覚で整える【強】
- 「余白の意味を考えてから UI 実装してくれ」https://speakerdeck.com/ktcryomm/naaxiong-di-yu-bai-noyi-wei-wokao-etekara-uishi-zhuang-sitekure : 余白の大きさはグルーピングを表す。タイトルと本文は常に 8pt、セクション間は 20pt、同格要素は 4pt のように、値を意味に対応させる。
- 「美しいUIを作るために」https://speakerdeck.com/yuichi_hara7/mei-siiuiwozuo-rutameni-dezainagayi-shi-siteiru-tiyot... : 上下マージンの微差、微妙に違う色、数値上の中央でなく重心で配置する。
- Michael Filipiuk の X 投稿 https://x.com/MichaelFilipiuk/status/2111383736243859714 : 「アプリが何か変なら、たぶん余白」(本文は 1 文だけ)。
- 保存時期は 10 月と一括取り込み分にまたがる。

### 5. 日本語の文字組を気にする【強】
- 「日本語を美しく表示するためのCSS、まとめ」(池田泰延の X 投稿)https://x.com/clockmaker/status/2109464073804877953 : 添付画像を読んだ。`font-feature-settings: "palt" 1`、`line-break: strict`、`word-break: auto-phrase`、`text-autospace: normal`(和欧間のアキ)を使う文字組の例。
- 「とりあえず Noto Sans JP、考え直してみませんか?」https://note.com/sompo_sprint/n/n1b4878cc1479 : Noto Sans JP は正解ではなく、小さい文字や幅広い利用者には UD 書体(BIZ UD ゴシック、LINE Seed、IBM Plex Sans JP、M+)も選択肢。UI に明朝は基本向かない。
- 「人に優しいフォームを作ろう、特に日本人に」https://zenn.dev/yumemi_inc/articles/c1c83cb4cdcaa8 (一括取り込み分、本文あり)。
- 件数は少ないが、10 月の保存が含まれ、内容が実装に直結する。

### 6. 「綺麗」と「良い」を分け、AI 時代は判断と文脈設計を人が持つ【強】
- 「UIデザインが『綺麗』とはどういうことか」https://note.com/kgsi/n/nd739362cbbae : 綺麗(規則で判定できる)、使いやすい(利用者・目的・状況が前提)、美しい(主観)の 3 つを分ける。画面に写らない遷移、権限、エラー時の挙動、通知文面まで設計に含める。
- 「このスロップ時代に良きデザインをつくるには?」https://speakerdeck.com/kgsi/good-design-in-the-slop-era : 「それっぽい」と「納得できる」は違う。良さの中身はコンセプト・コンテキスト・言葉・レイアウト・色。ハーネスは答えを知っている前提で動くので、新しい良さを定義するには人の眼が要る。
- Money Forward のデザインハーネス記事(kgsi の X 紹介 https://x.com/kgsi/status/2113414131558776959 。本体は 403 で未取得): 複数案を評価し、別のモデルに反論させ、最後は人が判断する。AI の提案と人の判断を別々に記録する。
- NestUI https://note.com/canary_inc/n/n538adfe8daee : design.md を 1 枚にまとめず、答える問いごとに参照先を分ける。禁則を足し続けると肥大するので、収束だけでなく探索もできる構造にする。
- 同じ著者を 3 件(note、スライド、X)保存しており、10 月に集中する。Figma の「方針を決める前に例外ケースを検討する」の X 投稿 https://x.com/t0m0Ki/status/2109434395312652710 も同じ向き。

### 7. AI 生成物の「スロップ感」を嫌い、検査と禁止則で抑える【強】
- impeccable https://github.com/pbakaus/impeccable (WebFetch で確認): 62 の決定的なルールで検出する。禁止の例は、Arial/Inter/システムフォントの多用、色付き背景上の灰色文字、純黒・純灰、カードの入れ子、バウンス/エラスティック。
- emilkowalski/skills: 「エージェントは趣味が良くない」。enter に ease-in を使う、半透明の影でなく実線の枠を使う、などの癖を列挙して直す。
- X の紹介投稿(Trevin Chow の「best design skill gets better」、AmirMušić の 10 リポジトリ)が impeccable を「Anti AI-slop」と紹介。
- 「AI に『もっと良く』と頼むと枠線を足し、影を足す」という impeccable の投稿文 https://x.com/trevin/status/2112651914567708786 も保存。

### 8. エージェントが使う UI 部品(チャット、承認、差分、思考表示)に関心がある【弱〜中】
- beautifului.dev https://www.beautifului.dev/ (ローディング、思考トレース、ストリーミング文、承認カード、ツール呼び出しチップ、プロンプトバー、差分テーブル)、aiverse https://www.aiverse.design/browse (AI UX の事例 200 以上)、CopilotKit https://www.copilotkit.ai/ 、Phil Pitus の Generative UI の動画 https://x.com/pitus_/status/2111519352503873866 、「実践AIチャットボットUI実装入門」(一括取り込み分)。
- 件数はあるが、どれも 1 件ずつの保存で、深掘りの跡がない。

### 9. 参考ギャラリー・素材集は広く保存しているが、特定の美学に収束していない【弱】
- Mobbin、fumufumuUI、Nikola Toy、Cofolios、Ucas Studio、Rosepine、Happy Hues、UI8、Pavyon(Framer テンプレ)、App Motion、layers.to など。
- 本文は多くが空か短く、保存理由は不明。色調やジャンルは揃っていない。「ギャラリーを集める人」であることは言えるが、好みの方向は言えない。

## 使っている技術スタック

保存物から言えること(Marty 自身の採用ではなく、保存物の傾向)。

- shadcn/ui(ui.shadcn.com を 2 件、satnaing/shadcn-admin、Figma の NextJS+shadcn ボイラープレート、organui の shadcn レジストリ)。beUI、Arc UI、Fluid Functionalism、snapcn も shadcn CLI 配布。強い。
- Tailwind CSS(Tremor、uicolors.app、beUI、ObsidianUI、CSS ユーティリティファーストの翻訳記事)。強い。
- React / Next.js(React 関連の保存が最も多い。useEffect の扱い、コンポーネント設計、Vercel の react-best-practices、react-doctor、eslint-plugin-react-you-might-not-need-an-effect)。強い。ただし TanStack Start の記事(「もうNext.jsには戻れない」)、Svelte、HTMX、Void も保存しており、Next 一択ではない。
- Motion(旧 Framer Motion)が動きのライブラリの前提(beUI、Arc UI、ObsidianUI が「Motion + Tailwind」)。
- Base UI / Radix をプリミティブ候補として見ている(Fluid Functionalism)。
- デザインシステムは AlignUI(2 件)、Magic UI、Reactbits、Sansan の One Design System の Storybook。
- 周辺: Biome、Storybook + Playwright、Figma + Storybook + Playwright MCP、Maestro、v0 × Cursor。
- 【推論】コードを書く人としての UI 関心で、Figma 中心のデザイナーというより「エンジニアが AI と作る」側。

## 保存された AI 向け UI スキル・ツール一覧

読んだページの内容から書いた。

| 名前 | 何をするか |
|---|---|
| emilkowalski/skills(emil-design-eng ほか) | アニメーションを中心とした UI 仕上げ。animate、review-animations、improve-animations、find-animation-opportunities、animation-vocabulary、apple-design など。エージェントがやりがちな誤り(ease-in の enter など)を列挙する |
| better-ui(jakubkrehel/skills) | 同心円の角丸、光学的な整列、面の深さ、コンテキストアイコン、当たり判定を固定値で定める。タイポ、アクセシビリティ、レイアウトは別スキルに分かれている |
| impeccable(pbakaus) | `/impeccable init` で PRODUCT.md を作り、shape、critique、audit、polish、distill など 24 コマンド。62 の決定的ルールで AI 臭い UI を検出 |
| stop-describing-ui(artouc) | UI から説明文を削る 9 規則 |
| lintapple(gholtzap) | ui-policy.json に基づき、フォント、コントラスト、間隔、角丸の入れ子などをブラウザで測って検査(Playwright 連携) |
| good-css(vojtaholik。X 経由) | 47 の現代 CSS 技法を先に試させる。hover の貼りつき、:user-invalid、scroll-padding など。リポジトリ本体は読んでいない |
| transitions.dev | 43 以上の CSS トランジション。CLI かエージェントスキルで導入。reduced-motion ガード付き |
| juliobsz/skills(/awwwards) | 1 行の依頼から受賞級のサイトを作り、実ブラウザで確認して返す |
| NestUI(カナリー) | AI にデザインシステムを問いごとに分けて渡す参照設計。作ってレビューして戻すループ |
| Refero Styles / design.how | 2,000 以上の実サイトから DESIGN.md を提供。「Design systems for agents」はタイトル程度しか読めていない |
| m3e-canvas(lnkiai) | ブラウザで Material 3 Expressive の画面を描き、AI コーディングツール向けのプロンプトにして渡す |
| 「kumagi の動きの引き出し」 | 139 の動きと 13 の AI スキル |
| beautifului.dev | エージェント向けの UI 部品(承認カード、思考トレース、差分テーブルなど) |
| react-doctor、react-best-practices(Vercel) | React コードの診断と規約。UI の好みというよりコード品質 |
| X の一覧投稿 | 10 リポジトリ(Superdesign、Better Design、Design Taste、Canvas UI、Paper Shaders、UI Layouts、Motion Primitives、Cursify ほか)、UI UX Pro Max、Penpot MCP など。各リポジトリは読んでいない |
| userinterface.wiki | 運営者は X/GitHub の handle から raphaelsalaja と推測される。動きとタイポ中心の読み物とデモ、Skill のリンク |

## 無いもの

- ダークモード、グラスモーフィズム、ネオブルータリズムなど、特定のビジュアルスタイルを名指しで追う保存がない。【推論】見た目の流派よりも、作法と判断の質を重視している。
- アクセシビリティの専門資料(WCAG、コントラスト計算など)は単独の保存がほとんどない。上の lintapple や good-css に含まれる程度。
- 色彩理論・配色の深掘りは弱い。Happy Hues と Tailwind カラージェネレーターのみ。
- イラスト、3D、リッチなブランド表現、ゲーム UI はない(Awwwards 系は juliobsz/skills 1 件)。
- 英語圏の大手デザインシステム(Material、Carbon、Polaris など)の原典はなく、保存は日本語のデザインシステム事例記事が中心。
- 保存に対するハイライトが 0 件で、本人の言葉による「なぜ良いか」が残っていない。好みは保存対象から読むしかない。
- ネイティブアプリ(iOS)の HIG は、X の紹介リストや emilkowalski の apple-design に出る程度で、単独の保存はない。

## Gaps(取得できなかったもの・未確認)

- Money Forward Design の記事本体(medium.com/moneyforward-design)は 403 で取れなかった。こぎその X 紹介文だけを根拠にした。
- 本文が空または極端に短く、取得も試さなかったもの: 資料作成デザインアイデア図鑑(Amazon)、memorisely、layers.to、Mobbin、Cofolios、Ucas Studio、AlignUI(旧 URL)、designsystems.surf、uiprint、DesignPlex、Zoviz、Looka、Stitch、Figma Make、Lovart、Onlook。ギャラリーや製品ページで、内容から好みを読み取れないと判断した。
- `design.how/systems`、Refero の DESIGN.md の中身、aiverse の個別事例、X の一覧投稿の各リポジトリ、good-css 本体、Figma Sightlines の記事は読んでいない。
- `userinterface.wiki` は WebFetch でも記事一覧が取れず、保存時の本文(記事一覧)を使った。
- `jakub.kr`、`emilkowalski/skills`、`kgsi` の 2 本、`fluidfunctionalism`、`stop-describing-ui` などは GoodLinks に本文があるか、WebFetch で読めた(上記の記述はそれに基づく)。
- 保存日が 2026-03-02 に 124 件集中しているため、2026 年 3 月以前の嗜好の変化は追えない。
- 「ラベルは最後の手段」の元記事は Refactoring UI の抄訳で、原典は読んでいない。
