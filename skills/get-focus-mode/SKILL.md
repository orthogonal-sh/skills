---
name: get-focus-mode
description: Read the current macOS Focus mode for context-aware automations.
---

# Get Focus Mode

Use this skill when an automation or assistant workflow should adapt to the user's current macOS Focus state.

## Notes

- Treat focus state as context, not permission to interrupt.
- Use this before proactive notifications when quiet modes may be active.
- Fall back gracefully if the local macOS command is unavailable.
