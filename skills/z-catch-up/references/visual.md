# Visual vocabulary

The page borrows the state language the reader already knows from their tracker, so
state is recognised without reading. For GitHub that means Octicons and Primer colours,
used exactly as github.com uses them. When the tracker changes, swap this file for that
tool's vocabulary; the procedure in `SKILL.md` stays.

## Devices, and where each comes from

| device | encodes | source |
| --- | --- | --- |
| Three-segment bar per stream: closed, waiting for review, mine; counts printed beside it | how far the stream is, and how much of the rest is the reader's | Jira timeline epic bar (done / in progress / to do); numbers printed because segments off the baseline are judged by length, not position (Cleveland & McGill; NN/g "3 of 50") |
| State circle at the start of every row: empty grey (Todo), half-filled amber (In Review), filled green with check (Done), ringed blue dot (next) | where the piece stands from the reader's side; GitHub's open/closed pair is deliberately not used because "open" hides the Todo / In Review split | Linear's filling status circle; Carbon three-of-four rule |
| `git-pull-request` green with the PR number, `git-merge` purple with the merge date, `git-pull-request-draft` grey | there is a PR, and where it stands | GitHub issue list "linked pull requests" count; Jira development panel |
| "n / m" after a parent row's number, and its open sub-pieces as inline chips | sub-issue progress and what exactly is still open | GitHub sub-issue count; Linear parent-row count |
| The In Review group itself, amber, with a word for what is waited on when it is not a review (a decision) | off the reader's hands | GTD "Waiting For"; Asana "Waiting on"; Spectrum notice = pending |
| One filled dot in accent blue, the word "next", and a tinted row | the single task the reader picks up | Things "Today" star; Graphite `◉` current branch; Few: highlight one thing |
| `blocked` glyph with "after X" in muted text | an order dependency that has not cleared | Linear blocked-by; Jira dependency lozenge; Tufte: keep rails muted |
| `stack` glyph with "k / n" | a PR stacked on another PR, base merged first | Graphite stack rail; GitHub stacked PRs (trunk at the bottom, merged bottom-up) |
| Rows grouped Todo, In Review, Done in that order; Done rows dimmed to one line | the reader's own work comes first, done is visible for the fraction | Jira status categories (To Do / In Progress / Done); Jira greys merged commits |
| Type pill (Epic, Task) outlined in the type's colour; status pill in the project's own spelling | the organisation's vocabulary, unchanged | GitHub issue types; Projects v2 single-select |

Every state carries at least three of: shape, colour, word (Carbon status-indicator rule;
WCAG 1.4.1 colour never alone). The page never uses a percentage by itself.

## Colours (Primer functional tokens, light / dark)

| role | light | dark | used for |
| --- | --- | --- | --- |
| success | `#1a7f37` | `#3fb950` | Done circle and bar segment; open PR glyph |
| done (purple) | `#8250df` | `#ab7df8` | merged PR glyph only |
| attention | `#9a6700` | `#d29922` | In Review circle, group heading, bar segment |
| accent | `#0969da` | `#4493f8` | next dot and tint, Todo group heading, Todo bar segment |
| danger | `#d1242f` | `#f85149` | changes requested (the review came back) |
| muted | `#59636e` | `#9198a1` | draft PR, blocked, not started |

Sources: `@primer/primitives` 11.10.0 functional themes; Primer colour-usage guidance
(https://primer.style/product/getting-started/foundations/color-usage/). Note that in
Primer "closed" means red (a closed PR), not grey; a closed issue is "done" purple.

## Icons

Octicons, MIT (https://github.com/primer/octicons). Inline them once as `<symbol>`
elements and reference with `<use href="#id">`; 16px viewBox, `fill: currentColor`. The
path data for the icons this page uses is in `assets/octicons.svg`.

## When the tracker is not GitHub

Replace the row icons with that tool's own state glyphs (Linear's filling circle, Jira's
status lozenge) and keep everything else: the segmented bar, the hourglass, the single
next marker, the blocked glyph, the greyed closed rows.
