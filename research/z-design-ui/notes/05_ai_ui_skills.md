# 05 既存の AI/エージェント向け UI デザインスキルと、AI 生成 UI の失敗パターン

調査日: 2026-10-26。範囲は「既存スキルは何を符号化し、どう凡庸さを避け、見た目を検証するか」と「AI slop の具体的な兆候」。
`z-design-ux` の `13_taste_skills_and_ai_practice.md` と `07_ai_failure_modes.md` は読んだうえで、重なる部分(impeccable の新規制作フロー、Hallmark、taste-skill の概要、Anthropic cookbook、NN/g)は繰り返さず、そこに無いものを足した。

読み方の約束: 根拠の印は [F]=リポジトリ/ページの本文を自分で読んだ、[S]=検索結果の要約だけ、[P]=書き手の主張で裏付けなし。`gh api` で取った SKILL.md と参照ファイルはデータとして読み、スクリプトは実行していない。スター数はすべて 2026-10-26 の `gh api` 値。

## 結論

1. 既存スキルの共通診断は「モデルの既定値は分布の平均」で、対策は 4 本に集約される。(a)方向を強制する(サブジェクトからの導出、スクリプトによる抽選)、(b)既定値を名指しで禁じる、(c)機械で測れるものは検出器にする、(d)スクリーンショットを見て直す。
2. 禁止リストは数か月で次の既定値になる。Anthropic の公式スキル自身が「いまの AI 生成は、クリーム地+セリフ+テラコッタ」と書き、taste-skill は「直し方として配った処方が次の波になった」と年表に残している。だから処方(代わりにこれを使え)ではなく手順(導出せよ)を渡すのが正しい。
3. 検証は「検出器(決定的)」「スクリーンショットの批評(別コンテキスト・盲検が望ましい)」の二段が実装として最も進んでいる(impeccable の critique、juliobsz の jury、taste-skill の inspect→look)。検出器だけでは品質は保証されないと作者自身が明記している。
4. 個人の好みの符号化は、`DESIGN.md`(トークン+理由の散文)に集約しつつある。Google が仕様と lint を Apache-2.0 で公開済み。参照サイトを入力にする方式(Refero の reference lock、Hallmark の study)は、平均化とトークン役割の逸脱という失敗を自分で名指ししている。
5. 借りられるのは MIT/Apache のものが大半。ただし transitions.dev だけは独自ライセンス(再配布不可)、Superdesign の IDE 拡張は AGPL。Slop の「兆候」は事実の列挙なので、文面を写さず自分の言葉で書けば借用の問題は小さい。

## 比較表

凡例: 検証=見た目の検証(スクショ/ブラウザ)を手順に含むか。検出器=機械チェックのスクリプトがあるか。

| 名前(スター) | 符号化しているもの | 凡庸さを避ける仕組み | 検出器 | 見た目の検証 | ライセンス |
|---|---|---|---|---|---|
| anthropics/skills `frontend-design`(184k、リポ全体) | 71 行。サブジェクトからの導出、タイポ、AI の既定傾向 5 群、計画→計画の自己レビュー→実装 | 「手の込んだ代理店のデザインリード」役、既定傾向の名指し、計画を「他の同種ページでも出るか」で自己検査 | なし | 「環境が許せばスクショで自己批評」の 1 文 | Apache-2.0(LICENSE.txt)[F] |
| pbakaus/impeccable(88k) | 1 スキル+24 コマンド。PRODUCT.md/DESIGN.md、モード(Persuade/Operate/Read/Experience)、craft-floor(Verify と Refuse) | 新規は抽選スクリプトで方向を配る、ブリーフが勝つ、7 候補の導出 | 62 ルール(CLI/ブラウザ拡張/編集時フック) | critique は A(設計レビュー)と B(検出器+ブラウザ)を別サブエージェントで走らせる。live で複数案をブラウザ上で選ぶ | Apache-2.0 [F] |
| Leonxlnx/taste-skill(103k) | 方向 20 種の抽選、ハウスルール、tells 年表、14 パスの批評、アプリ画面用の別ラン | 配られた 3 方向から選ぶ、サブジェクトの棚卸し、「ロゴを隠す」テスト | `lint.mjs`、`inspect.mjs`(実ブラウザで測定) | 3 幅のスクショを見て批評→直す、最大 3 周 | MIT [F] |
| emilkowalski/skills `emil-design-eng`(50k) | 674 行。アニメーション判断枠組み、コンポーネント作法、clip-path、ジェスチャー | 「趣味は鍛えるもの」の哲学+Before/After/Why の表を必須にする | なし(兄弟スキル `break-ui` は最悪データで壊す) | `break-ui` はブラウザがあれば両状態をスクショ比較 | MIT [F] |
| jakubkrehel/skills `better-*`(8.6k) | 15 スキルに分割(ui、layout、colors、typography、accessibility、writing、interface-review、variant、break など)。数値は「近似でなく正確値」 | `variant` は軸を 1 つ決めて 3 案を意図的に変える(順位は付けない) | なし | `build-design` は Figma/画像との比較を要求。比較してない一致は報告しない | MIT [F] |
| artouc/stop-describing-ui(87) | UI の説明文を削る 9 規則とチェックリスト、Before/After | 文章で説明する代わりに動詞・コントロール・アイコン・余白 | なし | なし | MIT [F] |
| gholtzap/lintapple(509) | `ui-policy.json` と Playwright で測る UI リンタ(フォント、コントラスト、操作域、間隔、同心円の角丸、ツールチップ、8px インセット) | 「AI が悪い UI を作れないように」。ポリシー変更はユーザー依頼なしにしない(AGENTS.md) | 本体が検出器 | 実ブラウザで状態×画面幅×テーマを測定 | MIT [F] |
| Jakubantalik/transitions.dev(5.8k) | モーショントークン(時間・距離・倍率・ぼかし・イージング)と使い分け規則、生成中アニメ | 「最寄りの数値でなく用途で合わせる」。用途が合わなければ触らない | なし | なし | 独自(個人・商用は自由、ライブラリ自体の再配布は不可)[F] |
| juliobsz/skills `awwwards`/`jury`(961) | Awwwards 採点軸(Design 40/Usability 30/Creativity 20/Content 10)。1 行プロンプトから完成まで | 3 コンセプトを異なる領域から出して採点、1 つのシグネチャ演出 | `shoot.mjs`、`audit.mjs`(LCP、CLS、axe 等) | jury は盲検の批評者(コードを見せない)が証拠だけで採点 | MIT [F] |
| madebymustafa/design-taste(196) | NEVER リスト、タイポ・色・レイアウト・モーション、出荷前チェック 9 項目、12 本の美学プリセット | 「デザインの読み」を 1 行で宣言してから生成 | なし | なし | MIT [F] |
| marvkr/better-design(534) | SKILL.md は MCP を呼ぶ手順だけ(58 行)。原則・システム・レビュー規則は外部 MCP 側 | 原則の取得、デザインシステム検索、レビュー規則での修正ループ | MCP に `review-ui-code`、`inspect-spacing` | MCP 側。未確認 | MIT(スキル部分)。MCP の中身は未確認 [F/S] |
| superdesigndev/superdesign(7.5k)とその skill リポ(904) | キャンバス上でデザイン案を生成・分岐。`superdesign init` が UI 文脈を `.superdesign/` に保存 | 複数モデルで独立に探索、branch で比較 | なし | キャンバスで人が見る | IDE 拡張は AGPLv3+企業ライセンス、skill リポは MIT [F] |
| referodesign/refero_skill(327)と Refero Styles | 調査必須の方法論。style/screens/flows の 3 層、reference lock、decision ledger、anti-ai-slop 9 項目 | 参照を平均化せず 1 つを主、他は 1〜2 の細部だけ。トークンの役割を変えない | なし | 実装後に固定した参照と比較する手順 | MIT(skill)。データ・MCP は有料サービス [F] |
| nextlevelbuilder/ui-ux-pro-max-skill(141k) | 検索可能な知識ベース(スタイル 79、パレット 192、フォント組 74、UX ガイド 119) | `--design-system` で製品種別から体系を生成 | なし(CLI 検索) | なし | MIT [F] |
| vercel-labs/agent-skills `web-design-guidelines`(33k)と web-interface-guidelines(1.0k) | UI コードを 1 つのガイドライン文書で監査。出力は `file:line` | 実行ごとに最新ガイドを取得 | 監査自体は LLM | なし | MIT [F] |
| google-labs-code/design.md(28.5k) | トークン(YAML)+理由(散文)の 8 節仕様、`lint`/`diff`/`export` | 仕様+11 の lint(参照切れ、コントラスト、孤立トークン等) | lint CLI | なし | Apache-2.0、alpha [F] |

