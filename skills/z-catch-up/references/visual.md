# Visual vocabulary

The page borrows the state language the reader already knows from their tracker, so
state is recognised without reading. For GitHub that means Octicons and Primer colours,
used exactly as github.com uses them. When the tracker changes, swap this file for that
tool's vocabulary; the procedure in `SKILL.md` stays.

## Devices, and where each comes from

| device | encodes | source |
| --- | --- | --- |
| Three-segment bar per stream: closed, waiting for review, mine; counts printed beside it | how far the stream is, and how much of the rest is the reader's | Jira timeline epic bar (done / in progress / to do); numbers printed because segments off the baseline are judged by length, not position (Cleveland & McGill; NN/g "3 of 50") |
| State icon at the start of every row: `issue-opened` green, `issue-closed` purple | open or closed, as GitHub shows it | Primer StateLabel; GitHub changelog 2021-06-08 |
| `git-pull-request` green with the PR number, `git-merge` purple with the merge date, `git-pull-request-draft` grey | there is a PR, and where it stands | GitHub issue list "linked pull requests" count; Jira development panel |
| Small ring plus "n / m" on a parent row | sub-issue progress | GitHub sub-issue progress ring; Linear parent-row count |
| `hourglass` in attention yellow with the word for what is waited on | off the reader's hands: review, someone's decision | GTD "Waiting For"; Asana "Waiting on"; Spectrum notice = pending; Octicon `hourglass` |
| One filled dot in accent blue, the word "next", and a tinted row | the single task the reader picks up | Things "Today" star; Graphite `◉` current branch; Few: highlight one thing |
| `blocked` glyph with "after X" in muted text | an order dependency that has not cleared | Linear blocked-by; Jira dependency lozenge; Tufte: keep rails muted |
| `stack` glyph with "k / n" | a PR stacked on another PR, base merged first | Graphite stack rail; GitHub stacked PRs (trunk at the bottom, merged bottom-up) |
| Closed rows at 55% opacity, one line, no description | done is visible for the fraction, but the eye lands on what is left | Jira greys merged commits |
| Type pill (Epic, Task) outlined in the type's colour; status pill in the project's own spelling | the organisation's vocabulary, unchanged | GitHub issue types; Projects v2 single-select |

Every state carries at least three of: shape, colour, word (Carbon status-indicator rule;
WCAG 1.4.1 colour never alone). The page never uses a percentage by itself.

## Colours (Primer functional tokens, light / dark)

| role | light | dark | used for |
| --- | --- | --- | --- |
| open (success) | `#1a7f37` | `#3fb950` | open issue, open PR |
| done | `#8250df` | `#ab7df8` | closed issue, merged PR, "closed" bar segment |
| attention | `#9a6700` | `#d29922` | waiting on someone, "waiting" bar segment |
| accent | `#0969da` | `#4493f8` | the next task, "mine" bar segment |
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
