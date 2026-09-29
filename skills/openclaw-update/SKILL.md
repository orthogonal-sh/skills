---
name: openclaw-update
description: Check, plan, apply, and verify OpenClaw updates across CLI, gateway, plugins, skills, and nodes.
---

# OpenClaw Update

Use this skill when updating OpenClaw itself or diagnosing version drift across local services and nodes.

## Workflow

- Inspect current versions, channel, service health, and pending changes before updating.
- Read release notes or changelogs for breaking changes.
- Preserve config and secrets; back up state when the update touches storage or auth.
- Apply the update with the supported CLI path.
- Verify gateway, channel, plugin, skill, and node health afterward.
