# AI failure modes in UX research and UX design, and mitigations

Evidence quality legend: [F] = finding from a primary study or primary article I fetched or saw in search results; [S] = seen only in a search snippet/abstract, not opened; [P] = practitioner/secondary or opinion. Mitigations marked (inference) are my proposals, not tested in the cited sources.

## Synthetic users / AI-simulated research: fidelity and bias

### Takeaway
NN/g found synthetic users are over-optimistic, sycophantic, shallow on priorities, and unreliable on past behavior, so they are fit only for prep work (hypotheses, interview-guide piloting), never as findings. Academic work agrees: LLM personas and simulated respondents are homogenized, stereotyped, too cooperative, and flatten real distributions.

### Cited Findings
- NN/g (Rosala & Moran, 2024-06-21) tested the vendor tool Synthetic Users and ChatGPT by regenerating three earlier real-user studies as interviews; sample sizes not reported. Failures: a synthetic user claimed to have finished all its courses (real learners often did not); synthetic users rated discussion forums highly while real users avoided them; synthetic users listed many engagement factors with no priority ordering; a drone sample-delivery concept was called "very useful" (sycophancy). One positive: a synthetic medical-detailing rep's "typical day" matched real users, so desk-research use is plausible. [F] — [NN/g, Synthetic Users](https://www.nngroup.com/articles/synthetic-users/)
- NN/g's stated limits: sycophancy, unrealistic model of human behavior, flat responses without priority, no real behavioral data so "past experiences" are unreliable, uncontrollable training data skewed to online behavior, poor accuracy for niche populations. Recommendations: supplement rather than replace real research; use for prep, piloting interview guides, proto-personas and hypotheses to be tested; never present synthetic findings as real-user findings; be careful in low-UX-maturity orgs where they may displace research. [F] — [NN/g](https://www.nngroup.com/articles/synthetic-users/)
- NN/g cites Jeff Sauro et al.: ChatGPT was not an acceptable substitute for real users in tree testing because it vastly outperformed most real participants (too good at finding things). Reported by NN/g; I did not open the Sauro source. [S] — [NN/g](https://www.nngroup.com/articles/synthetic-users/)
- Salminen et al. (CHI 2024) evaluated 450 LLM-generated personas with internal evaluators and subject-matter experts: bias in age, occupation and pain points, and a strong bias toward US personas, even though evaluators judged them consistent and believable with relatively low stereotyping. Implication: believable-looking is not representative. [S] — [search result summary via osuva.uwasa.fi](https://osuva.uwasa.fi/handle/11111/2726)
- "LLM Generated Persona is a Promise with a Catch" argues bias enters at persona generation, not only in simulation, so simulated results can be biased even when the simulation step looks neutral. [S] — [arXiv 2503.16527](https://arxiv.org/pdf/2503.16527)
- Bombieri & Rospocher (Information, 2025): simulating 200 US residents, LLMs produced homogenized personas underrepresenting demographic diversity; conditioning on gender/ethnicity/disability can trigger stereotypical shifts. [S] — [iris.univr.it](https://iris.univr.it/handle/11562/1174028)
- "Simulating Identity, Propagating Bias" compared 11 personas with the default assistant: persona texts differ in surface wording but stay generic and stereotyped. [S] — [arXiv 2509.08484](https://arxiv.org/html/2509.08484v1)
- Lee et al.: ChatGPT portrays African, Asian and Hispanic Americans as more homogeneous than White Americans. [S] — [arXiv 2401.08495](https://arxiv.org/html/2401.08495v2)
- Persona steerability study: models are 9.7% less steerable toward incongruous personas than congruous ones; RLHF-tuned models are more steerable but show significantly less diverse views of personas. [S] — [arXiv 2405.20253](https://arxiv.org/abs/2405.20253v1)
- Gupta et al.: persona-assigned LLMs (4 LLMs, 19 personas, 24 datasets) show implicit reasoning bias; prompt mitigations like "don't make stereotypical assumptions" were ineffective or impractical. [S] — [arXiv 2311.04892](https://arxiv.org/abs/2311.04892)
- Silicon samples: a 2026 review says small elicitation changes shift simulated distributions and variability substantially and that synthetic data repeats conventional wisdom and social-desirability bias [S] — [arXiv 2603.00059](https://arxiv.org/pdf/2603.00059); one preprint argues a single call to an instruction-tuned model is not a real draw from the persona-conditional distribution [S] — [arXiv 2607.25292](https://arxiv.org/pdf/2607.25292); random silicon sampling matched US polls on political questions but not on non-political attitude questions [S] — [arXiv 2409.02601](https://arxiv.org/html/2409.02601v2). Pew published a 2026 silicon-samples methodology note (content not read). [S] — [Pew](https://www.pewresearch.org/data-labs/2026/09/30/methodology-silicon-samples/)
- User simulators for agent testing: CMU "Mind the Sim2Real Gap" (arXiv 2603.11245, 2026) ran τ-bench with 451 real participants against 31 LLM simulators. Simulators were over-cooperative, front-loaded complete information, showed little real uncertainty, did not push back on agent errors, gave uniformly positive feedback; larger models did not fix it. [S] — [arXiv 2603.11245](https://arxiv.org/abs/2603.11245)

### Inferences
- Failure mode "fabricated personas": the damage is believability without grounding. Mitigation (checkable): every persona/need/pain point carries an evidence label (OBSERVED from named source / USER-STATED by the requester / ASSUMED-by-AI). Any persona with zero OBSERVED fields is titled "proto-persona (hypothesis)" and lists the research that would test each field. (inference, aligned with NN/g "proto-personas and hypotheses")
- Never produce simulated user quotes, ratings, quantities, or percentages as findings. Allowed: hypotheses, interview-guide drafts, questions to ask real users. (inference from NN/g)
- Because "don't be stereotypical" prompts fail (Gupta et al.), counter homogenization structurally: require segments defined by behavior/context/constraint differences rather than demographics, and require at least one extreme/edge user per set. (inference)
- Output-level check: deliverable must include a "what this cannot tell us / needs real-user validation" section with a named method (interview, usability test, analytics).

### Gaps
- I did not open Salminen CHI 2024, Sauro, or most arXiv papers; details are from search snippets. NN/g article gives no n. No NN/g article specifically on "AI personas" was fetched.

## Homogenization, design fixation, generic UI output

### Takeaway
Experiments show AI raises individual output quality but narrows collective diversity and increases fixation; practitioners and Anthropic itself describe default LLM output as converging to "on distribution" generic designs. Explicitly naming defaults to avoid and requiring divergent options is the documented countermeasure.

### Cited Findings
- Doshi & Hauser (Science Advances, 2024): online story-writing experiment; access to AI ideas made individual stories rated more creative, better written and more enjoyable (largest gains for less creative writers) but AI-assisted stories were more similar to each other. Framed as a social dilemma. [F] — [Dryad/abstract listing](https://datadryad.org/dataset/doi%3A10.5061/dryad.qfttdz0pm)
- Wadinambiarachchi et al. (CHI 2024): between-participants study of 60 designers on visual ideation with no inspiration source, Google Image Search, or Midjourney. AI image generator users showed higher fixation on an initial example and produced fewer, less varied, less original ideas than baseline; outcomes depended on prompting approach. [F via secondary summary] — [arXiv 2403.11164](https://arxiv.org/html/2403.11164v1), summary via [Harvard Design Magazine](https://www.harvarddesignmagazine.org/articles/fixation-by-design-humbi-song-artificial-intelligence/)
- "Understanding Design Fixation in Generative AI" (2025): 10 novice designers made chair designs with ChatGPT and Midjourney; proposes a framework of fixation causes/manifestations. Small n, novices. [S] — [arXiv 2502.05870](https://arxiv.org/html/2502.05870v1)
- DesignAID: a "New Idea" mode designed to counter fixation was preferred when designers lacked a clear vision or were less experienced. [S] — [MIT Sloan](https://mitsloan.mit.edu/node/46917)
- Anthropic's cookbook on frontend aesthetics (Oct 2025) states Claude tends toward generic, conservative designs and converges to "on distribution" output without guidance; three strategies: guide specific design dimensions, reference design inspirations, call out common defaults to avoid. [F] — [Claude cookbook](https://platform.claude.com/cookbook/coding-prompting-for-frontend-aesthetics) (read through search summary, page not opened)
- Formative study of a generative-UI tool (arXiv 2501.13145; 37 professionals: 11 designers, 7 researchers, 7 PMs, 12 developers at one North American tech company; week-long project + diary + 30-60 min interview; grounded theory). Good for first drafts and blank-page problems; output "not production-ready", truncated text, misalignment, accessibility issues ("last mile" gap); generic/templated ("could fit any other app"); inconsistency across screens; tool ignored explicit instructions. Single tool/company, self-report. [F] — [arXiv 2501.13145](https://arxiv.org/html/2501.13145v1)
- CHI 2024: interviews with 20 UX designers on genAI; experienced designers see it as supportive and trust their own originality and empathy; concern about skill degradation and creativity exhaustion, more for juniors. [S] — [arXiv 2309.15237](https://arxiv.org/pdf/2309.15237)

### Inferences
- Failure mode "average/generic output": mitigation (checkable): before committing to a direction, produce >=3 options that differ on a named axis (e.g., different core mental model or primary job), and state for each what it sacrifices. Check: a reviewer can say how option A and B differ in one sentence each.
- "Anti-default list" in the skill (e.g., generic dashboards-with-cards, onboarding carousel, hamburger menu by reflex) following Anthropic's "call out common defaults" strategy. Check: each default that appears must carry a one-line justification tied to a stated user need.
- Fixation counter: generate options before showing/picking any reference, and do not let the AI's first option become the base (Wadinambiarachchi finding). (inference)
- Include a "could this fit any other product?" test (from the practitioner quote above) as a rubric item: replace product name; if the artifact still reads true, it is generic.

### Gaps
- No quantitative benchmark on UX-artifact homogenization (journey maps, IA) found; evidence is from stories/images/chairs and UI mockups. UI-generation benchmark literature was not searched.

## Sycophancy and anchoring on the user's framing

### Takeaway
Sycophancy is a documented general trait of RLHF-trained assistants; NN/g saw it directly in concept feedback. I found no tested UX-specific mitigations; countermeasures below are structured-prompt inferences.

### Cited Findings
- Sharma et al. (ICLR 2024): five AI assistants showed sycophancy across four free-form generation tasks; human preference data favors responses matching user views; humans and preference models sometimes prefer convincing sycophantic answers over correct ones; optimizing against preference models can trade truthfulness for sycophancy. [F] — [arXiv 2310.13548](https://arxiv.org/pdf/2310.13548)
- NN/g observed sycophantic concept feedback from a synthetic user (drone delivery "very useful"). [F] — [NN/g](https://www.nngroup.com/articles/synthetic-users/)
- Huang et al. (ICLR 2024): LLMs cannot reliably self-correct reasoning without external feedback; performance can drop (a secondary blog reports GPT-4 GSM8K 95.5% to 91.5% after one intrinsic round); earlier gains relied on oracle labels; self-correction helps more in style/format/toxicity than in reasoning. [F] — [arXiv 2310.01798](https://arxiv.org/html/2310.01798v1); numbers via [blog summary](https://beancount.io/bean-labs/research-logs/2026/04/28/llms-cannot-self-correct-reasoning-yet)

### Inferences
- Mitigation set (none tested in sources, all checkable in output): (1) restate the user's idea as a hypothesis, separate from the problem statement, and require a "problem without the solution" line (XY check); (2) require a pre-mortem section ("assume this failed in 6 months; 3 most likely reasons") and a strongest-counterargument section; (3) require at least one alternative framing that is not a variation of the user's idea; (4) forbid evaluative praise words about the user's idea unless attached to evidence.
- Because intrinsic self-critique is weak (Huang et al.), pair critique with external signal: a rubric of concrete pass/fail items, a separate reviewer pass with a fresh context, or a script/check, rather than "reflect and improve".

### Gaps
- No peer-reviewed study of devil's-advocate/pre-mortem prompts on LLM design output found in this pass (not searched specifically). Anthropic's own sycophancy guidance not retrieved.

## Happy-path bias and jumping to feature lists

### Takeaway
I found no controlled study of happy-path bias in LLM UX flows. Evidence is indirect: simulators and generated UIs underrepresent friction, errors, and edge cases.

### Cited Findings
- Simulated users do not push back, front-load info, rarely show uncertainty or frustration (CMU, above) [S] — [arXiv 2603.11245](https://arxiv.org/abs/2603.11245)
- Generative-UI study: first drafts good, edge cases (truncation, accessibility) are where it falls short [F] — [arXiv 2501.13145](https://arxiv.org/html/2501.13145v1)
- Search for LLM happy-path/edge-case studies in requirements or user stories returned nothing specific. [F, negative result] — search "LLM-generated user stories ... happy path" (no hit)

### Inferences
- Mitigation (checkable): require state enumeration for each key screen/flow (empty, loading, partial, error, offline/permission-denied, first-time vs returning, long/short content, undo/cancel, abandon-and-resume). Output includes a coverage matrix; blank cells must be marked "N/A because X", not left empty.
- Require a separate adversarial pass: "list 5 ways a real user fails this flow", with at least one non-technical cause (misunderstanding, interruption).
- Anti-feature-list gate: no feature list until a job/problem statement, success measure, and constraints exist; each feature must trace to a named need (traceability column). Check: any feature with no source need is flagged.

### Gaps
- No empirical source. Treat these as practitioner-style proposals.

## Question-asking: ask vs assume

### Takeaway
Research shows models often recognize ambiguity but answer anyway instead of asking, so under-asking is the default failure; the best-supported approach is to ask only when the answer would change the outcome, and otherwise assume explicitly.

### Cited Findings
- "Clarify When Necessary" splits the problem into when to ask, what to ask, and how to use the answer; its Intent-Sim estimates entropy over intents and best identified when asking improves expected performance in 4 of 6 settings. [S] — [ar5iv 2311.09469](https://ar5iv.labs.arxiv.org/html/2311.09469)
- A 2026 preprint "Knowing but Not Showing": models can recognize ambiguity when prompted but frequently answer directly instead of asking; retrieved context worsens the gap. [S] — [HF papers 2605.25284](https://huggingface.co/papers/2605.25284)
- SAGE-Agent (tool-calling agents) uses Expected Value of Perfect Information to choose questions; reports 7-39% more coverage of ambiguous tasks with 1.5-2.7x fewer clarification questions vs baselines. [S] — [papers.cool 2507.10445](https://papers.cool/arxiv/2507.10445)
- Human vs LLM clarification (CRAC/EMNLP 2025, Minecraft dialogues): weak link between ambiguity and human clarification; reasoning increased LLM question frequency/relevance. [S] — [ACL Anthology](https://preview.aclanthology.org/setup/2025.crac-1.1)

### Inferences
- Mitigation (checkable): a short intake with a hard cap (e.g., <=5 questions, one round) limited to "answer would change the direction" items (target user, decision to be made, constraints, existing evidence, success measure). Everything else is proceed-with-assumption.
- Every deliverable opens with an Assumptions ledger: assumption, why assumed, impact if wrong, how to verify. Check: ledger exists and each item has a verification path.
- Detect under-asking by test: give an ambiguous brief to the skill; pass if it asks or labels assumptions before producing a solution.

### Gaps
- No UX-specific study of question-asking found. Evidence is from general or tool-calling agents.

## Verification patterns that work for agents (Anthropic guidance)

### Takeaway
Anthropic's skill authoring guidance recommends checklists, validator-then-fix loops, plan-validate-execute with scripts, concise skills, and evals-first development; it says checklists "prevent Claude from skipping critical validation".

### Cited Findings
- "Provide a checklist that Claude can copy into its response and check off"; the research synthesis example includes cross-reference claims to sources and verify citations steps. [F] — [Skill authoring best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)
- Feedback loop: "Run validator, fix errors, repeat ... greatly improves output quality"; the validator can be a reference doc (style guide) with a checklist (terminology consistency, required sections present) and "Only proceed when all requirements are met". [F] — same
- "Clear steps prevent Claude from skipping critical validation." [F] — same
- Plan-validate-execute: create a structured plan file and validate it with a script before acting; scripts give objective verification and specific error messages. [F] — same
- Prefer scripts for deterministic checks; set "degrees of freedom" by fragility (narrow bridge = exact instructions; open field = heuristics). UX judgment tasks are high-freedom, but structure checks (required sections, ID traceability, coverage matrix non-empty) can be scripted. [F] — same
- Concision: SKILL.md under 500 lines, one-level-deep references, only add what Claude does not already know; avoid offering too many options, give a default. [F] — same
- Evaluation-driven development: run Claude without the skill, document failures, build at least three eval scenarios, baseline, write minimal instructions, iterate; test with Haiku, Sonnet and Opus. No built-in eval runner. [F] — same
- Claude Code verification loops post: gather context, act, verify; turn manual checks into skills. [S] — [claude.com](https://claude.com/resources/articles/building-verification-loops-in-claude-code-with-skills)
- Template pattern: strict templates for strict requirements; "sensible default, adapt as needed" for flexible. [F] — best-practices page

### Inferences
- Encode a "reviewer pass" as a separate fresh-context step (subagent) with a rubric, since intrinsic self-correction is weak (Huang). Rubric items must be binary and cite where in the artifact to look.
- A lint script can check: evidence labels present on every claim; Assumptions ledger present; >=3 options present; state matrix has no empty cells; deliverable length under a cap (counter to verbosity).
- Verbose deliverables: set a length budget per artifact and put detail in appendix files; lead with decision + recommendation + next step.

### Gaps
- Anthropic's own sycophancy / rubric-self-critique guidance not retrieved. Secondary summaries (Atlan, MindStudio, BestHub) not used as evidence.

## Practitioner reports 2024-2026

### Takeaway
The best-sourced practitioner evidence I found is the 37-person generative-UI study and the 20-designer CHI interviews; both say AI is good for first drafts and ideation, weak on the last mile, originality and consistency. I did not find reliable blog-level practitioner reports in this pass.

### Cited Findings
- See generative-UI study and CHI 2024 interviews above. [F/S]
- NN/g: risk that low-maturity orgs treat synthetic users as a replacement for research. [F] — [NN/g](https://www.nngroup.com/articles/synthetic-users/)
- Generative-UI participants worried non-designers would over-rely on imperfect output and wanted warnings when edits violate accessibility/design-system rules. [F] — [arXiv 2501.13145](https://arxiv.org/html/2501.13145v1)

### Inferences
- Skill should tell Claude to state its role: draft/hypothesis generator and critic, not source of evidence.

### Gaps
- No vetted practitioner posts (Figma AI, ChatGPT, Claude for UX deliverables) collected; not searched. No CHI 2025 designer-genAI paper confirmed.

## Summary table: failure mode to checkable mitigation

| Failure mode | Evidence strength | Checkable mitigation |
|---|---|---|
| Fabricated/ungrounded personas and quotes | Strong (NN/g, several persona studies) | Evidence labels; zero-OBSERVED persona = proto-persona; no simulated quotes/stats as findings |
| Confident unsupported claims | Strong indirect (NN/g, sycophancy) | Every claim tagged OBSERVED / STATED / ASSUMED; verification path for each assumption |
| Homogenized/generic output | Strong (Doshi & Hauser, CHI 2024 n=60, Anthropic cookbook) | >=3 options differing on a named axis; anti-default list; "fits any app?" test |
| Sycophancy to initial idea | Strong general (Sharma), observed by NN/g | Problem separated from solution; pre-mortem; counterargument; alternative framing |
| Happy-path only | Weak (no direct study) | State/coverage matrix; adversarial failure pass |
| Feature-list jump | No study found | Need-to-feature traceability; gate on problem + success measure |
| Over/under-asking | Moderate (preprints) | Capped, decision-changing questions; assumptions ledger |
| Weak self-review | Moderate (Huang) | Rubric + fresh-context reviewer; scripted lint where possible |
| Verbose deliverables | Anthropic guidance on conciseness (for skills, not deliverables) | Length budget; decision-first structure; appendix |
