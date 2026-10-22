# Design cognition research: how expert designers think, and expert moves an AI agent can perform

Method note: about 29 tool calls. Primary text actually read: Vermaas/Dorst/Thurgood ICED15 (Kings Cross), Atman's own keynote slides summarising the 2007 JEE study, Visser 2006, a 2024 arXiv sampler that quotes Schön/Cross/Dorst & Cross, a 2025 arXiv study that defines primary generators and bridges. Blocked or not obtained: Cross 2004 full text (Elsevier 403, OU repository Cloudflare), Dorst & Cross 2001 full text, Dorst 2011 full text, Ahmed et al. 2003 (repository returned HTML), Schön and Lawson and Norman book texts. Everything resting on those is labeled secondary or moved to Gaps. Anything labeled "From memory, unverified" below is NOT a cited finding. Raw files: /Users/gary/tmp/ux-design-skill/downloads/{dorst,visser,atman,viz,cross}/. Earlier notes 01, 02, 09 were skimmed; process models (Garrett, double diamond stages, JTBD) are not repeated here.

## 1. Schön: reflection-in-action, naming and framing, "conversation with the situation", back-talk

### Takeaway
Schön's expert is not someone who analyses a fixed problem; the expert sets the problem by naming what to attend to and imposing a coherence, then acts, reads what the situation "says back", and reframes. Frames are judged by the quality of the conversation they enable, not by whether they are "true".

