---
name: turnstile-spin
description: Add and verify Cloudflare Turnstile challenge flows, token validation, bot-defense UX, and server checks.
---

# Turnstile Spin

Use this skill when integrating or debugging Cloudflare Turnstile.

## Workflow

1. Identify client framework, server endpoint, site key, secret handling, and threat model.
2. Validate tokens server-side and enforce expiry, hostname, action, and remote IP expectations where applicable.
3. Keep challenge UX accessible and avoid blocking legitimate fallback paths.
4. Test successful, failed, missing, expired, and replayed token cases.

## Source

Discovered from `skills.sh`: `cloudflare/skills` / `turnstile-spin`.
