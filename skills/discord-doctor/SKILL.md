---
name: discord-doctor
description: Diagnose Discord bot, gateway, OAuth, token, permission, and legacy config failures.
---

# Discord Doctor

Use this skill when Discord integrations fail, messages stop arriving, bot permissions look wrong, or gateway state needs diagnosis.

## Workflow

1. Identify the bot, guild, channel, failing action, and recent change.
2. Check gateway connectivity, token validity, OAuth scopes, intents, permissions, and rate limits.
3. Inspect local config for stale IDs or legacy fields.
4. Recommend the smallest repair with rollback notes.

## Safety

- Never print tokens.
- Avoid deleting config or rotating credentials without explicit approval.
