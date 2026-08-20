---
name: homeassistant
description: Control and inspect Home Assistant entities and automations
---

# Home Assistant

Use this skill when a user asks to check smart home state, control devices, run scenes, inspect automations, or troubleshoot Home Assistant entities.

## Workflow

1. Identify entity IDs, domains, area names, and the requested action.
2. Read current state before changing anything.
3. Use Home Assistant REST, WebSocket, or configured CLI tools.
4. Confirm irreversible or disruptive actions such as unlocks, alarms, or garage controls.
5. Report the final entity state and any errors.

## Source

Discovered from `sundial-org/awesome-openclaw-skills`.
