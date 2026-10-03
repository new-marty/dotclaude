# Test prompts

Four prompts for checking that `SKILL.md` produces the same thing every time. They are
written down rather than run: putting the pass conditions into words is what finds the
holes in the norm. Run them when the skill is read but the output still varies — with the
skill and without it, and compare.

Each case fails if any check fails. The checks are all decidable by reading the output.

## 1. A request arriving with everything attached

> 請求書のダウンロード機能を作りたい。サポートへの問い合わせが月40件くらいあって、その
> うち請求書の再発行依頼が大半。調べたら pdfkit と puppeteer があって、puppeteer のほう
> が CSS が効くけど重い。InvoiceService に render メソッドを足して S3 に置く形かなと思
> っている。将来はカスタムテンプレートも対応したい。ついでに InvoiceService のテストが
> 薄いのも気になっている。Issue にして。

- [ ] One Story is filed. The library comparison, the `InvoiceService.render` design, the
      custom templates, and the thin tests are **not** in the body
- [ ] The library comparison and the `InvoiceService.render` idea are in the findings
      comment, the latter marked as a candidate. Neither is in the body
- [ ] The custom templates and the thin tests are sorted into the four exits and shown, not
      filed silently and not filed as issues of their own
- [ ] "40 a month" appears rounded with a date, or not at all
- [ ] The title reads as an outcome, not as an instruction to build something
- [ ] Approval is asked for before the tracker's create command runs

Failure looks like: a Design section in the body; three issues filed at once.

## 2. A bug

> 請求書の PDF で合計額が税抜きで出てる。Safari だと出ないけど Chrome だと出る。たぶん
> 通貨のフォーマッタが税率を見てないんだと思う。

- [ ] The title names the symptom, not the fix and not the formatter
- [ ] The suspected cause appears as a suspicion, or not at all — the body separates what
      was observed from what was inferred
- [ ] Steps to reproduce, Expected, and Environment are present, and Environment records
      the browser difference
- [ ] No fix is proposed in the body

Failure looks like: a title like "Fix the currency formatter"; the guess written as fact.

## 3. A Story that turns out not to fit

> #11 やり始めたんだけど、PDF の生成と画面からのダウンロードで結構大きい。あと先に
> `InvoiceService` を分割しないと手が入らない。分けたい。

- [ ] The parent Story's acceptance criteria are read before anything is split
- [ ] Each Task states which of the parent's criteria it satisfies, except the preparatory
      refactoring, whose condition is that behavior is unchanged
- [ ] The vertical slice test is applied out loud: if one Task cannot work without another,
      the split is withdrawn
- [ ] Tasks are filed with `--parent 11`, and the parent is left with no PR of its own
- [ ] No Task is titled after a layer (model, API, UI)

Failure looks like: three Tasks split by layer; an ordinal such as `(1/3)` in a title.

## 4. Filing after the investigation found a fix

> CSV エクスポートで日本語が文字化けするって報告を調べた。Excel で開いたときだけで、
> BOM を付けてないのが原因。`export/csv.ts` の `toCsv` で先頭に `\uFEFF` を足せば直るの
> を手元で確認した。Shift_JIS で出す案も考えたけど、絵文字が落ちるのでやめた。Issue に
> して。

- [ ] The body describes the problem as the investigation left it: Excel shows the CSV
      garbled because it has no BOM — not only "Japanese is garbled in CSV exports"
- [ ] A findings comment is drafted and shown in the same approval, carrying the cause,
      the BOM fix as a candidate with what confirmed it, and Shift_JIS as ruled out with
      its reason
- [ ] `export/csv.ts` and `toCsv` appear in the comment, not in the body
- [ ] After approval, the comment is posted right after the item is created

Failure looks like: a body that restates the original report and nothing else, with the
cause and the fix gone; or the fix written into the body as the plan.
