---
name: z-gemini-write
description: Turn content Claude has already organised (bullet points, an outline, a rough draft) into Japanese prose written by Gemini, then check that nothing drifted. Gemini writes through the Antigravity CLI on the signed-in Google account; OpenRouter, which bills per token, is used only after the user approves it for that call. Use at the step where organised Japanese content becomes prose - 「Gemini で書いて」「Gemini で文章にして」「箇条書きを Gemini で文章に」"write this up with Gemini". Not for polishing prose that is already written, not for short chat replies, not for English, not for code.
argument-hint: "[what to write up]"
allowed-tools: Bash(~/.claude/skills/z-gemini-write/scripts/*), Bash(uv run *), Read, Write, Edit
---

<!-- The division of labour (Gemini writes, Claude checks for meaning drift) follows
     https://note.com/genkaijokyo/n/n8562c2500420. Everything here is written from scratch. -->

# Write Japanese with Gemini

Gemini writes Japanese that reads more naturally than Claude's, but it will also smooth a
hedge into an assertion, drop a condition, or add an example nobody asked for. So the work
is split at one point. Claude settles what the text says, as bullet points or an outline;
Gemini turns that into prose; Claude checks the prose against the outline. Gemini is not
asked to research, decide structure, or polish text that is already prose.

`scripts/gemini-write.sh` makes the call, and the instructions it sends are in
`assets/prompt.md`. Everything in the outline leaves this machine for Google or
OpenRouter, so keep secrets, credentials, and text the user marked as confidential out of
it; ask first when unsure.

## Two routes, and who chooses the paid one

The Antigravity CLI (`agy`) runs on the Google account signed in to it, at no extra
charge. It is the only route the script takes by itself. Before each call it reads the
remaining quota with `/quota`, which spends none, and stops rather than calling when the
Gemini quota is used up. Each call carries more than ten thousand tokens of `agy`'s own
system prompt, so the free weekly quota goes faster than the length of the text suggests.

OpenRouter bills per token, and the script uses it only with `--paid`. Pass `--paid` only
after the user has said yes to it in this conversation for this call. A yes earlier in the
conversation does not carry over to the next call. The user keeps both a work and a
personal Google account on this machine, so when `agy` fails the right fix is often to
switch accounts rather than to pay; the question has to leave room for that answer.

The script also refuses an OpenRouter key that has no spending limit, so even a runaway
loop stops at the cap set on openrouter.ai.

## Procedure

### 1. Settle the content

Put every fact, number, condition, and conclusion into bullet points or an outline, in
the order the reader should meet them. Gemini is told not to add anything, so what is
missing here stays missing. Save it to a file in the scratchpad directory.

Write a brief next to it: who reads the text, what it is for, where it will live (README
section, Slack post, design document), and the tone if that matters. A few lines.

### 2. Call Gemini

```bash
~/.claude/skills/z-gemini-write/scripts/gemini-write.sh <outline> <brief> > <out>
```

It takes 10-30 seconds. The exit code says what happened:

| Exit | Meaning | What to do |
| --- | --- | --- |
| 0 | Done | Go to step 3 |
| 3 | `agy` quota used up; the message gives the reset time | Ask the user (below) |
| 4 | `agy` is signed out | Ask the user (below) |
| 5 | Any other `agy` failure | Show the message, ask the user (below) |
| 6 | OpenRouter has no key, or the key has no limit | Relay the fix from the message |
| 7 | OpenRouter failed: limit reached, rate limit, network | Relay the message; do not retry in a loop |

On 3, 4, or 5, ask one question with the reason in it, for example: "agy の Gemini 枠を使い
切っています(リセット 10/5)。OpenRouter で書きますか(1回1〜2円)?それとも agy の
アカウントを切り替えますか?". Switching accounts or signing in means running `agy` in a
terminal, which the user does. On yes, run the same command with `--paid` after the script
name. On any other answer, stop.

Setting up OpenRouter is also the user's to do in a terminal: create a key with a spending
limit on openrouter.ai, then run
`~/.claude/skills/z-gemini-write/scripts/gemini-write.sh --setup-openrouter` and paste the
key. It goes into the macOS Keychain under the service `openrouter`. `--status` shows the
state of both routes without spending anything.

### 3. Check for drift against the outline

Read the prose against the outline, item by item. This is the step that makes the split
safe, so do it fully:

- Every fact, number, proper noun, and condition in the outline is in the prose.
- The prose says nothing the outline did not: no new example, figure, or claim.
- Hedges and assertions kept their strength.
- Code, commands, paths, URLs, and identifiers are byte-identical.

When something drifted, add one line per problem to the brief
(「「〜の場合」の条件が落ちている。残す」) and run step 2 again. Each rerun spends quota,
and on the paid route money, so after two reruns that still drift, fix only the drifted
spot by hand and leave the rest of Gemini's wording alone. A paid rerun needs its own yes.

### 4. Lint

```bash
uv run ~/.claude/skills/z-natural-japanese/scripts/lint.py <out>
```

Judge each finding in context, as `z-natural-japanese` says. Fix small ones by hand. When
a finding needs a paragraph rewritten, put it in the brief and send it back to Gemini
instead, because rewriting by hand brings back the phrasing this skill exists to avoid;
the same rerun limits as step 3 apply.

### 5. Hand it over

Put the text where it belongs, and say in one line which route wrote it.