取れなかったもの: 「good-css」スキルは名前の一致する公開リポを検索でも `gh search` でも見つけられなかった。NestUI(カナリー)も一致なし。マネーフォワードの記事は、CodeZine の「AI生成UIをCIで守る ──デザインハーネスの組み立て方」(連載「UI/UXにおけるハーネスエンジニアリング実践論」第 1 回)がそれらしいが、サイトが取得を拒否した(403 とボット確認画面)ので、検索要約の「ハーネスとは AI を制約・検査・フィードバックで包むこと」までしか確認できていない [S]。マネーフォワード製かは未確認。

## スキル別メモ

### Anthropic `frontend-design` [F]
- 出典: [SKILL.md](https://github.com/anthropics/skills/blob/main/skills/frontend-design/SKILL.md)。現行は 71 行の構造化文書(旧版との差は未確認)。
- 符号化: (1)ブリーフが製品を特定しなければ自分で提案して確認する(題材の業界・素材・言い回しから視覚の選択を導く)。(2)ヒーローは題材の最も特徴的なものから始める。「大きな数字+小ラベル+補助統計+グラデーションアクセント」は既定の処理だと明記。(3)タイポは 1〜2 ファミリー、行長 80 字未満。(4)構造記号(罫線、番号、アイブロウ)は内容が持つ情報を符号化するときだけ。(5)非ユーザー起因の動きは 1 回の演出に絞り、「各セクションのフェード+スライドアップ」「全カードのホバー遷移」は AI 臭い既定とする。
- 「現在の AI 生成が群れる 5 つの型」を自分で列挙している。①クリーム地(#F4F1EA 付近)+高コントラストのセリフ+テラコッタ(#D97757 付近。Anthropic 自身の Claude 対話アクセントなので、ユーザーのブリーフ上では tell になると断っている)。②ほぼ黒の地+アシッドグリーンかバーミリオン 1 色。③新聞風(罫線、角丸ゼロ、密な段組)。④SaaS カード一式(同じ角丸、同じ薄いグレーの影、装飾のグラデーション)。⑤テンプレの装飾(全見出しの上の大文字トラッキングのアイブロウ、「A · B · C」の中黒区切り、「WORD — fragment」のダッシュ、#0B0B0B の色付き黒、小さなデータにモノスペース、リンクの末尾の「→」)。
- 方向の強制: 「どの型も正当な場合はある。だが既定であり選択ではない。ブリーフが方向を固定しているならそれが勝つ」。軸が空いているときに型へ逃げるな、と書く。
- 工程: 色 4〜6 色の名前付き hex、書体と役割、レイアウト概念(一文+ASCII ワイヤー)、原則を「計画」として書き、**計画をブリーフに照らして自己レビューし、同種のプロンプトで自分が出す凡庸な答えに近い部分を直し、何を直したか言う**、そのあとコード。完成後は「スクショで自己批評(環境が許せば)」と「ひとつ飾りを外せ(シャネル)」。
- 文面(ライティング節)も含む: ボタンは「Submit」でなく「Save changes」、トーストは同じ語(Published)、エラーは謝らず原因と直し方を言う。
- 限界: 検出器もスクショの必須手順も無い。方針の自己レビューは同一コンテキストの自己批評なので、07 で整理した「自己修正は外部信号が無いと弱い」(Huang ら)の対象になる [inference]。

### impeccable(補足。13 番にある内容は省略)[F]
- 追加で読んだ範囲: `reference/craft-floor.md` 全文、`new-work.md` と `critique.md` の冒頭、`README.md`、`impeccable.style/slop`。
- 検出器 62 ルール+設計レビュー 6 パターン = 68 項目のカタログ(impeccable.style/slop)。分類は DESIGN.md 逸脱 4、視覚の細部 8、タイポ 13、色・コントラスト 7、レイアウト 12、モーション 4、コピー 5、画像 4、一般品質 10。slop の例: ラベルが見出しの上、アイコン角丸タイルが見出しの上、見出し上のバッジ、イタリックのセリフ表示見出し、AI パレット(紫グラデ+暗地のシアン)、暗地のグロー、グラデ文字、クリーム/ベージュ、同寸カードの格子、入れ子カード、ヒーロー指標、装飾グリッド線、片側だけ太い色罫線、バウンスのイージング、脈動するステータス点、自動スクロールのマーキー、強調の「Not a feature. A platform.」型対比、em ダッシュ多用。
- craft-floor の `Refuse` は「禁止でなく既定値」と位置づけ(ブリーフが言うなら許される)、例外が **アイブロウのみ「禁止」**(どのブリーフも取り戻せない)。`Verify` は **一度の描画で全項目をまとめて見る**(スクショを何度も往復しない)と指示している。
- 他に目を引く具体物: 「ブラウザが描く部分」(選択色、キャレット、スクロールバー、フォーカスリング、表の数字)をパレットで塗る。**「モデルが最も確実に飛ばすもの」と作者が書いている**。影は offset とぼかしを持つこと(ゼロオフセットの色付きハローは装飾)。モノスペースを「技術っぽさの衣装」にしない。絵文字や Unicode 記号をアイコン代わりにしない。
- `critique` の不変条件: 設計レビュー(A)と検出器/ブラウザ(B)は **別サブエージェントで隔離して走らせる**。A が終わるまで B の出力を親に入れない(検出器の出力が判断を錨にするため)。サブエージェントが使えない場合は先頭に `⚠️ DEGRADED` を出す。質問は報告の最後に 1 回。
- 「何が足りないか」: 検出器は web のみ(ネイティブは A のみ)。クリーンな検出結果は「証拠であって品質の証明ではない」と README が明記。
- 他スキルとの関係: README は「Anthropic の frontend-design から始まった」と書く。ライセンスは Apache-2.0 で、NOTICE.md に ehmo の `platform-design-skills`(MIT)由来の ios/android 参照を記載(帰属表示の実例)。

### Leonxlnx/taste-skill(補足)[F]
- 13 番に無い追加分: `references/tells.md`(年表付きの tells 登録簿)、House rules の根拠、`critique.md` の冒頭。
- House rules(サブジェクトによらず適用、`inspect.mjs` が実ブラウザで測る): 見出しは全幅で 2 行以内、アイブロウなし、モノスペースなし(コード以外)、番号付けなし、細い罫線なし、グラデなし、静止物に影なし、ガラスなし、絵文字なし、強調語なし、書体は最大 2。
- **根拠の出し方が率直**: 「研究で測った」ものと「作者の好み」を分けて書く。247 サイトの調査では、評点 7.5 以上のサイトは アイコン付き特徴カード 1% 対 弱いサイト 28%、グラデ 22% 対 52%、影 24% 対 48%、小さな大文字トラッキング 16% 対 57%。一方、モノスペースのラベル(44% 対 24%)と番号付け(38% 対 21%)は上位サイトに**より多い**が、「生成器が最初に真似るので」作者の判断で禁止。調査は作者自身のもので独立検証なし [P]。
- 「tells の年表」: 第 1 波(2023–24: 紫/インディゴのグラデ、グラデ文字、ガラス、3 枚の同一アイコンカード、絵文字アイコン)、第 2 波(2025: アイブロウ、ピルバッジ、強調語だけセリフ・イタリック、ベントー格子、暗地+ネオン 1 色、浮遊ピルナビ、偽ダッシュボード)、第 3 波(2025–26: **「温かく編集的に」という処方が模型に採用されて、いま最も見分けやすい生成の見た目になった**。クリーム地+テラコッタ+セリフ表示、新聞風の罫線、「Field notes」「Quietly trusted by」型の演技的ラベル)。
- 「除去だけでは不十分」: 飾りを外すと薄いページになり、盲検の審査員は飾りの残る厚いページを好んだ。穴は **スケール、完全な内容、その題材専用の画像、ベタ塗りの面** で埋める。
- 批評のパス(`critique.md`): 1 秒→5 秒、目を細める(質量が 2〜3 に減るか)、**ロゴを隠す**(競合に差し替えて成立すれば考えが無い)、テキスト左端の x 位置を数える(整ったページは 2〜3)、余白と枠、など 14 パス。**コードでなく画像だけ**を見て判断せよと明記。
- 限界: 「ヒーローがセンタリング」はルール無し(抽選で避ける)。作者の好みが強く、他製品の美学とは衝突する(例: モノスペースやアイブロウの禁止は、impeccable ではアイブロウのみ絶対禁止、その他は既定値扱い)。**ハウスルールはそのまま移植せず、「測れる検査」と「作者の好み」を分けて持ち込むべき**。

### emil-design-eng と break-ui [F]
- 出典: [emil-design-eng](https://github.com/emilkowalski/skills/blob/main/skills/emil-design-eng/SKILL.md)、[break-ui](https://github.com/emilkowalski/skills/blob/main/skills/break-ui/SKILL.md)。
- 哲学 3 本(「趣味は鍛えるもの」「見えない細部は複利になる」「美は梃子」)と、判断枠組み(アニメーションするか→目的→イージング→速さ)。具体規則: ボタンは `:active` で `scale(0.97)`、`scale(0)` から始めない(0.95+opacity)、ポップオーバーは起点基準、`transition: all` 禁止、`@starting-style`、`clip-path` の使い方。
- **レビュー出力形式を強制**: Before/After/Why の Markdown 表のみ(箇条書き禁止)。出力の形で「理由」を必ず書かせる。
- `break-ui`: 「世界で一番面倒なユーザー」になり、デモデータ(Jane Doe、12 members)がデザインを良く見せているので、**妥当な最悪データ**(長い姓名、`1 members` の単複、空リスト、翻訳された長いラベル)を一つのデータセットに混ぜて、開発専用のトグルで切り替えて壊れ方を見る。ルール: 乱数のゴミでなくスキーマの上限か実在パターン。壊すのはコンポーネントでなくデータ。
- 限界: 趣味の表現は規則に落ちている部分(数値)と文章(哲学)で混在。初回応答を固定文にする指示(`Initial Response`)は、スキルを呼んだだけで何も実行しない動作を作る。借用するなら避ける。

### jakubkrehel/skills(better-*)[F]
- 出典: [better-ui](https://github.com/jakubkrehel/skills/blob/main/skills/better-ui/SKILL.md)、[variant](https://github.com/jakubkrehel/skills/blob/main/skills/variant/SKILL.md)、[interface-review](https://github.com/jakubkrehel/skills/blob/main/skills/interface-review/SKILL.md)、[build-design](https://github.com/jakubkrehel/skills/blob/main/skills/build-design/SKILL.md)。
- 設計の特徴は **責務の分割と所有権**。各スキルは自分の担当外を名指しで他に委ねる(「色は better-colors」)。これで規則の重複と矛盾を避ける。
- 正確値の例: 外側の角丸=内側の角丸+パディング+枠線、押下は `0.96` を 150ms ease-out、画像に純黒/純白の `1px` アウトライン(`oklch(0 0 0 / 0.1)`)、段階的な入場は 100ms 間隔、退場は入場より短く小さく。「プロジェクトの一貫した慣習(影なしなど)は好みであって指摘ではない。同じ細部が 2 通りあるのは指摘」。
- `variant`(最も使える):「3 案を意図的に変える」。**軸を 1 つに決める**(構造・密度・強調・タイポ・声)。名前は `Option A` でなく `Quiet`/`Editorial`/`Dense`。全案が同一の床(アクセシビリティ 11 項目)を満たす。順位は付けない。実プロジェクトに切り替えピッカー付きで入れる。
- `interface-review`: 差分のレビュー。「これは悪くしたか」を問う。変更を触った周辺の既存問題 3 件は礼儀、30 件は別のレビュー。差分の波及先(直接の利用者、デザイントークンなら 2 ホップ)を最大 5 面レビュー。
- `build-design`: 「デザインが決める。値はデザインから読む。好みや別の場所で気に入ったパターンからは取らない」。Figma MCP の値は正確、画像は推定と明記。比較していない一致は報告しない。

### artouc/stop-describing-ui [F]
- 出典: [SKILL.md](https://github.com/artouc/stop-describing-ui/blob/main/skills/stop-describing-ui/SKILL.md)。作者名から日本発の可能性があるが、国籍は未確認。
- 9 規則: 機能を説明しない(名前を動作にする)、具体的な動詞(New/Create/Manage/Set up を避ける)、最重要の帰結だけ残す(不可逆・破壊・課金・通知は常に残す)、バックエンドの動作を書かない、同じコントロールで戻せるなら戻し方を書かない、ページが既に言っていることを書かない、無いものを書かない、有効にする方法を書かずにボタンを置く、記号(`->`、`✔️`、`→`)を区切りに使わず、アイコンと余白を使う。
- 検査法: 文字列ごとにチェックリストを順に当て、Before/After で提示。結果が空になるなら、その文章は不要だった。
- 位置づけ: 「AI が書いた UI は説明が多い」という失敗に特化した、**文面専用**の規則。frontend-design の「文面」節(動詞ボタン、一貫した語)とも整合する。UX スキルの画面一覧が各画面に「説明文を書く場所」を作らないことが前提になる。
- 限界: 日本語のコピーに固有の検討(敬語、助詞、字数)は無い。例は英語中心。

### gholtzap/lintapple [F]
- 出典: [README](https://github.com/gholtzap/lintapple/blob/main/README.md)、[AGENTS.md](https://github.com/gholtzap/lintapple/blob/main/AGENTS.md)。「AI が悪い UI を作れないようにすべき」を掲げる。
- 仕組み: `ui-policy.json` にフォントと文字サイズを宣言。`npx lintapple` が実ブラウザで測り、状態・画面幅・テーマごとに違反を JSON で出す(終了コード 0/1/2)。`data-ui-stack`、`data-ui-actions`、`data-ui-radius` などの属性でレイアウト検査の対象を宣言する。チェック: フォント、コントラスト(通常 4.5:1、大 3:1)、操作域、画面外のはみ出し、コントロール内側の 8px、同心円の角丸(外側−インセット=内側)、ツールチップ(hover と keyboard focus、Escape で閉じる)、桁幅の揃い。
- **フレームを正直に報告**: 子フレームは自動で検査せず、`frameCoverage` に未検査を列挙。「未測定」は合格ではない。
- AGENTS.md の運用: 「検査を通すためにポリシーを変えたり、例外を足したり、契約属性を消したりしない。ポリシーの変更はユーザーの依頼があるとき」。検査が証明できない範囲(視覚の質、文言の正しさ、テストの網羅)を明記する。

### transitions.dev [F]
- 3 スキル: `transitions-dev`(遷移の導入)、`transitions-polish`(既存のモーションの監査)、`transitions-ui-generation`(「AI が生成している」演出)。後者は製品演出であり、デザイン規則の参考にはならない。
- `transitions-polish` の中心: 5 次元(時間・距離・倍率・ぼかし・イージング)のトークン。**「最寄りの数値でなく用途に合わせる」**: モーダルを閉じる 300ms は、数値が違っても「モーダルを閉じる」用途のトークン(150ms)に対応させる。用途がどのトークンにも合わないなら触らない。開閉の非対称、ホバーの出入り、stagger、意図の遅延など「いつどの値か」の規則も含む。
- ライセンス: 個人・商用の自由利用、改変可、ただし「ライブラリ自体を競合製品として再配布しない」。GitHub の API では `NOASSERTION`。このリポジトリのスキルに文面を取り込むのは避ける。

### juliobsz `awwwards` と `jury` [F]
- 出典: [awwwards](https://github.com/juliobsz/skills/blob/main/awwwards/SKILL.md)、[jury](https://github.com/juliobsz/skills/blob/main/jury/SKILL.md)。Awwwards とは無関係と各所に明記。
- `awwwards`: 1 行のプロンプトから完成まで。質問をせず仮定を書く。**3 コンセプトを異なる領域から出して**(名前の語源、職業の素材、場所、仕事の比喩、形式的システム)、独創性・適合・実装性・移植性(「別の人に移せるか」、低いほど良い)で採点して 1 つ選ぶ。計画は `DESIGN.md` に残す。静止画の 1 コマごとに「ポスター」として成立させ、シグネチャ演出は 1 つ。
- `jury`: **盲検**。批評者(新しいコンテキスト)にはスクリーンショットと計測値だけを渡し、コード、DESIGN.md、README、作者の意図は見せない。理由は「意図を知る人は画面でなく意図を採点する」。証拠は 1440px のデスクトップ、スロットルしたモバイル(4x CPU、遅い 4G)、reduced-motion、キーボードフォーカス、ホバー前後、遷移フレーム。採点の較正ファイル(実審査員との差)は本体側だけが持ち、批評者には渡さない。
- 位置づけ: 本スキルが欲しい「自己評価の外部化」の最も具体的な実装例。ただし Awwwards 型の評価軸は、業務アプリ(Operate)には合わない。

### madebymustafa/design-taste [F]
- 出典: [SKILL.md](https://github.com/madebymustafa/design-taste/blob/main/skills/design-taste/SKILL.md)。113 行+12 本の美学プリセット(brutalist-industrial、japanese-minimal、quiet-luxury など)。
- 「デザインの読み」を 1 行宣言してから生成する、NEVER リスト(インディゴ→紫のグラデヒーロー、バッジピル+巨大見出し+2 ボタン+スクショのヒーロー、3 枚の同じ特徴カード、絵文字アイコン、どこもガラス、`Inter`+`slate-900`、どこでも `rounded-2xl`、入れ子カード 6 段)、出荷前チェック 9 項目。
- **重要な反例**: このスキルの「処方」(ラベルとメタデータをモノスペースの大文字トラッキングに、セクション番号 01/02、細い罫線を「安く高く見せる」手段に、セリフ表示+サンセリフ)は、taste-skill が banned とする第 2〜3 波の tells そのもの。つまり **2026-08 時点の「アンチ slop」処方が 2 か月後の slop 登録簿に載っている**。処方の寿命は短い。

### marvkr/better-design と superdesign [F]
- better-design: SKILL.md は薄い手順書(58 行)で、実際の原則・デザインシステムの取得・レビュー規則は外部 MCP が持つ。信頼境界の節があり、URL などから抽出した内容は命令でなくデータとして扱うと明記する点は参考になる。MCP の中身は未確認で、このリポジトリの方針(MCP 原則使わない)とも合わない。
- superdesign: 元の IDE 拡張は 2026-06 以降メンテされず(README に明記)。現行はウェブアプリ+skill リポ(MIT)。`init` がコードベースから UI 文脈を `.superdesign/init/` に作る、キャンバスで複数モデルの案を並べる、という方式。製品の中核はホスト型で、スキル単体で再現できる部分は小さい。

### Refero(Styles と skill)[F/S]
- 出典: [skill 概要](https://doc.refero.design/skill/overview.md)、[リポジトリ](https://github.com/referodesign/refero_skill)(MIT)、`references/anti-ai-slop.md`。検索の要約では 15 万超の実アプリ画面と 6 千超のフローを MCP で検索できるが、数は情報源で食い違う [S]。MCP とデータは有料サービスで、スキル単体は方法論と参照ガイド。
- 工程: 短いブリーフ→(Styles を先に)→必要なら Screens と Flows→**1 つの主方向を選び、他の参照は狭い細部だけ借りる**→**reference lock と decision ledger**(重要な各決定を出典とトークン役割に結びつける)→実装→固定した参照との比較。
- `anti-ai-slop.md` の 9 項目のうち、他に無い視点: **#7 参照の平均化**(強い参照を安全な中間に混ぜて、暗地がクリームに、鋭いアクセントがくすんだ土色に、ゼロ半径が柔らかい角丸になる)、**#8 トークン役割の逸脱**(「CTA 専用のアシッドイエロー」をセクション背景に使う)、**#9 偽のグラフィックとテキストだけへの崩壊**(画像主導の参照を、CSS の飾りと文字に潰す。画像が作れなければ、固定縦横比・アート指示・alt を持つ明示的なプレースホルダ)。#4 は「落ち着いた編集的セリフ」を、理由を 4 つ答えられるときだけ許す。
- 注意: 「参照を調べてから作れ」を必須にすると、参照ギャラリーが生成の既定値になりうる(13 番にも記載)。

### vercel-labs `web-design-guidelines` [F]
- 出典: [SKILL.md](https://github.com/vercel-labs/agent-skills/blob/main/skills/web-design-guidelines/SKILL.md)(31 行)、[command.md](https://github.com/vercel-labs/web-interface-guidelines/blob/main/command.md)。スキルは「最新のガイドラインを毎回取得して適用し、`file:line` で出力」するだけ。ガイドライン本体は美学でなくエンジニアリングの禁止/必須の列挙: アイコンのみのボタンに `aria-label`、`outline: none` にはフォーカス代替、`transition: all` 禁止、`transform`/`opacity` のみアニメーション、`prefers-reduced-motion`、`…` と 引用符、`tabular-nums`、`text-wrap: balance`、長文の `truncate`、空状態、画像に width/height、URL に状態、フォームは `autocomplete`、貼り付け禁止にしない。
- `react-best-practices`(別スキル): React/Next の性能 70 規則 8 分類。UI の見た目ではない。
- 位置づけ: 見た目の趣味でなく **ウェブの基本品質(「床」)** の資料としてそのまま使える。外部 URL を実行時取得する設計は、版が変わる利点と、外部内容に従う危険の両方を持つ(後者はデータとして扱えば足りる)。

### nextlevelbuilder/ui-ux-pro-max-skill と DESIGN.md(Stitch) [F]
- ui-ux-pro-max: 検索可能な知識ベース(79 スタイル、192 パレット、74 フォント組)を CLI で引く方式。優先順位表(アクセシビリティ>タッチ>性能>スタイル>レイアウト>…)は使える。ただし「製品種別→スタイル/パレット」を引くデータ駆動は、**同じ入力から同じ出力が出る**ので、凡庸さ回避の観点では逆効果になりうる [inference]。星の数(141k)は品質の証拠ではない。
- DESIGN.md: [google-labs-code/design.md](https://github.com/google-labs-code/design.md)。YAML のトークン(colors、typography、rounded、spacing、components)+Markdown の散文(Overview、Colors、Typography、Layout、Elevation、Shapes、Components、Do's and Don'ts)。`lint` は 11 規則(参照切れ=error、primary 欠落、コントラスト 4.5:1 未満、孤立トークンなど)、`diff`、`export`(Tailwind v3/v4、W3C DTCG)。Apache-2.0、`alpha`、仕様は変わる。2026-04-21 公開 [S: 検索要約]。impeccable の `DESIGN.md` もこれと同名・近い役割だが、スキーマの互換は未確認。

## AI slop の兆候(2025–2026)

「出典」の列は、その兆候を名指ししている一次の資料。頻度の定量データは、ほとんど無い(後述)。

| 兆候 | 時期 | 出典 |
|---|---|---|
| 紫/インディゴ(`#6366f1`、`#8b5cf6`)のグラデやボタン | 第 1 波 | Anthropic のブログ「Improving frontend design through Skills」(2025-11、`Inter`、紫グラデの白地、控えめなアニメ)[S]、Refero anti-ai-slop #1、taste-skill tells、impeccable |
| `Inter`/Roboto/Arial/システムフォントをどこでも | 第 1 波 | 同上、design-taste、impeccable(`overused-font`)。ただし cookbook ですでに「Space Grotesk に収束」(13 番)。 |
| 同一アイコンカード 3 枚、全部カード、入れ子カード | 第 1 波〜 | impeccable(`Refuse`、検出器)、Refero #2、design-taste、taste-skill |
| 絵文字をアイコンにする | 第 1 波 | Refero #5、taste-skill、design-taste、impeccable craft-floor |
| ガラス(backdrop blur)、グロー、暗地+ネオン 1 色 | 第 1〜2 波 | taste-skill、impeccable、frontend-design(型②) |
| 中央揃えヒーロー:バッジピル+巨大見出し+2 ボタン+スクショ | 第 1〜2 波 | design-taste、taste-skill(ルール化はせず抽選で回避)、impeccable(`Badge above the main headline`) |
| 見出し上のアイブロウ(小さな大文字トラッキング) | 第 2 波 | frontend-design、impeccable(**絶対禁止**)、taste-skill、lintapple。 taste-skill の調査では上位サイトに少ない(16% 対 57%) |
| 見出しの 1 語だけイタリック/セリフ/色違い | 第 2〜3 波 | frontend-design、Refero #4、taste-skill、impeccable |
| ヒーロー指標(大きな数字+小ラベル+補助統計) | 第 2 波 | frontend-design、impeccable |
| セクション番号 01/02/03、中黒つなぎの meta | 第 2〜3 波 | frontend-design、impeccable、taste-skill |
| クリーム地+テラコッタ/クレイ+セリフ表示(「落ち着いた編集的」) | **第 3 波** | frontend-design(Anthropic 自身のアクセント色に言及)、Refero #4、taste-skill、impeccable(`Cream / beige palette`) |
| 片側だけ太い色罫線(`border-left: 4px`) | 第 2 波 | Refero #6、impeccable(`Side-tab accent border`) |
| 各セクションのフェード+スライドアップ、全カードのホバー遷移 | 第 2 波 | frontend-design、impeccable、taste-skill |
| 偽ダッシュボード(灰色の棒とドーナツ)、CSS による偽の写真/イラスト | 第 2 波 | taste-skill、Refero #9、impeccable(`Rough SVG illustrations`) |
| ダーク/ライトを用途でなく「カテゴリ」や既定で選ぶ | — | Refero #3、impeccable craft-floor |
| コピーの癖: em ダッシュ、「Not a feature. A platform.」型の対比、「world-class」、「Field notes」 | — | impeccable(Copy 5 項目)、taste-skill |
| 説明文の多さ(機能説明、バックエンド説明、戻し方の説明) | — | stop-describing-ui |
| 偽の指標・証言・ロゴ(捏造) | — | Hallmark(13 番)、taste-skill(発明した虚栄の数字) |

### 根拠の強さ
- 「紫が多い」の**由来**を説明する記事([DEV Community](https://dev.to/jaainil/ai-purple-problem-make-your-ui-unmistakable-3ono))は、Tailwind の既定インディゴ、Polaris、Linear の見た目、2020–21 年のグラデ流行を挙げるが、**AI の出力頻度の数値データは無い**と自ら示す(私が読んだ限り)[P]。「Adam Wathan が謝罪した」という通説は、検索で裏付けられなかった。
- 「均質化が起きている」を測った一次研究は、本調査では見つからなかった。Shin ら([arXiv 2603.13036](https://arxiv.org/html/2603.13036v1)、2026-03)は 63 文献+6 ツールの試用の整理で、**実測データは無く**、均質化は仮説と明記している [F]。07 番の Doshi ら、Wadinambiarachchi ら(別領域の実験)が最も近い定量の根拠で、UI そのものではない。
- 定量に最も近いのは taste-skill の 247 サイト調査(上の数値)だが、「生成物の偏り」でなく「ギャラリーサイトの特徴と評点」の関係で、作者の自己調査 [P]。
- Anthropic のブログは「配布された学習データの安全な選択が支配する」という分布収束の説明と、同一プロンプトでのスキル有無の Before/After 画像を示す。**測定値は無く、質的** [F: 検索要約と取得の双方]。

## 有効な対策(比較)

| 対策 | 実装している例 | 強み | 弱み・注意 |
|---|---|---|---|
| 方向を強制する(題材から導出) | frontend-design(題材の業界・素材から)、impeccable new-work(7 候補→抽選)、taste-skill(サブジェクトの棚卸し 8〜12 項目+「競合に差し替えて成立するか」)、awwwards(3 領域から 3 案) | 既定値の外に出る最も根本的な手 | 質問が増える、「題材がない」業務アプリには導出元が少ない |
| 抽選(スクリプトに方向を配らせる) | impeccable `concept-seed`、taste-skill `draw.mjs` | モデルの「順位づけの癖」を壊す。ユーザーに 3 択は残す | 実装コスト。抽選の中身(ライブラリ)は誰かの好みで、時間とともに古くなる |
| 既定値の名指し禁止 | 全スキル | 即効性、安価 | **次の既定値を生む**(taste-skill の第 3 波、Space Grotesk)。処方でなく手順で書く |
| 複数案+軸を決めた分岐 | jakubkrehel `variant`、awwwards、impeccable `generate`、superdesign | 固定化(fixation)の対策になる(07 番) | 案の判断が人かモデルに戻る。「順位は付けない」(variant)は人が選ぶ前提 |
| 計画を書いて自己レビュー(同一コンテキスト) | frontend-design、Hallmark の 6 軸(13 番) | 軽い | 自己修正は外部信号が無いと弱い(Huang ら、07 番) |
| 検出器(決定的) | impeccable 62 ルール、taste-skill `lint`/`inspect`、lintapple、DESIGN.md lint | 再現でき、CI とフックに載せられる | 「クリーン=良い」ではない(3 者とも明記)。ルールは時間で古くなる |
| スクショを見て直す(外部信号) | taste-skill(14 パス、最大 3 周)、impeccable(一度の描画で全項目)、frontend-design(1 文) | 「見えるものは本物」。コードは意図を読み込む | 同一モデルの目。長い往復はコスト |
| 盲検/隔離した批評者 | jury(コード・意図を渡さない)、impeccable critique(A と B を隔離) | 自己確認バイアスを下げる最も明示的な手 | サブエージェントが要る。ない環境では劣化版 |
| 参照を入力にする(固定) | Refero(reference lock、decision ledger)、Hallmark `study` | 好みを具体化 | 平均化・トークン役割の逸脱・参照ギャラリーが既定になる |
| 最悪データで壊す | break-ui | デモデータの「良く見える偏り」を壊す | 妥当な最悪値を作る手間 |
| 床(必須品質)の分離 | variant(11 項目)、craft-floor、vercel guidelines | 美学の議論と品質を分ける | 床を満たすことと良いデザインは別 |

## 個人の好みの符号化

| 方式 | 例 | 内容 | 所見 |
|---|---|---|---|
| トークン+理由の文書 | Google DESIGN.md、impeccable の DESIGN.md/PRODUCT.md、Hallmark の `design.md`(「lock the system」と言われたときだけ出す) | 色・型・角丸・間隔の値と、使う理由・禁止 | 最も標準に近い。理由を書くので「役割」が残る(Refero #8 の防止) |
| 参照の固定 | Refero の reference lock、Hallmark `study`(スクショ/URL から構造の DNA) | 参照ごとに「構造上の動き」と「持ち込まないもの」を記録 | 参照は「写す」でなく「何を借りるか」を書く単位にする。Mobbin/Refero 等のギャラリー活用の実証は 13 番の通り乏しい |
| 質問で聞く | impeccable shape(2〜3 問、CSS 値や定型の美学は聞かない)、Hallmark(聴衆・用途・トーンの 3 問)、frontend-design(題材を提案して確認) | 好みの形容詞でなく、利用場面と成功の姿 | 形容詞(「モダンでクリーン」)は方向でないと全スキルが同意 |
| ダイヤル | taste-skill の「レイアウト変化量、モーション強度、密度」の調整(検索要約)[S] | 数段階のつまみ | 本文では未確認。多数の好みを少数の軸に潰す危険 |
| ユーザー記憶 | frontend-design が「記憶にある好み」を手がかりにする、と 1 行書く | — | 記憶は手がかりであり、ブリーフが勝つ |
| 摩擦を入れる設計案 | Shin ら: 生成前にムードボードを複数見せて選ばせる、既存ブランドと比べて差を提示する | 無難な出力の自動受容を止める | 概念提案で評価なし [F] |

個人の好み(Marty さんの趣味)を入れる場所は、(1)マシン/ユーザー共通の文書(トークンでなく、好む/避ける方向と理由)、(2)案件ごとの DESIGN.md、の 2 層に分ける案が最も自然。ただし本調査では、ユーザー個人の好みプロファイルを実際に運用して効果を測った資料は見つからなかった。

## スキルへの示唆

### 採用する
1. **処方でなく手順**: 禁止リストは「兆候の名前+なぜ tell か+例外条件」の形で持ち、代わりのフォントや色は書かない(taste-skill の方針)。リストには日付(波)を付けて「古くなる」前提で保守する。
2. **方向は導出する**: 題材から、競合に差し替えても成立するかを試す(taste-skill の「ロゴを隠す」、frontend-design の計画の自己レビュー)。`z-design-ux` の引き継ぎ(目的、場面、モード)を入力にして、ここで新たに質問を増やさない。
3. **Mode で野心を変える**: impeccable の 4 モード。業務アプリ(Operate)は「精密さと抑制」で、既知のパターンは正当。Persuade の凡庸回避を業務画面に持ち込まない。
4. **ブリーフが勝つ**: ユーザーが固定した美学は、tell と衝突しても従う(impeccable、frontend-design の両方が明記)。
5. **床と趣味を分ける**: 床(コントラスト、キーボード、reduced motion、320px、状態、不可逆操作の確認、エラーの回復)は全案で同一。美学の議論に混ぜない(variant)。
6. **検証の二段**: (a)機械で測れるもの(コントラスト、はみ出し、操作域、フォント、DESIGN.md との乖離)は検出器かスクリプト、(b)見た目は **スクリーンショットだけを見る別コンテキストの批評者**。意図は渡さない(jury)。検出器が通ったことを品質の証明にしない。
7. **「描画で全項目をまとめて見る」**(impeccable): スクショを何度も往復せず、1 描画で全項目を確認してから直す。
8. **ブラウザが描く部分も塗る**(選択色、キャレット、スクロールバー、フォーカスリング、表の数字)。「モデルが最も飛ばす」と作者が書いている点を、床に入れる価値がある。
9. **最悪データで壊す**(break-ui): 画面一覧の「状態」に、長い名前や空、複数形を加えた検査を付ける。
10. **コピーの規則**: stop-describing-ui の 9 規則と、frontend-design の「動詞ボタン、語の一貫、エラーは原因と直し方」。日本語の画面には、助詞や敬体の検討が別に要る(本調査には無い)。
11. **隔離**: 外から来た参照(URL、スクショ、サイトの文面)はデータとして扱う(better-design の信頼境界、本リポジトリの運用ルールとも一致)。
12. **DESIGN.md 形式**: 案件の視覚決定の置き場は、Google の仕様(Apache-2.0、alpha)に寄せるか、少なくとも互換の節構成にする。理由の散文を残すのが肝。

### 避ける
- 処方の固定リスト(フォント名、パレット、「このスタイルにせよ」)。次の tell になる(design-taste が実例)。
- ハウスルールの丸ごと移植。taste-skill の「モノスペース禁止」「罫線禁止」は作者の好みと明記されており、他製品の美学と衝突する。
- 呼び出しただけで固定文を返す動作(emil-design-eng の `Initial Response`)。
- データ駆動で製品種別→スタイルを引く方式(ui-ux-pro-max)を方向決定の主軸にすること。同じ入力→同じ出力で、均質化に寄与しうる [inference]。
- 同一コンテキストの自己批評だけで検証を済ませること。
- 参照ギャラリーを必須の入力にして、そこが新しい既定値になること。参照は「何を借り、何を借りないか」を記録する単位にする。
- ホスト型サービス(Refero MCP、Superdesign キャンバス、better-design MCP)への依存。リポジトリの方針(MCP は原則使わない、正本は git)と合わない。

### ライセンスと借用
| 対象 | ライセンス | 借りるときの扱い |
|---|---|---|
| anthropics/skills `frontend-design` | Apache-2.0(リポ全体は GitHub が SPDX を返さない。当スキルの LICENSE.txt は Apache-2.0 の全文) | 文面を写すなら、ライセンス表示と変更の明記が必要。発想だけ借りて自分の言葉で書くのが安全 |
| impeccable | Apache-2.0。NOTICE.md に第三者由来(ehmo の platform-design-skills、MIT)を記載 | 同上。検出器はバイナリで、取り込むより `npx impeccable detect` を呼ぶ方が簡単だが、依存を増やす(運用ルール)。呼ぶかどうかは別途判断 |
| taste-skill、emil、jakubkrehel、artouc、lintapple、juliobsz、design-taste、better-design(スキル部分)、Refero skill、ui-ux-pro-max、vercel-labs | MIT | 著作権表示と許諾文を残せば複製も可。本リポジトリの `z-design-ux` は「文面は写さない」方針で書かれている(SKILL.md 冒頭コメント)。同じ方針を保つ |
| Google design.md | Apache-2.0 | 仕様の参照、`npx @google/design.md` の利用は可 |
| transitions.dev | 独自(再配布不可の条項) | 文面を取り込まない。発想(用途で合わせる)の参照にとどめる |
| Superdesign IDE 拡張 | AGPLv3+企業ライセンス | 取り込まない |
| Refero のデータ・MCP | 有料サービス | 使うなら利用規約の確認が別に要る(本調査では未確認) |

事実の列挙(兆候の名前、WCAG の数値、CSS の定石)に著作権は及びにくいが、**文章の構成と言い回しは別**。本リポジトリでは「発想は借りる、文面は写さない、出典は ADOPTIONS 的な一覧に残す」で足りる [inference。法的助言ではない]。

## Gaps(未確認・取れなかったもの)
- good-css スキル、NestUI(カナリー)は、公開リポ・ページを特定できなかった。X の 3 投稿(AmirMushich、RoundtableSpace、so_ainsight)の一覧にも含まれない。名前の別表記かリンクが要る。
- マネーフォワードのデザインハーネス記事: CodeZine の記事 [29615](https://codezine.jp/article/detail/29615) が該当候補だが、本文を取得できなかった(403、ボット確認)。連載名と問題設定(生成は速くなったが公開可否の判断が人の目に残る)は検索要約のみ。マネーフォワードの記事かどうかも未確認。
- impeccable の 62 検出ルールの完全な一覧(ID と閾値)は `impeccable.style/slop` の名称一覧までで、各ルールの実装は読んでいない。`concept-seed` や `critique.md` の評点方式の詳細も未読。
- taste-skill の `app-screens.md`(アプリ画面用ラン)、`references/imagery.md`、`scenes.md` は未読。Hallmark は 13 番の範囲のまま再確認していない。
- better-design の MCP サーバー側の中身、Superdesign の skill リポの `SUPERDESIGN.md`、Refero のデータ内容は未確認。
- **どのスキルについても、出力の良し悪しを独立に測った評価は見つからなかった**。Anthropic は質的な Before/After、taste-skill は自己調査の盲検。Operate(業務アプリ)に対する効果は特に不明。
- Anthropic ブログ「Improving frontend design through Skills」は検索要約と取得抜粋で確認し、本文の全体は読んでいない。
- Tailwind 既定インディゴとの因果関係、Wathan の発言は裏付けなし。
- DESIGN.md の公式サイト(stitch.withgoogle.com)の仕様ページそのものは未取得。GitHub リポジトリの要約までで、日付(2026-04-21)は検索要約 [S]。
- 日本語 UI(字間、禁則、フォント、敬体、全角半角)に固有の slop や対策を扱った資料は、本調査の範囲では見つからなかった。