### Cited Findings
- Framing quote: "In order to formulate a design problem to be solved, the designer must frame a problematic design situation: set its boundaries, select particular things and relations for attention, and impose on the situation a coherence that guides subsequent moves." (Schön 1988, quoted in the arXiv sampler) — [Design Spaces sampler, arXiv 2407.18502](https://arxiv.org/pdf/2407.18502)
- "The work of framing is seldom done in one burst at the beginning of a design process" (Schön, quoted); Goel & Pirolli's protocol studies found problem-structuring dominates the start but recurs periodically throughout — [arXiv 2407.18502](https://arxiv.org/pdf/2407.18502)
- Schön: "A designer makes things... Typically this making process is complex. There are more variables... than can be represented in a finite model." Design is a "reflective conversation with the situation" — [arXiv 2407.18502](https://arxiv.org/pdf/2407.18502)
- Designers evaluate each move "in a threefold way": does the outcome meet the design criteria; does it conform to or violate what earlier moves implied; what new problems or possibilities did it create (the Quist/Petra school-design case, as paraphrased by a practitioner blog) — [thoughtbot](https://thoughtbot.com/blog/a-conversation-with-the-situation) (secondary)
- In the Quist and Petra case the instructor Quist uses metaphors and demonstrates moves rather than explaining them, because expert knowledge is hard to verbalise (blog paraphrase) — [thoughtbot](https://thoughtbot.com/blog/a-conversation-with-the-situation) (secondary)
- Reframing is the first step of the conversation; practitioners do not know a frame's implications in advance, so they test it by experiment and reframe if the consequences do not suit them. A frame is judged by whether the problem set can be solved, whether the situation becomes coherent, and whether inquiry keeps moving. "There is a problem in finding the problem." (review of The Reflective Practitioner) — [odannyboy review](https://www.odannyboy.com/?p=214) (secondary)
- The situation "talks back" through unintended effects, and the practitioner must listen and change the frame (same review; the page does not itself use the term "back-talk") — [odannyboy review](https://www.odannyboy.com/?p=214) (secondary)
- Schön's framing is analysed by Vermaas/Dorst as "taking a specific design situation S as being of a type T of situation", which lets the designer use experience from past situations of type T; this links metaphor and framing — [ICED15 Framing in design](https://opus.lib.uts.edu.au/bitstream/10453/36792/8/Full.pdf)

### Inferences
- For an agent: a "frame" can be written as one sentence "this situation is really a [type T]", which makes a specific set of solution moves available. The agent should test it by producing a cheap probe (a sketch of a screen state, a one-line flow) and check the threefold evaluation against it.
- "Back-talk" for an agent without a physical sketchpad = drafting a concrete artifact (a state table, a first-screen wireframe in words) and reading it for what it reveals (contradictions with earlier decisions, newly exposed cases).

### Gaps
- I did not get the book text, so exact Quist/Petra utterances, the "seeing-as" wording and Schön's "naming" quotes are unverified. Memory-only (unverified): Schön's phrase "see-move-see"; the "naming and framing" definition ("things to which they will attend" / "context in which we will attend to them").

## 2. Cross: how experts frame; solution-focused vs problem-focused; primary generator; co-evolution; first principles and systems thinking

### Takeaway
Expert designers do not analyse the problem exhaustively first. They scope it adequately, impose their own frame, and use early solution conjectures to learn about the problem, moving between the two repeatedly. Outstanding designers (Murray, Grange, Scheinman) share a broad systems view and design from first principles.

### Cited Findings
- Cross's claim: "successful design behaviour is based not on extensive problem analysis, but on adequate 'problem scoping'"; "Successful, experienced and especially outstanding designers are found in various studies to be pro-active" — [konigi quoting Cross 2004](https://mac.konigi.com/blog/problem-analysis-not-key-successful-design-process) (quote fragments only)
- Summaries of Cross (2004): expert approach is simultaneously top-down/broad and bottom-up/deep; experienced designers are pro-active in framing, imposing their view of the problem and directing the search for solution conjectures — [Design Thinking review, Muse](https://muse.jhu.edu/article/467170) (secondary, via search summary)
- Murray and Grange both take "a broad 'systems' approach to the problem", frame it "in a distinctive and ... personal way", and "design from first principles" (Cross, Design Thinking, p. 75, quoted in a review) — [Muse review](https://muse.jhu.edu/article/467170)
- Dorst & Cross 2001: protocol study of nine experienced industrial designers (litter disposal on trains). Designers start by exploring the problem space and positing a partial solution, then explore that in the solution space, which gives insights about the problem space; repeat ("co-evolution") — [arXiv 2407.18502](https://arxiv.org/pdf/2407.18502); study details also [TU/e record](https://research.tue.nl/en/publications/creativity-in-the-design-process-co-evolution-of-problem-solution/)
- Primary generator (Darke): a central idea (metaphor, concept, visual form) that appears early, often before the problem is understood, imposes structure on ambiguity and becomes the organising principle around which problem understanding and solution decisions develop. "Bridges" are tools (heuristics, metaphors, sketches) used iteratively to move between problem and solution space — [arXiv 2508.07058](https://arxiv.org/pdf/2508.07058)
- Same 2025 study (11 expert visualization designers) lists metaphors, heuristics, sketching, primary generators and reflective practice as the devices experts use to link problem and solution — [arXiv 2508.07058](https://arxiv.org/pdf/2508.07058)
- Visser's review: Akin found architects keep searching for alternatives even after a satisfactory concept (no premature commitment); Visser disputes this by pointing to design fixation and premature commitment to an early kernel idea — [Visser 2006](https://arxiv.org/pdf/cs/0612022). So "commit early" and "don't commit early" are both in the literature.
- Cross, per Muse review: "intense, reflective interaction with representations of problems and solutions" is the core of design thinking — [Muse review](https://muse.jhu.edu/article/467170)

### Inferences
- The two conflicting findings (early commitment vs. keep searching) are reconcilable as: commit to a provisional primary generator, hold it as a hypothesis, and keep a second candidate alive to test it against. This is my synthesis, not a source claim.
- Concrete agent output: a named "design concept in one line" (primary generator) at the start, revised openly when a probe contradicts it.

### Gaps
- Cross 2004 full text and Darke's original paper (1978/79/84; sources disagree on year) not read; direct Cross quotes on Murray ("Winning by design") not retrieved.

## 3. Dorst: abduction, frames, frame creation, Kings Cross

### Takeaway
Dorst's core claim: design problems are ones where neither the "what" nor the "how" is known, only the desired value or outcome, so designers create a frame (a "how" principle plus a way of seeing the situation) and then the "what". The Kings Cross case shows a frame changing the solution space entirely; the follow-up paper shows frames can also fail.

### Cited Findings
- Reasoning equations (Dorst 2015, relayed): deduction = what + how leads to ???; induction = what + ??? leads to outcome; normal abduction = ??? + how leads to outcome; design abduction = ??? + ??? leads to outcome — [i2Insights](https://i2insights.org/2022/11/01/abductive-reasoning-for-complexity/amp/) (secondary relay)
- Dorst 2011's four notions: abduction is the challenge; design reasoning is the response; design practices; frame creation (literature-review summary) — [TTU summary](https://scholars.ttu.edu/en/publications/the-core-of-kees-dorsts-design-thinking-a-literature-review)
- Kings Cross: Sydney's nightlife district had drunkenness, violence, theft, drugs. Previous attempts (strong-arm tactics, more police) "failed to enhance feelings of public safety and instead resulted in a grim atmosphere". Designers saw that it had been treated as law-and-order although "the people involved were not actually criminals. Instead, they were just young people looking to position themselves in a social setting and to have a good time"; lack of structure and sheer volume left them bored and frustrated — [ICED15](https://opus.lib.uts.edu.au/bitstream/10453/36792/8/Full.pdf)
- The reframe: compare the district to a well-organised music festival; they "asked themselves what they would do if they were organising a music festival". About 20 solution directions came from this one frame, e.g. trains ended just when peak influx began, so they added signage to a nearby all-night station; "Kings Cross Guides" welcome visitors, inform, and double as extra eyes and ears for police — [ICED15](https://opus.lib.uts.edu.au/bitstream/10453/36792/8/Full.pdf)
- Formal model: situation S, goal G, frame F[T] = characterising S as of type T so that the solution directions regularly applied to type T become available. The client's own task wording may already carry a frame (the City framed it as reducing crime) and designers may drop it — [ICED15](https://opus.lib.uts.edu.au/bitstream/10453/36792/8/Full.pdf)
- Two failure modes: goal reformulation (solving a reframed goal, not the original) and frame failure (a frame the client cannot accept; e.g. "festival" suggests selling alcohol on the street, and police are present because of disturbances). In 2012-13 two fatal assaults occurred, and the authors question the original frame, noting the sequel also showed the government re-framing wrongly as "alcohol-related violence" — [ICED15](https://opus.lib.uts.edu.au/bitstream/10453/36792/8/Full.pdf)
- Frame Innovation presents a nine-step frame-creation process (book description); other listed examples: shops that encourage purchases rather than theft — [KU Press listing](https://press.ku.edu.tr/en/book/frame-innovation/)

### Inferences
- A frame is useful to an agent only if it (a) names a different type T for the situation, (b) yields several concrete solution directions the old frame did not, and (c) survives a check against the original goal G and the client's acceptance. This operationalises the Vermaas/Dorst failure modes.
- Analogy-as-frame is the most portable move for an agent: "this is a [domain] problem" borrowed from a domain that already solves it.

### Gaps
- The nine step names were NOT verified. Two searches and an MIT Press fetch (403) failed. From memory, unverified: Archaeology, Paradox, Context, Field, Themes, Frames, Futures, Transformation, Integration (and "Sustaining"). Do not rely on it without checking the book. Dorst 2011 full text not read.

## 4. Lawson: what designers know; precedent, guiding principles; scientists vs architects

### Takeaway
Lawson's block experiment shows that architects attacked the task by proposing solutions and learning the rules from what was rejected, while scientists tried to discover the rules first. Designers lean on prior solutions and guiding principles rather than analysis only.

### Cited Findings
- Lawson (1979) gave final-year architecture students and postgraduate science students a coloured-block task with hidden rules and a goal of a perimeter favouring one colour. Scientists tried many different block combinations quickly to learn the allowed combinations, then optimise ("problem-focused"). Architects chose blocks to achieve the desired perimeter and, when rejected, substituted the next most favourable combination ("solution-focused") — [search summary of Lawson via Wikipedia and others](https://en.wikipedia.org/wiki/Design_thinking); characterisation also in [Visser 2006](https://arxiv.org/pdf/cs/0612022)
- A reader summary of How Designers Think: design is solution-oriented, using heuristic transformations of solutions proposed early rather than analysing the problem exhaustively — [LibraryThing](https://www.librarything.com/work/142979) (secondary)
- Part 3 of How Designers Think includes a "Guiding principles" chapter (table of contents only) — [Routledge](https://www.routledge.com/How-Designers-Think-The-Design-Process-Demystified/Lawson/p/book/9780750660778)
- Visser: experts and novices differ in representation and organisation of knowledge, a classical cognitive-psychology result confirmed in design; also experts differ by type of expertise, not only level — [Visser 2006](https://arxiv.org/pdf/cs/0612022)

### Inferences
- Agent behaviour: use a probe-by-proposal to discover hidden rules ("here is a candidate; what does it break?") instead of asking a long requirements questionnaire. This is Lawson's architects' strategy turned into a question style.
- Lawson's "precedent" knowledge maps to an agent seeking analogous products or domains.

### Gaps
- Lawson's book text not accessed, so I cannot quote his definition of "guiding principles", "parti" or schemata, nor the protocol details about precedent. The Wikipedia page is a weak source for the experiment; the Lawson 1979 original was not read.

## 5. Experts vs novices vs engineers: what behaviours differ

### Takeaway
The most replicated difference: experts spend more time scoping the problem, gather more and wider information, consider more aspects, and move between stages in a cascade rather than diving to modelling. Novices commonly use trial and error. A counterpoint: the sheer amount of information used does not separate experts; evaluating and using it does.

### Cited Findings
- Atman et al. 2007 (JEE 96(4)): 19 experts each designed a playground; compared with 26 freshmen and 24 seniors. Experts spent more time overall and especially on problem scoping, and gathered significantly more information covering more categories — [search summary of the paper](https://discovery.fiu.edu/display/pub199304)
- Atman's own slide summary of the findings: experts gather more information (explicitly) and cover more categories; spend longer problem scoping before turning to modelling; consider more objects in the design process; exhibit a "cascade" pattern of transitions. Similar patterns found with other design problems, other populations (engineering faculty, domain experts), within-subject longitudinal comparisons and teams — [Atman keynote PDF (UW HCDE)](https://www.hcde.washington.edu/sites/hcde/files/files/Transdisciplinary%20Engineering%20Keynote%20-%20final.pdf)
- "Moving towards more experienced design behaviors": thorough problem scoping at the start before turning to modelling; gather information throughout the process; transition and iterate throughout; stay the course at certain times — [Atman keynote PDF](https://www.hcde.washington.edu/sites/hcde/files/files/Transdisciplinary%20Engineering%20Keynote%20-%20final.pdf)
- Shanteau (via Cardella's group): quantity of information used does not reflect expertise; evaluation and use of gathered information differentiates experts — [ASEE/search summary](https://peer.asee.org/breadth-in-design-problem-scoping-using-insights-from-experts-to-investigate-student-processes) (secondary)
- Earlier Atman et al. 1999 freshman vs senior: novices spent proportionally more time on problem scoping than other stages yet produced lower-quality designs (search summary; this is in some tension with the expert-scoping finding, so "more scoping" is not the point; scoping breadth and quality is) — [FIU record](https://discovery.fiu.edu/display/pub199304)
- Ahmed, Wallace & Blessing 2003 (Res. Eng. Design 14(1)): novices use trial and error; experienced designers use design strategies (abstract-level summary via a later paper) — [DOI](https://www.doi.org/10.1007/S00163-002-0023-Z)
- Chen, Chen & Yang 2022 protocol study: no significant difference in overall sequence or total time per phase; differences arose early and affected later behaviour; experts tended to stay in the design phase later, novices made more frequent transitions between phases, possibly compensating for incomplete earlier phases — [IJDesign](https://ijdesign.org/index.php/IJDesign/article/view/4194) (abstract only; contradicts the simple "experts transition more" reading of Atman's cascade)
- Akin (via Visser): architects use rich representations, creative strategies, non-standard problem composition schemata, and complexity management approaches — [Visser 2006](https://arxiv.org/pdf/cs/0612022)

### Inferences
- Honest reading: no single "experts transition more" or "spend more time" rule holds across studies. What recurs is early breadth (more categories, more objects considered), an iterative problem-solution loop, then deliberate depth. The agent should be shown front-loading breadth of aspects, not volume of questions.
- Engineers (scientists in Lawson's study) default to problem-focused rule discovery; an agent trained on software engineering habits will drift to requirements gathering and spec writing. The behaviours that must be made explicit are the solution-first probes.

### Gaps
- Ho 2001 not found or read. Ahmed 2003 full text not obtained, so specific strategies (e.g. what "design strategies" means) are not documented. No study located that directly compares UX designers with software engineers. Effect sizes for Atman not retrieved.

## 6. Norman: designer's job, conceptual models, gulfs, "solve the right problem"

### Takeaway
Norman gives the lens: check the person's goal vs what the system lets them do (gulf of execution) and whether they can tell what happened (gulf of evaluation), carried by a good conceptual model. His claims about root cause and the double diamond were not verified from sources here.

### Cited Findings
- Gulf of execution: "The difference between the intentions and the allowable actions is the gulf of execution." Gulf of evaluation is small when the system presents state information in an easy-to-get form — [Wikipedia: The Design of Everyday Things](https://en.wikipedia.org/wiki/The_Design_of_Everyday_Things)
- Good design gives users a good conceptual model; one of four principles from the seven stages of action — [Wikipedia](https://en.wikipedia.org/wiki/The_Design_of_Everyday_Things)
- Gulf of execution is bridged with signifiers, constraints, mappings and a conceptual model; gulf of evaluation with feedback and a conceptual model; the seven stages run from forming a goal to comparing the result with the goal (secondary summaries) — [Medium summary](https://medium.com/@gazdgabr/the-gulf-of-execution-and-evaluation-890fca716bb7)

### Inferences
- Moves derived: ask what goal the person had at that moment; list each step's execution gap and evaluation gap (what tells them it worked?); state the conceptual model the interface implies and whether it matches the user's.

### Gaps
- Root cause / five whys / "solve the right problem" / double diamond origin in Norman's chapter 6 were not found in any fetched source. From memory, unverified: Norman credits the British Design Council double diamond and advises repeatedly asking "why" to reach the root cause, and treats a client's stated problem as often a symptom. Verify before using.

## 7. Synthesis: 13 expert moves an agent can perform

Each move: source basis / what it looks like in output / examples for (a) household budgeting app, (b) small clinic booking SaaS, (c) high drop-off sign-up. "Basis" labels: C = cited above, I = my inference.

1. **Name the situation as a type T (frame), then offer a rival frame.** Basis: Schön naming/framing; Dorst; Vermaas-Dorst formal model (C, ICED15). Output: "The request treats this as X; I read it as Y. Under X we would build A; under Y B, C, D." Mark which frame the client wrote vs which the agent proposes.
   - (a) "Expense tracker" frame vs "household negotiation about shared money" frame (couple fights about who spent what); the second makes shared categories and a monthly "settle up" ritual central.
   - (b) "Booking calendar" frame vs "front-desk phone-load reduction" frame; the second prioritises cancellations and reminders over slot UI.
   - (c) "Form with too many fields" frame vs "the user is not yet convinced" frame; the second moves value proof before the form.

2. **Pick the analogy domain that already solves it (precedent / bridge).** Basis: Kings Cross festival analogy (C); Lawson precedent (I, book unread). Output: "This is a [domain] problem; how does that domain handle it? Three transferable moves: ..."
   - (a) Meal-planning / allowance-envelopes for kids; or a restaurant's daily cash-out.
   - (b) Restaurant waitlists and airline check-in (no-show handling, overbooking, reminders).
   - (c) Airport security queues / retail fitting rooms (reduce uncertainty about what comes next; "progress and what you get").

3. **Commit to a provisional one-line concept (primary generator) and say it is provisional.** Basis: Darke via arXiv 2508.07058 (C); tension with Akin vs Visser (C). Output: a headline "Concept: ..." plus "what would make me drop this".
   - (a) "A calm monthly closing, not daily bookkeeping."
   - (b) "The clinic's day is a conveyor of 15-minute slots; our job is to keep the belt full."
   - (c) "Let people taste the product before they sign up."

4. **Probe by proposal: put a concrete candidate on the table and ask what it breaks.** Basis: Lawson architects vs scientists (C secondary); Dorst-Cross partial solution (C). Output: a candidate flow or screen described in 5 lines, followed by "if this is wrong, where?" rather than a questionnaire.
   - (a) "Draft: one screen, three numbers (left to spend, left until payday, shared). Where does this misrepresent your household?"
   - (b) "Draft: patient picks a symptom group, not a doctor. Does your clinic assign by doctor or by room?"
   - (c) "Draft: email only on step 1, everything else after first success. What breaks for your sales team?"

5. **Read the back-talk: list what the concrete draft exposed (new problem, violated earlier decision, new possibility).** Basis: Schön threefold evaluation (C secondary). Output: a "What the draft told us" list of 3 items, each revising the frame or the requirements.
   - (a) Drafting the settle-up screen reveals "who owns a shared card" is undecided.
   - (b) Drafting the cancel path reveals a policy need (late-cancel fees, waitlist backfill).
   - (c) Drafting the first-run state reveals nothing to show before data is entered (empty state problem).

6. **Scope broadly before modelling: sweep categories of context, not volume of questions.** Basis: Atman 2007 (C): more categories, more objects, scoping before modelling. Output: a compact scoping map across categories (people, situation, constraints, money, law/regulation, technology, existing workaround, failure consequences) with 1-2 lines each and flagged unknowns.
   - (a) Who is "household"? Irregular income? Cash? Joint vs separate accounts? Kids?
   - (b) Who answers the phone? Insurance/identity checks? Interpreter needs? Emergency vs routine? Regulation (the repo's note 11 covers JP clinic law).
   - (c) Traffic source, mobile share, where in the funnel users drop, what is compared to competitors.

7. **Ask about the situation around the moment of use (when, where, with whom, interrupted by what, what came just before and after).** Basis: Kings Cross reframe came from seeing the people as bored and positioning themselves socially, not as criminals (C); Norman's goal-at-the-moment lens (I). Output: situational questions framed on a specific recent episode, not "who are the users".
   - (a) "Last time you opened the app, where were you standing and what had just happened?" (at a checkout, after a bill arrives, at 11pm after the kids sleep).
   - (b) "Where is the patient when they book: a bus, at work, with a sick child; what did they do just before?"
   - (c) "What was the person doing before the sign-up page: coming from an ad on a phone, on a train?"

8. **Test who is actually in the frame: challenge the label the client uses for the people.** Basis: Kings Cross "not criminals" (C). Output: "You call them X; the evidence suggests they are Y." Include what evidence would show it.
   - (a) "Users" who say they want "control" may want relief from guilt.
   - (b) "Patients" vs the "parent who books for a child" vs "caregiver".
   - (c) "Leads" who drop are visitors still evaluating, not abandoners.

9. **Find the contradiction or inverse in the situation (the thing that should not happen but does).** Basis: Kings Cross paradox of more security causing a grimmer atmosphere and trains ending when crowds arrive (C); Dorst's step list is unverified so this is I. Output: "Paradox: X is meant to help but causes Y."
   - (a) The more categories users set up, the less likely they are to log expenses.
   - (b) Reminders that reduce no-shows may increase phone calls to cancel, loading the same desk.
   - (c) Asking for more information up front to "personalise" lowers completion before any personalisation shows.

10. **Trace the goal-to-feedback path (Norman gulfs).** Basis: Norman as summarised (C secondary). Output: a table per key task: goal, action possible?, what tells them it worked (evaluation), what mental model the UI implies.
   - (a) Goal "can I buy this?": needs left-to-spend; the evaluation gap is whether pending transactions are counted.
   - (b) Goal "I need a visit this week": execution gap if only doctor-based; evaluation gap if no confirmation of arrival time.
   - (c) Goal "start using it": evaluation gap when the confirmation email is the only success signal.

11. **Design from first principles and as a system, not from component conventions.** Basis: Cross on Murray and Grange: "broad systems approach" and "design from first principles" (C secondary). Output: "Strip it to the essential job and the forces on it; here is the system map (actors, flows, data), then the screens."
   - (a) Essential job: decide how much to spend before the next income; screens follow, not the bank-style ledger.
   - (b) System: patient, front desk, doctor, calendar rules, reminders; slot rules define the screens.
   - (c) System: promise made by the ad, proof, effort, trust, first success.

12. **Hold two alternatives and evaluate with explicit criteria; keep the evaluation loop going.** Basis: Akin via Visser (keep searching after a satisfactory concept) vs fixation warning (C); Shanteau: evaluation distinguishes experts (C secondary); Schön criteria: coherence and continued inquiry (C secondary). Output: two concepts, 3-4 criteria derived from this situation (not generic usability), verdict and what would reverse it.
   - (a) Criteria: time to first useful number, shared fairness, effort at month end.
   - (b) Criteria: front desk minutes saved per day, error rate on slot rules, patient comprehension.
   - (c) Criteria: time-to-first-value, drop-off per step, risk of low-quality signups.

13. **Check the frame against the original goal and the stakeholder's acceptance before committing (frame failure check).** Basis: Vermaas/Dorst failure modes (C). Output: "Original goal G: ... Does the frame still reach G? Who would reject it, and why?" plus the one decision that must be taken to the client.
   - (a) Frame "negotiation" may not fit a single-person household; owner of the product (G was personal budgeting) may reject.
   - (b) Frame "phone-load reduction" may fail if clinic wants patients to feel a human touch.
   - (c) Frame "taste before signup" may fail if legal/compliance requires an account before data capture.

### Inferences
- These 13 are my synthesis. The research evidence supports (strongly) 1, 3, 4, 5, 6, 8, 13 (frame / co-evolution / probe / scoping / failure modes), moderately 2, 11, 12, 10, and weakly 7, 9 (they are my adaptation of case details and Norman's lens, not demonstrated expert behaviours in a protocol study).
- What actually separates "expert sounding" from "layperson sounding" output in these studies is: a stated frame; a concrete provisional concept; questions asked from a concrete episode rather than in the abstract; and a statement of what the draft taught. Generic "consider the user" lacks all four.
- Risk for the skill: moves 1-3 can produce confident but wrong frames; Vermaas/Dorst shows even a celebrated frame had a failure mode. Build move 13 into the skill as a mandatory gate, and make frames labeled as hypotheses for the user to accept or reject.

### Gaps
- No source directly tests whether an AI agent performing these moves improves outcomes. No protocol study of UX/product designers (as opposed to architects, industrial and engineering designers) was retrieved. The examples in (a)-(c) are mine and not drawn from sources.
