# Scaling upstream UX process by project size, and domain cases (solo consumer app, B2B/clinic SaaS, existing-flow improvement)

Research caveat: ~20 tool calls, WebFetch summaries come from a small model (quotes were extracted by it, not read by me in full). Items marked "secondary" are vendor/agency blogs. Jared Spool, Cooper/Korman, Sarah Doody and Erika Hall's book text were NOT retrieved from primary sources (see Gaps).

## 1. What do practitioners say about right-sizing UX process?

### Takeaway
The primary sources converge on three sizing levers: (a) time/budget is fixed first and scope flexes (Shape Up appetite), (b) the process is cut to the cheapest method that reduces the biggest uncertainty or risk of a wrong decision (Nielsen discount usability, Hall, Lean UX), and (c) "some small test beats none", with iteration valued over one big study. Nothing found gives a numeric rubric; the rubric in Inferences is my synthesis.

### Cited Findings
- Shape Up: "Estimates start with a design and end with a number. Appetites start with a number and end with a design." Small batch = one designer + 1-2 programmers for 1-2 weeks; big batch = a full six-week cycle. "Fixed time, variable scope" is called key to shipping. — [Shape Up ch.3](https://basecamp.com/shapeup/1.2-chapter-03)
- Nielsen discount usability: three cheap techniques (scenarios/reduced prototypes, simplified think-aloud with 3-5 users, heuristic evaluation with ~10 heuristics and several evaluators); principle "anything is better than nothing"; even non-significant tests move a decision from 50/50 to roughly 4:1 odds; case numbers: 90 hours of discount work produced 8 versions and raised correct answers 56% to 76% (n=152); heuristic evaluation case: ~105 person-hours, estimated benefit-cost ~48. — [NN/g, Guerrilla HCI](https://www.nngroup.com/articles/guerrilla-hci/)
- Five users find ~85% of problems (first user ~31%); better to run several rounds of 5 than one big study (3x5 vs 15). Exceptions: several highly distinct user groups need 3-4 per group (2 groups) or 3 per group (3+ groups); quantitative metrics studies need ~20 users. — [NN/g, Why You Only Need to Test with 5 Users](https://www.nngroup.com/articles/why-you-only-need-to-test-with-5-users/)
- Erika Hall (secondary summaries only): scope research to the decisions at hand; right amount depends on project complexity and the risk of wrong design choices. Search tool flagged several of these PDFs as low-quality/garbled. — [search result set, ProTech summary](https://www.protechtraining.com/blog/post/just-enough-research-826), [Jason Santa Maria review](https://v5.jasonsantamaria.com/articles/just-enough-research-by-erika-hall)
- Lean UX (Gothelf): replaces "Big Design Up Front" with hypothesis validation; shifts effort from documentation to testing assumptions via MVPs "while minimizing the work we put into unproven ideas." — [Lean UX 2e ch.5 (O'Reilly)](https://www.oreilly.com/library/view/lean-ux-2nd/9781491953594/ch05.html)
- "Minimum viable research" checklist: "What is the least research I need to reduce the biggest uncertainty?" — [Koji guide](https://www.koji.so/docs/lean-user-research) (vendor, not tied to Gothelf/Spool; weak).
- NN/g UX maturity: 6 stages (Absent, Limited, Emergent, Structured, Integrated, User-driven); match actions to the stage; at Limited stage UX is sporadic, with no dedicated roles/process/budget; Integrated is the stage most orgs should aim for. This is an org-level model, not a project-sizing tool. — [NN/g UX maturity](https://www.nngroup.com/articles/ux-maturity-model/)

### Inferences
- Defensible sizing rule (mine, built from the above): size the process by (1) appetite (days vs weeks vs quarters), (2) cost of being wrong x reversibility, (3) number of distinct user roles (Nielsen's per-group testing exception makes roles a cost multiplier), (4) regulatory/data sensitivity, (5) whether the domain is unfamiliar to the builder. Any step whose output would not change a decision at the current risk level is compressed to its cheapest form, not deleted.
- "Compress" should mean a cheaper method (paper scenario, 3-5 person test, 10-heuristic review, one-page flow), not "skip", because Nielsen's evidence is that cheap beats none.
- Solo builders are at NN/g maturity "Absent/Limited" by default; the maturity model says nothing to override this, so the skill should carry its own process rather than assume org support.

### Gaps
- No primary Jared Spool source found on right-sizing (search returned none). No Erika Hall primary text. No NN/g article titled on "right-sizing" per se. No numeric thresholds from any practitioner for "when to do formal research".

## 2. Commonly skipped steps and the failures that result

### Takeaway
Evidence is mostly practitioner opinion, not rigorous post-mortems. The recurring theme: skipping flows/state design and testing leaves dead ends, empty/error states and navigation mismatches that visual polish cannot fix. The strongest hard case found (Healthcare.gov) is about system testing, not UX per se.

### Cited Findings
- Walk each screen through four empty-state cases (never had data, had data but empty now, filter returns nothing, integration broken); team reported better activation after adding a first-run state. — [dev.to, 137Foundry](https://dev.to/137foundry/how-we-refactored-three-empty-states-out-of-a-production-dashboard-4gef) (practitioner blog, self-reported)
- Restyling a UI leaves flow dead ends, edge cases and mental-model mismatches untouched. — [Phenomenon Studio](https://phenomenonstudio.com/article/your-ui-polished-product-looks-great-so-why-are-users-still-leaving/) (agency marketing; weak)
- Wallapop ex-PM on IA redesign failure: not listening to users, adding unwanted features, not de-risking launch with testing per phase. — [Mind the Product](https://mindtheproduct.com/a-case-study-how-to-produce-a-winning-app-redesign)
- Navigation validation example: 3 rounds of card sort/tree test, 75+ participants, 60% task-success threshold, sitemap revised 4 times. — [Lucy Wang portfolio](https://lucywang.myportfolio.com/information-architecture-redesign) (student-level case; illustrates method, not a benchmark)
- Healthcare.gov: HHS did not use GSA's free First Friday usability testing program (Nextgov); GAO and press focus on incomplete system/performance testing, end-to-end testing only in the final weeks. — [Nextgov](https://www.nextgov.com/cio-briefing/2013/10/health-exchange-website-failures-were-both-predicted-and-predictable/71762/), [Becker's](https://www.beckershospitalreview.com/healthcare-information-technology/what-went-wrong-with-healthcare-gov-10-things-to-know.html), [GAO-15-238](https://www.gao.gov/assets/670/668834.pdf) (PDF not read by me)

### Inferences
- Steps that practitioners treat as cheap-but-high-yield and that are most often dropped: state inventory (empty/loading/error/partial/permission-denied), a single end-to-end flow including failure paths, and one round of a 3-5 person test before build. These should be "never skip, shrink instead".
- Healthcare.gov is evidence for "test the whole path under realistic conditions before launch", not for any specific UX deliverable; do not overclaim it as a UX-skipping post-mortem.

### Gaps
- No named, quantified post-mortem specifically attributing failure to skipped IA/flows/states. Searches for one returned agency/portfolio content.

## 3. Enterprise / B2B SaaS specifics

### Takeaway
NN/g primary material says: study the domain first, research across multiple roles, map workflows across people and tools, partner with domain experts, and do not rely on training to cover bad design. Org setup, permissions, audit logs, bulk ops are not covered by an NN/g source I retrieved.

### Cited Findings
- Complex apps (enterprise apps, high-impact decision systems) need domain study: "developing a deep understanding of the domain itself, not just the people in it"; involve multiple roles ("each role contributes a distinct view"); map workflows across people/tools; observe in context (interruptions, shared equipment); triangulate; partner with domain experts who flag edge cases; if expert users are scarce, use knowledgeable internal staff but validate later with end users. — [NN/g, UX Strategies for Complex-Application Design](https://www.nngroup.com/articles/strategies-complex-application-design/)
- Three myths: people like old ways, they are experts in the existing UI, training will make up for bad design; all "misleading". Learner user type (domain expert new to the software) needs learnability, inline help, just-in-time tips. Users plateau in efficiency regardless of training. — search summary of [NN/g Complex App users](https://www.nngroup.com/articles/complex-apps-users/) and [heuristics for complex apps](https://www.nngroup.com/articles/usability-heuristics-complex-applications/) (I saw search snippets only, not full pages)
- NN/g also has a 5-layer framework for complex apps — [NN/g](https://www.nngroup.com/articles/complex-application-design-framework/) (title seen; contents not read).
- Secondary/agency claims: enterprise systems serve executives/analysts/managers/operators needing different detail levels; organize by role and workflow rather than by module; layer information (summary first, detail on demand); onboarding spans administrators, frontline staff and executives. — [Parallel HQ](https://www.parallelhq.com/blog/b2b-ux-design), [ElectroIQ](https://electroiq.com/news/b2b-ux-architectures/) (vendor blogs, low weight)

### Inferences
- Role x permission matrix, org/admin setup flow, and the first-run for the organization (not just the user) are the B2B-specific upstream artifacts. They follow from the NN/g "multiple roles / workflows across people" findings but I did not find a source that lists them as required deliverables.
- Each distinct role is a research and test multiplier (Nielsen: 3 per group when groups are distinct).

### Gaps
- Not found: Cooper/Korman, Sarah Doody primary content; NN/g or other sources on audit logs, bulk operations, integrations, data-density design, permissions modelling.

## 4. Healthcare / clinic scheduling (Japan context)

### Takeaway
Evidence for no-show/reminder design is partly rigorous (single-site studies) and partly vendor claims; the Japanese privacy/security layer is clear in structure (要配慮個人情報, MHLW security guideline 6.0, consignee supervision) but I could not read primary guideline text this run. No real clinic-booking UX case study of quality was found.

### Cited Findings
- Residency-clinic multi-method intervention (patient interviews, double booking for frequent no-show patients, modified advanced-access scheduling): no-show rate in a 141-patient cohort fell 33.3% to 17.7%, clinic-wide 10% to 7%, sustained over 33 months; single site, small. — [UT Southwestern](https://utsouthwestern.elsevierpure.com/en/publications/a-multi-method-intervention-to-reduce-no-shows-in-an-urban-reside)
- A systematic review of 24 studies cited in an AJMC article found lower no-shows in practices with baseline above 15%, other outcomes mixed; the dermatology RCT of algorithmic double booking results were not found by me. — [AJMC](https://www.ajmc.com/view/success-of-automated-algorithmic-scheduling-in-an-outpatient-setting)
- Reminder timing: a 2012 meta-analysis reportedly finds no significant difference between 24/48/72h reminders (secondary, zavis.ai); a 2026 medRxiv preprint (not peer reviewed) found one reminder ~24h before lowered no-shows most, a 72h reminder added early cancellations (useful for refilling slots). — [zavis.ai](https://www.zavis.ai/guides/reduce-patient-no-shows-uae) (vendor; low confidence)
- Vendor blogs claim double booking and no-show fees can backfire; unverified. — [simbo.ai](https://www.simbo.ai/blog/why-traditional-strategies-like-no-show-fees-and-double-booking-fail-to-reduce-patient-no-shows-and-how-technology-can-offer-better-alternatives-2056550)
- Japan: 病歴 is 要配慮個人情報; third-party provision generally needs prior consent, opt-out is not allowed for it, entrustment (委託) is an exception, so consignee supervision and security measures are the main issue. Joint MHLW/PPC guidance for medical and care providers exists, with a Q&A including consignee supervision. — [Atsugi city PDF excerpt of PPC guideline](https://www.city.atsugi.kanagawa.jp/material/files/group/9/sankou2_28740087.pdf), [MHLW Q&A PDF](https://www.mhlw.go.jp/content/001470633.pdf) (the search tool's summary; I did not open the PDFs, and its last paragraph marked the booking-system application as its own inference)
- 医療情報システムの安全管理に関するガイドライン 第6.0版: body split into 経営管理編・企画管理編・システム運用編; revision driven by mandatory オンライン資格確認 from April 2023 making network security relevant to nearly all providers; covers cloud risk, zero-trust vs perimeter, emergency response; includes a special section for small providers. — [MHLW PDF](https://www.mhlw.go.jp/content/10808000/001102596.pdf) (search summary; version number/current revision beyond 6.0 not verified)
- Seniors (NN/g, 123 participants 65+, 5 countries): small type and tap targets are repeated barriers; older users make more input errors and blame themselves; rigid input formats (e.g., dates) frustrate; accept multiple formats, clear error messages; ability to use websites declines ~0.8% per year from 25 to 60; 73% of people over 65 online in 2019 (Pew). — [NN/g, Usability for Senior Citizens](https://www.nngroup.com/articles/usability-for-senior-citizens/)

### Inferences
- Must-do upstream for a clinic booking product: (1) a slot/availability model (practitioner schedule, appointment types and durations, rooms/equipment, blocks, holidays) and the double-booking/concurrency rule written down before screens, (2) lifecycle state machine for an appointment (requested, confirmed, changed, cancelled by patient/clinic, no-show, walk-in, completed) with who can do each transition, (3) separate patient and staff task flows, (4) reminder and cancellation policy, (5) a data-classification and consignee-supervision check against 要配慮個人情報 and the 6.0 guideline, with a decision on what appears in notifications (e.g., no diagnosis in a SMS/LINE text), (6) older-user accessibility baseline (type size, targets, tolerant input). Items (1)-(4) are my synthesis from the domain; the sources support (5) and (6) and the reminder effect only.
- Staff are the daily users; a 3-5 person observation of reception work is the cheapest valid domain study, following NN/g's observe-in-context advice.

### Gaps
- No quality UX case study of clinic booking systems found. No primary reading of the 6.0 guideline sections or PPC text; verify clause numbers before the skill cites them. HIPAA not researched. Walk-in handling and waitlist: no rigorous source found.

## 5. Improving an existing flow (e.g., sign-up funnel)

### Takeaway
NN/g defaults to incremental change driven by data; Baymard provides strong e-commerce account-creation benchmarks. Redesign needs a diagnosis stage greenfield does not, but needs less concept/IA work unless structure has degraded.

### Cited Findings
- NN/g: drastic changes are jarring and risky; make incremental changes toward clear goals and fully redesign only if data says so; full redesign justified when long incremental patching has destroyed a unified conceptual structure; iteration can stall at a local optimum; a fundamental redesign may add new usability problems needing more iterations. — [Radical Redesign or Incremental Change?](https://www.nngroup.com/articles/radical-incremental-redesign/), [Fresh vs. Familiar](https://www.nngroup.com/articles/fresh-vs-familiar-aggressive-redesign/)
- Baymard checkout abandonment reasons (excluding "just browsing"): 40% extra costs, 20% slow delivery, 19% distrust with card, 18% "site wanted me to create an account", 17% too long/complicated, 17% errors/crash; average abandonment 70.22% across 50 studies (list updated 22 Sep 2025; survey date not given). — [Baymard](https://baymard.com/lists/cart-abandonment-rate)
- Baymard: delay account creation until the confirmation step (only password needed); 84% of sites fail to do so (as reported on the page); tell guest users they can create an account after checkout. — [Baymard](https://baymard.com/blog/checkout-flow-average-form-fields)
- Baymard passwords: 82% of benchmarked sites require unnecessarily complex passwords; recommends ~6-8 char minimum for general e-commerce; complex rules rarely cause immediate abandonment if stated up front, main harm is later sign-in failure. — [Baymard](https://baymard.com/blog/password-requirements-and-password-reset)
- Baymard relaunched Accounts & Self-Service research in 2026 (4,000+ hours, 1,400+ issues). — [Baymard](https://baymard.com/blog/accounts-and-self-service-ux-research-2026)
- Heuristic evaluation by several evaluators with ~10 heuristics is a cheap diagnostic. — [NN/g Guerrilla HCI](https://www.nngroup.com/articles/guerrilla-hci/)

### Inferences
- Baymard figures are e-commerce checkout; applying them to SaaS sign-up is analogy. Treat as hypotheses to test, not facts about the funnel.
- Required sequence for an existing funnel: instrument step-level funnel and segment, watch recordings/ run 3-5 moderated tests at the worst step, heuristic review, form out hypotheses ranked by impact/effort, then A/B (needs adequate traffic; otherwise ship and measure before/after). Persona/IA/concept work are skipped unless diagnosis shows structural problems.

### Gaps
- Not retrieved: Baymard inline-validation and social-login findings (2026 report is paywalled/not read); session-recording and form-analytics practitioner sources; A/B sample size guidance; a source on "what to measure" beyond completion rate.

## 6. Personal / small consumer apps (household budgeting)

### Takeaway
No rigorous study on budgeting-app abandonment was found. Practitioner and student sources point to manual entry friction and setup/category work as the main drag, which is a hypothesis for design rather than established fact.

### Cited Findings
- Self-tracking research: some quit because tracking made them feel judged or discouraged (food/self-tracking, not budgeting). — [PMC5428074](https://pmc.ncbi.nlm.nih.gov/articles/PMC5428074)
- Student case study (Money Lover): reports only ~1/10 of users remain after 30 days (class project; anecdotal). — [UX Foundation case study](https://uxfoundation.notion.site/Case-Study-Redesign-the-Money-Lover-App-to-cultivate-the-habit-of-expense-tracking-for-users-25a684fd8bbc4d499febe0eddb5858c4)
- Practitioner posts: logging in a separate app is a context switch that never becomes automatic; even auto-tracking needs manual category fixing; setup and categories are the hard part (YNAB user quote). — [Indie Hackers](https://www.indiehackers.com/post/i-built-an-expense-tracker-in-whatsapp-because-i-couldnt-stop-abandoning-apps-here-s-what-i-learned-about-intentional-friction-01776a7f3c), [Indie Hackers 2](https://www.indiehackers.com/post/3-reasons-why-even-the-best-budgeting-apps-don-t-work-what-works-for-everyone-8c9713a503)
- Feature bloat overwhelms (vendor blog, low weight). — [pocketclear](https://pocketclear.app/blog/digital-minimalism-finance.html)
- Nielsen: with a tiny budget, 3-5 users or paper scenarios still beat nothing. — [NN/g](https://www.nngroup.com/articles/guerrilla-hci/)

### Inferences
- Minimum that still matters: define the core loop and time-to-log an expense (target: fewest taps from open), first-run to first value, empty/first-use states, recovery from wrong entries, and who uses it (household = 2+ roles if shared). A 3-5 person "log a week of spending" trial with the builder's own household is the cheapest valid test.
- Safely skippable at this size (judgment, no source says so directly): formal personas, large-scale research, design system, full IA documentation. Unless the app is shared by several members with permissions or stores sensitive data, where flow/role design should be kept light but present.

### Gaps
- No ACM CHI/CSCW personal-informatics abandonment paper retrieved. No habit/retention benchmark data for finance apps.

## 7. Matrix: process step x project type (my synthesis, grounded as noted)

Legend: R = required, C = compress (cheapest form), S = skip unless a trigger fires. Trigger column gives the rule that flips it. Sources in brackets refer to sections above.

| Step | Solo consumer app | B2B/vertical SaaS (clinic) | Improve existing flow |
|---|---|---|---|
| Goal/problem statement + success metric | R (one paragraph) | R | R (baseline metric first) [5] |
| Decision-driven research plan ("what decision does this inform") | C | R | R |
| Domain study / observe real work | C (own use + 1-2 people) | R (observe reception/doctor; NN/g [3]) | C (only at the failing step) |
| User interviews / formal research | S (3-5 informal trials) | R (3-5 per distinct role [1]) | C (recordings + 3-5 tests at the drop step) |
| Personas | S | C (role cards, not personas) | S |
| Role x permission matrix / org model | S unless shared | R | S unless roles are involved |
| Competitor/pattern scan | C | R | C |
| Core flow / task flow incl. failure paths | R | R (patient and staff separately) | R (current vs proposed) |
| IA / navigation structure | C (sitemap in a list) | R (tree test if many roles/objects) | S unless structure degraded [5] |
| State inventory (empty/loading/error/partial/denied) | R | R | R for touched screens |
| Domain model / rules written down (slots, double-booking, states) | C | R | S unless the flow touches a domain rule |
| Regulatory/data classification | C (what data, where stored) | R (要配慮個人情報, guideline 6.0 [4]) | C (re-check if sign-up collects new data) |
| Accessibility baseline | C | R (elderly patients [4]) | R for the changed flow |
| Low-fi prototype + 3-5 person test before build | C (paper/self test) | R | R (test proposed change) |
| Heuristic evaluation | C (self-run, 10 heuristics) | C | R (cheap diagnostic [5]) |
| Funnel analytics / recordings | S (pre-launch) | S pre-launch, add after | R |
| Design system | S | C (tokens + reuse) | S |
| A/B or before/after measurement plan | S | C | R |

Triggers that flip a cell (my rules): irreversible or costly data (health, money movement) -> raise one level; 2+ roles with different permissions -> role artifacts become R; team larger than one -> shared artifacts (flows, states) must be written; unfamiliar domain -> domain study R; low traffic -> replace A/B with before/after.

Justification chain: cost of being wrong x reversibility [1], role multiplier [1][3], risk/regulation [4], diagnosis before redesign [5], cheap-beats-none [1].
