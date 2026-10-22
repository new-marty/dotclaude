# Hand-off

What the package gives the person or skill that builds the UI, and the review before it
goes out.

## The brief

Put the brief first: at the top of `UX.md` for small work, in `BRIEF.md` otherwise. It is
what the user pastes into `frontend-design` or hands to an engineer, so it stands on its
own in about one page:

- **Status**: confirmed with the user, or "unconfirmed"; researched, or "not researched";
  checked by the script, or "checked by hand".
- **What this is**: the product in one sentence, who it is for, and the main job.
- **First release**: the screens and flows to build first, then the rest.
- **Riskiest assumption**: what it is, and how the design behaves if it is wrong.
- **Skeletons**: the ASCII wireframes of the key screens from S3.
- **Screens**: every screen, in the brief itself, with its ID, purpose, primary action and
  content in priority order, in a list the builder can work through. Do not point to another
  file for these; the brief is often pasted on its own.
- **States**: a pointer to the states table, plus any state the builder could easily get
  wrong.
- **Experience principles**: tone, "A even over B" principles, experiences to avoid,
  interaction patterns.
- **Fixed and free**: what the builder must not change (copy that carries legal meaning,
  the order of steps, brand assets the user supplied) and what is theirs to decide (all
  visual design: colour, type, spacing, layout styling, imagery, motion details).
- **Open questions**: decisions the builder must not make alone, each with who decides.

Write the brief as instructions ("Show the remaining amount first"), because
implementation skills follow the brief's wording closely.

## Next step

End with one line to the user naming the next step and the file, for example:
"Next, give `docs/ux/<slug>/UX.md` to frontend-design." The user starts that step. If they
want to compare visual options, suggest `/z-prototype`, which only the user can start.

## Review before hand-off

After `scripts/check_package.py` passes, have the package read by a reviewer that did not
make it, a subagent where one is available, with this checklist. Each item is yes or no;
fix every no or record why it stays.

1. The problem statement names no screen or feature.
2. Every claim carries a label, and no persona, quote or number is invented.
3. The first reply offered a rival frame, and S1 records why it was or was not chosen.
4. Every main job has a flow, and every flow step has failure branches.
5. Two alternatives were compared on criteria specific to this case.
6. Each "n/a" in the states table is believable for this product.
7. Off-screen parts of the experience (messages, staff actions, paper) appear in the flows.
8. The people most likely to be left out are named, with what the design does for them.
9. Nothing in the package chooses a colour, typeface, size or layout styling (skeletons
   showing only grouping and order are fine).
10. The brief can be followed without reading the rest of the package, and its screen list
    has every ID in `ux:screens`.
11. The open questions are things only the user can decide.
12. Read as a first-time visitor, a first-time user and someone returning weeks later, the
    package gives each a clear first screen and next step.
13. The riskiest assumption has a design answer.
14. The first release is cut from the rest.

Fix every failed item and have the reviewer check again. Where no subagent is available,
go through the list yourself, opening only the package and this checklist and reading from
the top as a stranger would, and say in the status line that the review was a self-review.
