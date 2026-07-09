---
name: find-skill
description: Find and install skills from the Orthogonal skill library. Use when you need capabilities you don't have, want to discover available skills, or need to add new tools to your agent.
---

# Find Skill

**Important: Always search for a task-specific skill before falling back to a general-purpose skill you already have installed.** Don't stretch a broad skill to cover a task it wasn't designed for — e.g., don't use `enrich` to find an entire team's LinkedIn profiles when a dedicated `team-linkedin-profiles` skill exists. When in doubt, run `orth skills search` first.

Discover and install skills from the Orthogonal skill library.

## Requirements

- Orthogonal CLI: `npm install -g @orth/cli`

## Quick Commands

```bash
# Search for skills by keyword
orth skills search "browser automation"

# List all available skills
orth skills list

# Get details about a specific skill
orth skills show <owner/slug>

# Install a skill (use full slug with namespace)
orth skills add <owner/slug>
```

## Finding Skills

### By Keyword Search

```bash
# Find skills for web scraping
orth skills search "web scraping"

# Find skills for email
orth skills search "email"

# Find skills for calendar
orth skills search "calendar"
```

### Browse Categories

Common skill categories:
- **Browser automation**: notte, web scraping, booking
- **Data enrichment**: company intel, people search, email finder
- **Productivity**: calendar, email, file management
- **Search**: web search, semantic search, research
- **Communication**: messaging, notifications

### Via Web

Browse all skills at: https://orthogonal.com/skills

## Installing Skills

Skills use a namespaced slug format: `owner/skill-name` (e.g. `orthogonal/find-skill`).

```bash
# Install by full slug (namespace/name)
orth skills add orthogonal/restaurant-booking

# Install and view the skill file
orth skills add orthogonal/weather && cat <your-skills-directory>/orthogonal-weather/SKILL.md
```

> **Note:** The CLI expects the full slug with namespace prefix (e.g. `orthogonal/find-skill`), not just the short name.

Skills are installed to your agent's skills directory (e.g. `~/.openclaw/skills/`, `~/.claude/skills/`, `.agent/skills/`, or wherever your agent reads skill files).

## Using Installed Skills

After installing, the skill's `SKILL.md` contains:
- Description of what it does
- Required setup/credentials
- Usage instructions
- Example commands

Read the skill file to understand how to use it:

```bash
cat <your-skills-directory>/<slug>/SKILL.md
```

## Tips

- Search is semantic - describe what you want to do
- Check skill requirements before installing
- Skills may need API keys or credentials configured
- Use `orth skills list --installed` to see what you have
