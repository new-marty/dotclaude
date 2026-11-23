# The ten heuristics, what to look for, and where to ground a finding

The heuristics are Jakob Nielsen's, as NN/g states them
(https://www.nngroup.com/articles/ten-usability-heuristics/). Under each: the questions to
put to every screen, then sources that explain why an element fails. Cite one source per
finding, and only one that bears on that element; a finding with no fitting source rests on
the heuristic alone.

Contents: H1 to H10; severity; sources.

## H1 Visibility of system status

- After each tap or submit, does something on screen change at once, and is it near where
  the person was looking?
- While something loads or saves, what stays on screen and what says it is still working?
- Can the person tell where they are (which tab, filter or step is on) and how much there
  is (counts, how far through)?
- Is data that may be stale marked with when it was last updated?

Sources: Doherty Threshold (https://lawsofux.com/doherty-threshold/); Apple HIG Feedback
and Loading (https://developer.apple.com/design/human-interface-guidelines/feedback,
https://developer.apple.com/design/human-interface-guidelines/loading); GOV.UK
Notification banner (https://design-system.service.gov.uk/components/notification-banner/);
Inclusive Components, Notifications (https://inclusive-components.design/notifications/):
status changes must reach screen readers too.

## H2 Match between the system and the real world

- Are labels in the person's words, or in internal names (database fields, team jargon,
  English left in a Japanese screen)?
- Do icons mean what people in this domain expect?
- Do order and grouping follow how the person thinks about the task?

Sources: Mental Model (https://lawsofux.com/mental-model/), Jakob's Law
(https://lawsofux.com/jakobs-law/); GOV.UK Service Manual, Writing for user interfaces
(https://www.gov.uk/service-manual/design/writing-for-user-interfaces).

## H3 User control and freedom

- Can every action that changes something be undone, or at least reversed from a place the
  person can find?
- Is there a clear way back and a way out of every step, dialog and filter?
- Does the back button or swipe do what the person expects?

Sources: Apple HIG Undo and redo, Modality
(https://developer.apple.com/design/human-interface-guidelines/undo-and-redo,
https://developer.apple.com/design/human-interface-guidelines/modality); GOV.UK Back link
(https://design-system.service.gov.uk/components/back-link/).

## H4 Consistency and standards

- Does the same action look and behave the same on every screen, and does the same word
  always mean the same thing?
- Do controls behave like the platform's own (a toggle toggles, a link navigates, a button
  acts)?
- Do two things that differ look different enough?

Sources: Jakob's Law (https://lawsofux.com/jakobs-law/), Law of Similarity
(https://lawsofux.com/law-of-similarity/); Inclusive Components, Toggle Buttons, Menus &
Menu Buttons, Tabbed Interfaces (https://inclusive-components.design/toggle-button/,
https://inclusive-components.design/menus-menu-buttons/,
https://inclusive-components.design/tabbed-interfaces/): the right element for the job.

## H5 Error prevention

- Can a person trigger a costly action by accident (a small target next to a common one,
  a swipe, a double tap)?
- Do inputs accept the forms people actually type, and constrain only what must be
  constrained?
- Before something that cannot be undone, does the person see what will happen?

Sources: Fitts's Law (https://lawsofux.com/fittss-law/), Postel's Law
(https://lawsofux.com/postels-law/); Apple HIG Accessibility, for the 44×44 pt minimum hit
target (https://developer.apple.com/design/human-interface-guidelines/accessibility);
Apple HIG Entering data
(https://developer.apple.com/design/human-interface-guidelines/entering-data); GOV.UK
Check answers (https://design-system.service.gov.uk/patterns/check-answers/).

## H6 Recognition rather than recall

- Does the person have to remember something the screen could show (an earlier choice, a
  code, what an icon-only button does)?
- Are options visible, or hidden behind gestures and long presses with no hint?
- Are icon-only controls labelled, on screen or at least as a tooltip and accessible name?

Sources: Working Memory (https://lawsofux.com/working-memory/); Inclusive Components, Tooltips & Toggletips
(https://inclusive-components.design/tooltips-toggletips/).

## H7 Flexibility and efficiency of use

- Is the most frequent task the shortest path?
- Can a returning person skip what a newcomer needs (shortcuts, remembered filters,
  search)?
- Does a long list offer a way to narrow it before scrolling?

Sources: Hick's Law (https://lawsofux.com/hicks-law/), Pareto Principle
(https://lawsofux.com/pareto-principle/); Apple HIG Searching
(https://developer.apple.com/design/human-interface-guidelines/searching).

## H8 Aesthetic and minimalist design

- Does each element on screen serve the job on this screen? Which could go, or move
  to a later step?
- Is the primary action the most prominent thing, or does it compete?
- Is related content grouped and unrelated content separated?

Sources: Choice Overload (https://lawsofux.com/choice-overload/), Cognitive Load
(https://lawsofux.com/cognitive-load/), Law of Proximity
(https://lawsofux.com/law-of-proximity/), Law of Common Region
(https://lawsofux.com/law-of-common-region/), Von Restorff Effect
(https://lawsofux.com/von-restorff-effect/).

## H9 Help users recognise, diagnose and recover from errors

- Does each error say, in plain words, what went wrong and what to do, next to where it
  happened?
- Is what the person entered kept after an error?
- Do failed loads offer a retry instead of a blank area?

Sources: GOV.UK Error message, Error summary, Recover from validation errors
(https://design-system.service.gov.uk/components/error-message/,
https://design-system.service.gov.uk/components/error-summary/,
https://design-system.service.gov.uk/patterns/validation/); GOV.UK There is a problem with
the service pages (https://design-system.service.gov.uk/patterns/problem-with-the-service-pages/).

## H10 Help and documentation

- Where a screen needs explaining, is the explanation on the screen at the moment it is
  needed, not in a separate manual?
- Does the first run show what to do with an empty screen?

Sources: Paradox of the Active User (https://lawsofux.com/paradox-of-the-active-user/):
people start using a product without reading its manual; Apple HIG Offering help, Onboarding
(https://developer.apple.com/design/human-interface-guidelines/offering-help,
https://developer.apple.com/design/human-interface-guidelines/onboarding); GOV.UK Details,
Inset text (https://design-system.service.gov.uk/components/details/,
https://design-system.service.gov.uk/components/inset-text/).

## Severity

From NN/g (https://www.nngroup.com/articles/how-to-rate-the-severity-of-usability-problems/):
rate by how often it happens, how hard it is to get past, and whether people meet it again
and again. 0 not a usability problem (drop the candidate), 1 cosmetic (fix only if time
allows), 2 minor (low priority), 3 major (high priority), 4 catastrophe (imperative to fix
before release).

## Sources

- NN/g, 10 Usability Heuristics for User Interface Design (last reviewed 2024-01-30), and
  How to Rate the Severity of Usability Problems.
- Jon Yablonski, Laws of UX (https://lawsofux.com/).
- GOV.UK Design System (https://design-system.service.gov.uk/) and Service Manual.
- Heydon Pickering, Inclusive Components (https://inclusive-components.design/).
- Apple Human Interface Guidelines, Patterns
  (https://developer.apple.com/design/human-interface-guidelines/patterns).
