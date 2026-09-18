# Test prompts

Three prompts for checking that `SKILL.md` produces the same thing every time. They are
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
- [ ] The library comparison is either dropped or placed in a comment, never in the body
- [ ] The custom templates and the thin tests are sorted into the four exits and shown, not
      filed silently and not filed as issues of their own
- [ ] "40 a month" appears rounded with a date, or not at all
- [ ] The title reads as an outcome, not as an instruction to build something
- [ ] Approval is asked for before `gh issue create` runs

Failure looks like: a body over 20 lines; a Design section; three issues filed at once.

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
