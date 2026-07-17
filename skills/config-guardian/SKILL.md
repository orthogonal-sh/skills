---
name: config-guardian
description: Safely edit OpenClaw or service configuration with backups, validation, and rollback steps.
---

# Config Guardian

Use this skill before changing configuration that can affect routing, models, agents, tools, credentials, or gateways.

## Workflow

- Identify the config file, desired change, and expected runtime effect.
- Create a recoverable backup before editing.
- Validate the current config before making changes.
- Apply the smallest possible edit and avoid exposing secrets.
- Validate after the change and prepare rollback steps before restart or deploy.

