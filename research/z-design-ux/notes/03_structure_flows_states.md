# Structure, flows, screen skeletons and state coverage (pre-UI UX design)

Scope note: ~25 tool calls. Primary-source fetches succeeded for NN/g, Hurff, statecharts.dev, Baymard, W3C, A List Apart, Carbon. ooux.com itself returned 404/no hits, so OOUX details come from secondary sources and are flagged. See Gaps in each section. "Inferences" are mine, not source claims.

## 1. OOUX / ORCA (Sophia Prater) and how it derives screens and navigation

### Takeaway
ORCA = Objects, Relationships, CTAs, Attributes: define the nouns, how they nest, who can do what to them, and what each contains, before drawing any screen. Artifacts: object list, Nested Object Matrix, CTA matrix (roles x objects), Object Map. I could not reach ooux.com; the matrix mechanics below are secondary-sourced and the screen-derivation rule is my inference.

### Cited Findings
- ORCA stands for objects, relationships, calls-to-action, attributes; used to map a system before UI work. — [LogRocket search summary](https://blog.logrocket.com/ux-design/object-oriented-ux-ooux/) (search-result summary only)
- Round structure as implemented by an AI skill based on Prater's process: Objects (Discovery: Noun Foraging, Object Litmus Test, Consolidation); Relationships (Requirements: Nested Object Matrix, MCSFD framework); CTAs (Prioritization: Role Mapping, CTA Matrix); Attributes (Representation: Metadata & Content, Object Mapping); then object-oriented design. Described as a "15-step framework"; Quick (~20 min), Working (~60 min), Full (multi-session) modes. Secondary (third-party skill, not Prater). — [s1dd4rth/ooux-skill](https://github.com/s1dd4rth/ooux-skill)
- Nested Object Matrix: an objects-by-objects grid with relationships written at the intersections (a scalable ERD); records whether one object must, may, or may not have another. Secondary summaries. — search results incl. [Fundament](https://www.fundament.design/p/introduction-to-object-oriented-ux), [Figma widget](https://www.figma.com/community/widget/1497652353465349905/ooux-cta-matrix-widget)
- CTA Matrix: roles (rows) x objects (columns) with CTAs at intersections ("what can these different roles do to these different things?"). — same search results ([Figma OOUX CTA Matrix widget](https://www.figma.com/community/widget/1497652353465349905/ooux-cta-matrix-widget))
- Object Map: color-coded inventory of attributes on objects, built after the Nested Object Matrix; "holy grail" of ORCA. Secondary. — search result summary (Figma [ORCA Object Mapper](https://www.figma.com/community/widget/1486019986354610848/ooux-orca-object-mapper))
- Prater's A List Apart article: "designing objects before actions"; objects are real-world things in the user's domain; prioritize which objects make the MVP; validate relationships with users via a clickable prototype. — [ALA, OOUX: A Foundation for Interaction Design](https://alistapart.com/article/ooux-a-foundation-for-interaction-design/)
- Same article: object elements are core content, metadata (needs special handling for input/sort/filter, e.g. price, date, location, rating) and nested objects; CTAs are entry points to interaction flows attached to objects; CTA brainstorming often loops back to revise objects. — same
- Same article: high-fi "CTA Inventory" spreadsheet columns: Why (goal), Who (persona/role/permission), Where (places it appears), Complexity, Priority (launch/later/needs research), Questions. CTAs can be conditional (chef sees edit/delete on own recipes, favorite on others'). — same
- Same article does NOT explain deriving screens and does not use the word ORCA or "nested object matrix"; it says the matrix is the CTA inventory spreadsheet. (Terminology differs between sources.) — same
- Banking example (secondary): objects Accounts, Transactions, Users, Recipients; nesting User > Account > Transaction > Recipient; navigation follows object hierarchy and CTAs appear where their object is shown, e.g. transaction actions inside account detail, not a generic home action. Article does not define screens/roles itself. — [LogRocket](https://blog.logrocket.com/ux-design/object-oriented-ux-ooux/)

### Inferences
- Screen derivation rule (my synthesis, consistent with the sources): per object, expect at minimum a collection/list view, a detail view, and create/edit surfaces; one nav item per top-level object; nested objects appear inside parent detail; each CTA row in the CTA matrix needs a home surface and each role column implies visibility variants. This gives a mechanical screen inventory and surfaces permissions early.
- Template to use: Objects list (name, definition, litmus-test pass); Nested matrix (rows/cols = objects, cell = "has many / has one / may have / none"); CTA matrix (rows = roles, cols = objects, cells = verbs, mark conditional rules); Object Map (per object: core content, metadata, nested objects, CTAs, states/lifecycle).
- For B2B SaaS the role dimension (admin/member/viewer/billing owner) and organization/workspace/team nesting are exactly what the matrices force out.

### Gaps
- ooux.com primary pages (ORCA rounds, Object Litmus Test criteria, MCSFD expansion, matrix cell conventions) were unreachable; exact definitions unverified. MCSFD expansion not found.
- No source found stating a formal "objects -> screens" derivation algorithm from Prater.

## 2. Information architecture (card sorting, tree testing, Covert, sitemaps)

### Takeaway
Card sort (generative) then tree test (evaluative) is the standard pairing for structure and labels. Covert's method starts with intent and scope before structure. Rosenfeld/Morville, sitemaps and SaaS taxonomy were not retrieved.

### Cited Findings
- Card sorting is a discovery method run early; reveals how users group content; does not produce a final structure. Tree testing is evaluative: checks findability in an existing or proposed hierarchy, compares alternatives, exposes unclear labels. Sequence: card sort, draft structure with your judgment, tree test and refine. — [NN/g card sorting vs tree testing](https://www.nngroup.com/articles/card-sorting-tree-testing-differences/)
- Covert, How to Make Sense of Any Mess: seven steps; first five per a review: identify the mess; state your intent (who, why, what); face reality (scope, context, constraints, visual maps); choose a direction (relationships among objects, people, places); measure the distance (goals and indicators). IA is "the way that we arrange the parts of something to make it understandable as a whole." Steps 6-7 not found. — [UXmatters review](https://uxmatters.com/mt/archives/2016/02/information-architecture-in-review-part-1.php) (via search result)

### Inferences
- For a skill: IA work for a new product with no users can't run card sorts, so use OOUX object hierarchy as the first-draft nav and flag labels for later tree testing.

### Gaps
- Rosenfeld/Morville (four systems: organization, labeling, navigation, search) not fetched; sitemap notation, content inventory/audit method, SaaS taxonomy conventions, navigation models (hub-spoke, global/local, utility nav) not researched. Sample sizes for card sort/tree test: the NN/g page gives none.

## 3. Flow artifacts: user flow, task flow, wireflow, journey, blueprint

### Takeaway
Different altitudes: journey (macro, multi-channel, feelings), user flow (one product, minutes-hours, steps and system responses), wireflow (flow drawn as screens), service blueprint (journey plus frontstage/backstage/process/evidence lanes).

### Cited Findings
- User journey: "scenario-based sequence of the steps that a user takes in order to accomplish a high-level goal", multi-channel, days to months, records think/feel, macro. User flow: "set of interactions that describe the typical or ideal set of steps", one product, minutes/hours, micro, key user actions and system responses; often shown as wireflow, flowchart, or task diagram. — [NN/g journeys vs flows](https://www.nngroup.com/articles/user-journeys-vs-user-flows/)
- Wireflow: wireframe-style screens plus flowchart-like arrows; components: step screens, hotspot arrows pointing at the exact control, result states (new screen, same page with changed content, confirmation popup, error); partial screens for desktop. Use for apps with interactive controls (configurators, checkout); avoid for static multi-page sites. Notation advice: make the trigger hotspot unambiguous, show feedback states explicitly, reuse the same page when only content changes, start low-fi. — [NN/g wireflows](https://www.nngroup.com/articles/wireflows/)
- Service blueprint: diagram of relationships among service components for one specific customer journey; lanes: customer actions, frontstage, backstage, processes, evidence; lines of interaction/visibility/internal interaction; reveals internal dependencies and handoffs; "part two" to journey maps. — [NN/g service blueprints](https://www.nngroup.com/articles/service-blueprints-definition/)
- The NN/g journeys-vs-flows page does not define "task flow" and I found no NN/g definition of it.

### Inferences
- Flow notation checklist for the skill (my synthesis from the wireflow guidance and statechart concepts): each flow lists entry points (all of them: nav, email link, deep link, invite), decision points with every branch, system responses/feedback, exits (success, cancel, abandon, error), and re-entry/resume. Mermaid `flowchart` for flows and `stateDiagram-v2` for screen/object state; not verified against Mermaid docs in this research.

### Gaps
- Mermaid syntax/practices not researched. Task flow vs user flow distinction from a primary source not found. Entry-point/exit conventions have no direct source here.

## 4. Task analysis and enumerating tasks per role

### Takeaway
Hierarchical Task Analysis breaks a goal into numbered tasks/subtasks with "plans" for conditional ordering; per-role enumeration is by repeating per user type.

### Cited Findings
- Task analysis studies how users complete tasks; a task has an observable start and end. HTA: goal and scenario, broken into major tasks and subtasks to a chosen granularity, numbered hierarchically (1, 1.1); "plans" record order and conditions (e.g. forgotten password) and novice/expert differences. Inputs: contextual inquiry, critical incident interviews, diaries. Analyze task count, frequency, cognitive complexity/error likelihood, time. — [NN/g task analysis](https://www.nngroup.com/articles/task-analysis/)

### Inferences
- Plans with conditions are a natural place to surface non-happy-path branches (forgotten password, expired invite). Use frequency x criticality to prioritize screens. A role x task table cross-checks the CTA matrix.

### Gaps
- No source on role-based task enumeration templates or JTBD mapping.

## 5. Screen inventory / screen list

### Takeaway
No authoritative practitioner source on a canonical screen-inventory template was retrieved; derive it from the OOUX matrices and the state/ancillary checklists in this file.

### Cited Findings
- (none directly on screen inventories)
- Carbon treats empty/error/no-permission as surfaces replacing the missing element — [Carbon empty states](https://carbondesignsystem.com/patterns/empty-states-pattern/)

### Inferences
- Inventory categories to sweep (my checklist, not sourced): core object list/detail/create/edit per object; onboarding and first-run; auth (sign-up, sign-in, reset, verify, SSO, MFA); account/profile; organization/team/members/roles/invites; billing/plan/limits/upgrade; settings and integrations; notifications (in-app, email, push) with templates; admin; search results; error pages (404, 403, 500, offline, maintenance); legal/consent; help/support. Each row: screen, object, role visibility, entry points, states covered, source CTA.

### Gaps
- Needs a sourced practitioner template; not found in the time budget.

## 6. Content-first, priority guides, low-fi wireframes

### Takeaway
Priority guides / content reference wireframes specify content and hierarchy with real copy, not layout or style.

### Cited Findings
- Priority guide: list of a screen's content and elements ordered top to bottom by user relevance, no layout; steps: determine goals, research users, list content topics, rank (question whether each belongs), detailed guide with real content, functionality, annotations and links between pages, test and iterate. Excludes lorem ipsum, layout/visual design, the repeated menu; a discussion tool rather than deliverable; works with responsive design; gives developers HTML-like structure and testers an early checklist. — [A List Apart: Priority Guides](https://alistapart.com/article/priority-guides-a-content-first-alternative-to-wireframes/)
- Priority guides credited to Drew Clemens in a 2012 Smashing Magazine article; Smashing 2016 "Creating Content Wireframes for Responsive Design" describes content reference wireframes: order of content importance rather than page flow. Only seen via search snippets. — [Smashing 2016](https://www.smashingmagazine.com/2016/02/create-content-wireframes-for-responsive-design/), [ALA](https://alistapart.com/article/priority-guides-a-content-first-alternative-to-wireframes/)
- Wireflow guidance: start low-fi for discussion, hi-fi only when detailed specs needed. — [NN/g wireflows](https://www.nngroup.com/articles/wireflows/)

### Inferences
- A low-fi skeleton spec per screen: purpose, primary action, ordered content blocks with real sample copy, actions with outcomes, data fields from the Object Map, states list, role variants. Explicitly omit colors, type, imagery style.

### Gaps
- Heleen van Nieuwenhuijzen's guide itself was not found.

## 7. States coverage

### Takeaway
Enumerate per screen and per data region: ideal, empty (first-use / cleared / no results / no permission / error), loading, partial, error, plus destructive actions, offline, permissions and concurrency.

### Cited Findings
- UI Stack (Hurff): five states: ideal, empty (first use, user cleared data, search with no results), error, partial (some data, sparse; progress cues toward ideal), loading (skeleton screens; optimistic success for likes/comments). Design ideal first, others lead back to it. Error: never delete what the user entered. — [Scott Hurff](https://www.scotthurff.com/posts/why-your-user-interface-is-awkward-youre-ignoring-the-ui-stack/)
- Empty states (NN/g): do not default to totally empty states; don't show "no records" while still loading; give learning cues; give a direct path to the key task; include how, not just what. — [NN/g empty states](https://www.nngroup.com/articles/empty-state-interface-design/)
- Carbon empty-state types: no data (first use), no results, confirmation, cleared/deleted data (as use case), error, no permission (with steps to request access). Guidance: replace the missing element, one primary action, no dead ends, limit repeated illustrations when many widgets are empty, illustrations decorative with empty alt. — [Carbon](https://carbondesignsystem.com/patterns/empty-states-pattern/)
- NN/g error messages (14 guidelines): place near source; redundant cues, not color alone; severity-matched presentation, modals only for severe; don't error too early; plain language; specific; constructive remedy; non-blaming; avoid humor; safeguard against likely mistakes; preserve input; reduce correction effort; educate concisely; total failure last resort. — [NN/g error-message guidelines](https://www.nngroup.com/articles/error-message-guidelines/)
- Loading: under 1s no indicator; 1-10s skeleton for full-page, spinner for a single element; over 10s progress bar with estimate; skeletons only for full-page loads; avoid frame-only skeletons. — [NN/g skeleton screens](https://www.nngroup.com/articles/skeleton-screens/)
- Destructive actions: confirmation dialogs only for serious consequences; specific (name item, effect), outcome-labelled buttons, no default "Yes"; typing-a-word for rare extreme cases; undo is the stronger protection and complementary. — [NN/g confirmation dialogs](https://www.nngroup.com/articles/confirmation-dialog/)

### Inferences
- Full per-screen state checklist (union of the above plus my additions, unsourced where marked): ideal; first-use empty; cleared empty; no-results (with filter reset); partial/onboarding progress; loading (initial, refresh, pagination, inline action); error (field, form, section, page, system; retry); no permission / read-only / role-gated (my addition); offline/slow network (my addition); destructive confirm/undo; long text, i18n expansion, missing optional data, very large lists, zero/one/many (my addition); concurrency/conflict (double submit, stale edit, double booking) (my addition); expired session; rate/plan limits (my addition).

### Gaps
- Polaris, GitLab Pajamas (auth redirect), Atlassian, Material state guidelines not retrieved. No sourced edge-case checklist, offline, concurrency, or i18n source found.

## 8. Statecharts for UI

### Takeaway
Statecharts add hierarchy, parallel regions, guards and history to flat state machines, useful for enumerating UI states and legal transitions.

### Cited Findings
- Statecharts extend state machines with hierarchical substates, parallel (orthogonal) regions all active together, guards (condition on transition), history states, plus automatic and delayed transitions. — [statecharts.dev](https://statecharts.dev/what-is-a-statechart.html)

### Inferences
- The page does not claim it prevents state explosion/impossible states; that benefit (parallel regions avoid cross-product states; guards constrain combinations) is my reading. Use a state diagram for any screen with async data x form x permission combinations; list each state/event pair and ask "what happens?" to find missing transitions.

### Gaps
- Khourshid/XState writing not fetched; Mermaid stateDiagram not verified.

## 9. Accessibility upstream

### Takeaway
Structure decisions (focus order, error identification, redundant entry, authentication, target size) are set at skeleton level.

### Cited Findings
- Focus Order 2.4.3: order should match meaning and allow operation; may differ from visual layout if meaning is preserved. — [W3C Understanding 2.4.3](https://www.w3.org/WAI/WCAG22/Understanding/focus-order.html)
- WCAG 2.2 adds 9 criteria: Focus Not Obscured (min AA, enhanced AAA), Focus Appearance (AAA), Dragging Movements (AA), Target Size min 24x24 CSS px (AA), Consistent Help (A), Redundant Entry (A), Accessible Authentication (AA min, AAA enhanced); 4.1.1 Parsing removed. — [W3C What's new in WCAG 2.2](https://www.w3.org/WAI/standards-guidelines/wcag/new-in-22/)
- Don't rely on color alone for errors; use border, icon, text. — [NN/g error guidelines](https://www.nngroup.com/articles/error-message-guidelines/)
- Carbon: empty states replace the empty table/structure so screen readers don't read an empty shell. — [Carbon](https://carbondesignsystem.com/patterns/empty-states-pattern/)

### Inferences
- Skeleton annotations to add: heading outline, landmark regions, focus order, drag alternatives, help placement consistent across pages.

### Gaps
- Heading structure/landmark guidance from WAI not fetched.

## 10. Forms and sign-up flows

### Takeaway
Fewer fields, single column, specific errors, preserve input, and delay account creation matter most for sign-up drop-off. Baymard data is checkout-specific; applying it to SaaS sign-up is extrapolation.

### Cited Findings
- Baymard: avg 2024 checkout has 11.3 fields (12.7 in 2019); ~8 needed; field count affects usability more than step count; 17% abandoned due to checkout complexity. 42% typed full name in first-name field; single full-name field made only 4% hesitate; 30% stopped at Address Line 2; 84% of sites don't delay account creation until after the order; account creation at confirmation needs only password fields. — [Baymard](https://baymard.com/blog/checkout-flow-average-form-fields)
- NN/g form guidelines: keep it short; group labels with fields; single column; logical sequence, test Tab order; avoid placeholder text as label; match input type to options; mark optional fields; state input requirements up front (passwords); avoid Reset/Clear; visible, specific errors with preserved input. Inline validation not addressed on that page. — [NN/g web form design](https://www.nngroup.com/articles/web-form-design/)
- WCAG 2.2 Redundant Entry, Accessible Authentication (see section 9).

### Inferences
- Sign-up improvement audit: field inventory (justify each), social/SSO and magic-link options, password rules shown up front, paste/password-manager support, error recovery for existing-account and unverified-email states, verification email flow (resend, expired, wrong inbox), post-signup first-run empty state.

### Gaps
- Wroblewski's Web Form Design not fetched; no sourced data on SaaS sign-up drop-off, inline validation, or social login effects.
