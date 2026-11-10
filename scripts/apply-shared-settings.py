#!/usr/bin/env python3
"""Merge settings.shared.json into this machine's settings.json.

settings.json is per machine (Orca and the mac-mini write their own hooks into
it), so it is not tracked. The few keys every machine must have live in the
tracked settings.shared.json, and sync-pull.sh runs this after each pull.

Merge rules, so nothing a machine added is lost:
- a top-level key whose value is an object merges entry by entry, and each
  entry is replaced whole (a marketplace's source and autoUpdate travel together);
- any other top-level key is set to the shared value;
- keys starting with "_" are comments and are skipped;
- keys the shared file does not name are never touched.

The file is written only when something changed, through a temporary file and
a rename, after copying the previous version to settings.json.bak-shared.
It also starts `claude plugin install` in the background for enabled plugins this
machine has no install record for (CLAUDE_SYNC_NO_INSTALL=1 turns that off, for tests).
Usage: apply-shared-settings.py [claude_dir]   (default: $CLAUDE_SYNC_DIR or ~/.claude)
Exit status is always 0; problems are reported on stderr.
"""
import json
import os
import shutil
import subprocess
import sys
import tempfile


def log(msg):
    print(f"[claude-sync] {msg}", file=sys.stderr)


def merge(current, shared):
    changed = []
    for key, value in shared.items():
        if key.startswith("_"):
            continue
        if isinstance(value, dict):
            target = current.get(key)
            if not isinstance(target, dict):
                target = {}
                current[key] = target
            for name, entry in value.items():
                if target.get(name) != entry:
                    target[name] = entry
                    changed.append(f"{key}.{name}")
        elif current.get(key) != value:
            current[key] = value
            changed.append(key)
    return changed


def record_installs(claude_dir, shared):
    """Install, in the background, each enabled plugin this machine has no install record for.

    A session downloads an enabled plugin on its own, but without an entry in
    installed_plugins.json, and `claude plugin update` (which auto-update runs)
    then reports it as not installed. `claude plugin install` writes the entry.
    """
    wanted = [p for p, on in shared.get("enabledPlugins", {}).items() if on is True]
    try:
        with open(os.path.join(claude_dir, "plugins", "installed_plugins.json")) as f:
            have = set(json.load(f).get("plugins", {}))
    except (OSError, ValueError):
        have = set()
    missing = [p for p in wanted if p not in have]
    claude = None if os.environ.get("CLAUDE_SYNC_NO_INSTALL") else shutil.which("claude")
    if not missing or not claude:
        return
    log_path = os.path.join(claude_dir, "plugins", "shared-install.log")
    os.makedirs(os.path.dirname(log_path), exist_ok=True)
    script = "; ".join(f'"$0" plugin install {p} --scope user' for p in missing)
    with open(log_path, "a") as log_file:
        subprocess.Popen(["/bin/sh", "-c", script, claude], stdout=log_file, stderr=log_file,
                         stdin=subprocess.DEVNULL, start_new_session=True)
    log("installing in the background: " + ", ".join(missing) + f" (log: {log_path})")


def main():
    claude_dir = sys.argv[1] if len(sys.argv) > 1 else os.environ.get(
        "CLAUDE_SYNC_DIR", os.path.expanduser("~/.claude"))
    shared_path = os.path.join(claude_dir, "settings.shared.json")
    settings_path = os.path.realpath(os.path.join(claude_dir, "settings.json"))
    if not os.path.exists(shared_path):
        return
    try:
        with open(shared_path) as f:
            shared = json.load(f)
    except ValueError as e:
        log(f"settings.shared.json is not valid JSON ({e}); settings.json left as it was")
        return
    current = {}
    if os.path.exists(settings_path):
        try:
            with open(settings_path) as f:
                current = json.load(f)
        except ValueError as e:
            log(f"settings.json is not valid JSON ({e}); fix it by hand, nothing was merged")
            return
    changed = merge(current, shared)
    record_installs(claude_dir, shared)
    if not changed:
        return
    if os.path.exists(settings_path):
        shutil.copy2(settings_path, settings_path + ".bak-shared")
    fd, tmp = tempfile.mkstemp(dir=os.path.dirname(settings_path), prefix=".settings.")
    try:
        with os.fdopen(fd, "w") as f:
            json.dump(current, f, indent=2, ensure_ascii=False)
            f.write("\n")
        if os.path.exists(settings_path):
            shutil.copymode(settings_path + ".bak-shared", tmp)
        os.replace(tmp, settings_path)
    except BaseException:
        os.unlink(tmp)
        raise
    log("settings.json updated from settings.shared.json: " + ", ".join(changed))


if __name__ == "__main__":
    try:
        main()
    except Exception as e:  # never break session start
        log(f"apply-shared-settings failed: {e}")
    sys.exit(0)
