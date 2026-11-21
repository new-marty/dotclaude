#!/usr/bin/env python3
"""Stop hook: a Japanese prompt gets a Japanese reply.

When the user's last prompt is Japanese and the turn's final reply is mostly English,
block the stop once and ask Claude to rewrite the reply in Japanese. An English prompt
may get a reply in either language, so it is never checked. The rule text in CLAUDE.md
alone let about 7% of replies to Japanese prompts come back in English (2026-11, LAB-1514).

Skipped: headless runs (CLAUDE_CODE_ENTRYPOINT sdk-*), a stop that a hook already
blocked (stop_hook_active), replies that are JSON or an API error, and short replies.
The block goes out as JSON on stdout with exit 0, so a `|| :` wrapper does not swallow it.

agy runs the same check through the dotclaude agy plugin (agy-plugin/hooks.json), which
calls this script with --agy. agy's Stop input carries the prompt as lastUserInput but not
the reply, so the reply is the last PLANNER_RESPONSE of the turn in its transcript.
Skipped there: a stop a hook already continued (continuationActive, or executionNum above
0), a turn that ended for any reason but NO_TOOL_CALL, a turn whose last response is
empty, and `agy -p` runs. agy wants a JSON answer every time, so a pass, or input it
cannot read, prints {"decision":""}.

Usage: as a Stop hook, reads the hook input on stdin.
       ja-reply-gate.py --agy            the same, as an agy Stop hook.
       ja-reply-gate.py --scan DIR...   replays transcripts and prints the replies it would block.
"""
import json
import os
import re
import subprocess
import sys

JA = re.compile(r"[぀-ヿ㐀-鿿ｦ-ﾟ]")
KANA = re.compile(r"[぀-ヿ]")
NOT_PROSE = re.compile(
    r"```.*?```|`[^`\n]*`|https?://\S+|<pasted_content[^>]*>.*?</pasted_content>", re.S
)
REASON = (
    "直前の利用者の発言は日本語なのに、最後の返事が英語になっている。"
    "同じ内容を日本語で書き直して、もう一度返す。"
    "コード、コマンド、パス、固有名詞は元のままでよい。ツールは使わない。"
)


def ja_share(text):
    letters = [c for c in NOT_PROSE.sub(" ", text) if c.isalpha()]
    if not letters:
        return 0.0, 0
    return sum(1 for c in letters if JA.match(c)) / len(letters), len(letters)


def is_japanese_prompt(text):
    share, _ = ja_share(text)
    return bool(KANA.search(text)) and share >= 0.3


def is_english_reply(text):
    head = text.lstrip()
    if head[:1] in ("{", "[") or head.startswith(("API Error", "You've hit your")):
        return False
    share, letters = ja_share(text)
    return letters >= 40 and share < 0.1


def prompt_text(entry):
    """The text of a prompt the user typed, or None for tool results and injected messages."""
    if entry.get("type") != "user" or entry.get("isMeta"):
        return None
    content = (entry.get("message") or {}).get("content")
    if isinstance(content, list):
        if any(isinstance(b, dict) and b.get("type") == "tool_result" for b in content):
            return None
        content = "\n".join(
            b.get("text", "") for b in content if isinstance(b, dict) and b.get("type") == "text"
        )
    if not isinstance(content, str) or not content.strip():
        return None
    if content.lstrip().startswith(("<", "Stop hook feedback")):
        return None
    return content


def last_prompt(transcript_path, tail=4 << 20):
    """The newest typed prompt, read from the transcript's last 4 MB, then the whole file."""
    try:
        with open(transcript_path, "rb") as f:
            size = f.seek(0, os.SEEK_END)
            f.seek(max(0, size - tail))
            lines = f.read().decode("utf-8", "ignore").splitlines()
    except OSError:
        return None
    for line in reversed(lines):
        try:
            text = prompt_text(json.loads(line))
        except (ValueError, AttributeError):
            continue
        if text is not None:
            return text
    if size > tail:
        return last_prompt(transcript_path, size)
    return None


