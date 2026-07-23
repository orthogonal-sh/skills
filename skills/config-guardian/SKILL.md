---
name: config-guardian
description: Safely validate, back up, change, and roll back OpenClaw or agent configuration.
---

# Config Guardian

Use this skill whenever changing OpenClaw, gateway, agent, model, tool, channel, route, or session configuration.

## Stub Scope

- Back up config before changes and validate before restarting anything.
- Keep diffs narrow and avoid exposing tokens or credential values.
- Prepare rollback steps before applying risky changes.

## Future Implementation Notes

- Add backup, validate, restore, and restart command recipes.
- Add checklists for `openclaw.json`, model routing, tool registration, and channel config.
