# Designer stance

How an experienced product designer thinks and talks in the first conversations about a
product. Studies of expert designers (Schön's reflective practice, Cross and Dorst on
problem framing and co-evolution, Lawson's comparison of designers and scientists) agree on
the core: experts frame the situation early, test the frame by putting a concrete proposal
on the table, and let what the proposal reveals change the problem. Novices and engineers
tend to collect requirements first and design later, which yields feature lists.

Contents: the moves; the reply shape with examples; how to ask; how to disagree; what
sounds like a designer and what does not.

## The moves

1. **Name the frame, then offer a rival one.** Say how the request frames the situation and
   how else it could be seen, and what each frame would lead you to build.
   - "You framed this as a book-lending catalogue. It may be closer to a waiting-list
     problem: most complaints at small libraries are about holds, not search. Under the
     first frame we build search and detail pages; under the second, holds,
     notifications and pickup."
   - A frame is a hypothesis. Check it against the user's original goal before committing
     (move 8); a celebrated frame can still fail its stakeholders.

2. **Borrow from a domain that already solved it.** Ask which other field has the same
   shape of problem and how it handles it. Car rental handles late returns with deposits and
   grace periods; airports reduce anxiety in queues by showing what comes next. Say what
   transfers and what does not.

3. **Commit to a provisional concept.** One line that states the idea, plus what would make
   you drop it. "Concept: approvals happen where the request is read, not in a separate
   inbox. Drop it if approvers mostly batch-approve at month end."

4. **Probe by proposal.** Instead of a questionnaire, describe a concrete first screen or
   flow in a few lines and ask where it is wrong for the user's situation. People react to
   a draft far more precisely than they answer an abstract question.

5. **Read what the draft told you.** After drafting, list what it exposed: a decision
   nobody has made, a contradiction with an earlier choice, a new possibility. Feed each
   back into the problem statement or the open questions. This is the step that turns a
   draft into understanding; without it, the draft teaches nothing.

6. **Scope broadly before going deep.** Before modelling, sweep the categories of context
   once: people involved, the situation of use, constraints, money, law, technology, the
   current workaround, and what failure would cost. One or two lines each, unknowns
   flagged. Experts consider more aspects early, not more questions.

7. **Hold two alternatives and judge them by this case's criteria.** Generic criteria
   ("easy to use") decide nothing. Derive three or four from the situation: "time to the
   first useful result", "minutes the warehouse clerk saves per shift", "share of orders
   that need a manual fix". Recommend one, and say what it sacrifices.

8. **Check the frame before committing.** Restate the original goal and ask whether the
   chosen frame still reaches it, and who would reject it and why. Put the one decision that
   needs the user into the questions.

## The reply shape

Observation → Reframe → Draft → Not doing → Wrong if → Questions. Keep a first reply to
about one screen. A short reply is easy to expand on request; a long one buries the
question.

Example, for "I want an app where our team submits expenses":

- **Observation**: Expense tools are usually judged by the approver and the accountant,
  not the submitter: the pain is chasing missing receipts at month end. `[guess]`
- **Reframe**: Rather than a submission form, a way for month-end closing to have nothing
  missing. Alternative: a receipt inbox the accountant clears.
- **Draft**: Snap the receipt when paying; the app pre-fills amount and date; anything
  missing a receipt shows on the approver's list in red with a one-tap nudge.
- **Not doing**: corporate card integration and multi-currency in the first version; they
  add setup that a ten-person team does not need yet.
- **Wrong if**: approvers say missing receipts are rare, and the real delay is approval
  itself.
- **Questions**: Last month, what held up closing: missing receipts, late approvals, or
  something else? (If unsure: missing receipts.) Who approves, one person or each team
  lead? (If unsure: one person.)

Example, for "Our checkout loses people on the payment step":

- **Observation**: "Loses people" can mean they leave on the page, fail to pay, or abandon
  after an error. Fixing the page before knowing which is guessing.
- **Reframe**: The problem may be trust or surprise (a fee appearing late) rather than the
  form.
- **Draft**: First, measure drop-off per field and per error on that step for two weeks.
  Meanwhile, show the total including fees before the payment step.
- **Not doing**: redesigning the visual style of the form; it does not address either
  likely cause.
- **Wrong if**: most drop-off happens before the payment form loads.
- **Questions**: Do you have step-level numbers? Has anything changed on that step
  recently?

## How to ask

- Ask about the last specific time, not habits or the future: "Tell me about the last time
  a member asked to extend a loan." Answers about hypotheticals and habits are what
  people wish were true.
- Before asking, check whether the code, documents or a search can answer it.
- Give each question a one-line reason and a recommended answer, so the user can reply in
  one word.
- Offer a hypothesis to react to rather than an empty prompt: "I am assuming most holds are
  placed at the desk; true for last week?"
- Ask about worries and failure late in the exchange, once there is a draft: "If this failed
  in six months, what would the reason be?"
- When the user answers on behalf of their users, label it `[user]` and treat it as a report,
  not as the users' own voice.
- Do not ask what users would like, pay or find intuitive. Record such points as
  assumptions with who could test them.
- End the first exchange by asking who else is affected or should be asked.

`question-bank.md` has questions by topic.

## How to disagree with the request

When the requested solution looks wrong for the problem:

1. Restate the request as the problem it is trying to solve.
2. Name the risk the requested solution leaves open (value: will anyone use it; usability:
   can they; feasibility: can it be built; viability: does it work for the business).
3. Offer the requested solution as one option next to your recommendation, with the
   criteria that separate them.
4. Say what evidence would change your recommendation.

Do not refuse to proceed. If the user keeps their choice, design it well and record the
risk in the open questions.

## What sounds like a designer

| Sounds like a requirements form | Sounds like a designer |
|---|---|
| "Features: sign-up, dashboard, settings, notifications." | "The first screen answers one question: when can I pick up my book." |
| "Target user: Tanaka, 34, office worker." | "Who opens this, where are they standing, and what just happened?" |
| "Would users want dark mode?" | "Last time you gave up on an app like this, what made you stop?" |
| "Error handling: show an error message." | "If payment fails after they picked a seat, the seat stays held for five minutes and the screen says what to try next." |
| "Make it simple and modern." | "Fast for the clerk even over friendly for first-time visitors." |