def hook():
    try:
        inp = json.load(sys.stdin)
    except ValueError:
        return
    if inp.get("stop_hook_active"):
        return
    if os.environ.get("CLAUDE_CODE_ENTRYPOINT", "").startswith("sdk"):
        return
    reply = inp.get("last_assistant_message") or ""
    if not is_english_reply(reply):
        return
    prompt = last_prompt(inp.get("transcript_path") or "")
    if prompt and is_japanese_prompt(prompt):
        print(json.dumps({"decision": "block", "reason": REASON}, ensure_ascii=False))


def agy_reply(transcript_path, tail=4 << 20):
    """The text of the current turn's last PLANNER_RESPONSE with content, or ""."""
    try:
        with open(transcript_path, "rb") as f:
            size = f.seek(0, os.SEEK_END)
            f.seek(max(0, size - tail))
            lines = f.read().decode("utf-8", "ignore").splitlines()
    except OSError:
        return ""
    for line in reversed(lines):
        try:
            step = json.loads(line)
        except ValueError:
            continue
        if not isinstance(step, dict):
            continue
        if step.get("type") == "USER_INPUT":
            return ""
        content = step.get("content")
        if step.get("type") == "PLANNER_RESPONSE" and isinstance(content, str) and content:
            return content
    return ""


def agy_print_mode():
    """True when an ancestor agy process was started with -p/--print/--prompt."""
    pid = os.getppid()
    for _ in range(5):
        try:
            out = subprocess.run(["ps", "-o", "ppid=,args=", "-p", str(pid)],
                                 capture_output=True, text=True, timeout=2).stdout.split()
        except (OSError, subprocess.SubprocessError):
            return False
        if len(out) < 2:
            return False
        ppid, args = out[0], out[1:]
        if os.path.basename(args[0]) == "agy":
            return any(a in ("-p", "--print", "--prompt")
                       or a.startswith(("-p=", "--print=", "--prompt=")) for a in args[1:])
        pid = ppid
    return False


def agy_blocks(inp):
    # agy 1.5.14 reports continuationActive false on the stop after a continue;
    # executionNum is 1 there.
    prompt = inp.get("lastUserInput")
    return (not inp.get("continuationActive") and not inp.get("executionNum")
            and inp.get("terminationReason") == "NO_TOOL_CALL"
            and isinstance(prompt, str) and is_japanese_prompt(prompt)
            and is_english_reply(agy_reply(str(inp.get("transcriptPath") or "")))
            and not agy_print_mode())


def agy_hook():
    try:
        inp = json.load(sys.stdin)
        block = isinstance(inp, dict) and agy_blocks(inp)
    except Exception:
        block = False
    if block:
        print(json.dumps({"decision": "continue", "reason": REASON}, ensure_ascii=False))
    else:
        print(json.dumps({"decision": ""}))


def scan(dirs):
    checked = blocked = 0
    for d in dirs:
        for name in sorted(os.listdir(d)):
            if not name.endswith(".jsonl"):
                continue
            prompt = reply = None
            entrypoint = ""

            def judge():
                nonlocal checked, blocked
                if prompt and reply and not entrypoint.startswith("sdk") and is_japanese_prompt(prompt):
                    checked += 1
                    if is_english_reply(reply):
                        blocked += 1
                        print(f"{name[:8]}  {prompt[:30]!r} -> {reply[:60]!r}")

            for line in open(os.path.join(d, name), encoding="utf-8", errors="ignore"):
                try:
                    entry = json.loads(line)
                except ValueError:
                    continue
                text = prompt_text(entry)
                if text is not None:
                    judge()
                    prompt, reply, entrypoint = text, None, entry.get("entrypoint") or ""
                elif entry.get("type") == "assistant":
                    for b in (entry.get("message") or {}).get("content") or []:
                        if isinstance(b, dict) and b.get("type") == "text":
                            reply = b["text"]
            judge()
    print(f"checked {checked} Japanese prompts, would block {blocked}")


if __name__ == "__main__":
    if sys.argv[1:2] == ["--scan"]:
        scan(sys.argv[2:])
    elif sys.argv[1:2] == ["--agy"]:
        agy_hook()
    else:
        hook()
