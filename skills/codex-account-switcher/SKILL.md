---
name: codex-account-switcher
description: Inspect, switch, and troubleshoot Codex or OpenAI CLI account profiles, auth state, and workspace credentials.
---

# Codex Account Switcher

Use this skill when a task involves Codex account selection, OpenAI CLI auth, profile switching, credential locations, or account-specific access issues.

## Workflow

- Inspect the active profile, environment variables, config directories, and relevant auth status before changing anything.
- Avoid printing tokens, refresh credentials, or account secrets.
- Preserve existing profiles and document which profile is active after changes.
- Verify with a harmless authenticated command or status check.
