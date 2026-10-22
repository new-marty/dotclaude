# Problem framing and evidence vs assumptions (for a pre-UI-coding design skill)

Method note: ~25 tool calls. Fetched primary pages where possible (GOV.UK, NN/g, Product Talk, Intercom, Gilad). WebSearch was weak; several primary pages 404'd or were gated. Where a claim rests on a secondary source it is labeled. "Interpretation" lines are mine, not the sources'. Not found / not verified: see each Gaps section.

## 1. Jobs to be Done schools (Christensen/Moesta, Ulwick ODI, Klement/Intercom job stories) and which form suits screen/flow design

### Takeaway
The three schools differ in what they output: Moesta's forces/timeline is an interview-derived causal story of why someone switched; Ulwick's ODI is a quantified list of solution-free outcome statements; Intercom/Klement job stories are a one-line situation-motivation-outcome format. For screen/flow design the job story (situation-triggered) is the most directly usable, with ODI's job map and outcome statements as a way to check completeness of the flow. All three presume real customer data; none is a license to invent it.

### Cited Findings
- Four Forces of Progress: push (frustration with the situation) and pull (attraction of the new option) favor switching; anxiety (fear of the new) and habit (attachment to the present) resist it. Switching happens when push + pull outweigh anxiety + habit. Associated with Bob Moesta and Chris Spiek. — [jobstobedone.org (via search summary)](https://jobstobedone.org/radio/pull-and-anxiety/) (secondary summaries; primary page not read in full)
- Same sources claim teams over-invest in pull (features) and under-address anxiety and habit; more features can raise anxiety. — [Koji summary of forces](https://www.koji.so/visuals/jobs-to-be-done-four-forces-of-progress) (third-party, treat as commentary)
- Moesta's interview technique (from a podcast page): beginner's mindset, unpack language to uncover intent, build the story so the interviewer can play it back. The switch timeline stages (first thought, passive looking, active looking, deciding, consuming) I could NOT confirm from fetched sources. — [Rocketship.fm/Moesta page via search](https://rocketship.fm/episodes/jobs_to_be_done_the_full_moesta_pt_3)
- ODI desired-outcome statement grammar: direction of improvement + metric + object of control + contextual clarifier; example in the form "minimize the time it takes to identify the right drill bit size". — [Strategyn template page (gated), per search summary](https://strategyn.com/?p=42514); [CustomerThink intro to ODI](https://customerthink.com/an_introduction_to_outcome_driven_innovation/)
- ODI job map has 8 universal steps: Define, Locate, Prepare, Confirm, Execute, Monitor, Modify, Conclude; typical 50-150 desired outcomes per job. Detail comes from Ulwick's firm and vendors, not independent studies. — [Miro ODI template](https://miro.com/miroverse/jobs-to-be-done-odi-template/); [Koji ODI write-up](https://www.koji.so/docs/outcome-driven-innovation-odi)
- Intercom job story template: "[ When ___ ] [ I want to ___ ] [ So I can ___ ]" = situation, motivation, outcome. Intercom says it dropped personas (focus on attributes not motivations, split audiences that share goals, laborious, hard to remember) and user stories (engineering-oriented, not research-driven, describe functionality not what people try to achieve). Job stories sit in a one-page project brief. — [Intercom: How we accidentally invented Job Stories](https://www.intercom.com/blog/accidentally-invented-job-stories/)
- Intercom says it was inspired by JTBD but found little guidance for software, so built its own process. — [same](https://www.intercom.com/blog/accidentally-invented-job-stories/) ; attribution to Klement as best explainer is only from a secondary source — [Antoine Buteau notes](https://www.antoinebuteau.com/lessons-from-paul-adams/)
- Mountain Goat Software has a comparison of job stories vs user stories (not read). — [Mountain Goat](https://mountaingoatsoftware.com/blog/job-stories-offer-a-viable-alternative-to-user-stories)

### Inferences
- For screens/flows: the "When" clause gives the entry context (device, urgency, prior state), "I want to" gives the primary action, "so I can" gives the success criterion, which map to entry point, main CTA, and completion state. A job story is falsifiable by watching one real situation; a persona is not.
- ODI's job map is useful as a flow-completeness checklist (is there a Monitor/Modify/Conclude step in the UI?), but its quantified importance/satisfaction survey needs real respondents and cannot be done by an AI alone.
- Forces of progress is most useful for onboarding/switching/empty-state/pricing screens (anxiety and habit reduction), and requires real switch stories; without them it is a hypothesis list.
- Interpretation: the skill should accept job stories as the default unit but tag each clause with its evidence source.

### Gaps
- Primary texts not read: Klement "When Coding Fails" / jtbd.info job story post (fetch failed), Moesta/Spiek "Demand-Side Sales", Ulwick "What Customers Want". The Intercom page had no worked example (the one shown by the fetch tool was hypothetical).
- Switch timeline stage names unverified from fetched sources.
- No empirical comparison of the three schools' usefulness for UI design was found; the "which is most useful" judgment is interpretation.

## 2. Personas, proto-personas, no personas

### Takeaway
NN/g says personas must be based on user research and have a specific purpose; Spool says criticism targets bad personas, not the method; Indi Young and Intercom argue for context-bound thinking styles/situations instead of attribute-based people. A proto-persona is by definition a team guess and is only acceptable if labeled a hypothesis. For an AI skill, an unsourced persona is the fabrication risk, so default to situations/jobs plus explicit "unknown who".

### Cited Findings
- NN/g: "Personas must be based on user research"; "might be made-up people, but they should be based on information about real people"; remove details that do not affect design decisions. — [NN/g Persona](https://www.nngroup.com/articles/persona/)
- NN/g contrasts broad marketing personas vs targeted-scope UX personas, and lists failure causes: made but never used, no leadership buy-in, built in isolation, not understood, no clear purpose. — [NN/g Why Personas Fail](https://www.nngroup.com/articles/why-personas-fail/)
- Spool (2007): critics blame personas, but the problem is crappy personas; value lies in the research, "Personas are to Persona Descriptions as Vacations are to Souvenir Picture Albums" (quoted via Userfocus). — [UIE](https://archive.uie.com/brainsparks/2007/11/14/crappy-personas-vs-robust-personas/); [Userfocus](https://userfocus.co.uk/articles/are-personas-past-their-prime.html) (search summaries)
- Academic critique (Chapman & Milham 2006 "The Personas' New Clothes"): hard to know how many users a persona represents; cannot be verified or falsified. — [SAGE](https://journals.sagepub.com/doi/10.1177/154193120605000503) (per search summary)
- Indi Young: thinking styles and mental models change with context, derive from qualitative research, and replace fixed personas. — [Power of Ten interview](https://www.polaine.com/power-of-ten/indi-young-mental-models-and-thinking-styles/); [Rosenverse](https://rosenverse.rosenfeldmedia.com/videos/thinking-styles-mend-hidden-cracks-in-your-market) (summaries)
- Proto-persona = team's best guess at users from Lean UX (Gothelf and Seiden), sketched collaboratively. — [UserForge](https://userforge.com/personas/proto-personas/) (secondary)
- GOV.UK: share learnings in formats like experience maps or personas, after discovery research. — [GOV.UK user needs](https://www.gov.uk/service-manual/user-research/start-by-learning-user-needs)

### Inferences
- Persona is harmful when: no research behind it, made for a different purpose, used to justify choices ("Sarah would love this"), or when it fixes demographics that don't predict behavior (Intercom's point).
- A safe AI-compatible substitute: "Audience hypothesis" with fields {who (role/context), source (evidence id or ASSUMPTION), what would disprove}, no name, no photo, no quote, no age.
- Interpretation: NN/g's proto-persona page 404'd, so the "proto/qualitative/statistical" three-way taxonomy the brief mentioned was NOT confirmed from NN/g in this research.

### Gaps
- NN/g proto-personas article not retrievable; NN/g's own statement of persona types (proto, qualitative, statistical) not confirmed. Spool's current (post-2007) view not found. Indi Young's primary writing (indiyoung.com) not read.

## 3. Assumption mapping, Lean UX hypotheses, Opportunity Solution Tree

### Takeaway
Practitioners list assumptions as testable "must be true" statements, split by risk type, plot importance vs evidence, and test only the high-importance/low-evidence ones, with success thresholds set before testing. Torres adds that opportunities must come from interviews, not guesses.

### Cited Findings
- Torres OST: outcome (product outcome = customer behavior/sentiment in product) > opportunities (unmet need, pain point, desire; "not solutions") > solutions > assumption tests. Check: if only one way to address it, it is a solution in disguise. Source opportunities from story-based interviews; "against making up opportunities"; sales/support/analytics inspire interview topics but lack context to be valid opportunities. — [Product Talk OST](https://www.producttalk.org/opportunity-solution-tree/)
- Torres assumption testing: list assumptions as "must be true" statements, specific; five categories (desirability, viability, feasibility, usability, ethical), "labels matter less than coverage"; map by importance and evidence per David Bland; only high-critical/low-evidence need testing; define success threshold before the test; test types: prototype tests, one-question surveys, data mining, research spikes; record assumption, audience, test, criteria, results, action. — [Product Talk assumption testing](https://www.producttalk.org/2023/11/assumption-testing/)
- Bland: 2x2 on importance and evidence, built on desirability/viability/feasibility, refining Gothelf and Seiden's Lean UX technique; write assumptions privately before placing on the map; axis names vary across secondary sources (importance/criticality, evidence/certainty). — [Mural guide](https://www.mural.co/blog/how-to-look-before-you-leap-a-guide-to-mapping-assumptions-for-product-development-teams); [Uncertainty Project](https://www.theuncertaintyproject.org/tools/assumptions-mapping) (secondary; Bland's original not read)
- Lean UX hypothesis wording per summaries: "We believe [X] is true. We will know we're right/wrong when we see [specific feedback]." Verbatim book text unverified. — [Sumizeit summary](https://www.sumizeit.com/books/lean-ux)

### Inferences
- Assumption log row (proposed): id | statement ("must be true") | category | importance H/M/L | evidence level (see section 5) | disproof signal | cheapest test | status.
- Rule: an assumption goes to "test first" only if importance=H and evidence<=anecdotal. For a no-user session the test often is "ask the human owner" or "desk research", not a prototype.
- Torres's warning that support/analytics data are inputs to interviews, not finished opportunities, means a desk-research-only opportunity should be labeled "candidate, unverified".

### Gaps
- Bland's primary text (Testing Business Ideas / Strategyzer) not accessed. Gothelf/Seiden verbatim hypothesis template not confirmed from primary source (gothelf blog URL 404).

## 4. Problem statements, design briefs, How Might We

### Takeaway
Good HMWs derive from findings, don't embed a solution, and sit between too broad and too narrow. GOV.UK's discovery explicitly says to challenge any predefined solution and restate it as a problem, including what is out of scope, and quantify its cost.

### Cited Findings
- NN/g HMW: write after agreeing on findings; avoid embedding a solution; broad but not too broad; target root problem, not symptom; positive phrasing. Pitfalls with examples: too broad ("redesign the submission-drafting process"), embeds solution ("tell users which form to complete"), symptom ("stop users from calling us"), generic ("improve the UX"), negative framing ("less difficult"). — [NN/g HMW](https://www.nngroup.com/articles/how-might-we-questions/)
- GOV.UK discovery: define the problem, challenge predefined solution, reframe as problem, state what is not part of it, quantify cost; understand constraints (hard vs soft); consider non-build options; plan measurement. — [GOV.UK discovery](https://www.gov.uk/service-manual/agile-delivery/how-the-discovery-phase-works)
- Intercom: one-page brief with a Job Stories section before any project. — [Intercom](https://www.intercom.com/blog/accidentally-invented-job-stories/)

### Inferences
- Minimal brief template (interpretation, combining the above): Problem (no solution words) | Who/context (with source tag) | Job story(ies) | Evidence and its level | Out of scope | Constraints (hard/soft) | Success measure | Top 3 assumptions | Open questions for the human.
- Lint rule: flag any problem statement containing UI nouns (button, page, dashboard, modal).

### Gaps
- IDEO's own HMW/design-brief material and an NN/g problem-statement article were not fetched. No design brief template from Kim Goodwin retrieved.

## 5. Evidence levels and confidence labeling

### Takeaway
Gilad's Confidence Meter is a 0-10 scale in which opinion is worth almost nothing and only user/test/launch data scores high. It is the most concrete public scale found and adaptable to a skill. GOV.UK states the rule outright: opinions not from users are assumptions.

### Cited Findings
- Confidence Meter levels (Votito's transcription, secondary): Self-conviction 0.01; Pitch-deck 0.03; Thematic support 0.03-0.1 (aligned with strategy/trends); Others' opinion 0.1-0.2 (experts, investors, press); Estimates and plans 0.4-0.5 (feasibility evaluation, business case); Anecdotal 0.5-1 (1-3 interested customers, some competitors have it); Market data 1-3 (surveys, smoke tests, most competitors have it); User/customer evidence 3 (lots of product data, 20+ interviews, usability study, MVP); Test results 4-5 (A/B tests, longitudinal studies); Launch data 10. — [Votito](https://www.votito.com/methods/confidence-meter/)
- Gilad's own article confirms examples: self-conviction + thematic + others' opinion = 0.1/10 "Near Zero"; self-conviction + a handful of customers asking = 0.5 "Low"; customer evidence 3; an MVP with strong results 6.5. ICE = Impact x Confidence x Ease, Impact and Ease 1-10, confidence from the Meter. — [Gilad](https://itamargilad.com/the-tool-that-will-help-you-choose-better-product-ideas/)
- The full tool is a gated download; levels/values in the Votito page may differ slightly from Gilad's current version (other sources give thematic support 0.2 in older posts). — [Gilad Confidence Meter page](https://itamargilad.com/confidence-meter/); search summary
- GOV.UK: needs must be based on research; "treat opinions or suggestions that don't come from users as assumptions to test"; sources: analytics, search logs, call centre data, prior research, interviews/observation, and staff who work with users. — [GOV.UK](https://www.gov.uk/service-manual/user-research/start-by-learning-user-needs)

### Inferences
- A cheap 5-tier label set for the skill (my adaptation): E0 model/own guess; E1 stakeholder opinion; E2 desk evidence (docs, competitors, regulation); E3 first-party data or support logs; E4 direct user observation/interview/test. Anything E0-E1 must be printed as ASSUMPTION, never as a "user need".
- AI-written text is always E0 unless it quotes a cited source; the skill should refuse to assign E3-E4 without a file/link the human supplied.

### Gaps
- Spotify "Think It", Atlassian evidence ratings, and other "strength of evidence" scales were not researched (budget). Gilad's current official numbers not directly verified.

## 6. Discovery when you cannot talk to users

### Takeaway
GOV.UK and Torres both accept existing data and people close to users as inputs, but treat them as leads to be verified by direct contact. Acceptable without users: label as hypothesis, derive from analytics, support logs, staff, competitors, regulation, and mark user needs "unvalidated". I found little explicit practitioner guidance on "guerrilla" research ethics/limits in this pass.

### Cited Findings
- GOV.UK acceptable need sources include analytics, search logs, call-centre data, previous research reports, and people who work with users (caseworkers, call-centre agents, charity workers); also research users who struggle and those who deliver the service. — [GOV.UK](https://www.gov.uk/service-manual/user-research/start-by-learning-user-needs)
- GOV.UK discovery: learn from related/similar services and what constraints they faced; identify legislation, contract, legacy constraints; unresearched problems may need longer. — [GOV.UK discovery](https://www.gov.uk/service-manual/agile-delivery/how-the-discovery-phase-works)
- Torres: do not make up opportunities; support/sales/analytics inform interview topics but lack context; data mining is a valid assumption-test type for risk. — [Product Talk OST](https://www.producttalk.org/opportunity-solution-tree/); [assumption testing](https://www.producttalk.org/2023/11/assumption-testing/)
- NN/g: persona-based expert reviews "shouldn't replace user testing". — [NN/g Persona](https://www.nngroup.com/articles/persona/)

### Inferences
- Allowed with no users: competitor/analogous-product teardown, regulation/standards, public support forums and app-store reviews (E2, quoted with URL), accessibility baseline (WCAG) as non-negotiable constraint, the human owner's own knowledge (E1).
- Not allowed: invented quotes, named personas with demographics, invented statistics, "users want X" without a source.
- Progress rule: proceed on the riskiest-assumption-first basis; design for reversibility where evidence is low; output a "learning plan" (what to ask the human or real users next).

### Gaps
- No primary source found on guerrilla research best practices or its limits; no Atlassian/Spotify material; no article specifically on AI-fabricated research risk was gathered here.

## 7. Stakeholder kickoff questions

### Takeaway
NN/g gives a short topic list; it does not rank the questions. Which can be safely assumed is not covered by sources, so the ranking below is mine.

### Cited Findings
- NN/g stakeholder interview topics: role; success metrics ("What does success look like for you and your team?"); priorities (top challenges/business issues); history and constraints (past solutions, why they succeeded or fell short); process/involvement; closing ("anything else?" and "Who else should I speak to?"). Purpose: context, business goals, shared vision, buy-in. — [NN/g Stakeholder Interviews](https://www.nngroup.com/articles/stakeholder-interviews/)
- GOV.UK discovery asks: what the problem costs, hard vs soft constraints, measurement plan. — [GOV.UK discovery](https://www.gov.uk/service-manual/agile-delivery/how-the-discovery-phase-works)

### Inferences
- Must ask the human (not assumable): success measure; who the real users are and how the human knows; hard constraints (platform, regulation, deadline, existing design system/stack); what has been tried; what is out of scope.
- Can be assumed with a flag: visual style defaults, standard patterns, accessibility baseline, English/Japanese copy style.

### Gaps
- Kim Goodwin "Designing for the Digital Age" excerpts and design brief templates not retrieved; no source ranks which kickoff questions matter most.

## 8. GOV.UK discovery/alpha and user-need format

### Takeaway
GOV.UK is the best public, citable model: user need template, evidence requirement, discovery goal and exit criteria.

### Cited Findings
- Template: "I need/want/expect to... [what]" + "So that... [why]"; optional "As a... [user type]", "When... [trigger]", "Because... [constraint]". Write in users' words, prioritize, describe the problem not a solution (need a reminder, not an email). — [GOV.UK](https://www.gov.uk/service-manual/user-research/start-by-learning-user-needs)
- Discovery: typically 4-8 weeks; set a clear goal up front; do not build; ends with a go/no-go to alpha (viable service easier for users? cost-effective?); stopping is not failure; before alpha have a prioritized list of ideas to test, rough team, success measures. — [GOV.UK discovery](https://www.gov.uk/service-manual/agile-delivery/how-the-discovery-phase-works)
- Discovery questions: who likely users are and what they try to do; how they do it now (services/channels); problems and frustrations; what they need to reach goal. — [GOV.UK](https://www.gov.uk/service-manual/user-research/start-by-learning-user-needs)

### Inferences
- The skill's gate can mirror the exit criteria: do not start UI until goal, problem, constraints, success measure and prioritized ideas exist, or the human explicitly waives with assumptions logged.
- Alpha-phase guidance (prototype to test riskiest assumptions) was not fetched.

### Gaps
- GOV.UK alpha page not read.
