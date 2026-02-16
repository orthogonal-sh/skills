---
name: find-skill
description: Find and install skills from the Orthogonal skill library. Use when you need capabilities you don't have, want to discover available skills, or need to add new tools to your agent.
---

# Find Skill

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
orth skills info <slug>

# Install a skill
orth skills add <slug>
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

```bash
# Install by slug
orth skills add restaurant-booking

# Install and view the skill file
orth skills add weather && cat ~/.openclaw/skills/weather/SKILL.md
```

Skills are installed to `~/.openclaw/skills/<slug>/`

## Using Installed Skills

After installing, the skill's `SKILL.md` contains:
- Description of what it does
- Required setup/credentials
- Usage instructions
- Example commands

Read the skill file to understand how to use it:

```bash
cat ~/.openclaw/skills/<slug>/SKILL.md
```

## Popular Skills

| Skill | Description |
|-------|-------------|
| `weather` | Get weather forecasts |
| `restaurant-booking` | Book restaurant reservations via Notte |
| `gog` | Google Workspace (Gmail, Calendar, Drive) |
| `github` | GitHub CLI for issues, PRs, repos |
| `web-search` | Search the web |
| `company-intel` | Research companies |

## Tips

- Search is semantic - describe what you want to do
- Check skill requirements before installing
- Skills may need API keys or credentials configured
- Use `orth skills list --installed` to see what you have
