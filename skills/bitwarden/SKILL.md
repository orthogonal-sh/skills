---
name: bitwarden
description: Use Bitwarden CLI safely for vault search, secret lookup, item metadata, and credential hygiene checks.
---

# Bitwarden

Use this skill when the user asks to find a credential, audit vault entries, check for duplicate items, or prepare secure credential handling steps.

## Rules

- Never print passwords, recovery codes, private keys, or tokens into chat.
- Prefer item names, usernames, URI domains, and metadata over secret values.
- Ask before modifying, deleting, exporting, or sharing vault data.
- Use `bw` only after confirming the session is unlocked or the user provided an approved workflow.

## Common Tasks

- Search vault items by name or URI.
- Confirm whether a credential exists.
- Check duplicate or stale entries.
- Provide steps for the human to retrieve a secret locally.
