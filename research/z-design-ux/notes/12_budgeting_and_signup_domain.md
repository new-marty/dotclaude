# Domain briefs: (A) Japanese household budgeting app (家計簿アプリ) and (B) improving a high-drop-off 会員登録 flow

Research caveat: about 30 tool calls. WebFetch/WebSearch summaries come from a small model, so quotes are its extractions unless I say I read the text myself. I read the Epstein 2015 PDF text directly (saved in downloads/epstein/). Vendor data is marked "(vendor)". Several Japanese comparison/PR articles are marked as such.

## A1. Japanese budgeting market: products, core loops, input methods, complaint themes

### Takeaway
The Japanese market is organised around auto-aggregation of bank/card data (マネーフォワード ME, Zaim, Moneytree) versus lightweight manual/receipt entry (レシートで家計簿, ポケマネ) versus couple-oriented shared ledgers (OsidOri, Zaim ペア家計簿). The most documented user pain points are sync/connection errors, ads, weak receipt OCR and category chores. Evidence is mostly comparison/PR articles and a review site that over-samples low ratings, so treat the complaint themes as hypotheses.

### Cited Findings
- Comparison articles position MF ME for widest account linking (free plan limits linked accounts; paid from about 500 yen/month), OsidOri for couples (shared budgets, savings goals, settlement/割り勘), Zaim for a "ペア家計簿" where only chosen accounts are shared, Moneytree for few ads and strong bank/card/securities linking but (per some sources) no sharing. — [my-best](https://my-best.com/categories/2905), [app-liv](https://app-liv.jp/articles/153456), [arekore](https://arekore.app/lifestyle/shared-household-budget-apps) (comparison/PR content; the search summary flagged that a source includes PR)
- Sources contradict each other on receipt scanning: one comparison says Zaim lacks it and OsidOri has it, another says Zaim supports receipt photo capture. Plan/pricing details also differ between articles. — same comparison set above; verify against official pages before citing.
- MMDLabo (formerly MMD研究所) 2021 survey (fieldwork 2021-06-24 to 07-05; screening n=5,926 smartphone owners aged 20-69, main survey n=443 budgeting-app users): among 1,257 people managing money, apps used were MF ME 25.5%, Zaim 17.8%, LINE家計簿 14.2%. App selection criteria: free 57.3%, ease of use 48.1%, easy input 42.9%. Biggest merit: grasping cash in/out 53.0%. Exact demerit share not confirmed. — [dime.jp](https://dime.jp/genre/1190643/) (secondary report of a research-company poll, 2021, so dated)
- User-complaint themes found on a review aggregator for MF ME: months-long securities-account link failures with vague error messages; persistent "cannot connect to the internet" false errors; ads shown even to paid users, appearing at mis-tap-prone moments (just before input); receipt OCR succeeding about 1 in 8 attempts (one user); unanswered support inquiries. Positive: one view of all accounts/cards. Caveat: the site states it deliberately lists many low ratings. — [minhyo.jp](https://minhyo.jp/moneyforward-app) (user reviews, selection-biased); I did not retrieve App Store rating distributions.
- 2026 incident relevant to trust: Money Forward suspended bank linking in early May 2026 after a GitHub incident that exposed source code and some user information; partial resumption began May 12, restoration passed 99% by June 2, 2026 but not 100%, because as a 電子決済等代行業者 it needs bank-by-bank joint safety judgement and banks can halt connections by contract. — [ITmedia](https://www.itmedia.co.jp/news/article/2606/02/1260602097/2)
- No source retrieved on cash vs cashless split in budgeting-app UX, category taxonomies used by each app, or report/graph designs. Not found.

### Inferences
- Core loop in the market: (1) connect accounts or capture entries, (2) auto-categorise, (3) fix categories manually, (4) monthly/weekly report and budget remaining. The cash gap (cash is not on any bank feed) is why manual and receipt entry persist alongside aggregation; I have no retrieved source stating that explicitly.
- A pro would check: what happens when a sync breaks (visible status, per-institution error with next action), category correction that "learns", shared-household privacy (hide some spending from partner), and ads/monetisation that do not collide with input moments.

### Gaps
- No App Store/Google Play rating distributions, no systematic review mining. No primary sources from the vendors on category taxonomy or onboarding flows. Receipt OCR claims conflict between sources.

## A2. Survey numbers on 家計簿 continuation

### Takeaway
There is one usable continuation survey with method disclosed, and it is vendor-run (NilCraft, maker of ポケマネ), n=300, so it is weak evidence. The big finding for design is that category classification is the top reported burden for app users, and that continuation numbers differ by method, though with small groups. No MMD研究所/ネオマーケティング continuation-rate survey was found.

### Cited Findings
- NilCraft (vendor, own app お小遣い帳 ポケマネ) survey: published 2026-05-12, fieldwork 2026-04-27, online panel (Eyebridge "Freeasy"), n=300, ages 20-59, people who kept a household ledger within the past 5 years. 185 of 300 (61.7%) had kept it 1 year or longer. Among those 185: app 42.2%, handwritten 30.8%, PC spreadsheet 21.6%, bank/card auto-link only 4.9%. Reported continuation rate by method: handwritten 74.0%, app 51.7% (the release itself warns it is sensitive to group size). — [ASCII](https://ascii.jp/elem/000/004/401/4401241/)
- Same survey, burdens felt by app users (n=151): detailed expense categories 41.7% (handwritten 22.1%), daily entry 37.1%, receipt storage/organising 34.4%; 80.3% of all respondents reported some burden. Desired traits: simple input only 24.0%, graphs 20.3%, completely free 18.7%. The release does not give reasons for quitting; it measures burdens, not abandonment causes. — [ASCII](https://ascii.jp/elem/000/004/401/4401241/)
- Sample design caveat: respondents are people who kept a ledger in the last 5 years, so people who quit within days are likely under-represented (my inference about the sample frame; the release states only the eligibility). — [ASCII](https://ascii.jp/elem/000/004/401/4401241/)
- The search surfaced an ITトレンド Money survey (n=939, published 2026-07, 30.6% keep a ledger) but I did not open it. — [money.it-trend.jp](https://money.it-trend.jp/reports/household/expenses/17-0001) (title only; unverified)
- Explainer articles list common reasons for lapse (hassle, "don't know what I spent on", dropping out midway) and countermeasures (auto-link, start with food only). These are opinion pieces with no method. — [Habitto](https://www.habitto.com/blogs/kakeibo-tsudukanai-kotsu-apuri/)

### Inferences
- A pro would not quote "app users continue less than handwritten" as fact; sample and sponsor bias, small cells. The robust takeaway is the burden ranking (categories, daily entry, receipts) and that simple input is the most-wanted trait.

### Gaps
- No independent (non-vendor) continuation-rate survey found; no retention benchmarks (D30/D90) for Japanese finance apps. MMD研究所/ネオマーケティング continuation figures not found.

## A3. Academic research on tracking adherence and abandonment

### Takeaway
Epstein et al.'s lived informatics model (CHI/UbiComp 2015) reframes tracking as lapse-and-resume, not adopt-or-quit, and includes finance as one of three domains. Financial trackers lasted longer than physical-activity and location trackers. Four lapse types (forgetting, upkeep, skipping, suspending) map directly to budgeting-app design questions. Li et al. (CHI 2010) gives the five-stage barrier model.

### Cited Findings
- Li, Dey, Forlizzi CHI 2010: five stages (preparation, collection, integration, reflection, action), barriers in each, barriers cascade to later stages; stages can be user- or system-driven. — [Li et al. summary](https://ianli.owlstown.net/publications/17), [paper PDF](https://courses.cs.washington.edu/courses/cse440/15au/readings/PersonalInformatics-Li2010.pdf) (I read only the summary)
- Epstein et al. 2015 (read directly from PDF): surveys of 105/99/83 trackers of physical activity/finances/location on Mechanical Turk plus interviews with 22; people frequently switch tools; four lapse types: forgetting, upkeep, skipping, suspending; some lapse then resume, and 14% of current finance trackers (15% activity, 17% location) had not used their tool for a month or more yet still saw themselves as trackers. — [Epstein et al. 2015](https://my.eng.utah.edu/~cs5540/au16/readings/PersonalInformatics-Epstein2015.pdf)
- Same paper: within three months 26% abandoned finance tools versus 44% (activity) and 45% (location). 45% of financial trackers had used their current tool for at least two years; 73% used it in the past week; 63% of financial trackers were using spreadsheets despite heavy manual entry, and the authors cite prior work that people may prefer own effort over aggregation tools. Behaviour-change motivation was reported by 73% of financial trackers; many reviewed finances weekly or monthly rather than daily (weekly review 35% current, 33% past). — [Epstein et al. 2015](https://my.eng.utah.edu/~cs5540/au16/readings/PersonalInformatics-Epstein2015.pdf)
- Quote-level evidence of upkeep lapse in finance: a spreadsheet user said they "kind of stopped updating it because it was too much work to keep up to date." Open design problems named: designing to resume tracking after a lapse (use of historical data), and avoiding inertia around a long-used tool that no longer fits the goal (example: financial tool vs a spreadsheet user). — [Epstein et al. 2015](https://my.eng.utah.edu/~cs5540/au16/readings/PersonalInformatics-Epstein2015.pdf)
- Follow-up "Beyond Abandonment to Next Steps": survey of 193 and interviews with 12 found six reasons for stopping and five perspectives on life after tracking; abandonment is not always failure (goal reached, priorities change). — [selfresearch library summary](https://library.selfresearch.org/research/beyond-abandonment-to-next-steps-understanding-and-designing-for-life-after-personal-informatics-tool-use/) (abstract-level; the six reasons were not retrieved)
- Earlier note (round 1): tracking made some people feel judged and quit (food/self-tracking). — [PMC5428074](https://pmc.ncbi.nlm.nih.gov/articles/PMC5428074)

### Inferences
- Design implications a pro would draw: reduce collection effort (feeds, templates, quick-add), design the "return after two weeks away" experience (no guilt screen, backfill, catch-up), make reflection cheap (weekly summary rather than daily dashboards), and let a user suspend without data loss. These follow from the lapse taxonomy but are my application.
- Surprising point for judging outputs: the data suggests finance tracking is comparatively sticky, so a skill that claims "budgeting apps are abandoned fastest" has no support in this paper (the Money Lover "1 in 10 after 30 days" in round 1 is a student case study).

### Gaps
- Sample is US MTurk, 2015, tools such as Mint/Quicken; no Japanese data. No peer-reviewed HCI study of budgeting-app retention found in this round. Li et al. barrier lists not read.

## A4. Privacy/security expectations for account aggregation (電子決済等代行業)

### Takeaway
Since the 2017 Banking Act amendment, aggregators must register as 電子決済等代行業者 and bank APIs avoid sharing user IDs/passwords, but many card/e-money/some institution links still rely on credential-based scraping. The 2026 Money Forward incident shows the user-facing consequences: linking can be halted bank by bank.

### Cited Findings
- The 2017 amendment introduced registration for 電子決済等代行業者 with user-protection and information-security requirements, and contract rules on liability sharing with banks; with APIs the aggregator does not handle the user's ID/password. — [FSA explanatory material](https://www.fsa.go.jp/common/diet/193/01/setsumei.pdf) (via search summary; I did not open the PDF)
- Scraping means logging into bank sites with user-provided credentials; banks have largely moved to APIs; industry material says most big card/e-money data linkage is still scraping. — [ITmedia](https://www.itmedia.co.jp/news/article/2606/02/1260602097/2), [soumu.go.jp PDF](https://www.soumu.go.jp/main_content/000649196.pdf) (search summary only for the latter)
- Money Forward states that stored scraping credentials cannot move funds alone (no transfer authentication data stored) and are encrypted on a separate server. This is the company's claim. — [ITmedia](https://www.itmedia.co.jp/news/article/2606/02/1260602097/2)

### Inferences
- UX consequences a pro would raise: explain API vs ID/password linking in plain language at the connect step; read-only permission statement; one-tap disconnect/delete data; per-institution link status; what happens to history when a link is suspended; avoid asking for credentials without saying why. For a small personal app: manual/CSV import avoids the 電代業 registration burden entirely (my reading of the regulatory structure, not legal advice).

### Gaps
- No survey on what Japanese users expect/trust about aggregation. FSA primary guidance not opened; legal conclusions unverified.

## B1. Baymard Institute: account creation, guest checkout, passwords, form fields, inline validation, social login

### Takeaway
Baymard (e-commerce checkout, not SaaS sign-up) supports: delay account creation, minimise fields, state password rules up front and keep them lenient, validate inline at the end of a field and clear errors live. I found no primary Baymard social-login finding.

### Cited Findings
- Abandonment reasons (round 1): 18% abandoned because the site wanted an account; 17% too long/complicated. — [Baymard](https://baymard.com/lists/cart-abandonment-rate)
- Delay account creation to the confirmation step; 84% of sites do not; tell guests they can create an account after checkout. — [Baymard form fields](https://baymard.com/blog/checkout-flow-average-form-fields)
- Form fields: average checkout 11.3 fields (2024), most sites need about 8; field count affects usability more than step count. 89% of sites use separate first/last name fields; 42% of participants typed full name into First Name; with a single Full Name field only 4% hesitated. Address Line 2 shown by default on 75% of sites and 30% of participants stopped at it. Hide optional fields (coupon, company, extra phone) behind links; default billing = shipping. — [Baymard form fields](https://baymard.com/blog/checkout-flow-average-form-fields)
- Passwords: 82% of sites have unnecessarily complex requirements; recommended 6-8 character minimum for general e-commerce (cites NIST 8, or 6 machine-generated); no restrictions on special characters or restrictive max length; complex rules rarely cause immediate abandonment if stated up front; the bigger harm is later sign-in failure and reset. Up to 19% checkout abandonment among existing-account users in some tests due to password-reset problems (18.75% average at Amazon/ASOS in the test), including a participant waiting over 6 minutes for a reset email. — [Baymard passwords](https://baymard.com/blog/password-requirements-and-password-reset)
- Inline validation: do not validate while the user is typing the first entry; validate on blur (or when a fixed-length input reaches its length); once an error shows, clear it live on every keystroke so stale errors do not linger (important for email/password confirmation); positive checkmarks reduce cognitive load; inline validation does not replace a good submit-error design. The article says 31% of sites fail to provide inline validation (video summary says 32%; the page is internally inconsistent). — [Baymard inline validation](https://baymard.com/blog/inline-form-validation)
- Guest option hard to find on 44% of sites; "37% disliked being required to create an account" (2017 survey) and "10-30% conversion lift without forced accounts" are quoted via an Amazon Pay blog, not verified on Baymard. — [Amazon Pay blog](https://pay.amazon.com/us/blog/the-baymard-report-series-how-forcing-sign-ups-drives-down-sales) (secondary/vendor)
- Social login: no primary Baymard finding retrieved (premium research paywalled); results were vendor marketing. A 2018 academic paper notes users face two privacy decisions with social login (whether to use it, and whether to consent to the permissions). — [KIT paper](https://publikationen.bibliothek.kit.edu/1000083574/14753733) (abstract-level via search); Google ~75% of social logins in Okta/Auth0 data — [Okta whitepaper](https://www.okta.com/sites/default/files/2023-06/GoingDeepwithSocialLogin-Whitepaper-20230601-Final.pdf) (vendor)

### Inferences
- Applying to a Japanese service: a single name field (氏名) is plausible but Japanese forms usually need 姓/名 and フリガナ for operations; that is a business reason to test, not a Baymard finding. Treat all Baymard figures as e-commerce analogies.
- A pro would offer social/Apple/LINE login as an option, not replacement, and state what data is shared; evidence in this note is only vendor/privacy-paper level.

### Gaps
- Baymard social login/passkey findings not retrievable; no Baymard source on "show password" toggles or confirm-password fields (the password article doesn't discuss them).

## B2. NN/g and Luke Wroblewski on registration walls, forms, errors, gradual engagement

### Takeaway
Both argue: do not force registration before showing value; ask only when the user commits; make errors specific and located at the field. Wroblewski's gradual-engagement evidence (Twitter) is a single company case.

### Cited Findings
- NN/g: login walls are among the most annoying things in tests; users can't judge app value before committing and may delete the app; justified mainly for highly personal services (email, banking); show real content first, require login only when the user commits; reciprocity (give value first, then ask for registration); at checkout offer guest option, postpone account creation until after purchase. No statistics given in the article. — [NN/g, Login walls](https://www.nngroup.com/articles/login-walls/)
- NN/g form-error guidelines (10): inline validation after the user leaves the field; success indicators only for complex fields; messages next to the field; red plus icon (not color alone); do not validate before input is complete; do not rely on summaries alone; no tooltips for errors; use modals sparingly; if the same error repeats 3+ times, redesign and test for root causes. — [NN/g, Errors in forms](https://www.nngroup.com/articles/errors-forms-design-guidelines/)
- Wroblewski (LukeW): gradual engagement means postponing registration so first experience shows value; Twitter's redesign (interest-based onboarding before follow-lists) raised sign-up completion by 29% even though the flow grew from three steps to four; aim for a core success within the first one or two interactions. Page retrieved was the LukeW entry on Twitter's flow, not the "Sign-Up Forms Must Die" essay itself. — [LukeW](https://www.lukew.com/ff/entry.asp?1128)
- Not retrieved: NN/g on required-field marking, progressive disclosure, and Wroblewski's mobile input-type guidance (fields/keyboards). — see Gaps.

### Inferences
- Dropping registration for a budgeting app: let users enter a first expense/see value before asking for an account, especially since sensitive linking comes later; but a household app may legitimately need an account for sync, which is NN/g's "personal service" exception.
- Wording tension: NN/g says validate on field exit; the Digital Agency design system says the opposite (see B3). A pro would note the conflict and test.

### Gaps
- No NN/g page on required fields, progressive disclosure for forms, or social login retrieved. No Wroblewski mobile-forms/input-type source retrieved.

## B3. Japanese context: 会員登録 drop-off data, 全角/半角, フリガナ, 住所, 認証

### Takeaway
Japanese-specific pitfalls are well documented by the Digital Agency design system (DADS) and ITmedia: restricting character types forces errors; DADS recommends not restricting, or auto-converting at submit/confirm. Drop-off percentages in Japanese material are vendor/EFO secondary claims with no traceable source.

### Cited Findings
- DADS (Digital Agency design system, beta) input-text usage: by default do not limit accepted character types; if a restriction is needed, support auto-conversion (half-width katakana, full-width alphanumerics, hyphens, long vowel mark), preferably at submit or confirmation screen; converting right after input or on blur may confuse users by showing a different value; on the confirmation screen show the converted string and let users approve or correct. Describe format conditions in concise support text, not in placeholders ("サポートテキストを企図して、プレースホルダーテキストを使用してはなりません"); example of good support text: "半角数字のみ" for postal code shown up front vs the bad example of revealing the rule after a full-width entry error. — [DADS input-text usage](https://design.digital.go.jp/dads/components/input-text/usage/) (via fetch summary; Japanese quotes are the summary's extraction)
- DADS errors: preferably shown on or after submit; avoid showing errors at input/blur because layout shifts disrupt typing; error text states the content and how to fix; mark required/optional with "※必須"/"※任意" starting with a full-width ※. Phone numbers: a template with area code/exchange/subscriber in separate fields (added 2023) to avoid stray hyphens. Placeholders: avoid for conditions/examples (low contrast, vanishes on typing). — [DADS input-text usage](https://design.digital.go.jp/dads/components/input-text/usage/), [DADS accessibility](https://design.digital.go.jp/dads/components/input-text/accessibility/), [Digital Agency 2023-05-31](https://www.digital.go.jp/en/policies/servicedesign/designsystem/20230531-1) (search summaries)
- ITmedia on why 全角/半角 address problems persist: addresses mix kanji/numbers/kana, sites force full-width to avoid mixed data, legacy bank systems used single-byte half-width, JIS X 0208 (1980s) assumes full-width, developers underweight UX (especially internal systems); fixes: normalisation libraries (InputMan JS), in-house conversion, auto-advance to next field, no hyphen required. — [ITmedia](https://www.itmedia.co.jp/news/article/2111/05/1211105079/)
- Example of a real Japanese form warning: "フリガナは全て全角・数字は全て半角入力" and postal code half-width, from a prefecture's membership application form (shows the pitfall is still shipped). — [Gifu pref. form](https://www.pref.gifu.lg.jp/ques/questionnaire.php?openid=8) (search summary)
- GovTech Tokyo "入力フォーム ガイダンス" v1.1 exists as a form-design guideline; contents not read. — [GovTech Tokyo PDF](https://www.digitalservice.metro.tokyo.lg.jp/documents/d/digitalservice/inputform_guidance_v11)
- EFO drop-off claims: "form abandonment is 5-7 in 10" and "each field removed improves completion about 2%" appear in EFO-vendor/marketing articles with no traceable original study. — [honichi](https://honichi.com/news/2025/05/14/efo/), [stock-sun](https://stock-sun.com/column/lp-efo/) (vendor/secondary; the summaries say sources were unidentified)
- 住所自動入力 (postal-code lookup), メールアドレス確認/SMS認証 and フリガナ auto-fill: I found no retrieved source with numbers. DADS mentions an address template for the case where the postal code is unknown.

### Inferences
- A good output on a Japanese sign-up would include: accept full/half-width input and normalise (rather than error), postal-code lookup with manual fallback, phone/email format tolerant of hyphens/spaces, support text instead of placeholders, SMS/email verification designed for deliverability (carrier email blocking, resend, code expiry), and 郵便番号 + 住所 only if the business needs them for a budgeting app (it usually does not).
- Inconsistency to flag: DADS "errors at submit" vs NN/g/Baymard "inline on field exit". A pro explains the trade-off; note DADS targets government forms with mixed users, and its reasoning is about layout shift.

### Gaps
- No credible independent Japanese measurement of sign-up drop-off by cause. EFO vendor reports (e.g., ECビジネス系) not retrieved. SMS認証 and メール到達率 evidence not found. DADS pages were read via summarised fetches; check the live page before quoting.

## B4. How pros diagnose a funnel; metrics, guardrails, A/B basics

### Takeaway
Pros sequence diagnosis from quantitative (step funnel, field-level analytics, segment) to qualitative (recordings, usability tests, heuristic review) to hypotheses, then experiment with a pre-declared primary metric, guardrails and sample size. Evidence below is thin on field-analytics tooling (not retrieved) and strong on experiment trust principles.

### Cited Findings
- Evan Miller's sample size calculator inputs: baseline conversion rate, minimum detectable effect (absolute or relative), power (1-beta), significance (alpha); example yields 2,545 subjects per variation for 10.2% baseline with a 3-point MDE; effects within the gray area near baseline are not distinguishable. The page itself has no peeking guidance but links to "How Not To Run An A/B Test" (not read). — [Evan Miller](https://www.evanmiller.org/ab-testing/sample-size.html)
- Kohavi et al. (book): guardrail metrics are metrics that alert experimenters to violated assumptions, of two kinds, organizational (e.g., latency) and trust-related; sample ratio mismatch (SRM) is a trust-related guardrail (control/treatment allocation must match the configured split); Twyman's law: surprising results are more likely to be errors; OEC (overall evaluation criterion) is a book concept. — [Cambridge SRM chapter](https://www.cambridge.org/core/books/trustworthy-online-controlled-experiments/sample-ratio-mismatch-and-other-trustrelated-guardrail-metrics/8DBB0F59AC7729D7BC6B94690DB9CCD5) (listing/abstract, via search), [Kohavi doc](https://docs.google.com/document/d/1IDcLEr58QoQU2VJPc-TefLMLegdQMnh3/export?format=pdf) (via search); third-party summaries cited "8% of experiments have SRM" which I could not verify.
- NN/g: heuristic evaluation with several evaluators is a cheap diagnostic; 3-5 users find most problems; quantitative metrics need about 20 users (round 1 notes). — [NN/g](https://www.nngroup.com/articles/why-you-only-need-to-test-with-5-users/)
- Baymard-style test items to look at when diagnosing sign-up: required account, password rules, field count, validation, reset/verification email delays (all above).

### Inferences
- A pro's minimum deliverable for the sign-up case: (1) funnel with step-level conversion and segments (device, new/returning, traffic source, OS/browser, locale), (2) field-level view (time per field, errors per field, abandon-on-field, resubmits), (3) 5-10 session recordings at the worst step plus 3-5 moderated tests, (4) heuristic review against Baymard/NN/g/DADS items, (5) hypothesis list ranked by impact x effort, (6) pre-registered experiment: primary metric (e.g., completed sign-up that reaches first meaningful action, not just form submit), guardrails (verification completion, activation, support contacts, fraud/bot rate, later retention, sign-in success), MDE and sample size from the baseline, run for full weekly cycles, no early stopping, SRM check; if traffic is too low, before/after with caveats.
- Success metric trap: optimising registration completion alone can raise low-quality sign-ups; pair with activation/retention (a "guardrail"), as Kohavi's guardrail idea suggests. The specific metric names are my synthesis.

### Gaps
- Not retrieved: field-level analytics/session replay practitioner sources (e.g., Hotjar/Contentsquare/Baymard-style form analytics), Evan Miller's peeking article, Kohavi's book text (only abstract/summaries), Japanese EFO analytics practice. No source on a canonical set of sign-up funnel metrics beyond my synthesis.
