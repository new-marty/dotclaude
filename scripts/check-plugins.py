#!/usr/bin/env python3
"""Report shared plugins that auto-update has left behind their upstream.

check-upstream.sh runs this after its own list. For each plugin that
settings.shared.json enables, it compares the version this machine has
installed (plugins/installed_plugins.json) with the version upstream now
publishes, the way Claude Code resolves it: the marketplace entry's
`version`, else the plugin's plugin.json, else the upstream commit.

A difference is normal for a day, because auto-update runs only when a
session starts. A plugin still behind after LAG_DAYS days gets a CHANGED line
in check-upstream.sh's format, which the mac-mini's morning
dotclaude-upstream.sh turns into a Linear issue. The first day each gap was
seen is kept in $XDG_STATE_HOME/dotclaude-plugins/lag.tsv.

Exit status: 0 nothing overdue, 1 something overdue, 2 a fetch failed.
Environment: CLAUDE_SYNC_DIR (where plugins are installed, default ~/.claude),
PLUGIN_SHARED (default: this repository's settings.shared.json), PLUGIN_LAG_DAYS (default 2),
PLUGIN_CHECK_TODAY (YYYY-MM-DD, for tests), PLUGIN_CHECK_FETCH (a directory of
fixture files used instead of the network, for tests).
"""
import datetime
import json
import os
import subprocess
import sys
import urllib.request

CLAUDE_DIR = os.environ.get("CLAUDE_SYNC_DIR", os.path.expanduser("~/.claude"))
LAG_DAYS = int(os.environ.get("PLUGIN_LAG_DAYS", "2"))
TODAY = datetime.date.fromisoformat(
    os.environ.get("PLUGIN_CHECK_TODAY") or datetime.date.today().isoformat())
STATE = os.path.join(os.environ.get("XDG_STATE_HOME", os.path.expanduser("~/.local/state")),
                     "dotclaude-plugins", "lag.tsv")
FIXTURES = os.environ.get("PLUGIN_CHECK_FETCH")


def fetch_json(repo, path):
    """Return the JSON file at path in repo's default branch, or None if it is absent."""
    if FIXTURES:
        f = os.path.join(FIXTURES, repo.replace("/", "_"), path)
        return json.load(open(f)) if os.path.exists(f) else None
    url = f"https://raw.githubusercontent.com/{repo}/HEAD/{path}"
    try:
        with urllib.request.urlopen(url, timeout=20) as r:
            return json.load(r)
    except urllib.error.HTTPError as e:
        if e.code == 404:
            return None
        raise


def head_sha(repo):
    if FIXTURES:
        f = os.path.join(FIXTURES, repo.replace("/", "_"), "HEAD")
        return open(f).read().strip()
    out = subprocess.run(["git", "ls-remote", f"https://github.com/{repo}.git", "HEAD"],
                         capture_output=True, text=True, timeout=60, check=True).stdout
    return out.split()[0]


def upstream_version(market, plugin):
    """Return (repo, version) for plugin in the marketplace declared in settings.shared.json."""
    src = market["source"]
    if src["source"] == "settings":
        entry = next(p for p in src["plugins"] if p["name"] == plugin)
        repo, path = entry["source"]["repo"], ""
    else:
        repo = src["repo"]
        catalog = fetch_json(repo, src.get("path", ".claude-plugin/marketplace.json"))
        entry = next(p for p in catalog["plugins"] if p["name"] == plugin)
        s = entry["source"]
        if isinstance(s, str):
            path = s.strip("./").strip("/")
        else:
            repo = s.get("repo") or s["url"].removeprefix("https://github.com/").removesuffix(".git")
            path = s.get("path", "")
    if entry.get("version"):
        return repo, entry["version"]
    prefix = f"{path}/" if path else ""
    for candidate in (f"{prefix}.claude-plugin/plugin.json", f"{prefix}plugin.json"):
        manifest = fetch_json(repo, candidate)
        if manifest and manifest.get("version"):
            return repo, manifest["version"]
    return repo, head_sha(repo)


def installed_version(plugin_id):
    try:
        with open(os.path.join(CLAUDE_DIR, "plugins", "installed_plugins.json")) as f:
            entries = json.load(f)["plugins"].get(plugin_id, [])
    except (OSError, ValueError, KeyError):
        return None
    user = [e for e in entries if e.get("scope") == "user"] or entries
    return user[0].get("version") if user else None


def same(installed, upstream):
    if installed == upstream:
        return True
    # A plugin with no version is recorded by commit; compare as prefixes.
    return len(installed) >= 7 and len(upstream) >= 7 and (
        upstream.startswith(installed) or installed.startswith(upstream))


def main():
    shared_path = os.environ.get("PLUGIN_SHARED") or os.path.join(
        os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "settings.shared.json")
    with open(shared_path) as f:
        shared = json.load(f)
    markets = shared.get("extraKnownMarketplaces", {})
    seen = {}
    if os.path.exists(STATE):
        for line in open(STATE):
            parts = line.rstrip("\n").split("\t")
            if len(parts) == 3:
                seen[(parts[0], parts[1])] = parts[2]
    new_seen, overdue, failed = {}, False, False
    for plugin_id, on in shared.get("enabledPlugins", {}).items():
        if on is not True:
            continue
        plugin, _, market_name = plugin_id.partition("@")
        name = f"plugin:{plugin_id}"
        market = markets.get(market_name)
        if not market:
            continue
        try:
            repo, up = upstream_version(market, plugin)
        except Exception as e:  # network, missing entry, bad JSON
            print(f"ERROR    {name}  (could not read upstream: {e})")
            failed = True
            continue
        url = f"https://github.com/{repo}"
        have = installed_version(plugin_id)
        if have is None:
            print(f"ERROR    {name}  {url}  (not installed on this machine)")
            failed = True
            continue
        if same(have, up):
            print(f"current  {name}  {url}  @ {have}")
            continue
        first = seen.get((plugin_id, up), TODAY.isoformat())
        new_seen[(plugin_id, up)] = first
        days = (TODAY - datetime.date.fromisoformat(first)).days
        if days < LAG_DAYS:
            print(f"pending  {name}  {url}  {have} -> {up} (seen {first}; auto-update has {LAG_DAYS - days} more day(s))")
            continue
        overdue = True
        print(f"CHANGED  {name}  {url}  {have} -> {up}")
        print(f"         {url}")
    os.makedirs(os.path.dirname(STATE), exist_ok=True)
    with open(STATE, "w") as f:
        for (pid, up), first in sorted(new_seen.items()):
            f.write(f"{pid}\t{up}\t{first}\n")
    sys.exit(2 if failed else 1 if overdue else 0)


if __name__ == "__main__":
    main()
