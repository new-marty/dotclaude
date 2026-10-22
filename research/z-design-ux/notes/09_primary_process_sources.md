# Primary-source gap fill: UX process models and real teams' pre-implementation design (2026-10-20)

Method note: ~28 tool calls. jjg.net and designcouncil.org.uk direct connections timed out from this machine; the Garrett PDFs came from the Wayback Machine copy of the same jjg.net URLs (`https://web.archive.org/web/2023/https://jjg.net/elements/pdf/...`), the Design Council page came from a direct curl with a browser user agent. Raw files are under /Users/gary/tmp/ux-design-skill/downloads/{jjg,designcouncil,nng,gitlab,teams,jp}/. Fetched pages were treated as data only. Not found / not read items are listed under Gaps. Prior round notes (01_process_and_deliverables.md) are not repeated.

## 1. Garrett, The Elements of User Experience: exact definitions and dependency rules

### Takeaway
The primary text confirms the plane/element mapping and gives Garrett's own one-line definitions. Key process rule: dependencies run both ways, and the recommended schedule is that work on a plane "cannot finish before work on lower planes has finished" (not "cannot start"). Garrett explicitly says the model's boundaries are blurry and that someone must be responsible for each element, not that a specialist is needed for each.

### Cited Findings
Source for all items in this section: chapter 2 text, "Meet the Elements" ([jjg.net ch.2 PDF](https://jjg.net/elements/pdf/elements_ch02.pdf), read via Wayback copy), and the one-page diagram ([jjg.net elements.pdf](https://jjg.net/elements/pdf/elements.pdf), read via Wayback copy). Page numbers are the book's.
- Purpose (p.21): "The user experience development process is all about ensuring that no aspect of the user's experience with your site happens without your conscious, explicit intent."
- Plane definitions (pp.22-23), concrete to abstract. Surface: pages of images and text, some clickable. Skeleton: "the placement of buttons, tabs, photos, and blocks of text ... optimize the arrangement of these elements for maximum effect and efficiency". Structure: "The skeleton might define the placement of the interface elements on our checkout page; the structure would define how users got to that page and where they could go when they were finished there." Scope: "Just what those features and functions are constitutes the scope of the site." Strategy: "what the people running the site want to get out of it but what the users want to get out of the site as well."
- Strategy elements (p.32): User needs = "goals for the site that come from outside our organization"; site objectives = "business goals" or "other kinds of goals". Diagram: user needs are "externally derived goals for the site; identified through user research, ethno/techno/psychographics"; site objectives are "business, creative, or other internally derived goals".
- Scope (p.32): software side, "functional specifications: a detailed description of the 'feature set' of the product." Information-space side, "content requirements: a description of the various content elements that will be required." Diagram wording: functional specifications are "detailed descriptions of functionality the site must include in order to meet user needs"; content requirements are "definition of content elements required in the site in order to meet user needs".
- Structure (p.32): "interaction design, in which we define how the system behaves in response to the user"; "information architecture: the arrangement of content elements within the information space." Diagram wording: interaction design is "development of application flows to facilitate user tasks, defining how the user interacts with site functionality"; IA is "structural design of the information space to facilitate intuitive access to content".
- Skeleton (p.34): information design = "the presentation of information in a way that facilitates understanding" (both sides); interface design = "arranging interface elements to enable users to interact with the functionality of the system"; navigation design = "the set of screen elements that allow the user to move through the information architecture". Diagram: interface design is "as in traditional HCI"; information design is "in the Tuftean sense".
- Surface (p.34): visual design, "the look of the finished product". Diagram: "graphic treatment of interface elements (the 'look' in 'look-and-feel')".
- The duality (pp.28-31): the left/software side is about "tasks - the steps involved in a process and how people think about completing them"; the right/hypertext side is about "information - what information the site offers and what it means to our users". Diagram labels: "task-oriented" vs "Web as hypertext system".
- Dependency (p.25): "Each plane is dependent on the planes below it." "When the choices we make don't align with those above and below, projects often derail, deadlines are missed, and costs begin to skyrocket." Decisions on the strategy plane have a "ripple effect" up the chain; "the choices available to us on each plane are constrained by the decisions we make about issues on the planes below it."
- Both directions (p.26): "That does not mean, however, that every decision about the lower plane must be made before the upper plane can be addressed. Dependencies run in both directions, with decisions made on upper planes sometimes forcing a reevaluation (or an evaluation made for the first time!) of decisions on lower planes." "If you consider your decisions on lower planes to be set in stone before you take on your decisions on higher planes, you will almost certainly be throwing your project schedule at the very least ... into jeopardy."
- Scheduling rule (p.27): "you should plan your project so that work on any plane cannot finish before work on lower planes has finished. ... not to build the roof of the house before we know the shape of its foundation." Figure caption: "Requiring work on each plane to finish before work on the next can start leads to unsatisfactory results ... A better approach is to have work on each plane finish before work on the next can finish." (Note: the book's lower planes are the abstract ones; in this wording "lower" = strategy side.)
- Model limits (p.35): "the lines between these areas are not so clearly drawn"; job titles like "information architect" "generally have expertise spanning many of the elements"; "It's not necessary to have a member of your team who is a specialist in each of these areas; instead, you only have to ensure that someone is responsible for thinking about each of these issues."
- Terminology (pp.27-28): "One person might use 'information design' to refer to what another knows as 'information architecture.'" Garrett treats this as a vocabulary problem to be fixed by the model.
- Content and technology are named as two factors outside the five planes that shape the experience (pp.35-36).

### Inferences
- A skill that reproduces this should treat each plane as a "decide, then reopen if a higher plane contradicts" checkpoint, with explicit "return to plane X" triggers, not a one-way waterfall. The exit test per plane is "the next plane's decisions do not contradict it", not "frozen".
- For UI coding tasks (software side), the mapping is: strategy = user needs + objectives; scope = functional spec; structure = interaction design (flows, behaviour per input); skeleton = interface design + information design (+ navigation design if multi-page); surface = visual design. Content requirements apply when the UI is content-heavy.

### Gaps
- Chapters 3-7 (the per-element methods, e.g. the shape of a functional spec) were not fetched; only chapter 2 and the one-page diagram were.

## 2. UK Design Council: Double Diamond and Framework for Innovation

### Takeaway
The official page gives the four phase descriptions, four design principles, and a three-way method bank structure (Explore / Shape / Build), plus a culture section. It does not list individual methods or exit criteria on this page.

### Cited Findings
Source: [Design Council, Framework for Innovation](https://www.designcouncil.org.uk/our-resources/framework-for-innovation/) (fetched with curl; CC BY 4.0 per page).
- Launched 2004 ("Launched in 2004, the Double Diamond has become world-renowned"). This resolves the 2004/2005 discrepancy in the prior notes in favour of 2004 for the official claim.
- "The two diamonds represent a process of exploring an issue more widely or deeply (divergent thinking) and then taking focused action (convergent thinking)."
- Discover: "helps people understand, rather than simply assume, what the problem is. It involves speaking to and spending time with people who are affected by the issues." Define: "The insight gathered from the discovery phase can help you to define the challenge in a different way." Develop: "give different answers to the clearly defined problem, seeking inspiration from elsewhere and co-designing with a range of different people." Deliver: "testing out different solutions at small-scale, rejecting those that will not work and improving the ones that will."
- Non-linear: "Many of the organisations we support learn something more about the underlying problems which can send them back to the beginning. Making and testing very early stage ideas can be part of discovery."
- Four principles: Put people first ("Start with an understanding of the people using a service, their needs, strengths and aspirations."); Communicate visually and inclusively ("Help people gain a shared understanding of the problem and ideas."); Collaborate and co-create; Iterate, iterate, iterate ("to spot errors early, avoid risk and build confidence in your ideas").
- Methods bank is structured in three areas: Explore (challenges, needs and opportunities), Shape (prototypes, insights and visions), Build (ideas, plans and expertise).
- Culture: leadership (permission for experimentation) and engagement.

### Inferences
- The Double Diamond only gives the exit logic "diverge then converge twice"; the second convergence (Deliver) is "reject what does not work, improve what does". The skill must draw its artifacts from elsewhere.

### Gaps
- The individual methods inside the Explore/Shape/Build bank were not retrieved (they are on separate pages not fetched). No explicit phase exit criteria found on the page.

## 3. ISO 9241-210 human-centred design (international baseline)

### Takeaway
The standard defines an iterative cycle with four core activities (understand and specify context of use; specify user requirements; produce design solutions; evaluate against requirements) plus planning. Exit criteria for the loop come from a secondary book summary, not the ISO text, which was paywalled.

### Cited Findings
- Standard scope: ISO 9241-210:2019 gives requirements and recommendations for human-centred design principles and activities across the life cycle of computer-based interactive systems, aimed at people managing design processes; it does not cover methods and techniques in detail; the 2010 edition is withdrawn — [ISO listing via Standards Council of Canada](https://scc-ccn.ca/standardsdb/standards/8169649), [ISO 77520](https://www.iso.org/standard/77520.html), [motoso scrapbox quoting the 2019 foreword](https://scrapbox.io/motoso/ISO_9241-210_Human-centred_design_for_interactive_systems).
- Quote from the 2019 foreword (via scrapbox): "The principles of human-centred design and the related activities have not changed substantially since ISO 13407 was produced and have been validated by ten years of application. This document reflects this by making requirements as well as recommendations." — [scrapbox](https://scrapbox.io/motoso/ISO_9241-210_Human-centred_design_for_interactive_systems)
- Process as summarised by the authors of "Usability and User Experience Design" (Franz, Kauer-Franz): six steps, first and last define start and end: (1) plan the HCD process, (2) understand and specify the context of use, (3) specify the user requirements, (4) produce design solutions, (5) evaluate the design, (6) (end; design meets requirements). — [Rheinwerk Computing blog](https://blog.rheinwerk-computing.com/how-to-do-ux-design-a-guide-to-the-iso-9241-210-standard)
- Planning step asks three questions: relation of usability to the purpose and use of the system; risks from low usability; the economic environment — [Rheinwerk](https://blog.rheinwerk-computing.com/how-to-do-ux-design-a-guide-to-the-iso-9241-210-standard)
- User requirements rules: "auditable" (clear whether met), "supported by stakeholders", "free of contradictions"; the list is not static — [Rheinwerk](https://blog.rheinwerk-computing.com/how-to-do-ux-design-a-guide-to-the-iso-9241-210-standard)
- Producing design solutions is "usually not yet about technical development"; use scenarios, pictures of UI parts, simulations or prototypes, "built ... as simply as possible"; consult implementers early — [Rheinwerk](https://blog.rheinwerk-computing.com/how-to-do-ux-design-a-guide-to-the-iso-9241-210-standard)
- Evaluation aims: get new information about user requirements; understand strengths and weaknesses; check whether requirements are met; compare variants; enable benchmarking. Expert evaluation is usually insufficient for acceptance and task fit, so user evaluation is the norm — [Rheinwerk](https://blog.rheinwerk-computing.com/how-to-do-ux-design-a-guide-to-the-iso-9241-210-standard)
- Exit criteria for ending the loop: "No new user requirements have emerged. Your design solution matches all known user requirements. The overall usability and UX are good enough." — [Rheinwerk](https://blog.rheinwerk-computing.com/how-to-do-ux-design-a-guide-to-the-iso-9241-210-standard)
- The result of HCD is "usually no finished system ... only a 'construction manual'" that speeds up implementation — [Rheinwerk](https://blog.rheinwerk-computing.com/how-to-do-ux-design-a-guide-to-the-iso-9241-210-standard)
- Japanese-language search gave the same four-activity description at summary level only — [search result summary, no individual page cited beyond the ISO listings above]

### Inferences
- This is the strongest available "definition of done" for a design loop and is usable verbatim as a skill exit gate: no new requirements, solution matches all known requirements, usability good enough. For an AI without users, the "evaluate with users" step has to become an explicit assumption log or a heuristic review (my interpretation).

### Gaps
- ISO clause text (including the six principles: user-centred, user involvement, iterative, whole user experience, multidisciplinary team, driven by evaluation) was not retrieved; the Rheinwerk text is a secondary summary by textbook authors. HCD-Net's page (`hcdnet.org/about/hcd.html`) returned only 1,381 bytes of non-content. 安藤昌也『UXデザインの教科書』 outline not found online.

## 4. NN/g primary articles

### Takeaway
Five NN/g articles were read in full: design critiques, personas (three types incl. proto personas), task analysis, user need statements, product design principles. Their steps and formats are directly reusable. "UX deliverables", a generic "UX design process" and a stand-alone proto-personas article returned 404 at the guessed URLs; proto personas are covered inside the persona-types article.

### Cited Findings
- Design critique definition: "analyzing a design, and giving feedback on whether it meets its objectives"; the group conversation aims to improve a design. Critiques vs design reviews: "Design reviews ... are usually evaluations of a design based on a set of heuristics ... in a meeting held at the end of the creative process in order to gain approval and move forward." Three themes: "Clear scope for the conversation", "Agreed-upon design objectives for the work", "Conversation rather than command." Without agreed objectives and users' needs, "any feedback is subjective and baseless." Pitfalls: not agreeing on personas or objectives beforehand; too long sessions; taking feedback personally; rushing to problem-solve in the moment; talking only about negatives. Presenter practices: repeat objectives (summarize personas, pain points, tasks), tell the story, present quickly, share work beforehand. Facilitator: scope/agenda, ask goal-related questions (reformulate "This is too red!" into goal-relative feedback), document publicly, follow up with notes and action items. — [NN/g Design Critiques](https://www.nngroup.com/articles/design-critiques/) (2016)
- Persona types: proto, qualitative, statistical. "Proto personas are a lightweight form of ad-hoc personas created with no new research. They catalogue the team's existing knowledge (or best guesses)". Workshop of 2-4 hours; each participant creates 2-5 using a simple template; merged to a final set of 3-6. Value: they "make your team's implicit assumptions about your users explicit" and can be treated as hypotheses to validate. Con: can be "an echo chamber for the team's incorrect assumptions". Qualitative personas: 5-30 interviews as a rolling sample until few new insights. Personas should be "memorable, actionable, and distinct from one another". — [NN/g 3 Persona Types](https://www.nngroup.com/articles/persona-types/)
- Task analysis: "the systematic study of how users complete tasks to achieve their goals". A task is "any activity that is usually observable and has a start and an end point"; do not confuse goals with tasks ("a user's goal isn't to fill in a form"). Two stages: (1) gather information on goals and tasks (contextual inquiry, critical-incident interviews, diary/record keeping, activity sampling, simulations); (2) analyze number, sequence, hierarchy, complexity of tasks, usually as a hierarchical task analysis (HTA) diagram with "plans" capturing order and novice/expert differences. Warning: do not rely solely on self-report or simulations ("you are not the user!"). Attributes to check per task: number, frequency, etc. — [NN/g Task Analysis](https://www.nngroup.com/articles/task-analysis/) (2020)
- User need statement: "An actionable problem statement used to summarize who a particular user is, the user's need, and why the need is important to that user. It defines what you want to solve before you move on to generating potential solutions". Format: "[A user] needs [need] in order to accomplish [goal]". Rules: user should map to a researched persona or segment; need "should be real, should belong to users, should not be made up by the team, and should not be phrased as a solution"; needs are verbs, not nouns ("users don't ever need a dropdown ... they need to see the choices that they can make and select one of them"). Scope with a parent (umbrella) statement and child statements. — [NN/g User Need Statements](https://www.nngroup.com/articles/user-need-statements/) (2019, reviewed Sep 2026)
- Product design principles: "value statements that describe the most important goals that a product or service should deliver for users and are used to frame design decisions"; they differ from heuristics and from UI standards. Properties: take a stand on which value is important, inspire empathy, concise, memorable, not conflict; avoid 10 or more. Four steps: identify core values; consider how values impact users; identify common tradeoffs; write, compare, iterate. Example: "Clarity Over Popularity". — [NN/g Design Principles](https://www.nngroup.com/articles/design-principles/) (2020)

### Inferences
- A skill can use: need statement -> principles (tradeoff tie-breakers) -> HTA/flow -> critique against stated objectives. The critique article's "agreed objectives first" is a natural gate: the design critique step cannot run until need statement and principles exist.
- For an AI-driven flow, proto personas are the honest form: label as assumptions, never as findings.

### Gaps
- NN/g "UX deliverables" article, a general "UX design process phases" article and the Lean-UX-style standalone proto-persona page were not found at guessed URLs (404). Not claimed.

## 5. GitLab handbook: Product Designer workflow

### Takeaway
The current Product Designer page gives a concrete sequence: define opportunity (who/what/why, JTBD, MVC criteria) -> before you design (generate ideas, understand the space, dependencies) -> ideate and iterate (north star, low fidelity first) -> refine MVC -> present one MVC solution asynchronously -> design reviews/critiques. It has a "design and UI changes checklist" but no stated formal definition of done in the text read.

### Cited Findings
Source: [GitLab Handbook, Product Designer](https://handbook.gitlab.com/handbook/product/ux/product-designer/) (fetched with curl; the gitlab.com raw-markdown path returned 403/not found).
- "Validate who you're designing for, what you're designing, and why you're designing it"; help the PM articulate it as a job to be done; "If asked to implement a non-evidence-based 'how,' encourage the PM to refocus on the who/what/why".
- Define MVC success criteria: prioritize "must-haves" and "should-haves/could-haves"; criteria "may change based on new insights".
- Before designing: problem validation research, review existing research, competitive analysis ("Adhere to industry standards unless there is a strategic reason for deviation"), "Create user flows and journey maps: Develop flows or journey maps to ensure comprehensive understanding of the workflow", identify the DRI and dependencies on other product areas.
- Vision: "Before breaking work into iterations, establish a clear picture of where you're headed, a north star". Use journey maps, storyboards, design visions; "Keep fidelity low when the solution scope is large." "Start low-fidelity, increase with confidence: Begin with the simplest artifact that communicates your idea."
- "Design with data, judge with experience: Validate high-risk directions with users through UX research. For lower-risk work, gather feedback post-release."
- "Use the design and UI changes checklist: Ensure readability, appearance, and functionality before shipping."
- Refine MVC: document non-MVC concepts in new issues linked to the original; "Features should be buildable within 1-2 milestones. If too large ... split"; designers and PMs aim to "get 1-2 months ahead".
- Present an MVC solution: "we propose a single validated solution rather than multiple options"; state who the solution is for, what it enables, what feedback or approval is needed; "Begin with the current state, explain how it fails to meet user needs, and present the proposed solution from the user's perspective"; use headings framed as questions; "Keep the SSOT updated".
- Design reviews are dedicated sessions with async option (issue, screenshots, Figma, video walkthrough); critiques are for "rigorous, constructive feedback ... challenging assumptions and examining the underlying rationales".

### Inferences
- GitLab's flow is a usable template for the written proposal (current state -> failure -> solution -> open questions). Combined with the prior round's finding (handoff study; DoD template still an action item), no formal industry DoD exists; GitLab's closest gate is the checklist plus MVC criteria.

### Gaps
- The linked "design and UI changes checklist" and the product-development-flow validation page contents were not read.

## 6. Real product teams

### Takeaway
Linear and Intercom give the clearest primary descriptions: Linear writes a short project spec (why/what/how) first, then an "Explore designs" issue, feedback, direction, then discrete design tasks, with engineers in the loop from spec time. Intercom contributes the Job Story format that fixes the "implementation coupled to motivation" problem.

### Cited Findings
- Linear, Manage design projects: "The first design task for any project is to understand and verify the problem." Users "will ask you to build a specific feature X to fix their problem Y"; X is limited by their view of the problem. "We also invest in writing out detailed project specs for each feature before building anything which forces us to think through the problem in depth." Then an "Explore designs" placeholder issue; explore "freely and without judging whether something is feasible, fits into your design system or is a good idea at all"; "part research to learn best practices and find inspiration and part experimenting with options in Figma", a few hours to a few days. Get feedback while exploring: "don't just pay attention to what they say but ask them why they said it"; alternate between overall design and specific details. Choosing a direction needs "a round of internal feedback in the design including the engineers who will be building the feature", then a list of concrete design tasks ("Design X view"); finally an implementation sub-issue references the design decisions and Figma link. — [Linear Method: Manage design projects](https://linear.app/method/manage-design-projects)
- Linear, project spec purpose: "briefly communicate the 'why', 'what' and 'how' of the project ... Ideally these short documents force teams to scope out work so priorities are clear and teams avoid building the wrong thing." "Aim for brevity." Every project has one named owner responsible for the brief and delivery. — [Linear Method: Principles & Practices](https://linear.app/method/introduction)
- Linear, issues vs user stories: "we don't write user stories and think they're an anti-pattern"; "Discuss the user experience at the product and feature level, not the task level." "The project owner writes specs and gathers feedback until we feel like we have the right approach. Only then do we start writing code. It's not uncommon to take a couple weeks to think through a feature before building it". — [Linear Method: Write issues not user stories](https://linear.app/method/write-issues-not-user-stories)
- Intercom Job Story format: "[ When _____ ] [ I want to _____ ] [So I can _____ ]" where "When" is the situation, "I want to" the motivation, "So I can" the outcome; created because User Stories "are not driven by empirical research" and "are formatted to describe functionality to be built, rather than motivations". — [Intercom blog (Paul Adams), "The product development process is broken"](https://www.intercom.com/blog/the-product-development-process-is-broken-here-is-why/)
- Intercom/Alan Klement five-step Job Story workflow: start with the high-level job; identify smaller jobs; "Observe how people solve the problem now"; write job stories about "causality, anxieties, and motivations"; create the solution that resolves the job story. End state: "every element can be traced back to resolving a job". Personas fail because "attributes ... don't acknowledge causality"; user stories fail because they "couple implementation with motivations and outcomes". — [Inside Intercom, Designing Features Using Job Stories](https://www.intercom.com/blog/using-job-stories-design-features-ui-ux/) (2013)

### Inferences
- A "traceability" check from Klement is portable: for each UI element in the proposed design, name the job story or need it serves; elements with no source get cut. This is my reading of the article's end state.

### Gaps
- Intercom's "design principles" post and "Intercom on Product Management" book page returned 404. Atlassian (design sprint play page downloaded but not read), Shopify Polaris design-process page (404/no content at the guessed URL), Airbnb and Figma spec posts were not read.

## 7. Design engineers' process (pre-coding)

### Takeaway
Primary text found only for Rauno Freiberg's essay; it describes a make-first process rather than a pre-coding document process. No primary text for Emil Kowalski, Paco Coursey, Jim Nielsen or Vercel.

### Cited Findings
- Rauno Freiberg: "Sitting down and just thinking hard does not magically produce valuable discoveries either. ... great revelations surface from making something - filling your headspace with a problem - and then going for a synthesising daydreaming walk to stir the pot." He also describes recreating interfaces as a way to build "design intuition and vocabulary", and criticises "recycled content obsessing over user personas, storyboards, and Venn diagrams". His interaction analysis frames design as decisions about triggers and thresholds, e.g. when a swipe triggers an action (during the gesture for lightweight actions, on release for destructive ones), interruptibility, spatial consistency. — [rauno.me, Invisible Details of Interaction Design](https://rauno.me/craft/interaction-design) (July 2023)
- The same site's Craft index labels items as "Prototype" or "Production"; the page lists prototype work in SwiftUI/web — [rauno.me/craft](https://rauno.me/craft)

### Inferences
- Design engineers reduce upstream documents because behaviour is explored in working prototypes; the questions they ask (what triggers, what is interruptible, what happens when partially covered) are interaction-design specs that can be turned into a pre-coding checklist for states and gestures. This is my inference from one essay.

### Gaps
- Emil Kowalski (emilkowal.ski/ui 404; animations.dev content not read), Jim Nielsen (guessed URL 404), Paco Coursey, Vercel design-engineering posts: no primary pre-coding process found. Do not assert their process.

## 8. Japanese practitioner sources

### Takeaway
Little process-level primary text was reachable. SmartHR's design system home and a published summary give principles-based design; Goodpatch process text and 安藤昌也's book outline were not found online.

### Cited Findings
- SmartHR Design System: positioned for "すべての人によりよい体験を届けるためのデザインシステム"; sections are 基本原則 (four values called "パーソナリティ"), 基本要素, アクセシビリティ, プロダクト (guidelines, design tokens, components), コミュニケーション — [smarthr.design](https://smarthr.design/)
- A CodeZine article reports that SmartHR wrote down design principles so that non-designers share the design stance, with the design system aimed at "all people who work on the product" — summarized in a search result, article page not read in full: [CodeZine 13865](https://codezine.jp/article/detail/13865)
- A book table of contents for SmartHR's design system book lists chapters on design patterns and "デザインレビュー" (3-15, 3-16) but no body text was read — [Kinokuniya listing](https://www.kinokuniya.co.jp/f/dsg-08-EK-1424074)

### Inferences
- SmartHR's approach is design-system-first: pre-implementation decisions are largely pre-made through tokens, components and patterns, so per-screen design is composition plus review. For the skill: check existing components and patterns before inventing (consistent with GitLab's "Adhere to industry standards").

### Gaps
- Goodpatch process/design sprint posts, freee design, SmartHR design process pages, HCD-Net text and 安藤昌也『UXデザインの教科書』 were not obtained (searches returned job listings or no match; guessed URLs 404 or empty). Nothing is claimed about them.
