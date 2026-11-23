---
name: review-ux
description: >-
  Reviews a built prototype or app screen by screen against Nielsen's 10 usability
  heuristics and, for every problem, names the heuristic and the exact element that causes
  it, with a screenshot that outlines that element. Use once screens exist and someone asks
  whether they are usable: "review the prototype", "heuristic evaluation", "UX review of
  what we built", 「作った画面を見て」「使いにくいところを洗い出して」「ヒューリスティック評価」.
  Not for designing screens that do not exist yet (design-ux), nor for spacing, alignment or
  AI-looking styling (gridlines, unslop).
allowed-tools: Read, Glob, Grep, Write, Edit, WebSearch, WebFetch, Agent, Bash(agent-browser *), Bash(mkdir *)
---

<!-- Hand-written for dotclaude (LAB-1772, 2026-11). Sources are listed in
     references/heuristics.md and ADOPTIONS.md; no text is copied. -->

# Review a built prototype against the heuristics

Act as a usability evaluator handed a working build. The output is a review file whose
every finding a builder can act on without asking: which heuristic, which element, what
the person experiences, how bad, and what to change.

A finding has exactly one heuristic and one element. "The list is confusing" is not a
finding; "H6, the ✓ button on each card (`Done(アーカイブへ移す)`): the icon alone does
not say the item leaves the list" is.

## Inputs

Settle these before opening the build. Ask only for what you cannot find.

1. **The build**: a URL the browser can reach, or the app to launch. When the browser
   runs on another machine than the server (on the mac-mini, `agent-browser` runs on the
   M1), a `127.0.0.1` address is out of reach; use the LAN or tailnet address.
2. **The intent**: the design package if one exists (`docs/ux/<slug>/UX.md` or `BRIEF.md`
   from design-ux): its jobs, screen IDs, states and experience principles. Without one,
   write down in two lines who uses it and for which main jobs, labelled `[guess]`.
3. **The device**: the one the people use most. Set the browser to it
   (`agent-browser --session <s> set viewport 393 852` for a phone; `--device` alone may
   leave the desktop width) before the first screenshot.

## Steps

1. **Walk the main jobs as the user.** For each job in the intent, go through the screens
   in the order a person would, using `snapshot -i` to see what is on screen and
   `screenshot` to see it as they do. Visit the states you can reach without changing real
   data: empty search, no results, a long item, a narrow screen, and a failed load
   (`set offline on`, then move to another view; `set offline off` afterwards). Watch what
   the screen says while something is still loading, not only once it settles. Do only
   what can be undone, and only in a `--session` of your own; when the build holds real
   data, leave its destructive and sending actions untouched and review them from what
   the screen and the code say. Done when every job has been walked and every screen it
   touches is listed.

2. **Check each screen against all ten heuristics.** Read `references/heuristics.md` first:
   it gives, per heuristic, what to look for and where the sources go deeper. For every
   screen, go through H1 to H10 in order and write each problem as a candidate finding.
   Done when every cell of the screen-by-heuristic table (step 5) holds a finding or "-"
   for no problem seen.

3. **Pin each finding to its element.** Outline it with `highlight <selector>` (a ref from
   `snapshot -i`, or a CSS selector) and take
   `screenshot <review-dir>/<NN>-<screen>-H<n>.png`, where `NN` matches the finding's
   number in the written review (rename after sorting). Outlines pile up until the page
   reloads, so `reload` (and reach the state again) before each new highlight; one
   screenshot carries one outline. An element with no ref or clean selector, such as a
   message box, can be tagged first with `eval` (set an `id` on it) and highlighted by
   that id. When the problem is something missing (no undo, no status), outline the
   element where it should have appeared and say so. Name the element by its visible
   label or accessible name plus a CSS selector, and the source file when you can find
   it, so the builder can find it in code. Done when every finding has a screenshot whose
   outline is on the element named.

4. **Rate and ground each finding.** Give the severity from NN/g's 0 to 4 scale in
   `references/heuristics.md`; a 0 is dropped. Then name what the finding rests on:
   the heuristic, plus at most one source from `references/heuristics.md` (a Law of UX, a
   GOV.UK pattern or component, an Inclusive Components article, an Apple HIG pattern) that
   says why this element fails, or the design package's own principle it breaks. Drop any
   candidate you cannot reproduce a second time.

5. **Write the review.** Save it as `docs/ux/<slug>/REVIEW-<YYYY-MM-DD>.md` with the
   screenshots in `docs/ux/<slug>/review-<YYYY-MM-DD>/`, in the target repository and in
   the language that repository writes in. Put first: the build and version reviewed, the
   device, the jobs walked, and what was not reviewed (states you could not reach, actions
   left untouched). Then the findings, most severe first, each as:

   ```markdown
   ### 1. <one-line problem as the person meets it> (severity 3)

   - Heuristic: H6 Recognition rather than recall
   - Screen: SC-01 list (or the URL)
   - Element: `Done(アーカイブへ移す)` button on each card, `button[aria-label^="Done"]`
   - What happens: <what the person sees or does, and what goes wrong>
   - Rests on: <source or package principle, with URL>
   - Change: <the behaviour to change; leave the visual treatment to the builder>
   - ![](review-<date>/01-list-H6.png)
   ```

   End with the screen-by-heuristic table: one row per screen, one column per heuristic,
   each cell the numbers of its findings or "-". Under it, one line for each heuristic
   that found nothing anywhere, saying what was checked.

6. **Have it checked.** Give a subagent that did not do the review the file and the
   screenshots, and ask it to answer for each finding: is the outline on the element
   named, does the heuristic fit (or does another fit better), and is the change
   something a builder can act on. Fix every no, then close the browser session.

## Next step

End with one line to the user naming the file and the next step, for example: "Next, fix
the severity 3 and 4 findings in `docs/ux/<slug>/REVIEW-<date>.md`, then run review-ux
again on those screens." If a finding shows the design itself is wrong (a missing screen,
a flow that does not fit the job), say so and suggest taking it back to design-ux.
