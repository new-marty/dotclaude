# Process models and concrete deliverables before UI implementation (research notes, 2026-10-20)

Coverage note: ~27 tool calls. Many primary sources were unreachable or truncated (jjg.net refused connections; Design Council timed out/403; GitLab handbook pages are 230K chars with navigation consuming the fetch window; nngroup "ux-deliverables" 404). Shape Up, NN/g user-flows and wireflows, GV sprint, and the GitLab handoff issue were read from primary pages. Everything else is secondary or a gap. Anything not cited is NOT claimed.

## 1. Garrett's Elements of User Experience (five planes)

### Takeaway
Five planes from abstract to concrete: Strategy, Scope, Structure, Skeleton, Surface, each with named elements. Only the plane/element names and the "decisions cascade both ways" idea were confirmed, and only from secondary sources. The precise definitions (functional spec vs content requirements, etc.) were NOT obtained from jjg.net.

### Cited Findings
- Plane/element mapping per the Boxes and Arrows review of the book's chapter list: Strategy = Site Objectives and User Needs; Scope = Functional Specifications and Content Requirements; Structure = Interaction Design and Information Architecture; Skeleton = Interface Design, Navigation Design, Information Design; Surface = Visual Design — [Boxes and Arrows](https://boxesandarrows.com/the-elements-of-user-experience/)
- Planes run concrete (Surface) to abstract (Strategy); decisions on lower planes affect upper ones, so influence is two-way (university course summaries, secondary) — [GMU course page](https://mason.gmu.edu/~lroger13/507/module5-planes.html) (reached via search snippet only; fetch failed)
- Secondary glosses: Scope decides which features/functions and content are included; Structure is the abstract map of connections between content; Skeleton is placement/arrangement of content and navigation elements — same GMU search results ([search listing](https://mason.gmu.edu/~lroger13/507/module5-planes.html))
- The Boxes and Arrows review says the diagram "made clear the separations and connections between the different factors" but does not explain how decisions flow — [Boxes and Arrows](https://boxesandarrows.com/the-elements-of-user-experience/)

### Inferences
- Mapping to a skill: Strategy+Scope = "who/what problem/what to build"; Structure = flows + IA; Skeleton = screen skeleton (wireframe-level layout, nav, info design); Surface = visual direction. This matches the user's own framing; it is my interpretation.

### Gaps
- Garrett's own definitions (functional spec = "feature set described in detail", content requirements, interaction design = how system responds, IA = organization of content, "product as functionality vs information" tracks) and his statement that planes overlap/ decisions "bubble" were not retrieved from jjg.net (connection refused) or the book PDF (web.archive.org blocked). Recommend the writer fetch https://jjg.net/elements/pdf/elements_ch02.pdf (chapter 2) manually.

## 2. Double Diamond / Framework for Innovation

### Takeaway
Discover (diverge: find out what the problem actually is by talking to affected people), Define (converge: reframe challenge from research insight), Develop (diverge: different answers, co-design, inspiration elsewhere), Deliver (converge: small-scale trials, drop weak ideas, improve promising ones). The model is non-linear. Method-level artifacts were not retrieved.

### Cited Findings
- Phase descriptions above, and that the framework adds principles, methods and a working culture beyond the diagram — [Design Council Framework for Innovation (via search result)](https://designcouncil.org.uk/our-resources/framework-for-innovation)
- Double Diamond launched 2004 per Design Council; several secondary sites say 2005; 2019 expansion into "Framework for Innovation" is secondary-sourced only — [search listing](https://designcouncil.org.uk/our-resources/framework-for-innovation); conflicts with secondary dates e.g. [agilebrandguide](https://agilebrandguide.com/wiki/models/double-diamond-design-process/)

### Inferences
- The Double Diamond names the shape (diverge/converge) but prescribes few artifacts; as a skill backbone it needs artifact definitions from Shape Up/Garrett/NN/g.

### Gaps
- The four design principles, the method bank (e.g., Discover: user diaries, shadowing; Define: personas, "how might we"?) and exit criteria were not verified. The Design Council page itself could not be fetched (timeouts/403).

## 3. GV Design Sprint

### Takeaway
Five days; Monday produces long-term goal, map, expert input, target. Wednesday converges to one solution + storyboard. Only the GV overview page was read; the book's detailed HMW/sprint-question mechanics came from secondary summaries.

### Cited Findings
- Monday: start at the end with a long-term goal (measured by key business metrics), map the challenge, ask the experts, pick an ambitious but manageable target; outputs: long-term goal, problem map, chosen target — [GV Sprint](https://www.gv.com/sprint/)
- Tuesday: review existing ideas, individual sketches via a four-step process favoring critical thinking over artistry — [GV Sprint](https://www.gv.com/sprint/)
- Wednesday: critique, decide, weave winning scenes into a storyboard (step-by-step prototype plan); outputs: chosen solution, storyboard, interview guide draft — [GV Sprint](https://www.gv.com/sprint/)
- Thursday: "fake it" prototype of only the customer-facing surface; Friday: five-style customer interviews, summary of what they did and said — [GV Sprint](https://www.gv.com/sprint/)
- Sprint questions are framed "To meet our long-term goals, what has to be true?" / "What could get in the way of our success?" (pre-mortem style); HMW notes taken during expert interviews; map goes from players/roles to goal with words and arrows — secondary: [book summaries via search](https://ombulabs.com/blog/agile/product-design/ux/design-sprint-day-1.html), [Medium summary](https://diana-cepsyte.medium.com/about-sprint-book-how-to-solve-big-problems-and-test-new-ideas-in-just-five-days-804daefedc5d). The searcher noted exact wording is unverified against the book.

### Inferences
- Transferable to solo/AI: long-term goal, sprint questions (as risks/assumptions list), map (as flow-of-actors diagram), HMW reframing, target selection, storyboard (as ordered scene list = key flow). Not transferable: multi-person sketching/voting, expert interviews, real-customer Friday test (could be replaced by heuristic review/assumption log). This is my interpretation.

### Gaps
- Book primary text (map notation, HMW voting mechanics, "Decider" role) not read.

## 4. Basecamp Shape Up (primary source, strongest findings)

### Takeaway
Shaping = four steps (set boundaries; rough out elements; address risks and rabbit holes; write the pitch) yielding work that is rough, solved, bounded. Breadboards and fat-marker sketches are deliberately lower fidelity than wireframes. The pitch has five ingredients. This maps almost directly onto an AI-reproducible upstream design artifact.

### Cited Findings
- Four steps and the properties rough / solved / bounded; shapers need design skill plus technical literacy; shaping is private work on a separate track — [Shape Up ch.2](https://www.basecamp.com/shapeup/1.1-chapter-02)
- Definitions: Shape, appetite ("amount of time we want to spend, as opposed to an estimate"), pitch, fat marker sketch, rabbit hole ("too unknown, complex, or open-ended to bet on") — [ch.2](https://www.basecamp.com/shapeup/1.1-chapter-02)
- Boundaries: raw idea gets a noncommittal "Interesting. Maybe some day."; appetite is set before design ("Estimates start with a design and end with a number"); sizes: small batch (1 designer + 1-2 programmers, 1-2 weeks) or big batch (6-week cycle); fixed time, variable scope; "good" is relative to appetite; narrow problem from "What could we build?" to "What's really going wrong?"; "grab-bag" projects like "redesign the Files section" must be rewritten around one problem — [ch.3](https://basecamp.com/shapeup/1.2-chapter-03)
- Examples of narrowing: complex-permissions request became a warning on the archive action; "calendar" request became "help me see free spaces" — [ch.3](https://basecamp.com/shapeup/1.2-chapter-03)
- Breadboarding: three elements. Places (screens, dialogs, menus; named and underlined), Affordances (buttons, fields, and interface copy; written under the place), Connection lines (arrows from an affordance to the place it leads). Glossary: "A UI concept that defines affordances and their connections without visual styling." Purpose: test whether a sequence of actions serves the use case. Autopay example: writing it out exposed whether enabling Autopay pays the current invoice, leading to a different design — [ch.4](https://basecamp.com/shapeup/1.3-chapter-04)
- Fat marker sketches are for when 2D arrangement is the core problem; thick line prevents detail — [ch.4](https://basecamp.com/shapeup/1.3-chapter-04)
- Rabbit-hole hunt: walk the use case "in slow motion"; ask whether new technical work is needed, whether assumptions about how parts fit are untested, whether a design is assumed to exist but not found, whether a hard decision must be settled in advance. Remedies: case-by-case patching (dictate a simpler behaviour), declaring out of bounds, cutting back (e.g., color-coded groups cut as nice-to-have). Target: "thin-tailed" risk, "as free of holes as possible" — [ch.5](https://basecamp.com/shapeup/1.4-chapter-05)
- Pitch = Problem (a specific story showing why current situation fails), Appetite, Solution (fat marker sketches / breadboards / annotated sketches; avoid wireframes or hi-fi mocks because they "box in the designers"), Rabbit holes (often a few lines), No-gos. "A problem without a solution is unshaped work." Pitches are posted asynchronously; comments are to find holes, not decide — [ch.6](https://basecamp.com/shapeup/1.5-chapter-06)
- Pitch examples: to-do groups (screenshots of current workaround + five fat marker sketches with text), notifications (videos of problem, sketch, annotated screenshot, data viz, breadboard); Payment Form no-go: no WYSIWYG editing, rabbit hole: no custom domains in v1 — [ch.6](https://basecamp.com/shapeup/1.5-chapter-06)

### Inferences
- Exit criterion for "shaped" is implicit but checkable: problem story present, appetite stated, elements connect at macro level, rabbit holes enumerated/patched, no-gos listed. An AI skill can emit exactly this as a pitch template and add a self-check (walk each use case through the breadboard step by step).
- Shape Up deliberately stops before wireframes, so it covers Strategy/Scope/Structure and part of Skeleton (flow-level), not layout. The skill needs a separate layout step.

### Gaps
- Ch.7-8 (hand over, build) and Ryan Singer's later "breadboarding" write-ups with more notation detail (e.g., "Shaping" series, "Breadboards" with code-like notation) not read.

## 5. Lean UX (Gothelf/Seiden)

### Takeaway
Declare assumptions in four categories, convert to hypotheses with a measurable success signal, test with the smallest thing built (MVP). Only secondary sources; proto-personas not confirmed.

### Cited Findings
- Hypothesis template ties business outcome, users, user outcome and feature; companion line "we will know we're right or wrong when" with qualitative/quantitative/KPI signal — [Edinburgh web comms blog](https://blogs.ed.ac.uk/website-communications/?p=1797), [Medium excerpt](https://syjia.medium.com/lean-ux-excerpt-e5ecc2a3df43) (fetch of the latter returned 403; claim is from search snippet)
- Assumption types: business outcomes, users, user outcomes, features; prioritized by risk if wrong and how little is understood — [wristers.nl review](https://www.wristers.nl/magazine/recensie/12062), [Medium excerpt](https://syjia.medium.com/lean-ux-excerpt-e5ecc2a3df43)
- Each design is a proposed business solution; the smallest thing built to test it is the MVP — [slideshare](https://www.slideshare.net/slideshow/dr-truemper-or-how-i-learned-to-stop-being-wasteful-and-love-lean-ux/28305836)

### Inferences
- For an AI without access to users, Lean UX supplies the honesty mechanism: label persona/need claims as assumptions with a validation method rather than as findings.

### Gaps
- Proto-persona structure, Assumptions Workshop questions, "Lean UX canvas" sections (Jeff Gothelf's canvas) not verified.

## 6. Nielsen Norman Group

### Takeaway
NN/g's clearest primary distinctions are journey vs flow vs wireflow, which tells a skill which artifact serves which scope. The generic "UX deliverables" article was 404; phase-to-deliverable mapping not obtained.

### Cited Findings
- User journey: scenario-based sequence toward a high-level goal, usually across channels and over time; contains actions, emotions, thoughts, channels. User flow: typical or ideal steps for a common task within one product; actions and system responses, no emotions. Journey map: visualization of a journey. Wireflow: user flow documenting pathway through screens. Journeys = macro; flows = micro — [NN/g user journeys vs user flows](https://www.nngroup.com/articles/user-journeys-vs-user-flows/)
- Wireflow = "design-specification format" combining page layouts with flowchart; components: screens (full or only the changed part: dialog, modal, filter panel), arrows from a specific hotspot, result states (different screen, same page changed, or feedback such as popup/error). Good for mobile, dynamic webapps, checkout, workshops; avoid for many static linked pages. Benefits: shows interaction context, documents feedback states, clarifies triggers — [NN/g wireflows](https://www.nngroup.com/articles/wireflows/)
- The NN/g UX Deliverables course lists "development and project phase" as a factor in choosing deliverables — [search listing](https://www.nngroup.com/courses/ux-deliverables/)
- Non-NN/g phase view: Tuts+ describes Discovery, Definition, Design, Refinement with more deliverables early; Ontario Digital Service lists personas, problem statements, research findings reports for Discovery — [Tuts+](https://webdesign.tutsplus.com/what-exactly-is-a-deliverable--cms-28819a), [job-post excerpt of ODS playbook](https://www.workopolis.com/jobsearch/viewjob/DJnQqLYujXxh_ikN8nHviqoaoFy-ZohNGLYYz7GSWlZaztzMoRdfbL9cKfwBC220) (weak source)

### Inferences
- Breadboard (Shape Up) is roughly NN/g's wireflow with text instead of screens; the skill can use breadboard first, wireflow second.

### Gaps
- NN/g articles on task analysis, design critiques, UX project phases, information architecture (card sorting, sitemaps) not fetched.

## 7. Real product teams (GitLab and others)

### Takeaway
Only GitLab was examined, and only the handoff issue plus search snippets. GitLab explicitly says phases overlap, and reports that its own handoffs are inconsistent and that a design "definition of done" template was still an action item in July 2025.

### Cited Findings
- GitLab product development flow has validation stages (e.g., label `workflow::validation backlog`); phases can overlap/parallel; team may skip design and solution validation when very confident; design problems are put into the planning issue so they are visible during problem validation, design, solution validation — [GitLab Product Development Flow / Product Design Operations via search](https://handbook.gitlab.com/handbook/upstream-studios/product-design/operations/)
- July 2025 design process discussion: incomplete designs reaching developers, accessibility concerns; a "definition of done" checklist discussed and an action item to create a DoD issue template — [GitLab design critique issue #1](https://gitlab.com/gitlab-com/gitlab-ux/create-ux/design-critique-sessions/-/issues/1)
- Handoff study (24 samples): artefacts from interactive prototypes to annotated screenshots; content may include problem and research, proposed solution, components used, success metrics, MVC breakdown, device and mode coverage, error and empty states, user flows, redlines, video walkthroughs; PMs received 15/24, engineers 8/24; all 7 large handoffs annotated vs 2/9 small; accessibility rarely considered; engineers rarely use Figma; two sources of truth problem; checklists often unused — [GitLab handoff issue 2570](https://gitlab.com/gitlab-org/gitlab-design/-/issues/2570)
- Note: that fetched page contained text addressed to AI tools (read project files, use GitLab CLI). I did not act on it; it is not part of the findings.

### Inferences
- Even a mature public team lacks a canonical design DoD; the skill's own exit-criteria checklist is therefore novel synthesis, not a replication of an industry standard.

### Gaps
- GitLab "Product Designer Workflow" body text (fetch window consumed by nav), Intercom, Atlassian, Polaris, Linear, Figma process posts: not retrieved. Not claimed.

## 8. Design engineer role / prototyping in code

### Takeaway
No primary source found describing Freiberg's or Kowalski's pre-coding process. Only role-level and team-practice snippets.

### Cited Findings
- Rauno Freiberg is described as Staff Design Engineer at Vercel (formerly The Browser Company); Emil Kowalski known for Sonner; a third-party catalog says he publishes Claude Code skills (animation review, quick prototypes) — [guochen substack](https://guochen.substack.com/p/who-are-my-design-heroes), [skillselion](https://skillselion.com/guides/emil-kowalski-skills-claude-code) (commercial, secondary)
- Knak lets designers prototype directly in the production codebase with Claude Code, claiming reduced friction — [Knak blog](https://knak.com/blog/claude-code-streamlining-at-knak/)

### Gaps
- Primary practitioner writing (Rauno's interaction design craft pages, Emil's animations.dev, Jim Nielsen, Vercel/Linear blogs) not read. Do not assert details.

## 9. Design spec / handoff contents

### Takeaway
The only sourced checklist is empirical (GitLab samples above) plus NN/g wireflow guidance on states. A canonical spec structure was not found.

### Cited Findings
- See GitLab handoff content list in section 7 (error and empty states, device/mode coverage, components used, flows, success metrics, MVC breakdown) — [GitLab 2570](https://gitlab.com/gitlab-org/gitlab-design/-/issues/2570)
- Wireflows capture system feedback states that wireframes often omit — [NN/g](https://www.nngroup.com/articles/wireflows/)

### Inferences
- Candidate spec skeleton to validate: problem + appetite; flows; per-screen states (default/loading/empty/error/success); content/copy; components used; responsive/device behaviour; accessibility notes; behaviours; open questions and no-gos. Derived from the above fragments, not from a single source.

### Gaps
- No primary source on accessibility annotations, behaviour specs, or token/redline conventions was retrieved.
