#!/usr/bin/env python3
"""Link the skills Claude Code loads into ~/.agents/skills, for the other agents.

Codex, pi and agy read user skills from ~/.agents/skills; Claude Code reads
~/.claude/skills and its plugins. sync-pull.sh runs this after each pull so the
other agents see the same skills: one symlink ~/.agents/skills/<name> per skill
under ~/.claude/skills and per skill of an enabled, installed plugin, where
<name> is the skill's frontmatter name.

Rules, so nothing another tool put there is lost:
- only symlinks that point into the claude dir are ours; anything else in
  ~/.agents/skills (Orca's skills, a real directory) is never touched, and a
  skill whose name it already takes is skipped;
- our links that no longer match a wanted skill are removed, so a plugin update
  (a new version directory) or a disabled plugin is followed on the next run;
- on a name clash ~/.claude/skills wins over a plugin, and an earlier plugin in
  enabledPlugins over a later one;
- plugins in CLAUDE_ONLY are not linked.
agy reads ~/.agents/skills only when its ~/.gemini/config/skills.json lists it
by absolute path, so that entry is added when agy's config directory exists;
the file's other entries are kept.
Usage: link-agent-skills.py [claude_dir] [agents_skills_dir] [agy_config_dir]
       (defaults: $CLAUDE_SYNC_DIR or ~/.claude, ~/.agents/skills, ~/.gemini/config)
Exit status is always 0; problems are reported on stderr.
"""
import json
import os
import sys
import tempfile

# pstack's 59 skills are manual-only and lean on Claude Code's own tools and its
# poteto-mode routing; elsewhere they would only add descriptions to every session.
CLAUDE_ONLY = {"pstack@pstack-mirror"}


def log(msg):
    print(f"[claude-sync] {msg}", file=sys.stderr)


def skill_name(skill_dir):
    """The frontmatter name of skill_dir/SKILL.md, or the directory name."""
    try:
        with open(os.path.join(skill_dir, "SKILL.md")) as f:
            lines = f.read().splitlines()
    except OSError:
        return None
    if lines and lines[0].strip() == "---":
        for line in lines[1:]:
            if line.strip() == "---":
                break
            if line.startswith("name:"):
                name = line[5:].strip().strip("'\"")
                if name:
                    return name
    return os.path.basename(os.path.realpath(skill_dir))


def scan(path):
    """Skill directories at path: path itself if it holds SKILL.md, else its children that do."""
    if os.path.isfile(os.path.join(path, "SKILL.md")):
        return [path]
    try:
        names = sorted(os.listdir(path))
    except OSError:
        return []
    return [os.path.join(path, n) for n in names if os.path.isfile(os.path.join(path, n, "SKILL.md"))]


def plugin_skills(root):
    """The skill directories Claude Code loads from a plugin installed at root."""
    try:
        with open(os.path.join(root, ".claude-plugin", "plugin.json")) as f:
            extra = json.load(f).get("skills", [])
    except (OSError, ValueError):
        extra = []
    if isinstance(extra, str):
        extra = [extra]
    default = os.path.join(root, "skills")
    if not os.path.isdir(default) and not extra:
        return scan(root)
    dirs = scan(default) if os.path.isdir(default) else []
    for rel in extra:
        dirs += scan(os.path.normpath(os.path.join(root, rel)))
    return dirs


