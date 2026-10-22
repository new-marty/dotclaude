# Expert UX questions: kickoff, user interviews, critique, digging for the "why", and how an AI should use them

Method note: ~25 tool calls (WebFetch/WebSearch only; no curl needed, nothing saved to downloads/). Verbatim wording below is from pages actually fetched; wording from search summaries is labeled "secondary". Items marked [SYN] are my synthesis, not source wording. Earlier notes (02) covered JTBD schools, personas, assumption mapping, HMW; not repeated here except where a question is lifted from them.

## 1. Kickoff / stakeholder questions (what experts actually ask the requester)

### Takeaway
Goodwin's and NN/g's published lists agree on a pattern: ask role-specific facts, then goals and personal definition of success, then worries ("worst thing that could happen"), then constraints and history, and always close with "who else" and "what did I not ask". The sharp questions are the ones that expose conflicts and buried assumptions (what is it NOT meant to be; speed vs quality; what do you know that others haven't said). Shape Up adds a requester-side question set for raw ideas: what is driving the request, and what is the baseline.

### Cited Findings
- Goodwin (Designing for the Digital Age, excerpt on Boxes and Arrows) "All stakeholders" list, verbatim: "What is your role in this project?"; "What is this product going to be?"; "Who is this product for?"; "When is the version we're designing going to be released?"; "What worries you about this project? What's the worst thing that could happen?"; "What should this project accomplish for the business?"; "How will you, personally, define success for this project?"; "Is there anyone you think we need to speak with who isn't on our list? Who?"; "How would you like to be involved in the rest of the project, and what's the best way to reach you?" — [Boxes and Arrows: stakeholder interview checklist](https://boxesandarrows.com/a-stakeholder-interview-checklist/)
- Goodwin "Watch out for": "Presumed constraints—ask why they are constraints"; "Jumping to solutions—ask what problem the solution would solve". — same
- Goodwin adds "What is the product not meant to be?" and advice: keep it conversational, hold a topic cheat sheet; probe buzzwords by asking what the product does "for the average user"; when two goals conflict, point out the contradiction and ask which matters more; save worries for later "after the stakeholder has relaxed"; if business goals can't be articulated, ask narrower questions. — [Boxes and Arrows: general stakeholder interview](https://boxesandarrows.com/the-general-stakeholder-interview/)
- Goodwin role-specific questions, verbatim: Marketing: "Who are your customers and users today, and how do you want that to be different in five years?"; "How do you expect to differentiate this product?"; Sales: "Why do customers buy a product like this one, and why this one over competitor's?"; "When you lose sales, what are the most common reasons?"; "What things do customers complain about or ask for most often, and why?"; Executives: "What do I need to know that you don't think other members of your team have said?"; "If you had to choose between going to market on schedule with a flawed product, or going to market late with a solid product, which would you choose?"; Engineering: "What technology decisions have already been made, and how firm are they?"; SMEs: "What distinctions in user roles and tasks would you expect us to see?"; Support: "What problems do you see most often?"; Training/docs: "Where do users most often get confused today?" — [Boxes and Arrows checklist](https://boxesandarrows.com/a-stakeholder-interview-checklist/)
- NN/g stakeholder interview guide, verbatim examples: "What are you aiming to achieve with that work?" and "Why is that important to the organization?"; "What does success look like for you and your team?"; "Can you tell me about any constraints related to the work I'm doing that you think would be important for me to know about?"; "Can you tell me about any solutions to this problem or similar projects you've tried before?"; closing "Is there anything else that would be helpful for me to know?" and "Who else should I speak to?". Principles: semistructured guide, tie questions to a concrete interview goal, ask for an example or "why does it matter" as follow-up, stay neutral. — [NN/g stakeholder interviews](https://www.nngroup.com/articles/stakeholder-interviews/)
- Shape Up (Basecamp), verbatim fragments: "In that case we flip from asking 'What could we build?' to 'What's really going wrong?'"; "But what is driving the request?"; "At what point specifically does someone's current workflow break down without this thing they're asking for?"; "What was she doing when the thought occurred to ask for it?"; "What's not working? In what context are there too many steps?"; "What parts of the existing design can stay the same and what parts need to change?"; baseline = "What customers are doing without the thing we're currently building."; default reaction to a raw idea: "Interesting. Maybe some day." and "It's too early to say 'yes' or 'no' on first contact." — [Shape Up ch. 3 "Set Boundaries"](https://basecamp.com/shapeup/1.2-chapter-03)
- GV sprint (via thoughtbot playbook, an adaptation, not the book): "What questions do we want to answer in this sprint?"; "To solve our problem statement what needs to be true?"; "If in future this project completely failed, what might have caused that?"; then rewrite answers as questions ("They have to trust us" becomes "Will potential customers trust our skills?"). — [thoughtbot sprint questions](https://thoughtbot.com/playbook/designing/design-sprints/03-understand-exercises/sprint-questions)
- GOV.UK discovery (already in note 02): challenge a predefined solution, state what is out of scope, quantify the cost, consider non-build options. — [GOV.UK discovery](https://www.gov.uk/service-manual/agile-delivery/how-the-discovery-phase-works)

### Inferences
- [SYN] The questions that surface what a requester "hasn't noticed" are rarely the opening ones; they are: not-meant-to-be, worst case, which goal wins when two conflict, what has been tried, what do others know that you don't say, and baseline (what do people do today without this).
- [SYN] Goodwin's role-based lists tell the skill to ask the requester to wear several hats ("answer as sales", "as support") when only one human is present: support/sales questions ("what do customers complain about", "where do users get confused") are answerable by a requester from memory and are the nearest proxy for user data.

### Gaps
- Erika Hall's (Just Enough Research) stakeholder-interview question list: not found. Two searches only returned book descriptions; her text was not retrievable, so nothing is attributed to her here.
- Spool/Center Centre stakeholder questions, Intercom/Linear "what would you do if we didn't build it": not found verbatim (Intercom/Des Traynor searches returned only secondary summaries). The "what if we didn't build it" wording is not sourced; the nearest primary equivalents are Shape Up's baseline and GOV.UK's non-build options.

## 2. User-interview questions (past behaviour, stories, incidents, observation)

### Takeaway
All the user-research sources converge on one move: replace opinions and futures with a specific past episode ("the last time"), then probe the facts around it. The Mom Test names what to distrust (generics, future promises, hypotheticals, compliments); NN/g's critical-incident method scripts the follow-ups; switch interviews structure the story as a timeline; contextual inquiry replaces asking with watching.

### Cited Findings
- Mom Test rules (via a book report): "Talk about their life instead of your idea."; "Ask about specifics in the past instead of generics or opinions about the future."; "Talk less and listen more." Fluff = generic claims ("I usually/always/never"), future promises ("I would/will"), hypothetical maybes ("I might/could"); when it appears, anchor to a concrete past event. Instead of "what would you pay", ask what the problem currently costs them; instead of "would you use it", ask how they handle it now and what alternatives they tried. Closers: "Who else should I talk to?" and "Is there anything else I should have asked?". Commitment (time, reputation, money) and advancement are the real signal, compliments are noise. — [mtlynch.io book report](https://mtlynch.io/book-reports/the-mom-test/); search summary also gives "Talk me through the last time that happened" and "What else have you tried?" (secondary; book not read) — [search results incl. greaterwrong summary](https://www.greaterwrong.com/posts/fuktKYSvzFMTfPpeT/the-mom-test-summary-and-thoughts)
- NN/g critical incident technique, verbatim: "Tell me about a time where you used the tool in your job." (general) vs "Tell me about the last time you used the tool in your job." (specific) vs "Tell me about a particular time when you used the tool in your job where it helped you to be effective in your work." and the negative form ("...and it made you ineffective"). Probes: "What task were you doing at the time?"; "Why did you choose to use the tool?"; "In what way did the tool make you effective?" Ask positive first, then negative, separately; "Is there another time you can think of...?". Limits: memory-dependent, surfaces extremes, misses typical use; pair with observation. — [NN/g CIT](https://www.nngroup.com/articles/critical-incident-technique/)
- NN/g user interviews, verbatim: "Walk me through a typical day for you."; "Tell me about the last time you [did something]."; follow-ups "When did this happen?", "How long did it take you?", "Has this happened to you before?", "How did you feel during this experience?"; probes "Tell me more about that.", "Why is that important to you?". Specific events beat general processes because a particular incident aids recall. — [NN/g user interviews](https://www.nngroup.com/articles/user-interviews/)
- Switch-interview timeline (one secondary guide, which credits Moesta and Spiek for the method but does not attribute these exact words to them): "When did you first realize the old way wasn't working?"; "What were you doing once you started looking around?"; "When did you start seriously comparing options?"; "Walk me through the moment you decided." Moesta/Spiek Q&A: the odd-seeming questions rebuild a memory; comfort over pressure. — [Koji switch interviews](https://www.koji.so/docs/switch-interviews-jtbd-method) (secondary); [JTBD.org mattress interview Q&A](https://jobstobedone.org/radio/the-mattress-interview-qa/) (seen only as a search result)
- Forces of progress (push, pull, anxiety, habit) from note 02 supply the probing targets: "what were you worried about?" / "what almost stopped you?" — see [note 02](02_problem_framing_and_evidence.md).
- Contextual inquiry (NN/g), four principles: context (observe in the natural environment), partnership (researcher doesn't control the session), interpretation (build shared understanding, check readings with the user), focus. Observe: external resources users rely on (notes, other tools), standard steps vs unusual variations. Ask: open questions about actions you don't understand and why the user took them. Share interpretations of the mental model for the user to correct, mostly at wrap-up. — [NN/g contextual inquiry](https://www.nngroup.com/articles/contextual-inquiry/)
- Portigal (Interviewing Users): only secondary snippet that stories are where the richest insights lie and getting to them should be the objective. — [Goodreads quotes](https://www.goodreads.com/work/quotes/25017878) (secondary)

### Inferences
- [SYN] "Observe: external resources, unusual variations" translates to requester questions like "what do they keep on a sticky note / spreadsheet / in their head next to this tool?" and "what do they do when it doesn't go the normal way?" These expose workarounds a screen design must absorb.
- [SYN] CIT's bias warning (extremes) means ask both "last time" (typical-ish) and "worst time" (critical): the skill should do both.

### Gaps
- Portigal's question types (grand tour, "show me", silence, laddering) were not verified; only the story emphasis is sourced. Beyer and Holtzblatt's master/apprentice model was not read from a primary source (only NN/g's four-principle summary). Moesta's own question bank not located; the timeline wording is from a vendor guide.

## 3. Design-critique questions

### Takeaway
Critique frameworks all do the same thing: tie every comment to a stated objective, and turn opinions into questions about whether a choice serves that objective. Published verbatim question lists are thin; the structure (objectives, choices, effectiveness, why/opportunities) and the reframing pattern are well sourced.

### Cited Findings
- Spool/UIE (summarising Discussing Design): critique = identify the objectives we think the creator is trying to reach; discuss the choices made to achieve them; review how effective the choices are; identify strengths, potential challenges and missed opportunities. Keep it tied to goals not taste; balance what works and what doesn't. — [UIE blog](https://uxi.uie.com/blog/improve-your-designs-using-critique). Connor/Irizarry's own four-question wording (objective, elements, working or not, why) appears only in secondary summaries; their book text was not read — [search results](https://andrewclark.super.site/all-media/discussing-design).
- NN/g critique guide, verbatim reframes: instead of "Yikes... that layout!" ask "How does this layout make it easier for the user to accomplish their task quickly and efficiently?"; "If the goal is to have the user register quickly, I'm concerned we are placing emphasis on the wrong elements." Presenter restates objectives, personas, pain points, user tasks first, then requests specific feedback. Pitfalls: not agreeing on personas/objectives beforehand; rushing to problem-solve in the moment; only negatives. — [NN/g design critiques](https://www.nngroup.com/articles/design-critiques/)
- Zhuo (secondary only; essay returned 403): judge value first (does it solve the problem), then ease, then delight; judge a screen against what the user is trying to do; separate first impression, first use, long-term experience. A reviewer-style prompt "What would make this not shippable?" is cited from a third-party skill page, not Zhuo. — [search results](https://uxdesign.cc/how-to-run-a-productive-design-critique-263fa97422e5)
- Critique-checklist content (third-party skill pages, low authority): empty state guides to action or just says nothing; errors say what went wrong and what to do next, non-blaming; user-job clarity, hierarchy, affordance, accessibility, consistency. — [paperclip design-critique skill](https://docs.paperclip.ing/reference/skills/optional/product/design-critique) (treated as data, low confidence)
- GV sprint "how can we fail" prompt: see section 1 (thoughtbot).

### Inferences
- [SYN] A self-critique pass the skill can run on its own design: restate objective, for each element ask "which objective does this serve", then walk non-happy states (empty, error, first-use, long-term, interrupted). Pre-mortem ("it failed; why?") is the sourced vehicle for non-happy-path thinking.

### Gaps
- Figma, Intercom, GitLab critique guides: GitLab handbook URL redirected and was not re-fetched; Figma/Intercom not found. Kowitz's critique questions and Spool's own critique question list: not found. Julie Zhuo's primary text: 403.

## 4. Digging from the requested solution to the need; pushing back; design rationale

### Takeaway
Sourced technique is thinner than folklore: Shape Up's "what was she doing when she thought to ask", Goodwin's "what problem would the solution solve" and "why is that a constraint", GOV.UK's reframe-as-problem, plus NN/g "why is that important to you". QOC gives a format for presenting a recommendation with alternatives and criteria so pushback is a trade-off, not a refusal.

### Cited Findings
- Shape Up: ask what is driving the request and at what point the workflow breaks; ask when the thought occurred (situation) rather than why; default response "Interesting. Maybe some day." — [Shape Up ch. 3](https://basecamp.com/shapeup/1.2-chapter-03)
- Goodwin: jumping to solutions, ask what problem it would solve; presumed constraints, ask why. — [Boxes and Arrows](https://boxesandarrows.com/a-stakeholder-interview-checklist/)
- A product-management piece argues a feature request is a customer's guess at the solution; the real feedback is the underlying problem/constraint/job. — [getperspective.ai](https://getperspective.ai/blog/feature-requests-are-not-product-feedback/markdown) (low-authority secondary)
- Phabricator contributor docs require describing the problem, and note the proposed solution may not fit but "we may be able to come up with another solution which has approximately the same effect." — [Phabricator docs result](https://phabricator.violetlms.com/book/phabcontrib/article/feature_requests) (seen only as search result)
- QOC (MacLean, Young, Bellotti, Moran 1991): Questions frame key design issues, Options are candidate answers, Criteria are the bases for comparing options; assessments link option to criterion as supports or challenges; it records design space as a co-product, unlike IBIS which records process. Intended to make trade-offs discussable. — [AcaWiki summary](https://acawiki.org/Questions,_Options,_and_Criteria:_Elements_of_design_space_analysis); [Naver Labs history](https://europe.naverlabs.com/history/past-research/design-space-analysis/) (summaries; 1991 paper not read)
- NN/g critique reframe pattern ("If the goal is X, I'm concerned that Y") is a ready template for respectful pushback. — [NN/g](https://www.nngroup.com/articles/design-critiques/)

### Inferences
- [SYN] Pushback template for the skill: "You asked for X. The need I heard is N. Options: X, Y, Z. Criteria: C1..Cn. My recommendation is Y because C2, at the cost of C1. Tell me if C1 matters more." That is a QOC row in prose.
- [SYN] Five whys / laddering: no primary source fetched (NN/g 5-whys URL 404). Use as technique name only; the sourced equivalents are "why is that important to you?" and "what problem would it solve".

### Gaps
- Five whys, laddering, "what would that let you do?": no primary or reliable secondary source retrieved. Intercom/Linear wording unverified. MacLean 1991 full text not read.

## 5. What an AI should ask the requester vs research vs hold as assumption

### Takeaway
[SYN, no source covers AI-as-designer.] The requester can answer questions about their own goals, constraints, worries, history, and (via memory) concrete past episodes involving their users. They cannot answer how users would react to a design or what users want in general; those become labeled assumptions with a disproof signal.

### Inferences
- Ask the requester (proxy, answerable from memory): goals, success definition, worst case, not-meant-to-be, constraints and "why", what was tried, baseline workflow, support/sales-style complaints, and past incidents ("the last time someone double-booked"). Source basis: Goodwin, NN/g, Shape Up, CIT.
- Convert user questions to requester questions by adding "tell me about the last time you saw/heard" and by asking for the requester's own role as the observer: CIT, "last time", "what else have they tried" convert well; "how did you feel", "what almost stopped you" convert only if the requester was there, else mark as assumption.
- Do not ask the requester: "would users like/use this", "what would they pay", "is this intuitive". These are hypotheticals (Mom Test); log as assumption, tag with who could validate.
- Research (desk/AI can do): competitor patterns, domain conventions, regulations, accessibility, platform guidelines; and the AI's own critique pass (section 3).
- Hold as assumption with a test: audience hypothesis, frequency/severity, willingness to switch (forces), any metric target. Format from note 02: statement, importance, evidence, disproof signal, cheapest test.
- Note the Mom Test commitment idea does not transfer: the requester's enthusiasm is a compliment; ask what they will commit (time to review a prototype, an intro to a real user).

### Gaps
- No source evaluates proxy interviewing of a requester about their users; reliability of proxy answers is unknown (people filter through their own beliefs). The skill should label such answers "requester-reported".

## 6. Question bank (46 questions; tag: who / blind spot / source)

Who: R = requester (proxy), U = end user (via requester recall or later research), D = design review (ask of the design). Source "SYN" = my rewording or composition, with the nearest source named.

### A. Purpose and outcome (R)
1. What is going wrong today that made you want this? / R / solution-first request, no problem named / Shape Up "What's really going wrong?"
2. What was happening when the thought occurred to ask for it? / R / hides trigger situation / Shape Up
3. At what point does the current workflow break down without it? / R / vague pain / Shape Up
4. What do people do today without this (what is the baseline)? / R / ignoring existing workarounds and competing habits / Shape Up glossary
5. What would count as success, for you personally, and how would you notice? / R / unmeasurable goal, no stop condition / Goodwin
6. Why is that important to the organization (or to you)? / R / goal that is really a means / NN/g
7. What should this accomplish for the business, and for the person using it? / R / one-sided value / Goodwin (SYN split)
8. What is this NOT meant to be? / R / scope creep, hidden non-goals / Goodwin
9. If we did nothing or used a spreadsheet, what would be lost, and what would it cost? / R / unexamined non-build option / GOV.UK non-build + cost (SYN wording)
10. If you had to choose: on time with a flawed product or late and solid? / R / unstated priority between speed and quality / Goodwin (executives)
11. If two of your goals conflict, which wins? / R / silent trade-offs / Goodwin advice

### B. Risk, constraints, history (R)
12. What worries you about this project? What is the worst thing that could happen? / R / fears that shape scope, e.g. data loss, embarrassment / Goodwin
13. If this failed in six months, what would the reason be? / R / unexamined failure causes / GV pre-mortem via thoughtbot
14. What has been tried before, and what happened? / R / repeated past failures / NN/g
15. Which constraints are fixed, and why are they constraints? / R / presumed constraints / Goodwin
16. What technology or data decisions are already made, and how firm are they? / R / hidden platform/legacy limits / Goodwin (engineering)
17. What do you know about this that you don't think others on your team have said? / R / undisclosed knowledge / Goodwin (executives)
18. Who else should I talk to, and what should I have asked? / R / missing stakeholders / Goodwin, NN/g, Mom Test

### C. Who and context (R about users)
19. Who is this for, and who is it explicitly not for? / R / assuming one audience / Goodwin (not-for SYN)
20. Who decides, who pays, who uses, who is affected but never asked? / R / non-user stakeholders (e.g. the patient, the admin) / Goodwin sales "who is typically involved in the purchase decision" (SYN extension)
21. How much do users vary in skill, frequency, devices, and role? / R / designing for the average that does not exist / Goodwin SMEs
22. Where and with what are they when they do this (interruptions, device, noise, time pressure)? / R/U / context of use / NN/g contextual inquiry "context" (SYN)
23. How often does this happen: daily, monthly, once? / R/U / frequency decides optimise-vs-explain / SYN (CIT "has this happened before")

### D. Past behaviour and incidents (R recalling; U if available)
24. Tell me about the last time this happened. Walk me through it. / R/U / generic claims and idealised process / Mom Test, NN/g
25. What were they doing just before, and what did they do right after? / U / missing entry and exit points of the flow / CIT probes (SYN)
26. Tell me about a time it went well, and a time it went badly. / R/U / only extreme or only typical cases / NN/g CIT
27. What do they keep on the side (notes, spreadsheet, memory, a coworker) to get this done? / R/U / workarounds and external resources / NN/g CI "external resources"
28. What do they do when it does not go the normal way? / R/U / exception paths / NN/g CI "unusual variations"
29. What have they already tried, and why did they stop? / R/U / prior solutions and their failure / Mom Test, NN/g
30. What does this problem currently cost them (time, money, mistakes)? / R/U / severity guess instead of cost / Mom Test
31. What complaints or requests do you hear most often, and why? / R / loudest vs. most frequent signal / Goodwin sales/support
32. Where do users get confused today? / R / known friction points / Goodwin training/docs
33. What almost stopped them from adopting or finishing? What would they miss about the old way? / U / anxiety and habit forces / forces of progress (note 02), switch interviews
34. When did they first realise the old way wasn't working? / U / trigger event (for onboarding/entry design) / switch timeline (Koji, secondary)

### E. Hypothesis to react to (R, convert from options)
35. I'm assuming [X]; is that true for the last three cases you can recall? / R / unconfirmed assumption presented as fact / SYN (assumption mapping, note 02)
36. Which of these two or three approaches fits how people really do it, and which would break their habit? / R / unexplored alternatives / SYN (QOC)
37. What would have to be true for this to work? / R / hidden dependencies / GV via thoughtbot

### F. Design review (D; asked by the skill of its own design)
38. What objective does each element serve, and who defined it? / D / decoration with no job / Discussing Design (UIE summary)
39. How does this layout make it easier for the user to accomplish their task quickly? / D / pretty but off-task / NN/g critique reframe
40. What does the user see on first use, with no data? / D / empty state / critique checklists (low authority); Zhuo "first use" (secondary)
41. What happens on error, on slow network, on partial success, on "undo"? / D / unhappy paths / SYN; critique checklists
42. What does the screen look like on the hundredth use, and with 1000 rows? / D / long-term and scale / Zhuo "long-term" (secondary)
43. Is there any state where the user cannot tell what happened or what to do next? / D / dead ends, silent failure / SYN
44. If the goal is [objective], where would the emphasis go wrong? / D / hierarchy vs goal / NN/g
45. Which of my choices rests on an assumption, and what would show it wrong? / D / hidden assumptions in design / note 02 (assumption log)
46. What would make this not shippable? / D / blocking flaw / third-party reviewer prompt (low authority)

## 7. Principles of asking

Source-backed unless marked [SYN].
1. Ask about the last specific time, not generic habit or the future. Generics, "I would", "I might" are fluff. — Mom Test; NN/g CIT
2. Ask about the requester's life and the users' situation before the idea. Keep solution talk out of the first questions. — Mom Test; Shape Up ("What's really going wrong?")
3. Ask what problem a proposed solution solves; ask why a constraint is a constraint. Do not accept or reject on first contact. — Goodwin; Shape Up
4. Probe worries, the worst case and failure causes; they are held back until rapport exists, so ask them later in the exchange. — Goodwin; GV pre-mortem
5. Name conflicts back to the requester and ask which wins. — Goodwin
6. Anchor critique in objectives; turn opinions into questions about whether a choice serves the goal. — Discussing Design via UIE; NN/g critique
7. Ask for both positive and negative incidents, separately, and several of them; know the memory and extremes bias. — NN/g CIT
8. Watch for what is around the task: tools on the side, workarounds, exceptions. — NN/g contextual inquiry
9. End with "who else" and "what did I not ask". — Mom Test; Goodwin; NN/g
10. [SYN] One question at a time, each with a one-line reason ("I'm asking because screens for first-time and daily users differ"). NN/g stresses tying questions to a concrete interview goal and open follow-ups; the one-with-a-reason format is my adaptation for chat.
11. [SYN] Offer a hypothesis or two to react to instead of an empty prompt (pairs with QOC options and the assumption log); label unconfirmed answers "requester-reported".
12. [SYN] Push back as options, criteria, and a recommendation with its cost (QOC shape), and end with what would change the recommendation.
13. [SYN] Do not ask what you can look up; ask the requester only what only they know.
