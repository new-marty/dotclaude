# 導出で網羅させる、UI実装前のUX設計スキル

結論から言う。プロは UI を描く前に「誰のどんな問題か(戦略)→何を作るか(範囲)→対象物と流れ(構造)→画面の骨格→見た目」の順に決め、各層の成果物は画面の手前(フロー、画面一覧、状態、優先順位)で止める。この順序は Garrett の5層モデルが原典で、ただし各層は一方向の滝ではなく、上位層が下位層の決定をやり直させる前提で運用される([Garrett ch.2](https://jjg.net/elements/pdf/elements_ch02.pdf))。省略してよいかは、(1)かけられる時間、(2)間違えたときの損失と戻しやすさ、(3)ロールの数、(4)規制・機微データ、(5)作り手にとってのドメインの不慣れさ、の5点で決まる。工程は「消す」のではなく最安の形に縮める。縮めてもよいが消してはいけないのは、問題文と成功指標、主要フローの失敗分岐、画面ごとの状態、証拠ラベルの4つである。既存の Claude 向け UX スキルは、トピック一覧(pablostanley の ux-designer、owl-listener の jobs-to-be-done)か百科事典(Teslasoft)にとどまり、出力の形、証拠の扱い、画面と状態の網羅を機械的に固定したものは見つからなかった。唯一まとまった工程を持つ julianoczkowski/designer-skills と pbakaus/impeccable も、状態の扱いは前者が実装タスク側、後者が質問項目にとどまる。推奨設計は8工程(S0 受付と規模判定、S1 問題設定、S2 範囲、S3 対象物と権限、S4 フロー、S5 画面、S6 方向性とパターン、S7 梱包と検査)で、網羅を「文章での注意」ではなく導出規則(対象物→画面、フローのステップ↔画面の双方向トレース、画面×原因クラスの状態表)と検査スクリプトで強制する。質問は1ラウンド3問までで推奨既定値を添え、推測は ASSUMED として調査・ユーザーの声と区別し、デザインシステムは方向性だけを渡して画面から繰り返しパターンを抽出する。

以下、出典付きの事実と、調査担当者の推論(【推論】)、本設計の独自案(【独自】)を分けて記す。ベンダー由来や出典が弱い主張は【弱】で示す。

## 1. プロの工程は「決めて、必要なら戻る」を繰り返し、成果物は画面の手前で止まる

プロセスモデルの原典は複数あり、共通点は「問題の理解を先に固定し、解決策は低忠実度で検討し、実装前に検証する」ことにある。Garrett は戦略(ユーザーニーズとサイト目的)、範囲(機能仕様とコンテンツ要件)、構造(インタラクションデザインと情報設計)、骨格(インターフェース、ナビゲーション、情報デザイン)、表層(ビジュアル)の5層を定義し、目的を「ユーザー体験のどの側面も、意図なく起きない状態にすること」と置いた。スケジュールの規則は「ある層の作業は、下位層の作業が終わる前に終えてはならない」であり、「始められない」ではない。上位層の決定が下位層の再検討を強いることは前提とされている([Garrett ch.2](https://jjg.net/elements/pdf/elements_ch02.pdf))。UK Design Council の Double Diamond は2004年公開で、発見(問題が何かを、影響を受ける人と過ごして理解する)、定義、展開、提供(小規模に試して捨てる)の発散と収束を二度繰り返す。ただし成果物は規定しておらず、非線形であることを明言している([Design Council](https://www.designcouncil.org.uk/our-resources/framework-for-innovation/))。ISO 9241-210 は利用状況の把握、ユーザー要求の明確化、設計解の作成、評価を回す反復サイクルで、教科書の要約によれば終了条件は「新しい要求が出ない」「設計解がすべての既知要求に合う」「ユーザビリティが十分」であり、成果は完成品ではなく「施工マニュアル」とされる(二次要約。ISO本文は有料で未確認)([Rheinwerk](https://blog.rheinwerk-computing.com/how-to-do-ux-design-a-guide-to-the-iso-9241-210-standard))。

成果物のレベルで最も具体的なのは Basecamp の Shape Up と GOV.UK である。Shape Up の「形作り」は、境界を決める(アペタイト=かけたい時間を先に決め、「Xを作れるか」を「何が実際に問題か」に狭める)、要素を粗く描く、リスクと落とし穴を潰す、ピッチを書く、の4手順で、成果物は問題、アペタイト、解(ブレッドボードかファットマーカースケッチ)、落とし穴、やらないことの5要素である。ブレッドボードは場所(画面)、アフォーダンス(ボタンやフィールドと文言)、接続線の3要素だけで、視覚スタイルなしに操作列がユースケースを満たすかを確かめる。落とし穴探しは、ユースケースを「スローモーション」で歩く方法である([Shape Up ch.2](https://www.basecamp.com/shapeup/1.1-chapter-02)、[ch.3](https://basecamp.com/shapeup/1.2-chapter-03)、[ch.4](https://basecamp.com/shapeup/1.3-chapter-04)、[ch.5](https://basecamp.com/shapeup/1.4-chapter-05)、[ch.6](https://basecamp.com/shapeup/1.5-chapter-06))。GOV.UK の発見フェーズは、既定の解をいったん問題として言い直し、スコープ外と制約(ハードかソフトか)と問題のコストを書き、「ユーザーからでない意見は検証すべき仮定として扱う」とまで言い切る([discovery](https://www.gov.uk/service-manual/agile-delivery/how-the-discovery-phase-works)、[user needs](https://www.gov.uk/service-manual/user-research/start-by-learning-user-needs))。Linear はユーザーが言う「機能X」を問題Yの解として疑い、短いプロジェクト仕様(なぜ・何を・どう)を書いてから探索し、設計方針の合意にはその機能を実装するエンジニアを含める。数週間考えてから作ることも珍しくないと自ら述べている([Linear Method](https://linear.app/method/manage-design-projects))。GitLab の実務手順は、who/what/why の確認、成功基準(MVC)、ユーザーフローとジャーニー、低忠実度から、現状→失敗→提案の順で書く提案、である([GitLab handbook](https://handbook.gitlab.com/handbook/product/ux/product-designer/))。デザインエンジニアについては一次資料が乏しい。Rauno Freiberg の1本のエッセイは「ペルソナやストーリーボードを回す」ことに批判的で、作りながら考える立場だが、同時にトリガー、しきい値、中断可能性といった挙動の問いを立てており、これは状態とジェスチャの事前チェックに転用できる([rauno.me](https://rauno.me/craft/interaction-design))【推論: 単一エッセイからの解釈】。

実チームの引き渡しには標準がない。GitLab の24件の引き渡しサンプル調査では、PMが15件、エンジニアが8件しか受け取っておらず、大規模な7件はすべて注釈付きだった一方、小規模は9件中2件、アクセシビリティはほとんど考慮されず、チェックリストは使われないことが多かった([GitLab issue 2570](https://gitlab.com/gitlab-org/gitlab-design/-/issues/2570))。同チームの「完成の定義」テンプレートは2025年7月時点でも未作成のアクションだった([GitLab critique issue](https://gitlab.com/gitlab-com/gitlab-ux/create-ux/design-critique-sessions/-/issues/1))。したがって、後述の完了条件チェックリストは業界標準の再現ではなく、断片的な知見からの合成であり、そう断って提示すべきである。引き渡し内容として実際に挙がっていたのは、問題と調査、提案解、使用コンポーネント、成功指標、MVC分解、デバイスとモードの網羅、エラーと空状態、ユーザーフロー、動画説明である(同 issue 2570)。エンジニア側の不満は、ロード、空、エラー、権限の状態、ブレークポイント間の挙動、根拠の欠落に集中する(ベンダーと実務ブログ由来のため【弱】:[Figr](https://figr.design/blog/developer-handoff-playbook-tools-templates-and-best-practices-for-cross-functional-teams)、[Sizzy](https://sizzy.co/blog/design-to-dev-handoff))。

主要な中間成果物の選び方は NN/g が整理している。ジャーニーは複数チャネルと感情を含む巨視的なもの、ユーザーフローは単一プロダクト内の操作とシステム応答の微視的なもの、ワイヤフローはそれを画面で描いた仕様形式で、ポップアップやエラーなどの結果状態を明示でき、静的な多ページサイトには向かない([NN/g journeys vs flows](https://www.nngroup.com/articles/user-journeys-vs-user-flows/)、[wireflows](https://www.nngroup.com/articles/wireflows/))。コンテンツ優先順位ガイドは、レイアウトを含めずに画面の内容を実文言つきで重要度順に並べる成果物で、開発者にはHTML構造の手がかり、テスターには早期のチェックリストになる([A List Apart](https://alistapart.com/article/priority-guides-a-content-first-alternative-to-wireframes/))。画面一覧の権威ある雛形は見つからなかった。出てくるのはコミュニティ製スキルの列定義(ID、画面名、対応要件、遷移元と遷移先など)と「要件→画面、画面→要件の双方向対応」だけである(【弱】:[prd-v04 skill](https://smithery.ai/skills/mattgierhart/prd-v04-screen-flow-definition))。対象物から画面を導く OOUX(Sophia Prater)は、Prater 自身の説明で4ラウンド(発見、要件、優先順位付け、見直し)とされ、画面を扱うのは最後のラウンドである。名詞(対象物)をまず決め、対象物×対象物のネステッド・オブジェクト・マトリクスで関係を、役割×対象物のCTAマトリクスで動詞と権限を、オブジェクトマップで属性を定義する。各関係は「Mechanics, Cardinality, Sorting and Filtering, Dependency」の合言葉で点検し、ナビゲーションは対象物の階層に従い、件数が多ければ並べ替えと絞り込みが要る([InfoQ podcast](https://www.infoq.com/podcasts/object-oriented-ux-sophia-prater/)、[ALA](https://alistapart.com/article/ooux-a-foundation-for-interaction-design/))。ただし「対象物から画面を機械的に導く」アルゴリズム自体はどの資料にもなく、本設計の導出規則は【独自】である。

### 規模による省略の判断基準

規模調整の一次資料に数値基準はない。得られた原則は3つで、時間と予算を先に固定して範囲を動かす(Shape Up のアペタイト)、決定を変えうる最安の手法で最大の不確実性を減らす、そして「何もしないよりは小さな検証」(Nielsen の割引ユーザビリティ。3〜5人のテストや10項目のヒューリスティック評価。5人で問題の約85%、複数の別グループがあれば群ごとに3〜4人)である([Shape Up ch.3](https://basecamp.com/shapeup/1.2-chapter-03)、[NN/g Guerrilla HCI](https://www.nngroup.com/articles/guerrilla-hci/)、[NN/g 5 users](https://www.nngroup.com/articles/why-you-only-need-to-test-with-5-users/))。GitLab も、確信が高ければ設計や解の検証を省くことがあると述べている([GitLab Product Design Operations](https://handbook.gitlab.com/handbook/upstream-studios/product-design/operations/))。これらを合成した判断基準を次に示す【推論+独自】。

| 判断軸 | 工程を深くする条件 | 縮める条件 |
|---|---|---|
| 間違いの損失×戻しやすさ | 金銭、健康、不可逆データ | 可逆で個人利用 |
| ロール数 | 権限の異なる2種類以上(ロールが調査とテストの乗数になる。NN/g の群別3〜4人の例外に基づく) | 1ロール |
| 規制・機微データ | 要配慮個人情報、金銭移動 | なし |
| ドメインの不慣れ | 作り手が現場を知らない | 作り手自身が利用者 |
| チーム人数 | 2人以上(共有成果物が必須) | 1人 |
| 既存フローの改善か | 先に診断(計測)が要る。NN/g は、データが示さない限り全面再設計せず漸進改善とする([NN/g](https://www.nngroup.com/articles/radical-incremental-redesign/)) | 新規は診断不要 |

縮めてよいが消してはいけない工程は、実務の失敗談が示す。状態一覧(空、ロード、エラー、部分、権限なし)、失敗経路を含む通し1本のフロー、着手前の3〜5人検証は「安いのに最も落とされる」ものである(推論。事後検証の定量資料はなく、Healthcare.gov は UX 成果物の欠落ではなく通しテストの不足の事例で、過大に使わない:[Nextgov](https://www.nextgov.com/cio-briefing/2013/10/health-exchange-website-failures-were-both-predicted-and-predictable/71762/))。スケール別の行列を4.4に示す。

## 2. 既存スキルは「何を」書くが「どの形で、何から」を固定しない

全クローン実読の結果(2026-10-20時点)を要約する。

| スキル | 型 | 中身 | 弱点 |
|---|---|---|---|
| pablostanley/designteam-app ux-designer(77行) | 役割プロンプト | 「ハッピーパス、エラー、エッジの順」。成果物名のみ(フロー図、IA、ワイヤーフレーム、状態一覧)。品質チェックに「全画面にロード/空/エラー」 | 成果物にテンプレートがない。チェック対象の画面一覧を生成する仕組みがない。researcher が「実ユーザーの引用」を要求するが、手に入らないときの手順がなく捏造の誘因になる。評価はCLIのみで、UX出力の評価はない |
| Teslasoft ux(約1.1万行、6スキル) | 百科事典型 | ダブルダイヤモンドの工程対応、引き渡し表、フロー例、ヒューリスティック | 出力の形を縛らない。「15人のカードソート」等、Claudeには実行できない前提。オーケストレーションの呼び先名が実ディレクトリ名と食い違う。ライセンスがMITと商用の二重で内部矛盾 |
| owl-listener jobs-to-be-done(約30行) | 役割プロンプト | 7ステップと「When/I want/So I can」の一行形式 | 出力スキーマも証拠規則もなく、データがなければ job map を作文する。同集合のペルソナ系は研究に基づくよう述べつつ名前・写真・引用の欄を要求する。ただし `start-here` ルーターは「1問だけ聞く」「迷えば上流側を選ぶ」と優れる |
| borghei product-designer(305行) | 役割+生成スクリプト | 「Clarify First」(重要な2〜3点だけ聞き、お任せなら成果物冒頭に仮定を列挙) | 検査点が「エラー状態1つ」と弱い。ペルソナ「Sarah」の例や SaaS 固定のジャーニー生成が、データなしで体裁だけ整える。Commons Clause で再利用に制約 |
| anthropics/frontend-design(後段) | 視覚実装 | 入力は「ブリーフ」のみ。主題、対象、主要な仕事を自分で補い、色4〜6個、書体、ASCIIワイヤーの計画を立てる。ブリーフが指定した方向は「ブリーフの言葉が常に勝つ」 | 画面一覧、フロー、状態、データを要求しない。構造は自分で作り話にする |
| julianoczkowski/designer-skills | ファイル連鎖型 | grill-me → brief → IA → tokens → tasks。`.design/<slug>/` に残し、次のスキルが読む。「コードで答えが出る質問はコードを読む」「質問ごとに推奨回答を添える」 | IA と brief に空、ロード、エラーの要求がなく、状態は実装タスクにしか出ない。証拠ラベルなし、質問の打ち切り規則なし |
| pbakaus/impeccable | ルーター型 | PRODUCT.md は確認済み事実と明示した未決事項のみ。質問は1ラウンド2〜3問が既定、「推測を断言して訂正を促す」。規模に応じ「落ち着いていれば3〜5行」。振る舞いの評価(読み込み契約と起動)を持つ | UX構造(フロー、IA、画面一覧)の方法が薄く、状態は質問項目どまり。導入が重い |

(出典はすべて各リポジトリの実ファイル。pablostanley は commit 2eb77e2、Teslasoft は 596bb77、owl-listener は 9a6930c、borghei は 4a698e8、julianoczkowski は c259656、impeccable は dad8dbb。[designteam-app](https://github.com/pablostanley/designteam-app)、[Teslasoft](https://github.com/teslasoft-de/claude-skills-marketplace)、[owl-listener](https://github.com/Owl-Listener/designer-skills)、[borghei](https://github.com/borghei/claude-skills)、[frontend-design](https://github.com/anthropics/skills)、[julianoczkowski](https://github.com/julianoczkowski/designer-skills)、[impeccable](https://github.com/pbakaus/impeccable)。)

調査担当の総括は次のとおり。成果物は名前だけで列定義がない。証拠と仮定の区別は規則はあるが機構がない。非ハッピーパスは最後のチェック項目に追いやられ、「画面一覧を導出する」仕組みがない。規模調整は専門家の人数や「工程を飛ばすか聞く」にとどまる。後段への引き渡しは、ファイルを次のスキルが読む julianoczkowski と impeccable 以外は暗黙である。評価を持つのは impeccable だけで、「計画した抜け(状態の欠落)を検出できるか」を試す評価はどこにもない(以上、一覧は調査担当者の合成)。さらに、使えるが乗っ取れない点として、Vercel の web-design-guidelines は実行時に可変URLから規則を取得するため再現性とインジェクション面に問題がある。ライセンスは、MIT系(owl-listener、Laith、ibelick)、Apache-2.0(julianoczkowski、impeccable、anthropics)は翻案できるが、borghei(Commons Clause)と Teslasoft(二重)は避け、本スキルは全て「アイデアのみ、文面は新規執筆」とし ADOPTIONS.md に記録する、が安全である。

超える方向は6つ。(1)成果物の契約(フィールド名と完了条件)を第一級にする。(2)証拠ラベルを機構にする。(3)画面と状態を導出で網羅する。(4)質問規約を「読めるものは読む、推奨既定値を添える、上限を置く、仮定を記録する」の組み合わせにする(現状、個々の要素は別々のスキルにあるが組み合わせたものはない)。(5)規模で出力サイズを変える。(6)計画的な抜けを埋め込んだ評価で検査力を測る。

後段の視覚スキルとの関係で注意が要る点がある。impeccable と Hallmark は、製品把握の段階で色や書体や雰囲気の希望を聞くことを避ける(impeccable の `init` は明示的に禁止)。一方、frontend-design は指定された方向を厳守する。taste-skill は公開した「代わりにこれを使え」リストが数か月で次の「型」になると指摘する。Anthropic 自身も cookbook で、避けるフォントを挙げた結果 Space Grotesk に収束する現象に触れている([Anthropic cookbook](https://raw.githubusercontent.com/anthropics/claude-cookbooks/main/coding/prompting_for_frontend_aesthetics.ipynb)、taste-skill:[repo](https://github.com/Leonxlnx/taste-skill)、Hallmark:[repo](https://github.com/Nutlope/hallmark))。ここから、引き渡しの視覚部分は「具体値」ではなく方針(トーン、避けたいこと、制約、確定か自由かの旗)にするのが妥当と考える【推論】。また NN/g の AI プロトタイプ試験では、詳細なプロンプトと忠実度の高い添付物ほど出力が良く、曖昧な「プロフィールページ」依頼ではSNS型の誤パターンが生まれ、主要コンテンツが押し下げられた。後段が失敗する典型は、パターン名、内容の優先順位、グルーピング、実データの欠落である([NN/g](https://www.nngroup.com/articles/ai-prototyping/)、[NN/g prompts](https://www.nngroup.com/articles/vague-prototyping/))。上流の引き渡しはそこを埋める設計になる【推論】。なお、構造化ブリーフがLLMのUI品質を上げることを単独で検証した研究は見つからなかった。効果の主張は実務レベルであることを正直に書くべきである。

## 3. AIの失敗は「もっともらしさ」に集中し、検査可能な対策に変換できる

AI 特有の失敗は、証拠の強さが異なる。強いのは合成ユーザーの問題である。NN/g は、合成ユーザーが追従的で、優先順位を持たず、過去の行動に関して信頼できないと報告し、用途を準備作業(仮説、インタビューガイドの試験)に限定せよとする。「全コースを修了した」と答える合成学習者、実ユーザーが避けた掲示板を高く評価する合成ユーザーなどが例である([NN/g Synthetic Users](https://www.nngroup.com/articles/synthetic-users/))。LLM が生成するペルソナには年齢、職業、悩み、米国への偏りがあり、「信じられるように見える」ことは代表性を意味しない(検索要約のみ:[Salminen CHI 2024](https://osuva.uwasa.fi/handle/11111/2726))。「ステレオタイプにするな」という指示は効かない([Gupta et al.](https://arxiv.org/abs/2311.04892))。ホモジナイズ(出力の均質化)では、AIがあると個々の作品は良くなるが全体の多様性が下がり([Doshi & Hauser](https://datadryad.org/dataset/doi%3A10.5061/dryad.qfttdz0pm))、60人の設計者の実験で画像生成AI利用者は最初の例に固着した([Wadinambiarachchi et al.](https://arxiv.org/html/2403.11164v1))。生成UIの定性調査(37人)でも、初稿には有効だが「どのアプリにも当てはまる」汎用性、画面間の不整合、最後の詰め(切り詰め、アクセシビリティ)で弱いと報告された([arXiv 2501.13145](https://arxiv.org/html/2501.13145v1))。追従性は5つのAIアシスタントで確認され([Sharma et al.](https://arxiv.org/pdf/2310.13548))、外部の信号なしの自己訂正は推論を改善しないことがある([Huang et al.](https://arxiv.org/html/2310.01798v1))。ハッピーパス偏重と「機能一覧に飛びつく」ことには直接の実験がなく(否定的結果)、対策は実務的提案にとどまる。質問の側では、モデルは曖昧さを認識していても聞かずに答える傾向があり(【弱】プレプリント:[HF papers 2605.25284](https://huggingface.co/papers/2605.25284))、期待価値で質問を選ぶ手法が質問数を減らしつつ被覆を上げた(【弱】:[papers.cool 2507.10445](https://papers.cool/arxiv/2507.10445))。

| 失敗 | 証拠の強さ | 本スキルの機構(検査できる形) |
|---|---|---|
| 捏造したペルソナ・引用・統計 | 強い | 証拠ラベル必須。OBSERVED は人間が渡したファイル/URLがある場合のみ。名前、顔、年齢、引用、数値の作文を禁止。全項目 ASSUMED のペルソナは「仮説」と題し反証方法を書く。「この成果物で分からないこと」欄を必須にする |
| 平均的で汎用的な出力 | 強い | 方向づけでは名前付きの軸で異なる選択肢を最低3案(中規模以上)。「製品名を入れ替えても成り立つか」テスト。避ける既定値は理由付きのときだけ許す |
| 依頼者の案への追従 | 強い(一般) | 依頼(解)と問題文を分ける。解の言葉を含まない問題文(UI名詞のlint)。依頼の延長ではない別の捉え方を1つ。事前検死(失敗する理由3つ)。根拠に結びつかない称賛を禁止 |
| ハッピーパスのみ | 弱い(直接研究なし) | 4.6の網羅機構。失敗の仕方を5つ出す敵対的パス(少なくとも1つは非技術的原因) |
| 機能一覧への飛びつき | 研究なし | 問題文・成功指標・制約が揃うまで機能一覧を書かない。各機能にニーズIDを持たせ、孤立機能にフラグ |
| 聞きすぎ/聞かなさすぎ | 中(プレプリント) | 4.3の質問規約と、曖昧な依頼で「聞くか仮定を明示するか」をテストする評価 |
| 弱い自己レビュー | 中 | 二値の採点表と新しいコンテキストのレビュー担当(サブエージェント)、決定的チェックはスクリプト |
| 冗長な成果物 | 弱い | 成果物ごとの長さ予算、結論先頭、詳細は付録ファイル |

この表の「機構」列は、いずれも出典で効果が確かめられたものではなく、Anthropic のスキル作成ガイドが勧める検証ループ(チェックリスト、検証してから直す、計画を検証してから実行、スクリプトによる決定的検査)に沿った設計提案である([best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices))。

## 4. スキル設計案

名称は `z-design-ux` を提案する(リポジトリの `z-` 接頭辞と作業系の命名に合わせる。`claude`/`anthropic` を含まない)。配置は `skills/z-design-ux/`。SKILL.md は dotclaude の流儀に従い英語で書き、起動語だけ 「」 内に日本語を入れる。テンプレートの見出しは、利用者の言語に訳して出す旨を一節で書く(`z-write-task` の「Heading translations」と同じ運用。dotclaude の CLAUDE.md の規則)。

### 4.1 工程・入出力・完了条件

後ろの工程が前の工程の決定に矛盾したら、その工程に戻る(Garrett の「上位層が下位層をやり直させる」規則を完了条件に使い、凍結はしない)。

| 工程 | 目的 | 入力 | 出力(成果物) | 次へ進む条件 |
|---|---|---|---|---|
| S0 受付と規模判定 | 規模と種別(新規/業務SaaS/既存フロー改善)を決め、聞く前に読む | 依頼文、リポジトリ(PRODUCT.md、DESIGN.md、既存コード)、添付 | `00-intake`: 規模区分、種別、既知事実(ラベル付き)、質問と回答、仮定 | 規模と種別を一文で述べた。読める資料は読了。質問は4.3の上限内で出したか、「お任せ」で仮定を記録した |
| S1 問題設定 | 解を含まない問題と、誰が何を達成したいかを固定する | S0 | `01-brief`: 問題、状況と利用者(ラベル付き)、ジョブストーリー、成功指標、制約、スコープ外、仮定台帳、別の捉え方 | 問題文にUI名詞がない。成功指標が1つ。ジョブストーリー1つ以上で各節に証拠ラベル。仮定上位3つに反証シグナル。別の捉え方が1つ |
| S2 範囲 | 作るもの/作らないものを決める | S1 | `01-brief` に追記: MVP機能(ニーズID付き)、やらないこと、落とし穴、アペタイト | 全機能がニーズIDにつながる。落とし穴を「スローモーション」で歩き、対処済みか範囲外にした |
| S3 対象物と権限 | 名詞と関係と権限を先に決める | S1、S2 | `02-model`: 対象物、関係表(MCSFD点検つき)、役割×対象物×動詞の表、ライフサイクルが要る対象物の状態遷移 | ジョブストーリーの名詞が全て対象物に現れる。「必ず持つ」関係に依存(親の削除時)の答えがある。単一ロールなら理由を書く |
| S4 フロー | 役割ごとの主要フローを失敗分岐つきで書く | S3 | `03-flows`: フロー表(ステップID、操作、システム応答、画面ID、失敗分岐、出口)とMermaid | ジョブストーリーごとにフローが1本以上。全ステップに失敗分岐か「なし:理由」。入口は全て列挙、出口は成功/中止/離脱/エラー、再開を記載 |
| S5 画面 | 画面一覧を導出し、画面ごとに目的・優先順位・状態を書く | S3、S4 | `04-screens`: 画面一覧、画面仕様、状態表 | 4.6の双方向トレースに孤立なし。システム画面の掃引が全行「あり/N/A+理由」。状態表に空欄なし。各画面の主操作が1つ |
| S6 方向性とパターン | 視覚の方針だけを決め、繰り返し要素を台帳化 | S1、S5 | `05-direction`、`06-patterns` | 確定/自由の旗がある。避ける既定値が理由つき。コントラスト方針がある。パターン台帳が画面から抽出されている |
| S7 梱包と検査 | 後段が読める一式にし、検査する | S1〜S6 | `HANDOFF.md`、`coverage` 報告、未決事項 | 検査スクリプトが通る。新しいコンテキストのレビュー採点表が二値で全て合格。未決事項は人が決める項目だけ(最大5) |

既存フロー改善では S1の前に「診断」を置く(4.4)。逆流の例は、S4で新しい名詞が出たらS3へ、S5で孤立した画面が出たらS3かS4へ、S6のトーンが S1 の利用者像と矛盾したらS1へ、である。

### 4.2 成果物テンプレートの骨格(フィールド名)

テンプレートの厳格度は、Anthropic の勧めに従い成果物ごとに明示する(厳格なもの=スクリプトで検査する列、既定+調整=自由記述欄)【独自】。

`01-brief`: `problem`(解の言葉を含めない)/`context`(状況、利用者。各項目 `[tag]`)/`job_stories[]`(`when`/`want`/`so_that`、節ごと `[tag]`)/`success_measure`(1つ、可能なら基準値)/`constraints`(`hard`/`soft`)/`out_of_scope`/`appetite`/`rabbit_holes[]`(対処: パッチ/範囲外/削る)/`needs[]`(ID、動詞形、解を含まない。OBSERVEDが1つもなければ「仮説」)/`features[]`(ID、`need_id`)/`assumptions[]`(`id, statement, category, importance, evidence, disproof_signal, cheapest_test, status`)/`alt_framing`/`premortem[3]`/`cannot_tell_us`/`open_questions_for_human`。

`02-model`: `objects[]`(名前、定義、`core_content`、`metadata`(並べ替え・絞り込みに使う)、`lifecycle`)/`relations[]`(`a, b, mechanics, cardinality, sort_filter, dependency`)/`cta_matrix`(行=役割、列=対象物、セル=動詞と条件)/`roles[]`/`object_states[]`(Mermaid `stateDiagram-v2`)。

`03-flows`: `flow_id, role, job_story, entry_points[], steps[](step_id, user_action, system_response, screen_id, failure_branches[], exit)`と、`exits`(成功/中止/離脱/エラー)、`resume`。

`04-screens`の一覧: `screen_id, name, type(page/modal/drawer/email/system), objects[], roles[], entry[], exit[], source(cta_cell | flow_step), priority(MVP|later), states_ref, open_questions`。一画面の仕様: `purpose`/`primary_action`(1つ)/`content_priority[]`(重要度順。実文言と実データ、最小・典型・最大の長さ)/`actions[]`(→結果)/`role_variants`/`state_matrix`/`copy`(ボタン、エラー、空の文言)/`a11y`(見出し構造、フォーカス順、ターゲットサイズ)/`responsive_intent`(どの幅でも見えるべきもの、折り返すもの)。ここでは色、書体、ピクセル配置を書かない(コンテンツ優先順位ガイドの流儀)。

`05-direction`: `surface_mode`、`subject/audience/primary_job`、`principles[]`(`A_even_over_B, visual_consequence, must_not`)、`tone`(極端な語。「クリーンでモダン」は不可)、`anti_goals`、`rejected_defaults[]`、`references[]`(`url, structural_move, not_carried, why_fits`)、`color_policy`、`type_policy`、`density`、`motion`、`assets_present/absent`、`pinned_vs_free`。

`06-patterns`: `pattern, used_in[screen_id], variants, states, promoted`。

### 4.3 質問規約(何を聞き、何を仮定して明示するか)

原則は「答えが構造や方向を変える問いだけ聞く」である。まず読めるものは読む(コードに答えがあれば聞かない。julianoczkowski)。聞くときは1ラウンド最大3問、各問に推奨既定値を添え、「断言して訂正を促す」形にする(impeccable の「1ラウンド2〜3問、推測を断言」と julianoczkowski の「推奨回答を添える」)。第2ラウンドは重大な抜けが残るときだけ、最大2問。曖昧な依頼では最低1ラウンド聞くか、「お任せ」と言われたら、成果物冒頭に仮定を並べて進む(borghei)。回答不能(無人実行など)のときは、聞かずに進め、未決事項に残す。

必ず聞く(人間にしか答えられない):成功の測り方、実利用者が誰でどう知っているか、ハード制約(プラットフォーム、規制、期限、既存スタック)、すでに試したこと、スコープ外。仮定として明示すれば進めてよい:標準的な操作パターン、アクセシビリティの基準(WCAG 2.2 AA)、文言のスタイル、視覚の既定。この区分は NN/g のステークホルダー面談項目(成功指標、制約と履歴)と GOV.UK の発見の問いから導いた【推論】。上限は規模別(後述の表)で、小規模は1メッセージ・3問・第2ラウンドなし。

3ケースの第1ラウンドの例:家計簿なら「①自分だけで使うか世帯で共有か(既定:自分のみ)②口座連携は入れるか(既定:手入力とCSV)③既存コードや使いたい技術はあるか」。クリニックなら「①対象(診療科、拠点数、1診察室の運営か)②ロール(院長/受付/医師/看護師/患者)と電話予約の扱い③既存の電子カルテ/レセコンとの連携範囲(既定:一方向のみ、v1は連携なし)」。会員登録改善なら「①ファネルの数値(ステップ別完了率)と取得元の有無②主要指標の定義(登録完了か初回価値到達か)③変えてはいけない制約(本人確認、法令、必須項目)」。ここで、データが手に入らなければ「診断計画とヒューリスティック評価」を出し、結論は仮説として扱う。

### 4.4 規模別の圧縮表

R=必須、C=最安の形に圧縮、S=トリガーがなければ省略。トリガーは、不可逆/金銭/健康データなら1段上げる、ロールが2種以上ならロール成果物をRに、チーム2人以上なら共有成果物(フロー、状態)を書く、ドメインが不慣れなら現場調査をRに、トラフィックが少なければA/Bの代わりに前後比較、である(調査担当者の合成)。

| 工程 | 個人の小さなアプリ(例:家計簿) | 業務SaaS(例:クリニック予約) | 既存フロー改善(例:会員登録) |
|---|---|---|---|
| 問題文と成功指標 | R(1段落) | R | R(基準値の計測が先) |
| 診断(ファネル、録画、3〜5人のテスト) | S(公開前) | S(公開後に追加) | R(最悪ステップから) |
| 現場調査・利用者聞き取り | C(自分と身近な1〜2人) | R(受付の観察、ロール別3〜5人) | C(落ちるステップだけ) |
| ペルソナ | S(ジョブストーリーのみ) | C(ロールカード。ペルソナでなく) | S |
| 対象物と権限 | C(対象物リストのみ。共有なら権限表) | R(ロール×対象物×動詞) | S(構造が劣化していなければ) |
| フロー(失敗分岐含む) | R(主要1〜2本) | R(患者と職員を別に) | R(現状と提案) |
| 画面一覧と状態表 | R(圧縮。状態表は必須) | R | R(触る画面のみ) |
| ドメイン規則の明文化 | C | R(枠、二重予約、予約の状態遷移) | S(規則に触れなければ) |
| 規制・データ分類 | C(何を保存しどこにあるか) | R | C(登録で新規取得する項目のみ再確認) |
| アクセシビリティ基準 | C | R(高齢の患者) | R(変更フローのみ) |
| 低忠実度+3〜5人検証 | C(自己・家族) | R | R |
| デザインシステム | S | C(トークンと再利用) | S |
| 方向性 | C(3行) | C | S(既存を継承) |

個人の小規模では、`UX.md` 1ファイル(2ページ程度)に01〜05を圧縮して書く。ただし検査(S7)は同じ強さで走らせる。「規模を落としても網羅の検査は落とさない」ことが、縮めてよい/いけないの線である。

### 4.5 証拠ラベル

記述の各項目に次の4種のどれかを付ける。形式:`[USER]`、`[DESK: URL]`、`[OBSERVED: file/URL]`、`[ASSUMED]`。ジョブストーリーでは節ごとに付ける。これは Gilad の Confidence Meter(自己確信 0.01、他者の意見 0.1〜0.2、逸話 0.5〜1、ユーザー証拠 3、検証結果 4〜5)の考え方を簡略化したもので([Gilad](https://itamargilad.com/the-tool-that-will-help-you-choose-better-product-ideas/)、数値表は二次転記:[Votito](https://www.votito.com/methods/confidence-meter/))、対応は【独自】である:`ASSUMED`=モデルの推測(E0)、`USER`=依頼者の発言(E1。意見は仮定として扱う:GOV.UK)、`DESK`=公開資料。競合、法令、ストアレビューなど(E2。ベンダー資料は `(vendor)` 付記)、`OBSERVED`=人間が渡した一次データ(分析値、問い合わせ記録、テスト結果。E3〜4)。

規則は4つ。AIの記述は、出典を引かない限り常に `ASSUMED`。`OBSERVED` は人間が渡したファイルかURLがあるときだけ付ける。`ASSUMED` が重要度H(間違えば大きい)の項目は「先に検証」として仮定台帳に上げ、「ニーズ」ではなく「仮説」と呼ぶ。引用、年齢や職業つきの名前付きペルソナ、統計の作文は、どのラベルでも禁止する。根拠は NN/g(合成ユーザーの研究:準備作業にのみ使う)と GOV.UK(ユーザー由来でない意見は仮定)である。

### 4.6 網羅の強制機構【独自。出典にある部品の組み合わせ】

(1)対象物→画面の導出:対象物ごとに、一覧、詳細、作成/編集を最低候補とし、一覧の並べ替え・絞り込みは `metadata` から、詳細内の入れ子は関係表の件数から決める。CTA表の各セルは「居場所となる画面とトリガー」を持ち、各ロール列には可視性の確認を要求し、「必ず持つ」関係は作成順序とブロック/空状態を生む。MCSFD(Mechanics、Cardinality、Sorting and Filtering、Dependency)を関係ごとのゲートに使う([InfoQ](https://www.infoq.com/podcasts/object-oriented-ux-sophia-prater/))。(2)システム画面の掃引:認証(登録・ログイン・再設定・確認・SSO/MFA)、初回体験、アカウント、組織/メンバー/権限/招待、課金・上限、設定と連携、通知(アプリ内/メール/プッシュとテンプレート)、検索結果、エラーページ(404、403、500、オフライン、メンテナンス、セッション切れ)、同意と法務、ヘルプ。各行を「あり」か「N/A+理由」で埋める(調査担当者の点検表を出発点とする【推論】)。500ページは「入力内容がどうなったか」を述べる必要がある([GOV.UK](https://design-system.service.gov.uk/patterns/problem-with-the-service-pages/))。(3)フロー↔画面の双方向トレース:全ステップが画面IDを持ち、全画面が少なくとも1つのCTAセルかフローステップを出典に持つ。孤立が1件でもあれば不合格。(4)画面×原因クラスの状態表:列は、通常、初回の空、期間内データなしの空/クリア後、検索結果なし、ロード(初回/更新/ページング/個別操作)、部分、エラー(項目/フォーム/区画/ページ、「入力は保存されたか」付き)、警告(失敗前)、権限なし/読み取り専用、プラン/上限による制限、設定が必要、オフライン/低速、古い/競合、セッション切れ、破壊的操作(確認/元に戻す)、内容の極端(0/1/多、長文、翻訳による伸び)。各セルは「設計済み(参照)」か「N/A+理由」で、空欄は不合格。状態はブール値の組ではなく、データ領域ごとに1つの列挙型で書く(矛盾した組み合わせを禁じる。Dodds の紹介する「不可能な状態を不可能にする」:[Dodds](https://buttondown.com/kentcdodds/archive/make-impossible-states-impossible))。根拠は Hurff の5状態(通常、空、エラー、部分、ロード:[Hurff](https://www.scotthurff.com/posts/why-your-user-interface-is-awkward-youre-ignoring-the-ui-stack/))、Carbon の空状態分類([Carbon](https://carbondesignsystem.com/patterns/empty-states-pattern/))、GitLab Pajamas の「設定が必要」「上位プラン限定」の区別([Pajamas](https://design.gitlab.com/patterns/empty-states))、NN/g のエラーメッセージ14指針([NN/g](https://www.nngroup.com/articles/error-message-guidelines/))で、「オフライン」「競合」「セッション切れ」「上限」の列は一次資料が弱く推論である(Atlassian のエラー文言、W3C の翻訳による文字数の伸びなどの部分的な裏付けはある:[Atlassian](https://atlassian.design/foundations/content/designing-messages/error-messages)、[W3C](https://www.w3.org/International/articles/article-text-size))。(5)敵対的パス:各主要フローで「実ユーザーが失敗する5通り(少なくとも1つは非技術的:誤解、中断)」を書き、フローに反映する。(6)検査スクリプト `scripts/check_package.py`:ID解決、双方向トレース、状態表の空欄、証拠ラベルの有無、仮定台帳の列、問題文のUI名詞、孤立機能を決定的に検査する。未検証で、実装時に動作確認が要る。

フォーム/登録系にはさらに規則を足す。1問1ページの方式(GOV.UK:[question pages](https://design-system.service.gov.uk/patterns/question-pages/))、確認画面での修正リンク、エラーサマリと項目内エラーの併用は、行政など向けの規範である。一方、検証のタイミングは出典間で割れており、Baymard と NN/g は項目を離れたとき、GOV.UK と日本のデジタル庁デザインシステムは送信時で、後者は入力中のレイアウトずれを理由にする([Baymard](https://baymard.com/blog/inline-form-validation)、[GOV.UK](https://design-system.service.gov.uk/patterns/validation/)、[DADS](https://design.digital.go.jp/dads/components/input-text/usage/))。スキルは黙って選ばず、フォームごとに検証タイミングを決めて理由を書かせ、割れていることを明記させる【推論】。

### 4.7 引き渡しパッケージと方向性、デザインシステム

引き渡しの主目的は、後段(frontend-design 等)と開発者が「見た目の実行だけ」できる状態にすることである。`HANDOFF.md` は索引(読む順、各ファイルの要点)と、貼り付けて使える1ページの実装ブリーフ(主題、対象、主要な仕事、画面ごとの主要要素、状態、方向性、確定/自由の旗、未決事項)を持つ。frontend-design は「ブリーフの言葉が常に勝つ」と述べるため、確定した方向は命令形で書き、自由な軸を明示し、実装者が勝手に決めてはいけない未決事項(impeccable の「builder must not invent」)を一覧にする。画面一覧と状態表は frontend-design が要求しない情報で、自己レビュー(スクリーンショットでの確認)が「趣味」だけでなく「画面と状態の完全性」も検査できるようにする【推論】。

視覚の方向性は、方針(トーン、避けたい既定値、参照の構造的な動き、色・書体の方針、密度、動き)までとする。トーンは「クリーンでモダン」を禁じ、極端な語か、「Aを優先しBより」の原則で書く(原則は覆せるものだけ。Matt Strom の4条件と Keith のテスト:[Strom](https://mattstromawn.com/writing/principles)、[Frost](https://bradfrost.com/blog/link/in-the-future-design-principles-wont-be-about-design/))。NN/g も、競合との差、トレードオフの立場、10個未満を求める([NN/g](https://www.nngroup.com/articles/design-principles/))。参照は URL、借りる構造、借りないもの、なぜ合うかの記録で、参照は競合UIより主題の世界(素材、現場の書類、看板)を優先する(Mall の視覚インベントリ、impeccable、taste-skill の考え方。ギャラリー利用の一次資料はなく、使い方は推論:[Hooked on Code](https://hookedoncode.com/2015/02/so-what-do-i-make-by-dan-mall-notes-from-an-event-apart-talk/))。色は役割(面、文字、アクセント、境界、危険/成功、フォーカス)とコントラスト基準(WCAG 2.2 AA、通常文字4.5:1、大きい文字3:1。[W3C](https://www.w3.org/WAI/WCAG22/Understanding/contrast-minimum.html))を方針とし、具体値は、ブランドの制約があるときだけ確定として渡す。WCAG 3 はまだ草案で、APCA は補助にとどめる([W3C](https://www.w3.org/WAI/WCAG3))。

デザインシステムは先に作らない。方向性の段階で作るのはトークンの原始値と意味づけ(面、文字、アクセント等)の方針までで(DTCG形式はJSONで、階層は規格ではなく慣習:[DTCG draft](https://www.designtokens.org/tr/drafts/format/))、コンポーネントは S5 の画面から抽出する。Frost の「実プロジェクトの画面と並行して育てる」「ブラウザに入れたらブラウザに留める」が根拠で、既存UIの棚卸しに相当するのが、新規製品では画面からの「パターン台帳」である([Atomic Design ch.4](https://atomicdesign.bradfrost.com/chapter-4/)、[interface inventory](https://bradfrost.com/blog/post/interface-inventory/))。2〜3回目の出現で名前を付けて昇格させる、という閾値は出典がなく【独自】で、調整してよい。

### 4.8 ファイル構成(1行の役割つき)

```
skills/z-design-ux/
  SKILL.md                      # 起動条件、8工程と完了条件、判断基準、「いつ何を読むか」(目標150行、上限500行)
  EVALS.md                      # 評価プロンプトと判定可能なチェック(z-write-task の形式)
  references/
    intake-and-questions.md     # S0: 規模判定、読む順、質問規約と推奨既定値、「お任せ」時の扱い
    scaling.md                  # 規模別の圧縮表、トリガー、「縮める/消さない」の線
    evidence.md                 # 証拠ラベル、禁止事項、仮定台帳、合成ユーザーの扱い
    s1-s2-frame-and-scope.md    # 問題設定と範囲の方法と`01-brief`テンプレート
    s3-model.md                 # 対象物、関係(MCSFD)、CTA表、状態遷移の方法とテンプレート
    s4-flows.md                 # フロー表、Mermaid(制限した書式)、敵対的パス
    s5-screens-and-states.md    # 導出規則、システム画面の掃引、状態表の原因クラス、画面仕様
    s6-direction-and-patterns.md# 方向性テンプレート、参照の記録、パターン台帳、トークンの範囲
    s7-handoff-and-review.md    # HANDOFF.mdの形、二値の採点表、未決事項の書き方
    existing-flow-mode.md       # 既存フロー改善: 診断、現状/提案フロー、計測計画
    domain-checks.md            # 家計簿、予約・業務SaaS、会員登録の「プロが落とさない点」(要検証の注記付き)
    sources.md                  # 規則→出典→ライセンスの表(z-writing-for-readers の流儀)
  scripts/
    check_package.py            # 構造検査(ID解決、双方向トレース、状態表の空欄、ラベル)
```

SKILL.md から直接リンクし、参照は1階層に収める。100行を超える参照ファイルには目次を付ける(best practices)。SKILL.md の冒頭100行に工程と完了条件を置くのは、圧縮後に再添付されるのが先頭約5,000トークンだけという制約への対処である([Claude Code docs](https://code.claude.com/docs/en/skills))。

### 4.9 スキル作成要件への適合

公式要件の要点:`name` は64文字以下で小文字・数字・ハイフン、ディレクトリ名と一致。`description` は1,024文字以下で「何を」と「いつ」を三人称/命令形で書く。Claude Code の一覧では description と when_to_use を合わせて1,536文字で切られ、主要な用途を先頭に置く。本文は500行未満、参照は1階層、100行超の参照に目次([best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)、[spec](https://agentskills.io/specification)、[Claude Code docs](https://code.claude.com/docs/en/skills))。説明は押しが強めでよい(Claude は起動不足になりがち)、意図を書き、隣接スキルとの境界を明記する([optimizing descriptions](https://agentskills.io/skill-creation/optimizing-descriptions))。評価駆動で作る:先にスキルなしで失敗を確認し、少なくとも3つの評価、複数モデルでの試験([best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices))。`disable-model-invocation: true` は付けない(説明が文脈から消えて自動起動できない)。YAML の先頭の説明に `: ` を含めて引用しないと frontmatter が壊れ、スキルが黙って読み込まれなくなった実例があるため、説明は引用符で囲む([taste-skill CHANGELOG](https://github.com/Leonxlnx/taste-skill))。命令形で書き、各規則に理由の一節を付け、「ALWAYS/NEVER」の連呼を避け(skill-creator)、dotclaude の「エージェント向け文章」の規則(実在するコマンドとパス、1つの事実は1か所)に従う。判断が主の工程は高い自由度、出力テンプレートは中程度、構造検査は低い自由度(スクリプト)に分ける。

「アプリを作りたい」「画面を考えて」「UXを設計して」で frontend-design より先に起動させるための説明の案(英語、約900字。実測は未確認):

> Design the UX before any UI is built: turn a rough app or feature idea into a handoff package (problem and users, objects and roles, user flows, screen list with per-screen priorities and states, visual direction) that a UI-implementation skill such as frontend-design, or an engineer, can build from. Use it whenever the intent is to decide what to build and how it should work before screens or code exist: "I want to build an app", "what screens does this need", "design the UX", "user flow", "information architecture", 「アプリを作りたい」「画面を考えて」「UXを設計して」「画面遷移を考えて」「会員登録の離脱を改善したい」, even if the user never says "UX". Also use it when an existing flow should be improved and the cause of the drop-off is not yet known. Run it before frontend-design or any UI coding. Not for styling, typography, or writing components (frontend-design), not for throwaway prototypes (z-prototype), not for filing tickets (z-write-task).

どの説明が競合時に優先されるかの公式規則はなく、複数の一致時の順序を決める仕組みもない(Claude Code の名前衝突規則は別名のスキル間を決めない)。よって「先に起動する」は説明の鋭さと境界文だけでは保証できず、実測で確かめるしかない。frontend-design が読み込まれたとき「UX設計がなければ先に本スキルを走らせる」という一行を本スキル側と利用側のCLAUDE.mdに置くこと、それでも不足ならフックを検討することを提案する。「必ず起きること」は文章でなくフックで担保するのが Anthropic の整理である([Claude Code docs](https://code.claude.com/docs/en/skills))。

### 4.10 借用と独自の区分

| 要素 | 借用元 | 独自の部分 |
|---|---|---|
| 5層と「戻る」規則 | Garrett | 完了条件を「次の層の決定と矛盾しない」とした運用 |
| 問題→範囲→ブレッドボード→落とし穴→ピッチ | Shape Up | 完了時の自己点検(ユースケースをブレッドボードで歩く)のスクリプト化 |
| 解を含まない問題、制約、仮定は検証対象 | GOV.UK、Linear | 問題文のUI名詞lint |
| ジョブストーリー | Intercom/Klement | 節ごとの証拠ラベル |
| 対象物→画面の素材(ORCA、MCSFD) | Prater/OOUX | 導出規則(対象物とCTAセルから画面を導く)は独自 |
| 状態表 | Hurff、Carbon、Pajamas、NN/g | 原因クラスの列、空欄不可、列挙型 |
| 質問(読んでから聞く、推奨既定値、1ラウンド2〜3問) | julianoczkowski、impeccable、borghei | 規模別の上限と必須/仮定の区分の統合 |
| 引き渡しのファイル連鎖 | julianoczkowski、impeccable | 引き渡し契約と検査、frontend-design の読み方に合わせた命令形 |
| 検証ループ | Anthropic のスキル作成ガイド | 敵対的パス、二値の採点表、計画的な抜けを埋めた評価 |
| 証拠の階層 | Gilad、GOV.UK、NN/g | 4ラベルと運用規則 |
| パターン台帳 | Frost の棚卸し | 画面からの抽出と閾値(2〜3回) |

## 5. 評価3ケース:プロが落とさない点(採点の表明候補)

スキルあり/なしの比較は、skill-creator の手順(同一ターンでサブエージェント2つ、クリーンな文脈、成果物を保存)で行い、判定可能な表明(アサーション)を事前に書く。品質の主観的な部分は人間のレビューに残す(agentskills.io の評価ガイド)。下の項目は、各ケースで「プロなら落とさない」ことの候補で、出典のある事実は URL 付き、調査担当者の推論は【推論】とする。いずれも判定は成果物の記述を読んで決められる形にしてある。

### ケース1:家計簿アプリ(曖昧な依頼)

- 解を作る前に、目的(何を知りたい、何を変えたい)と使い手(自分だけか世帯共有か)を、1ラウンド3問以内で聞くか、仮定として冒頭に明示している(上限規則と「お任せ」規則の検査)。
- 口座連携を既定で入れず、手入力+CSVを既定とし、連携を選ぶ場合の論点(電子決済等代行業の登録、スクレイピングと API の違い、連携停止時の扱い)を未決事項にしている。2026年のマネーフォワードの連携停止は、連携が銀行単位で止まりうることを示す([ITmedia](https://www.itmedia.co.jp/news/article/2606/02/1260602097/2))。法的結論は未検証。
- 中核ループ(入力→分類→見直し→予算残)と「開いてから記録までの操作数」を設計の指標にしている【推論】。入力の負担は主要な課題とされる:分類の細かさ41.7%、日々の入力37.1%、レシート整理34.4%、望まれるのは「入力が簡単」(ベンダー調査 n=300【弱】:[ASCII](https://ascii.jp/elem/000/004/401/4401241/))。
- 「中断と再開」を設計している。パーソナル・インフォマティクスの研究は、追跡は採用か離脱かではなく中断と再開で、忘却、維持の負担、スキップ、一時停止の4種の中断を挙げる。金融の追跡は活動や位置より定着しやすかった(3か月以内の放棄26%対44%と45%、米国MTurk、2015年:[Epstein et al.](https://my.eng.utah.edu/~cs5540/au16/readings/PersonalInformatics-Epstein2015.pdf))。「家計簿は最も続かない」という断定は、この論文では支持されない。2週間空けて戻った人の画面(責めない、後から埋める、一時停止してもデータを失わない)がある【推論】。
- 画面が対象物(取引、カテゴリ、口座/支払手段、予算、期間、(共有なら)メンバー、定期)から導かれ、初回の空、期間内データなし、予算未設定、予算超過(警告)、誤入力の修正と元に戻す、重複、長いカテゴリ名、返金や負の金額、月またぎ/締め日、円表記が、状態表に埋まっている【推論】。
- 登録の壁を後ろにし、最初の1件の入力を先にさせる案を検討している(NN/g と Wroblewski:[NN/g](https://www.nngroup.com/articles/login-walls/)、[LukeW](https://www.lukew.com/ff/entry.asp?1128)。ただし同期のためアカウントが要るなら「個人サービス」の例外)。
- ペルソナの名前・年齢・引用を作文せず、利用者は `ASSUMED` と書く。「追跡で責められる感じ」を避けるトーンを方針に入れる(自己追跡で判断された感覚から離脱する例:[PMC5428074](https://pmc.ncbi.nlm.nih.gov/articles/PMC5428074)。食事など別領域)。
- 書き出した出力に実装コードや見た目の色・フォントの確定値がない。

### ケース2:小規模クリニックの予約管理SaaS

- 要配慮個人情報(病歴、診療情報)と3省2ガイドラインを前提に、**医療情報システムの安全管理に関するガイドラインは第7.0版(令和8年6月)**で、第6.0版ではない。システム運用編は、利用者の識別と認証、部署別の権限付与、ID台帳の棚卸し、アクセスログの収集とレビュー、二要素認証(令和9年4月時点で稼働予定のシステムで新規導入や更新時)、パスワード規則を定める([MHLW 7.0 システム運用編](https://www.mhlw.go.jp/content/10808000/001716295.pdf)、[改訂の概要](https://www.mhlw.go.jp/content/10808000/001102596.pdf))。SaaS では責任分界を事業者と合意する必要がある([企画管理編](https://www.mhlw.go.jp/content/10808000/001716292.pdf))。事業者側は総務省・経産省の2省ガイドライン第2.0版。予約専用ツールがどこまで「医療情報システム」に入るかは資料で確定できず、未決事項に挙げるべき。条文番号は引用前に確認を要する。
- 個人アカウント(共有の受付ログインなし)、ロール別権限(院長/受付/医師/看護師と患者)、ロール×対象物×動詞の表、ユーザーのライフサイクル(招待、変更、退職の即日停止、最後の管理者の保護)、アクセスログ(患者詳細の閲覧を含む)、ID棚卸し画面。患者通知に診断名を入れない(推論:要配慮個人情報がLINE/SMSで外に出る)。
- 患者フローと職員フローを別に設計している。患者の入口は初診/再診/当日で分けるのが一般的で(ベンダー):予約の型は順番/時間/時間帯の3種で、診療科で適性が違い、混在する医院には並走が要る([Medicom Park](https://www.phchd.com/jp/medicom/park/idea/management-reservationsystem)、[MEDISMA](https://medisma.jp/column/reserve010/)、いずれもベンダー【弱】)。
- 予約枠モデル(診察室/医師/メニュー別の時間、初診と再診の長さ、休診、ブロック)と二重予約・同時操作の規則、予約の状態遷移(誰がどの遷移を起こせるか)を、画面より先に文書化。状態名の標準リストは出典がなく、作文しない。
- 電話予約の入力、当日飛び込みの挿入、緊急後の一括後ろ倒し、突然の休診での一括キャンセルと影響を受ける予約のプレビュー、CSVの取り込みと書き出し(ベンダー記事が挙げる評価観点:【弱】)。
- リマインド(キャンセル用リンク、キャンセル規定の事前表示、空いた枠の再公開)。リマインドの最適時刻やキャンセル料の効果は出典が弱く、断定しない。単一施設の介入研究が無断キャンセル率の低下を報告するにとどまる([UT Southwestern](https://utsouthwestern.elsevierpure.com/en/publications/a-multi-method-intervention-to-reduce-no-shows-in-an-urban-reside))。
- 高齢患者の基準(大きい文字、広い押下領域、寛容な入力:[NN/g](https://www.nngroup.com/articles/usability-for-senior-citizens/))、電話や窓口の併用、代理予約(保護者や介護者)、きょうだい同時予約、名寄せ(重複患者)、診察券番号、緊急症状の注意書き、システム停止時の紙の代替。
- 組織の初回設定(拠点、診療科、診察室、医師と週間シフト、予約種別と時間、休診、通知チャネルとテンプレート、キャンセル規定、問診、スタッフ招待、予約URLの公開)、設定変更が既存予約に与える影響のプレビュー、複数拠点の切り替え、契約終了時のデータ書き出し。
- 受付の業務を3〜5人観察する、という最安の現場調査を計画に入れている(NN/g の複雑なアプリ向け戦略:[NN/g](https://www.nngroup.com/articles/strategies-complex-application-design/))。

### ケース3:離脱が多い会員登録フローの改善

- 再設計の前に診断を置く。ステップ別の完了率とセグメント(デバイス、新規/再訪、流入元)、項目別の分析(滞在、エラー、放棄)、最悪ステップの録画5〜10本、3〜5人のテスト、ヒューリスティック評価、仮説の影響×労力の順位付け。数値が渡されなければ診断計画を出し、結論を仮説として扱う。NN/g は、データが支持しない限り漸進改善とする([NN/g](https://www.nngroup.com/articles/radical-incremental-redesign/))。
- 主要指標を「フォーム送信」ではなく初回の意味ある行動までの登録完了とし、ガードレール(メール確認の完了、有効化、問い合わせ、不正、後の継続、ログイン成功)、検出したい最小効果と標本サイズ、満週サイクル、途中で止めない、サンプル比のずれ検査、低トラフィックなら前後比較。これらは Kohavi と Evan Miller の考え方の合成(指標名は調査担当者の合成:[Evan Miller](https://www.evanmiller.org/ab-testing/sample-size.html))。
- 項目の棚卸し(各項目に必要な理由)、アカウント作成の後ろ倒し、パスワード規則は先に提示し緩く(Baymardの数値は EC の購入での値で類推として扱う。アカウント強制による放棄18%、複雑すぎる規則が82%のサイトなど:[Baymard](https://baymard.com/lists/cart-abandonment-rate)、[passwords](https://baymard.com/blog/password-requirements-and-password-reset))。日本の「離脱の5〜7割」「1項目減らせば2%」は出典不明のEFOベンダー主張で採用しない(【弱】)。
- メール確認とSMS認証(再送、期限、別の受信箱、迷惑メール/キャリア遮断)、既存アカウントの検出、パスワード再設定の失敗経路、登録後の初回画面。再設定メールの遅延は EC の検証で大きな離脱要因だった([Baymard](https://baymard.com/blog/password-requirements-and-password-reset))。
- 日本語の入力:全角/半角を許容して正規化(制限しない)、郵便番号からの住所補完と手動の代替、電話番号とメールの空白・ハイフンの許容、プレースホルダーでなく補助テキスト、「必須/任意」の表記、フリガナは事業上の必要で決める(デジタル庁デザインシステム:[DADS](https://design.digital.go.jp/dads/components/input-text/usage/)。要約経由のため原典を確認)。検証タイミングの出典間の食い違い(4.6)を明記している。
- 外部ログイン(Google/Apple/LINE)は置き換えでなく選択肢とし、共有される情報を明示(根拠はベンダー資料と論文の要約のみ【弱】)。WCAG 2.2 の「アクセシブルな認証」「冗長な入力」「ターゲットサイズ24px以上」を点検([W3C](https://www.w3.org/WAI/standards-guidelines/wcag/new-in-22/))。
- 現状フローと提案フローを並べ、構造が劣化していなければペルソナ、IA、コンセプトの作業を省くと明記し、やらないこと(全面再設計等)を書く。

### 起動の評価(別枠)

実質的な複数ステップの依頼で、should-trigger を8〜10件、近いが別の依頼(「このボタンをもっときれいに」「CSSのバグを直して」「Figma のログインフォームを実装して」)を should-not-trigger として8〜10件用意し、各3回走らせる。frontend-design が読み込まれた環境で、どちらが先に呼ばれたかも記録する(agentskills.io の手順:[optimizing descriptions](https://agentskills.io/skill-creation/optimizing-descriptions))。単純な一手の依頼は、説明が一致しても起動しないことがあるため、試験には実質的な依頼を使う。

## 6. ノート間の訂正と未確認事項

訂正:医療情報システムの安全管理ガイドラインは、2026-10-20時点で**第7.0版(令和8年6月)**が最新である。第5.0/6.0版を最新とする記述(ノート05)は古い(ノート11が一次資料のPDFで確認)。Double Diamond の公開年は、Design Council の公式ページが2004年と述べており、二次資料の2005年は採らない。Garrett の規則は「下位層が終わる前に上位層を終えてはならない」で、「始めてはならない」ではない(ノート01の理解を、ノート09の一次資料が訂正)。NN/g のプロトペルソナは、ペルソナの3類型の記事で確認できた:「新規調査なしでチームの既存知識(または推測)を記録するもの」で、チームの思い込みのエコーチェンバーになりうる([NN/g persona types](https://www.nngroup.com/articles/persona-types/))。MCSFD の展開は「Mechanics, Cardinality, Sorting and Filtering, Dependency」(ノート10。ノート03では未確認)。frontend-design は、古いブログが述べる「大胆な美的方向性」の版ではなく、より新しい71行の版が現行(ノート04)。Baymard のインライン検証の記事は、欠けているサイトの割合を31%と32%の両方で書いており内部で不一致。Epstein らの結果(金融は比較的定着)は、学生の事例(Money Lover:30日後に1割)と食い違い、後者は授業課題の逸話にすぎない。

未確認・弱い点:Garrett の第3〜7章、Dan Mall の「this, not that」(一次資料なし。引用しない)、Nathan Curtis の時期の指針(403)、ISO 9241-210 の本文、OOUX の公式サイト(404。「Object Litmus Test」は検証できず)、参照ギャラリー(Mobbin、Refero 等)の実践の一次資料、クリニック予約UXの質の高い事例、Figma Dev Mode の詳細(検索要約のみ)、構造化ブリーフが LLM の UI 品質を上げるかの実験、Claude Design の効果(ベンダーの主張)。frontend-design の本文は変わりうるため、出荷前に引き渡し形式を再確認する。

## 結論

調査で最も意外だった点は、「証拠の扱い」と「網羅」の両方が、既存スキルでは文章の注意にとどまり、機構になっていないことだった。逆に言えば、ここに機構(ラベルの規則、導出、双方向トレース、状態表、検査スクリプト)を入れ、規模で出力の大きさだけを変える設計は、既存のどのスキルにもなく、また効果は実務的な推論の域を出ない。だから評価を、計画的な抜けを埋めたケースで作り、「あり/なし」の差が出る表明だけを残すべきである。視覚の方向性を「方針」に絞ったことは、後段の汎用化対策が「代わりにこれを使え」を数か月で次の型にしてしまう現象への対応でもあり、上流が構造と事実を、下流が表層を持つ分業の線にもなる。

## 決めてほしいこと(5件)

1. 視覚の引き渡しをどこまで具体にするか。推奨:方針(トーン、避ける既定値、参照の構造的動き、色と書体の役割と基準)+確定/自由の旗までとし、書体や配色の具体値はブランドの制約があるときだけ確定として渡す。根拠は、後段スキルが「代わりにこれを使え」の一覧を数か月で次の型にすると報告している点(taste-skill、Anthropic cookbook)。
2. 「frontend-design より先に起動する」をどう担保するか。推奨:まず説明文と境界文だけで起動評価を回し、先に呼ばれた率が低ければ、CLAUDE.md の一行、それでも不足ならフックを足す。根拠は、競合時の優先順位に公式規則がなく、実測でしか分からない点。
3. 業務SaaS・日本の規制や既存フロー改善などの領域知識をどこに置くか。推奨:単一スキルのまま `domain-checks.md` と `existing-flow-mode.md` に置き、SKILL.md が300行を超えたら分割する。条文番号や数値は「引用前に確認」と注記する。根拠は、規制や数値が改訂されやすいこと(第6.0版から第7.0版への変更が実例)。
4. 引き渡し一式の置き場所と検査スクリプトの採否。推奨:対象リポジトリの `docs/ux/<slug>/` にコミットし(消えて困るものを `~/tmp` に置かない、というこのマシンの規則)、`check_package.py` は最小限の決定的検査だけで入れる。根拠は、Anthropic の指針が、構造検査は決定的スクリプト、判断は高い自由度としている点。
5. テンプレートの言語。推奨:SKILL.md と参照は英語、出力の見出しとラベルは利用者の言語に訳して出す(日本語の利用者には日本語)。根拠は、dotclaude が既存の成果物の言語に合わせる規則と、`z-write-task` の見出し翻訳表の前例。