def wanted_skills(claude_dir, agents_dir):
    """(name, skill_dir) pairs in priority order."""
    found = []
    own = os.path.join(claude_dir, "skills")
    for entry in sorted(os.listdir(own)) if os.path.isdir(own) else []:
        path = os.path.join(own, entry)
        real = os.path.realpath(path)
        # skip claude.ai's synced bundle, dangling links, and links back into agents_dir
        if entry in ("synced", ".trash") or not os.path.isdir(real) or \
                real.startswith(os.path.realpath(agents_dir) + os.sep):
            continue
        if os.path.isfile(os.path.join(path, "SKILL.md")):
            found.append(path)
    try:
        with open(os.path.join(claude_dir, "settings.json")) as f:
            enabled = [p for p, on in json.load(f).get("enabledPlugins", {}).items() if on is True]
        with open(os.path.join(claude_dir, "plugins", "installed_plugins.json")) as f:
            installed = json.load(f).get("plugins", {})
    except (OSError, ValueError):
        enabled, installed = [], {}
    for plugin in enabled:
        records = installed.get(plugin) or []
        root = records[0].get("installPath") if records else None
        if plugin in CLAUDE_ONLY or not root or not os.path.isdir(root):
            continue
        found += plugin_skills(root)
    pairs, names = [], {}
    for path in dict.fromkeys(found):
        name = skill_name(path)
        if not name or "/" in name:
            continue
        if name in names:
            log(f"agent skills: {path} left out, {names[name]} already has the name {name}")
            continue
        names[name] = path
        pairs.append((name, path))
    return pairs


def ours(link, claude_dir):
    """A symlink this script made: one that points into the claude dir."""
    if not os.path.islink(link):
        return False
    target = os.readlink(link)
    return any(target.startswith(d.rstrip(os.sep) + os.sep)
               for d in (claude_dir, os.path.realpath(claude_dir)))


def register_agy(agy_dir, agents_dir):
    """Make agy's skills.json list agents_dir; agy expands neither ~ nor relative paths here."""
    if not os.path.isdir(agy_dir):
        return
    path = os.path.join(agy_dir, "skills.json")
    config = {}
    if os.path.exists(path):
        try:
            with open(path) as f:
                config = json.load(f)
        except ValueError as e:
            log(f"agent skills: {path} is not valid JSON ({e}); agy left as it was")
            return
    entries = config.setdefault("entries", [])
    target = os.path.abspath(agents_dir)
    if any(isinstance(e, dict) and e.get("path") == target for e in entries):
        return
    entries.append({"path": target})
    fd, tmp = tempfile.mkstemp(dir=agy_dir, prefix=".skills.")
    with os.fdopen(fd, "w") as f:
        json.dump(config, f, indent=2)
        f.write("\n")
    os.chmod(tmp, 0o644)
    os.replace(tmp, path)
    log(f"agent skills: added {target} to {path}")


def main():
    claude_dir = sys.argv[1] if len(sys.argv) > 1 else os.environ.get(
        "CLAUDE_SYNC_DIR", os.path.expanduser("~/.claude"))
    agents_dir = sys.argv[2] if len(sys.argv) > 2 else os.path.expanduser("~/.agents/skills")
    agy_dir = sys.argv[3] if len(sys.argv) > 3 else os.path.expanduser("~/.gemini/config")
    real_claude = os.path.realpath(claude_dir)
    if (os.path.realpath(agents_dir) + os.sep).startswith(real_claude + os.sep):
        log(f"agent skills: {agents_dir} resolves into {claude_dir}; nothing linked")
        return
    os.makedirs(agents_dir, exist_ok=True)
    wanted = dict(wanted_skills(claude_dir, agents_dir))
    added, removed = [], []
    for entry in sorted(os.listdir(agents_dir)):
        link = os.path.join(agents_dir, entry)
        if ours(link, claude_dir) and wanted.get(entry) != os.readlink(link):
            os.unlink(link)
            if entry not in wanted:
                removed.append(entry)
    for name, path in wanted.items():
        link = os.path.join(agents_dir, name)
        if os.path.lexists(link):
            if not ours(link, claude_dir):
                log(f"agent skills: {link} is not ours; {name} left out")
            continue
        tmp = link + ".tmp-link"
        if os.path.lexists(tmp):
            os.unlink(tmp)
        os.symlink(path, tmp)
        os.replace(tmp, link)
        added.append(name)
    if added or removed:
        log(f"agent skills in {agents_dir}: linked {', '.join(added) or 'none'}; "
            f"removed {', '.join(removed) or 'none'}")
    register_agy(agy_dir, agents_dir)


if __name__ == "__main__":
    try:
        main()
    except Exception as e:  # never break session start
        log(f"link-agent-skills failed: {e}")
    sys.exit(0)
