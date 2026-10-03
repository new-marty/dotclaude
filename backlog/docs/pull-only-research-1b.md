# Stage 1B report: Claude Code mechanics (2026-10-04)

Saved by the orchestrator from the Stage 1B agent's text report (status DONE_WITH_CONCERNS).
Condensed. Sources: https://code.claude.com/docs/en/ pages (memory, skills, settings,
plugins, plugins/host-marketplace, plugins/org, managed settings), fetched 2026-10-04; local CLI
2.1.288. The repository is public, so https clone and marketplace add need no credentials.

## Instructions

- `@import`: relative or absolute paths, up to four hops, loaded at launch; skipped inside code
  spans and fences. A missing target does not fail the session (tested 2026-10-04; the docs do
  not state this case).
- No precedence: "All discovered files are concatenated into context rather than overriding
  each other", and "if two instructions contradict each other, Claude may pick one
  arbitrarily". "Local wins" holds only if the text says so. Managed CLAUDE.md always loads.
- `~/.claude/rules/*.md`: personal rules for every project, found recursively; no `paths:`
  frontmatter means loaded at launch. Untracked here because `.gitignore` starts with `*`, so a
  local rules file needs no edit to a tracked file. Not tested on a device.
- `/context` lists the memory files that loaded.

## Skills

- Same name: "Enterprise over personal, and personal over project." A local skill cannot share
  a name with a tracked one (both are personal scope). Plugin skills are namespaced
  (`/dotclaude:name`).
- Skills cannot be extended or included; no `@import` in SKILL.md is documented.
- Hide a shared skill per machine without editing it: `skillOverrides` in the untracked
  `~/.claude/settings.json`. The docs disagree on the value shape (string `"off"` on /skills,
  object `{visibility: ...}` on settings reference): test before relying on it.
- Local skills: untracked directories (or symlinks) under `~/.claude/skills/` with names that
  differ from tracked ones.

## Plugins

- This repo already is a marketplace (`.claude-plugin/marketplace.json`, plugin `dotclaude`,
  source `./`, no `version`, so every commit counts as an update). A device can
  `claude plugin marketplace add new-marty/dotclaude` and `claude plugin install
  dotclaude@dotclaude` without push rights; update by hand with `claude plugin marketplace
  update` then `claude plugin update dotclaude@dotclaude`, then `/reload-plugins`.
- A plugin cannot carry CLAUDE.md ("isn't loaded as context"), rules, or settings other than
  `agent` and `subagentStatusLine`. Updates replace the copy; local edits inside it are lost.
- Installing the plugin on a device that also has the clone shows every skill twice.

## Company constraints (managed settings, cannot be overridden)

| key | effect | impact |
|---|---|---|
| `allowManagedHooksOnly`, `disableAllHooks` | user and plugin hooks do not run | no SessionStart pull; pull by hand |
| `strictPluginOnlyCustomization` (`skills: true`) | skills in `~/.claude/skills` are rejected silently | shared and local skills vanish; only plugin or managed skills remain |
| `strictKnownMarketplaces`, `blockedMarketplaces` | marketplace allowlist / blocklist | plugin route only if the company allows this repo |
| `enabledPlugins` (managed `false`) | blocks a plugin by name | |
| `disableSideloadFlags` | rejects `--plugin-dir` and similar | |
| managed CLAUDE.md / `claudeMd` | always loads | may conflict with local text at the model level |

## Consequences suggested by Stage 1B (input to the design)

1. Layer 0, no hooks or scripts: tracked CLAUDE.md ends with an import of an untracked local
   file; local rules in `~/.claude/rules/`; local skills under new names; manual `git pull`.
2. Editing a tracked file cannot be overlaid by Claude Code; it is a plain git conflict.
3. Write "where local rules conflict with shared ones, the local ones win" in the local text;
   check with `/context`.
4. Hide unwanted shared skills with `skillOverrides` after testing its shape.
5. The plugin is a fallback channel for a device where the clone is impossible or skills in
   `~/.claude/skills` are blocked; it cannot carry instructions.
6. Plan a self-check for the worst case (skills silently rejected).

## Unverified

Missing-import behaviour on other versions; rules/ loading on a device; the `skillOverrides`
shape; the managed-settings file path and plist domain; any include mechanism inside SKILL.md.
