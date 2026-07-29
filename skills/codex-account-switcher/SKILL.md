---
name: codex-account-switcher
description: Capture and switch between multiple local Codex login profiles for development environments.
---

# Codex Account Switcher

Use this skill when a user needs to manage multiple Codex accounts on the same machine.

## When To Use

- Save the current Codex login profile.
- Switch between work and personal Codex accounts.
- Verify which account is active before starting billable work.
- Restore a previous login after testing.

## Safe Workflow

1. Identify the active Codex config and auth files.
2. Back up the current profile.
3. Switch only to a named saved profile.
4. Verify account identity after switching.

## Guardrails

- Never print tokens or auth file contents.
- Never copy credentials into chat.
- Prefer file permissions that keep auth material private.

## Output

Report only the profile name and verification status, not secrets.
