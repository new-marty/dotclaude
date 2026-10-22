# Visual direction, design-system direction, and handoff before high-fidelity UI

Scope note: ~25 tool calls (WebFetch/WebSearch). Several claims come via search-engine summaries rather than the primary page; these are marked "(search summary)". Items I could not verify are under Gaps. Date of research: 2026-10-20.

## 1. Visual direction exploration: style tiles, element collages, mood boards, divergent-then-converge

### Takeaway
Pros set visual direction with deliberately low-fidelity, layout-free artifacts (style tiles, element collages) that show fonts, colors and a few real interface elements, so stakeholders react to a look without committing to page layouts. Direction is derived from client adjectives/themes, and several options are shown so the reaction itself is data. Brad Frost's process says "paint the broad strokes first" and keep everything in the browser afterwards.

### Cited Findings
- Style tile = "fonts, colors and interface elements" that convey a visual brand; it does not define layout. Analogy: paint chips and fabric swatches an interior designer gets approved before designing a room. — [styletil.es](https://styletil.es/)
- Style-tile process: Listen (kickoff, surveys) -> Interpret (client adjectives and themes become design principles) -> Define visual language (compose the tile; "a point of reference to determine if you both are on the same page") -> Iterate (revise styles outside of layout). — [styletil.es](https://styletil.es/)
- Tiles let designers "present clients with interface choices without making the investment in multiple photoshop mockups"; "Presenting multiple tiles gives you information to work with." The page does not prescribe a number of tiles. — [styletil.es](https://styletil.es/)
- Adjectives are not a tile component themselves; they are gathered, grouped into themes, then matched to styles. — [styletil.es](https://styletil.es/)
- Atomic Design ch. 4 establishes direction with three tools: a "20-second gut test" (stakeholders rate ~20-30 sites, 20 s each, to surface aesthetic preferences), style tiles ("explore color, typography, texture, icons" without layout or polish), and element collages ("a playground for designers to apply design atmosphere to actual interface elements", free of layout and high polish). Core principle: "paint the broad strokes first." Mood boards are not mentioned in the chapter. — [Atomic Design ch.4](https://atomicdesign.bradfrost.com/chapter-4/)
- Element collage (Dan Mall): static document of the components the team is most eager to design, not whole pages; several approaches per element are made to "weigh the value of any given approach"; considers a wide range of viewports; used as a basis for critique with clients, not sign-off, to agree a direction "to continue exploring"; then a baseline style is picked and refined in browser prototypes. Diagram abandoned full-page comps because they couldn't show multiple widths, interactivity or browser type rendering. The Diagram author prefers collages to style tiles / style prototypes because they balance specificity and abstraction, "though they aren't always the right choice." — [Diagram](https://www.wearediagram.com/blog/using-element-collages-to-improve-the-design-process)
- Mall's motivation (secondary): he finds mood boards and wireframes too abstract; the name signals a loose assembly rather than a finished design; teams test everything from buttons/forms to progress diagrams; states can be shown isolated or in context. Mall's original 2012 post was not retrieved. — [search summary](https://v3.danmall.com/articles/rif-element-collages), [Cloud Four](https://cloudfour.com/thinks/element-collages-are-fun/) (each designer made a unique collage with notes on palette, imagery, typography)
- Atomic design stage 5 note: "Dan Mall uses collages of key organisms to shape visual direction and spark client conversations without building full comps." Static comps become hypotheses; "Once the designs are in the browser, they should stay in the browser." — [Atomic web design](https://bradfrost.com/blog/post/atomic-web-design/), [ch.4](https://atomicdesign.bradfrost.com/chapter-4/)
- Mailchimp voice/tone is an example of mapping attributes to behavior: four voice principles (Plainspoken, Genuine, Translator, Dry humor), each glossed with a concrete clause (e.g. "prefer winking to shouting"; avoid "fluffy metaphors and cheap plays to emotion"); "You have the same voice all the time, but your tone changes" with tone shifting by reader emotional state. — [Mailchimp](https://styleguide.mailchimp.com/voice-and-tone/)

### Inferences
- A direction artifact for the skill should contain: (a) the adjective-theme-principle chain, (b) 2-3 divergent candidate directions each as tokens-level swatches (type, palette, shape/density, imagery) plus 2-4 real elements from this product (hero, a form, a data row), (c) a chosen direction with the reason traced to audience/context, and (d) what was rejected and why. Style tiles supply (b)'s swatches; element collages supply the "real elements" part. This is my synthesis; no single source defines it.
- Because the sources keep layout out of these artifacts, layout/skeleton should be a separate artifact (see section 7).
- Mood boards are the weakest of the tools by the sources' own lights (Mall: too abstract; Frost's chapter omits them); use them only as a cheap divergence step.

### Gaps
- No primary Dan Mall page (2012 element-collage post) retrieved; styletil.es sub-pages (/about) returned 404 so the exact tile contents list (e.g. texture, imagery) is unverified beyond the home page.
- No source found on a numeric rule for how many divergent directions to present (3 is common practice but not cited).

## 2. Brand attributes / tone words to visual decisions; how principles are written (good vs bad)

### Takeaway
A principle is only useful if it helps a team say no and its opposite is something a reasonable team could choose; "A even over B" is the quick form. Tone words ("friendly") only become design inputs when paired with a "not that" and tied to concrete behaviors, as Mailchimp does.

### Cited Findings
- Spool's two tests as relayed by Brad Frost: does the principle distinguish your design from competitors', and is it something you might reverse in a future release. Jeremy Keith's reversibility test: "could you imagine the exact opposite of the design principle being perfectly valid in a different organisation or on a different project?" Frost notes generic principles can still be useful where the audience needs them spelled out. — [Brad Frost](https://bradfrost.com/blog/link/in-the-future-design-principles-wont-be-about-design/); Spool's original UIE article not retrieved.
- Matt Strom's four criteria: memorable; helps you say no; not a truism (opposite is something a reasonable person might believe); applicable across platforms/disciplines. Good/bad pairs: "One primary action per screen" (good) vs "Keep the number of actions per screen to a minimum" (bad, vague); "Don't solve every edge case" (good) vs "Make users happy" (bad); "Use an 8 pixel grid" is a bad principle (platform-specific). Shortcut: "(Choice A) even over (Choice B)", e.g. "Accessibility even over aesthetics". — [Matt Strom](https://mattstromawn.com/writing/principles)
- Julie Zhuo (search summary): strong principles should be controversial, explaining a decision your company would make and another wouldn't. — [Inside Intercom](https://www.intercom.com/blog/podcast-julie-zhuo-on-product-design/)
- Intercom's five principles, whose stated purpose is deciding between options that are each valuable: Connected, modular systems; Opinionated by default, flexible under the hood; Follow the fundamentals ("favor established best practices and avoid overly clever, non-standard design patterns"); Make it feel personal; What you ship is what matters. — [principles.design](https://principles.design/examples/intercom-design-principles)
- GOV.UK's 11 principles (e.g. "Start with user needs", "Do the hard work to make it simple", "Be consistent, not uniform", "This is for everyone") — each is a title plus an elaborating sentence. — [GOV.UK](https://www.gov.uk/guidance/government-design-principles)

### Inferences
- GOV.UK and Intercom both mix reversible/distinctive principles ("Be consistent, not uniform"; "Opinionated by default") with near-truisms ("Start with user needs"); for a skill, enforce Strom's tests: each principle is "A even over B", has a stated visual consequence, and a rejected alternative.
- Suggested format per principle (my design): `principle | even over | visual consequence (type/color/shape/density/motion) | what the implementer must NOT do`. Pairing with Mailchimp-style one-line behavior glosses keeps tone words actionable.
- "This but not that" spectra for brand attributes: I did not find a primary Dan Mall source; treat as a common practice requiring a source.

### Gaps
- Could not find a primary source for Dan Mall's "this/not that" or attribute-spectrum technique.
- Spool's original article and Intercom's own blog post were not read in full.

## 3. Atomic Design, interface inventory, and when to start a design system

### Takeaway
The inventory-first / pilot-project approach is established: collect real patterns (inventory) or build patterns while building real screens, then name and rationalize them. Visual direction comes first via style tiles/collages; the system is "sculpted in iterative loops" alongside project work, not completed upfront.

### Cited Findings
- Interface inventory: screenshot distinct treatments of each component (not every instance), categorize side by side; it "exposes redundancy", separates intentional from accidental variation, and is "the first step at deconstructing pages down to their atomic level." — [Brad Frost](https://bradfrost.com/blog/post/interface-inventory/)
- Inventory in ch.4: time-box roughly 30-90 min, cross-disciplinary, main value is persuasion and shared vocabulary. — [Atomic Design ch.4](https://atomicdesign.bradfrost.com/chapter-4/)
- Building alongside projects: front-end devs "prep chefs" start markup early; patterns built in the browser then reused across templates; as patterns mature "new templates become mostly a matter of assembling existing parts"; system "sculpted in iterative loops, building up fidelity." — [ch.4](https://atomicdesign.bradfrost.com/chapter-4/)
- Atomic stages: atoms, molecules ("do one thing and do it well"), organisms, templates (grayscale wireframes gaining fidelity), pages (real content); pages are where you test variations (long headlines, cart states) and feed fixes back to templates and organisms. — [Atomic web design](https://bradfrost.com/blog/post/atomic-web-design/)
- Frost: Smashing Conf 2019 workshop builds a system's components "and several screens of a real pilot project" simultaneously (search summary). — [Smashing Conf](https://smashingconf.com/sf-2019/speakers/brad-frost/)
- Nathan Curtis "Starting a Design System" (2017) exists; page returned HTTP 403 so contents not read. Curtis frames a design system as a product, not a project (search summary). — [Medium](https://medium.com/eightshapes-llc/starting-a-design-system-6b909a578325)
- Dan Mall's Design That Scales is positioned against "design system graveyards"; stresses fit with users' workflow (search summary). — [Better Read](https://www.betterread.com.au/book/design-that-scales-creating-a-sustainable-design-system-practice.do)

### Inferences
- Frost's inventory is of an existing interface; for a greenfield product the equivalent is extracting recurring patterns from the first designed screens ("pattern ledger"): after each screen, record any element used 2+ times (name, variants, states, where used), and promote to a named pattern at the 2nd-3rd occurrence. The sources support the principle (build with real screens) but the "rule of 2-3" threshold is my interpretation, not cited.
- Direction-level deliverables to define upfront: principles, type/palette/shape/density/motion stance, a few token primitives; defer components.

### Gaps
- Nathan Curtis's explicit guidance on timing not retrieved (403). No primary source for a "rule of three" threshold.

## 4. Design tokens (DTCG) and tiering

### Takeaway
The DTCG format (2025.10 stable; a September 2026 draft is in progress) gives a JSON file format for tokens with types, descriptions and aliases; the tier model (primitive/semantic/component) is community convention, not part of the spec.

### Cited Findings
- DTCG: JSON; media type `application/design-tokens+json` (`application/json` allowed); extensions `.tokens` / `.tokens.json`; object with `$value` = token, otherwise group; `$type`, `$description`, `$extends`, `$deprecated`, `$extensions`, `$root`; aliases via `{group.token}` or `{"$ref": "#/..."}`; tools must not infer types; circular references are errors. Types: color, dimension, fontFamily, fontWeight, duration, cubicBezier, number, plus composite strokeStyle, border, transition, shadow, gradient, typography. Latest published version 2025.10; the page fetched is a preview draft dated 8 Sept 2026 "should not be cited as authoritative." — [DTCG draft](https://www.designtokens.org/tr/drafts/format/)
- Three-tier convention (core/primitive raw values; semantic = design decision about usage; component references semantic); each tier references only the tier above; "--blue-500 is a fact, --color-accent is a decision, --button-bg is a location." Common failure: jumping to component tokens. — [UHC Abyss tokens intro](https://abyss.uhc.com/web/theme-customization/tokens/tokens-intro), [search summary of tier guidance](https://www.alwaystwisted.com/articles/design-token-naming-conventions)

### Inferences
- At direction stage emit only primitives + a small semantic layer (surface, text, accent, border, danger/success, focus) in DTCG JSON; component tokens are extracted later from the pattern ledger.
- Caveat: tier guidance sources are vendor design-system docs/blogs, not the spec; Curtis's own token article was not retrieved.

### Gaps
- Curtis's tokens article not read; Style Dictionary/Tokens Studio compatibility with the 2025.10 format not checked.

## 5. Typography, color roles, contrast, density at direction level

### Takeaway
Hard rules available: WCAG 2.2 contrast thresholds. Pairing, scale and density guidance mostly comes from the frontend-design skill itself; I found little primary pro-literature on density in this pass.

### Cited Findings
- WCAG 2.2 SC 1.4.3: 4.5:1 normal text, 3:1 large text (>=18pt or 14pt bold, about 24px / 18.5px); non-text UI/graphics fall under 1.4.11 (3:1). — [W3C Understanding 1.4.3](https://www.w3.org/WAI/WCAG22/Understanding/contrast-minimum.html) (the 3:1 value for 1.4.11 is from my knowledge of the SC; the page only names it)
- WCAG 3 is still an incomplete draft (latest Working Draft 3 March 2026); not expected to be a standard for some years; APCA was reported not to be in the draft as of a 2024 co-chair update; its 2026 status is unconfirmed. — [W3C WCAG 3 intro](https://www.w3.org/WAI/WCAG3), [W3C news 2026-03-03](https://www.w3.org/WAI/news/2026-03-03/wcag3), [Yatil](https://www.yatil.net/blog/wcag-3-is-not-ready-yet)
- frontend-design skill typography stance: one or two typefaces, if two clearly distinct; deliberate scale following The Elements of Typographic Style; lines under 80 characters; serif body gets slightly more line-height. — [SKILL.md](https://raw.githubusercontent.com/anthropics/skills/main/skills/frontend-design/SKILL.md)
- Taste-skill (community) exposes three dials: VARIANCE, MOTION, DENSITY (search summary; star counts disagree between sources). — [x-cmd](https://x-cmd.com/install/taste-skill/)

### Inferences
- Direction-level type decision rule to record: for each of display/body/data, role + candidate family + the reason (subject-derived) + fallback stack + size scale ratio + line-length cap. Color: 4-6 named base values plus semantic roles; verify AA (4.5/3) at direction stage using WCAG 2.2; treat APCA as optional supplementary check.
- Density: a three-way setting (airy / comfortable / dense) tied to audience and task (consumer browsing vs analyst scanning) recorded with consequences (row height, type size floor, spacing unit). Not sourced; mark as proposal.

### Gaps
- No primary source gathered on type-scale ratios, font-pairing rationale, or consumer-vs-enterprise density (Material density, Carbon, Polaris etc.). No APCA primary source (Myndex) fetched.

## 6. Reference gathering practice

### Takeaway
Practitioners treat references as evidence of a decision pattern (task, friction removed, why it works in context), not as screens to reproduce; different galleries serve different questions.

### Cited Findings
- Guide advice: understand the decision behind a reference; ask what task the screen helps complete, what pattern reduces friction, why it works in that context, what principle is adaptable. Tool split: Mobbin/Pttrns for UI pattern research, Page Flows/Refero for screen sequencing, Behance/Dribbble as direction only. — [Procreator](https://procreator.design/blog/sources-mobile-web-app-design-inspiration/) (agency blog, low authority)
- No industry standard on what counts as copying was found (search summary of same results).
- Anthropic's skill itself says typical AI output clusters around specific defaults and asks the designer to check the plan against what it would produce for "any similar page." — [SKILL.md](https://raw.githubusercontent.com/anthropics/skills/main/skills/frontend-design/SKILL.md)
- Frost's Interface inventory and ch.4's 20-second gut test are the established "comparative" tools: both collect examples and have stakeholders react. — [inventory](https://bradfrost.com/blog/post/interface-inventory/), [ch.4](https://atomicdesign.bradfrost.com/chapter-4/)

### Inferences
- Reference record format (mine): `source URL | what it is | what to borrow (structural pattern, not look) | what NOT to borrow | why it fits our audience`. Two sets: pattern references (Mobbin/Refero/Page Flows for flows) vs atmosphere references (Godly, Land-book, footer.design, cta.gallery, 404s.design, bentogrids.com for specific sections). The latter sites were not individually researched.
- Subject-world references (materials, vernacular, domain artifacts, print, signage) beat in-category UI references for distinctiveness, aligned with the Anthropic skill's "Ground your designs in the subject matter."

### Gaps
- Godly, Land-book, footer.design, cta.gallery, 404s.design, bentogrids.com and Refero not opened; no verified claims about them.

## 7. What Anthropic's frontend-design skill consumes, and other anti-slop skills

### Takeaway
The current frontend-design SKILL.md (fetched via curl from main, 71 lines) wants a brief naming subject, audience and primary job, and itself produces a short plan (4-6 named hex colors, type roles, layout concept with ASCII wireframes plus alignment, principles). A handoff matching this shape lets it skip invention and spend its effort on execution and self-critique. Note this is a different, newer text than the older "bold aesthetic direction" version many blogs describe.

### Cited Findings (all from [SKILL.md](https://raw.githubusercontent.com/anthropics/skills/main/skills/frontend-design/SKILL.md))
- Frontmatter: name `frontend-design`; description "Guidance for distinctive, intentional visual design when building new UI or reshaping an existing one."
- Inputs expected: "If the brief does not identify what the product or subject matter is, identify it yourself ... one concrete subject, the design's audience, and the design's primary job." Memory/client preferences are used as hints.
- "Where the brief pins down a visual direction, follow it exactly — the brief's own words always win, including when it asks for one of these [default] looks. Where it leaves an axis free, don't spend that freedom on one of these defaults."
- Process: two passes. Pass 1 design plan: Color = "4-6 named hex values"; Type = typefaces and roles; Layout = layout concept in one-sentence prose and ASCII wireframes, with alignment guidance; Principles = what makes the page unique. Then review against the brief for generic defaults and revise, saying what changed and why; then build; then self-critique with screenshots.
- Listed AI-default clusters: cream (#F4F1EA) + high-contrast serif + terracotta (#D97757); near-black + acid green/vermilion; broadsheet hairline rules and zero radius; SaaS-card kit (identical rounded cards, same radius/shadow, gradient washes); template chrome (tracked ALL-CAPS eyebrows, middle-dot meta strings, "WORD — fragment" labels, tinted near-black, monospace data labels, "->" on links).
- Typography tells to avoid: accenting one word in a headline, all-caps labels, unnecessary labels above content. Structural devices (borders, numbering, dividers) must encode information; numbered markers only for true sequences.
- Hero: open with "the most characteristic thing in the subject's world"; avoid default "big number, small label, supporting stats, gradient accent."
- Motion: sparing; one orchestrated moment; user-triggered motion welcome.
- Restraint: "Spend your boldness in one place"; quality floor: responsive to mobile, visible keyboard focus, reduced motion, accessibility, harmonious color.
- Copy: no real content in briefs often, so it invents copy; writing guidance (user's words, active voice, consistent action names, errors and empty states explain and direct, sentence case).
- Other skills (search summary only): Taste-skill (VARIANCE/MOTION/DENSITY dials), Hallmark (MIT, 57 tests for generic AI patterns), Frontend Prime, Impeccable; common diagnosis "default output is an average of common patterns" and the fix is a stronger brief and references. Sources are blogs/marketplaces. — [Mejba](https://www.mejba.me/blog/top-tools-fix-claude-code-ai-slop), [x-cmd](https://x-cmd.com/install/taste-skill/), [Medium](https://medium.com/@porter.nicholas/anthropic-skills-marketplace-the-anti-ai-slop-ui-design-skill-a572d0cfef4f)

### Inferences
- Handoff should supply, in the skill's own vocabulary: subject / audience / primary job; 4-6 named hex colors (+ semantic roles); type roles with chosen families; layout concept per key screen with ASCII wireframes and alignment; principles with "even over" statements; explicit "default-avoidance" list for this brief (which of the five clusters were considered and rejected). Since "the brief's own words always win", the handoff's direction should be written as explicit directives, not suggestions, and say which axes are intentionally left free.
- Also hand over the single "memorable moment" (hero or signature element) and the real content/copy so the implementer need not invent it.
- The skill carries the quality floor itself; the handoff should still list screen states and a11y specifics that a general quality floor will not know.

### Gaps
- Other skills' files (Hallmark, Impeccable, taste-skill) not read directly; their input contracts are unverified.
- Skill text may change; recheck before shipping the handoff schema.

## 8. Handoff content: Dev Mode, annotations, specs, what engineers say is missing, prototype-as-spec

### Takeaway
Modern handoff (Figma Dev Mode) is annotated, status-tagged design plus tokens and code, not redlines; the recurrent practitioner complaint is missing non-happy-path states, between-breakpoint behavior, and unstated rationale. Code prototypes are increasingly used as the spec but evidence is anecdotal.

### Cited Findings
- Figma Dev Mode (search summary of help pages): annotations (free text or layer properties like alignment/sizing, categorizable), saved measurements via Shift+M, and "Ready for dev" status on sections/frames/components with a Ready-for-dev view showing what's ready, changed, done. Annotations available on paid plans; editing needs a Full seat. — [Figma Dev Mode guide](https://help.figma.com/hc/en-us/articles/15023124644247), [Figma design handoff](https://figma.com/design-handoff/)
- Missing in handoffs (vendor/practitioner blogs, not surveys): loading, empty, error, permission/constraint states; responsive variants and behavior between shown sizes; behavior over time (motion, progressive disclosure); rationale (constraints, research); developer "what if" questions (e.g. no profile photo). Fix: map each component's states and their triggers, turn into acceptance criteria. — [Figr](https://figr.design/blog/developer-handoff-playbook-tools-templates-and-best-practices-for-cross-functional-teams), [Sizzy](https://sizzy.co/blog/design-to-dev-handoff), [Miro](https://miro.com/software-development/developer-designer-handoff/)
- Prototype-as-spec: a team (Dust) made prototypes their default artifact; engineers reuse components and read code; limitations: no real latency/loading/backend weirdness, preview-comment feedback unreliable. Other reports say prototype code integrates poorly with mature codebases; no controlled study found. — [uxdesign.cc field study](https://uxdesign.cc/field-study-prototypes-over-mockups-8581f20102ff) (via search summary), [ADPList](https://adplist.substack.com/p/why-i-stopped-prototyping-in-figma)
- Frost: pages are where to test variations (long headlines, cart states) and feed refinements back. — [Atomic web design](https://bradfrost.com/blog/post/atomic-web-design/)

### Inferences
- For an LLM implementer the table below (my synthesis of the above) is the minimum "execute the surface" package:
  1. Direction brief: subject, audience, job, principles ("A even over B"), rejected defaults.
  2. Tokens: DTCG JSON primitives + semantic roles; type roles; spacing unit; radius/shadow stance; motion stance.
  3. Per screen: purpose, ASCII wireframe, content (real copy and data ranges), hierarchy and one focal point, states (default, loading, empty, error, partial, permission), responsive behavior at each breakpoint and between them, interactions with triggers, motion spec, a11y notes, max content lengths/overflow behavior.
  4. Pattern ledger: recurring elements named with variants.
  5. Acceptance checks: contrast, focus, reduced motion, "memorable moment present", "no listed defaults".
  6. Open questions with defaults the implementer may choose.
- Content limits (max length, truncation, i18n expansion) are not in the cited sources as such; they are inferred from the "what if" complaints.

### Gaps
- No developer survey found; complaints are from vendor/practitioner blogs. Zeplin-era redlines vs annotations comparison not sourced. Figma Dev Mode details are from search summaries of the help center, not fetched pages. Bennadel's engineer-side post not read.

## 9. Responsive/layout direction at skeleton stage

### Takeaway
At direction stage, define layout intent (alignment, reading width, content priority, what reflows) with named primitives rather than pixel redlines; Every Layout primitives let the layout adapt without fixed `@media` breakpoints.

### Cited Findings
- Every Layout primitives: Stack, Box, Center, Cluster, Sidebar, Switcher, Cover, Grid, Frame, Reel, Imposter, Icon, Container; composable "to create robust and responsive layouts without the need for @media breakpoints". — [Every Layout](https://every-layout.dev/layouts/)
- frontend-design asks for layout concept as prose plus ASCII wireframes with alignment guidance and responsive-to-mobile as a quality floor; line length under 80 characters. — [SKILL.md](https://raw.githubusercontent.com/anthropics/skills/main/skills/frontend-design/SKILL.md)
- Atomic templates start as grayscale, layout-only wireframes and gain fidelity. — [Atomic web design](https://bradfrost.com/blog/post/atomic-web-design/)

### Inferences
- Skeleton format: per screen, ASCII wireframe at mobile and wide, content priority order, which layout primitive governs each region (e.g. "Sidebar: nav + content, stacks when narrow"), and the one thing that must remain visible at every width. Mobile-first is a default stance, not sourced here.

### Gaps
- Material 3 window-size-class page returned 404, so no sourced breakpoint values; no sourced mobile-first claim; no Utopia/fluid type source.
