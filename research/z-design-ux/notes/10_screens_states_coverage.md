# Deriving the screen list and covering non-happy-path states: gap-filling round

Scope note: ~30 tool calls. WebFetch returns summaries by a small model, so "quotes" below are the fetcher's quotes of the page, not verified verbatim. ooux.com (404), web.archive.org (blocked), Polaris pages (moved), pajamas.gitlab.com (moved to design.gitlab.com), web.dev offline-ux (404), Khourshid/Stately pages (404), Mermaid code blocks (not extracted) failed. Does not repeat file 03.

## 1. OOUX primary material and objects-to-screens derivation

### Takeaway
The best primary-ish source reached is the InfoQ podcast with Prater: four ORCA rounds (discovery, requirements, prioritization, revision), "object guide", Nested Object Matrix with a per-relationship check ("My Cat Saving Fire Department"), CTA matrix, Object Map, and screens only in the last round. She states that navigation follows the object hierarchy and that sort/filter needs come from relationship volume. No formal "objects to screens" algorithm exists in any source reached, so the mechanism must be designed by us (see Inferences). "Object Litmus Test" appears in no primary source reached.

### Cited Findings
- Four rounds: "four rounds of ORCA" = discovery, requirements, prioritization, revision; adapting to the project is normal. — [InfoQ podcast, Prater](https://www.infoq.com/podcasts/object-oriented-ux-sophia-prater/)
- Objects found by "noun foraging" in interviews, chat logs etc.; look for "nouns that have structure, instances and purpose". "it's way easier to figure out the verbs in a system if you've already defined the nouns." — same
- Object guide = "a glossary on steroids". — same
- Nested Object Matrix: objects on both axes, relationships in intersections, multiple relationships per cell (e.g. a person "has many posts they've created", "in draft", "liked"); prevents missed relationships that boxes-and-arrows hide. — same
- Each relationship checked with mnemonic "My Cat Saving Fire Department" = Mechanics, Cardinality, Sorting and Filtering, Dependency. — same
- CTA matrix: roles x objects, "we put the verbs in the middle"; roles/permissions considered early. — same
- Object Map adds attributes, split into core content vs metadata (users sort/filter by metadata); "the holy grail of the ORCA process". — same
- Screens are late: "It's not until that last round where we start getting into screens"; "OOUX style sketching" keeps object presentation consistent. — same
- Volume drives views: with many posts "I probably need to provide the user with sorting and filter mechanisms"; person detail page shows a few related posts or needs sort/filter at scale. — same
- Navigation follows the object tree: from a showtime "navigate up to the main movie" (movie > movie at theater > showtime). — same
- Miro template outline: identify objects from existing docs; map relationships for core objects; define actions and who can take them; capture metadata; log questions throughout. — [Miro ORCA template](https://miro.com/miroverse/ooux-orca-process/)
- Search-level confirmation: CTA matrix maps objects to roles, leads to the Object Map. "Object Litmus Test" not found. — [WebSearch summary citing InfoQ/uxdesign.cc/LogRocket](https://www.infoq.com/podcasts/object-oriented-ux-sophia-prater/)
- Not reached: ooux.com, web.archive.org snapshots (fetch tool blocked the host), Cooper object-action, Fluent/Material/Apple HIG noun-verb. Not researched.

### Inferences
- Derivation rule for the skill (ours): for every object, from Nested Matrix volume/cardinality decide list view (with sort/filter attributes taken from metadata), detail view (with nested-object sections; "many" relationships with large volume need their own list), create/edit surface; every CTA-matrix cell needs a home surface and a trigger; every role column needs a visibility check; every nested-matrix cell with dependency ("must have") implies a creation order and a blocked/empty state. Add the "My Cat Saving Fire Department" check as a per-relationship gate: it forces Sorting/Filtering and Dependency (delete-parent behaviour) answers.
- The ORCA rounds give a natural gate sequence: no screens until object guide, nested matrix, CTA matrix and object map exist.

### Gaps
- Meaning of Object Litmus Test unverified. Prater's own written rules for list/detail derivation not found. Cooper/Fluent/HIG not covered.

## 2. Screen inventory templates

### Takeaway
No authoritative agency template was found. Only community AI-skill/open-source templates surfaced; they converge on: stable screen ID, name, type, purpose, requirement/journey traceability, entry from, exit to, primary role, route, states, and a coverage rule in both directions.

### Cited Findings
- Template columns reported: ID | Screen | Covers FR | Entry from | Exit to | file link; coverage rule: every requirement with UI maps to at least one screen and every screen traces to a requirement. — [prd-v04-screen-flow-definition skill](https://smithery.ai/skills/mattgierhart/prd-v04-screen-flow-definition) (via search summary; community source)
- Per-screen: type (page/modal/panel/component), purpose, journeys and features served, primary/secondary actions, navigation sources. — [torus tas-kit UIUX-Design template](https://cdn.jsdelivr.net/npm/@torus-engineering/tas-kit@2.2.0/.tas/templates/UIUX-Design.md) (via search summary)
- Flow rules: every flow has entry point and clear exit or success condition; explicit recovery paths for loading, empty, error; non-root screens need back navigation. — [ux-flow skill](https://openskillindex.com/skills/sickn33-antigravity-awesome-skills-ux-flow) (via search summary)
- Inventory columns: screen ID, name, route, primary user role, purpose; document entry/exit/blocking conditions; avoid layout. — [ux-analyst skill](https://skills.sh/go-sphere/skills/ux-analyst) (via search summary)
- Wireframe spec adds exit points, related screens, modal triggers/dismissal, WCAG level, tab order. — [aiwg wireframe template](https://cdn.jsdelivr.net/npm/aiwg@2026.7.12/agentic/code/frameworks/sdlc-complete/templates/ux/wireframe-specification-template.md) (via search summary)
- Sources are community skills, not established UX bodies (the search tool itself says so).

### Inferences
- Proposed columns: ID, name, type (page/modal/drawer/email/system page), object(s), role visibility, route, entry points (all), exits, source CTA/flow step, states covered (from the checklist in section 3), open questions. Two-way trace: every CTA-matrix cell and flow step maps to a screen ID; every screen maps back (orphan check both ways).

### Gaps
- No agency/NN/g/UX-practitioner screen-list example with sample rows; a one-search attempt only.

## 3. Edge-case and state checklists from design systems and authorities

### Takeaway
GOV.UK, GitLab Pajamas and Atlassian give concrete, primary, per-situation rules; they supply typed lists of non-happy-path pages and empty states. Offline, concurrency, i18n, rate limits and session expiry have weak or no primary design-system sources in this round.

### Cited Findings
- GOV.UK "problem with the service" (500) page: required H1 "Sorry, there is a problem with the service", "Try again later", must say what happened to the user's answers (e.g. "We saved your answers. They will be available for 30 days."), contact info if needed, link to another service; avoid "500", "technical difficulties", red text; if not fixable quickly use a Service unavailable page. — [GOV.UK problem-with-the-service pages](https://design-system.service.gov.uk/patterns/problem-with-the-service-pages/)
- GOV.UK lists sibling page types: Confirmation, Cookies, Interruption, Page not found, Service unavailable (content not retrieved). — same page navigation
- GitLab empty-state types: blank content, configuration required (with secondary "Invite member to configure"), higher tier feature ("Feature not available"), empty search results (no CTA, "No results found"). Titles ~5 words, one primary button, hide header button duplicating the empty state's action, include analytics. — [GitLab Pajamas empty states](https://design.gitlab.com/patterns/empty-states)
- Atlassian error messages: error (already failed) vs warning (future problem); unknown cause: don't invent one, offer a next step; multiple causes: most likely first; CTA imperative 1-2 words, not "OK", with cancel; use "you" not "we"; avoid "sorry"/"please" unless severe. — [Atlassian error messages](https://atlassian.design/foundations/content/designing-messages/error-messages)
- Text expansion (IBM figures via W3C): up to 10 chars 200-300%; 11-20 180-200%; 21-30 160-180%; 31-50 140-160%; 51-70 151-170%; >70 130%. Flickr "views": German 280%, Italian 300%. Design: flexible layouts, no snug text in graphics, don't abbreviate to fit, plan DB field widths, taller scripts need line height. — [W3C i18n text size](https://www.w3.org/International/articles/article-text-size)
- Concurrency: no primary UX source. Product docs/forums reached suggest: auto-merge non-overlapping field edits, flag only true overlaps, show who changed what, let the user choose, do not discard their work. — [PTC DocStudio conflicts](https://support.ptc.com/help/windchillrvs/r12.3.1.0/en/IntegrityHelp/webui_document_editing/resolving_conflicts.html) (via search summary; vendor doc, weak)
- Polaris empty-state URL redirected to the generic API page; no Polaris content captured. Material, Carbon beyond file 03, web.dev offline not captured.

### Inferences
- State matrix by "cause class" (our synthesis from the above plus file 03): not-yet-created (blank), setup-required, plan/tier-gated, permission-denied, no results, loading, error (field/form/page/system, with "what happened to my data"), warning (pre-failure), offline/slow, stale/conflict, session expired/interrupted, limit reached, partial, long/translated/zero-one-many content. Each screen row forces a decision (applies/N-A with reason) per class. GitLab and GOV.UK show that "gated by tier/permission" and "setup required" are distinct from "empty".
- Every system-page type (404, 500, unavailable, interruption, session timeout, maintenance) becomes an inventory row of its own, with the 500 page required to state data-preservation status.

### Gaps
- Primary sources for offline, concurrent edit, timezone/number/currency formatting, rate limits, session expiry, email/notification-as-flow not found. GOV.UK session-timeout page 404 at guessed URL.

## 4. Statecharts, XState, Mermaid

### Takeaway
Khourshid's primary pages were unreachable; only secondary confirmation of "make impossible states impossible" and boolean-flag problems. Mermaid stateDiagram-v2 supports composite, choice, fork/join, concurrency, notes, with stated restrictions; flowchart has subgraph direction caveats.

### Cited Findings
- Kent C. Dodds says he first heard "Make impossible states impossible" in Khourshid's React Rally 2017 talk; example: several boolean props can combine contradictorily, one enum type prevents it. — [Dodds](https://buttondown.com/kentcdodds/archive/make-impossible-states-impossible)
- Khourshid's talk abstract: UI complexity grows exponentially with states; finite state machines/statecharts make transitions explicit. — [HolyJS](https://holyjs.ru/en/talks/zXrnRblTtQE2G4qceUUgA/)
- Mermaid stateDiagram: `Id : Description`, `A --> B : event`, `[*]` start/end, composite `state X { ... }`, `<<choice>>`, `<<fork>>`/`<<join>>`, concurrency separated by `--`, `note right of X : text`, `direction LR`, `%%` comments. Limits: classDef not on start/end states or composite states; "You cannot define transitions between internal states belonging to different composite states." (page code blocks did not render in fetch, syntax per prose.) — [Mermaid stateDiagram](https://mermaid.js.org/syntax/stateDiagram.html)
- Mermaid flowchart: shapes via `A@{ shape: diam }` etc.; `subgraph id [Title] ... end`; edges to/from subgraphs allowed; "If any of a subgraph's nodes are linked to the outside, subgraph direction will be ignored"; lowercase "end" in node text breaks the chart (use "End"); `A---oB`/`A---xB` create circle/cross edges, add space; collapsible subgraphs need v11.17+. — [Mermaid flowchart](https://mermaid.js.org/syntax/flowchart.html)
- statecharts.dev (from file 03): hierarchy, parallel regions, guards, history.

### Inferences
- Skill should emit Mermaid with a restricted subset (flat states, one composite level, no cross-composite transitions, "End" capitalised) and validate by rendering. Use a states x events table as the coverage mechanism (every cell: transition, ignored with reason, or impossible); the diagram is a view of it.
- Boolean-flag screen specs (isLoading, hasError, isEmpty) should be replaced by one state enum per data region to forbid contradictory combos.

### Gaps
- Stately/XState docs and Khourshid's own writing not retrieved. Rendering behaviour limits of Mermaid at scale (large diagrams) not documented in what was fetched.

## 5. Forms, sign-up, validation, login walls

### Takeaway
Wroblewski: gradual engagement, delay registration; NN/g: login walls are costly except personal-data services, ask for account after value; Baymard: inline validation details; GOV.UK deliberately takes the opposite stance on blur validation. Sources conflict on when to validate.

### Cited Findings
- Sign-up often "dropped off a cliff"; gradual engagement = moving users through the service, registration delayed or backgrounded; Twitter redesign added a step yet "increased completions 29%" (author's citation). — [LukeW](https://www.lukew.com/ff/entry.asp?1128)
- NN/g (2014): login walls frustrate; justified for personal services (email, banking); show content before requiring login (oDesk) and require it at commitment; hidden guest access backfires (Yelp tablet); guest checkout, ask for password after checkout. No statistics in article. — [NN/g login walls](https://www.nngroup.com/articles/login-walls/)
- Baymard: validate on field exit for most inputs; at full length for fixed-format fields; re-check on every keystroke once an error exists so stale errors clear immediately; avoid premature validation; positive inline validation for all fields; 31% of sites lack inline validation (article text also says 32%, internal inconsistency). — [Baymard inline validation](https://baymard.com/blog/inline-form-validation)
- GOV.UK conflicts: "Do not validate when the user moves away from a field"; validate on continue/submit; server-side always required; client-side only with user need; reject impossible, ambiguous, or missing values; strip spaces/hyphens in numbers/codes; keep entries on redisplay; do not use `required`. — [GOV.UK validation](https://design-system.service.gov.uk/patterns/validation/)
- Wroblewski's Web Form Design book and SaaS sign-up drop-off benchmarks: not found. Baymard account-creation page and password requirements not fetched.

### Inferences
- Skill should record a per-form validation-timing decision and flag the Baymard/GOV.UK disagreement rather than choosing silently. Auth section of the inventory should include "account wall" decision: what is usable before sign-up, and where registration is requested.

### Gaps
- No primary SaaS sign-up drop-off benchmark found.

## 6. GOV.UK patterns for flows and error handling

### Takeaway
GOV.UK gives crisp, testable structural rules that convert directly into templates: one question per page, Back link always, Check answers with Change links returning to summary, error summary plus inline errors, page-title "Error:" prefix.

### Cited Findings
- "Asking just one question per question page helps users understand what you're asking them to do"; page heading from the legend/label; do not reuse headings across pages; group related questions when research supports (use statement heading). — [GOV.UK question pages](https://design-system.service.gov.uk/patterns/question-pages/)
- "Always include a Back link component at the top of question pages"; do not break the browser Back; for one-time actions (payment/submission) Back should show a sensible message rather than repeat the action. — same
- Check answers: Change link per section with hidden descriptive text; previous input pre-populated; Continue returns to check-answers page; if the edit needs new questions, ask them first; skipped optional questions show "Not provided"; gives users "a second chance to notice and correct errors before submitting". — [GOV.UK check answers](https://design-system.service.gov.uk/patterns/check-answers/)
- Error summary: "Always show an error summary when there is a validation error, even if there's only one"; heading "There is a problem"; each item links to the field (first field for date/radios/checkboxes); placed at top of main above h1 and below back link; keyboard focus moves to it; "Error: " prefix on page `<title>`; summary text identical to inline message; both summary and inline message required. — [GOV.UK error summary](https://design-system.service.gov.uk/components/error-summary/)

### Inferences
- Template per flow step: question (one per step), Back target, error list (summary + inline text, page title prefix), resume behaviour; per multi-step flow: check-answers step with Change targets, plus confirmation page and 500/unavailable fallbacks. Applicable to onboarding and settings wizards, not necessarily dense B2B tables.

### Gaps
- Interruption, Page not found, Service unavailable, Confirmation, Recover from validation errors pages exist but content not retrieved.
