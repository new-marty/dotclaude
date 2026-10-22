# Lenses

Ways of looking that experienced designers apply without being asked, written as the
question each one makes you ask. Engineers and requesters tend to miss these because they
see the system from the inside. Pick the lenses that bear on the case; going through all of
them mechanically produces noise. A lens that changes a decision earns a line in the
package; one that changes nothing is dropped.

Contents: framing; structure; screens and states; experience principles; sources.

## Framing (S0–S1)

1. **Goal, not task.** What is the person trying to get done in their life, and which steps
   here are only means to it? ("Get reimbursed before rent is due", not "submit form".)
2. **Their model, not ours.** Is this shaped like our database or process, or like how the
   person thinks about it? Watch for internal words (resources, entities, slots) leaking
   into the request.
3. **Moment of use.** Where are they, what is in their hands, who is around, what
   interrupts them, how much time do they have? Ask it as a specific recent episode.
4. **What comes right before and after.** What made them open this, and where do they go
   next? The trigger often decides the entry screen.
5. **Posture.** Will people live in this for hours (dense, learnable, keyboard-friendly), drop
   in for one quick job (fast, no setup), let it run in the background, or keep a small
   helper always visible? One product often has more than one posture.
6. **Time.** What is it like on day 1, day 30, after a three-month gap, at a life change,
   and when leaving? Most designs cover only the busy middle.
7. **Beyond the screen.** Which emails, messages, phone calls, paper, counters and staff
   actions are part of the experience? The screen is often the smaller half.
8. **Front stage and back stage.** Which hidden steps (manual checks, approvals, data
   entry) decide whether the promise on screen is kept?
9. **Everyone involved.** Who uses it, who decides, who pays, who is affected but never
   asked (staff, family, caregivers, support)? Who acts on someone else's behalf?
10. **Who gets left out.** Who is excluded permanently, temporarily or by the situation (no
    sight, an injured arm, a baby on one arm; low literacy; a second language; an old
    phone)? Solving for the most constrained often helps everyone.
11. **Emotional temperature.** At this moment, is the person anxious, ashamed, rushed or
    grieving? Money, health and failure are never neutral data.
12. **Why it is not happening.** If people do not do the thing, is motivation, ability or the
    prompt missing? Lowering effort usually works better than adding persuasion.
13. **Doing nothing.** What do people do today without this (spreadsheet, paper, a
    colleague), and what would be lost if nothing were built? The workaround is the real
    competitor.
14. **Which risk dominates.** Will anyone use it (value), can they (usability), can it be
    built (feasibility), does it work for the business (viability)? Design work goes first
    where the risk is largest.
15. **Trade-off.** What are we willing to be worse at, to be better at this?

## Structure (S2)

16. **Conceptual model.** What simple story lets someone predict what this does, and does
    every screen tell the same story? Pick one model and keep it.
17. **Frequency, criticality, variation.** How often does each task happen, how costly is a
    mistake, how much do users differ in doing it? Frequent tasks get prominence; rare but
    critical ones get protection.
18. **Probable and possible.** What do most people do most of the time? Make that direct,
    and keep rare cases possible without giving them equal weight.
19. **Permissions as experience.** What does someone see when they may not do something, and
    who can grant it?
20. **Lifecycle of accounts and data.** How do people join, change role, leave, export, pause
    or delete? Who is the last admin, and what if they leave?
21. **Information scent.** Before choosing, can people guess what they will get, in their
    words? Labels drawn from internal naming lose people.
22. **Interruption.** If they are pulled away mid-task, what do they find when they come back?

## Screens and states (S3)

23. **What state am I in?** At every moment, can the person tell what the system is doing and
    whether their action worked?
24. **What can I do next?** Is the next step visible, or does it exist only for those who know
    where to look?
25. **Slip or mistake.** Is an error a wrong action despite the right intent (fix the
    interface) or a wrong plan (fix the explanation)? They need different designs.
26. **Undo before confirm.** Can this be undone? If yes, offer undo instead of asking "are you
    sure?", which people learn to dismiss. If not, make the pause meaningful.
27. **Recognition over recall.** Does the person have to remember something the screen could
    show (a code, a rule, an earlier answer)?
28. **Now or later.** What is needed now, what can wait, and can people see that more
    exists?
29. **Real content.** What are the longest name, the empty case, the thousand-row case, the
    foreign script, the zero amount? Designs built on tidy sample data break on these.
30. **First run.** What is the smallest real success, and how fast can people reach it? What
    does the empty screen teach?
31. **Waiting.** When something takes time, what stays on screen and what tells people it is
    still working?
32. **Peaks and the end.** What are the best and worst moments, and the last one? People
    remember those.
33. **Three looks at your own design.** First impression (is it clear what this is), first
    use (can they finish the main task), weeks later (is it still worth opening)?

## Experience principles (S4)

34. **Trust at the moment of giving.** When people hand over data, money or health details,
    what tells them why it is asked and who sees it?
35. **Whose interest does each default serve?** Would the user endorse each preselected
    option, nudge and exit path if they saw it? Hard-to-cancel flows, preselected add-ons
    and shaming copy are deceptive patterns.
36. **Words as design.** What does the person read before, during and after each action?
    Write the real labels and messages now, not after layout.
37. **Motion has a job.** Each animation should have a purpose; frequent actions get little or
    none. Note the purpose here; the implementer chooses the motion.

## Sources

The questions above are written for this skill. They draw on: NN/g articles on task
analysis, service blueprints, the gulfs of execution and evaluation, information scent and
the peak-end rule; Don Norman, *The Design of Everyday Things*; Alan Cooper, *About Face*
(application posture); Microsoft Inclusive Design; W3C, *Making Content Usable for People
with Cognitive and Learning Disabilities*; BJ Fogg's behavior model; Marty Cagan's four
product risks; deceptive.design; Samuel Hulick on onboarding; Julie Zhuo on product
critique; Emil Kowalski on animation.
