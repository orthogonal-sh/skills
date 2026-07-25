---
name: oauth-helper
description: Guide OAuth setup, callback handling, token exchange, scopes, and troubleshooting.
---

# OAuth Helper

Use this skill when integrating OAuth login, debugging auth flows, or setting up provider applications.

## Workflow

1. Identify provider, grant type, redirect URI, scopes, and client type.
2. Verify app configuration and callback routes.
3. Walk through authorization, code exchange, token storage, and refresh.
4. Diagnose common errors such as invalid redirect URI, scope mismatch, and expired tokens.
5. Document minimal required scopes and security notes.

## Security

- Never ask users to paste secrets into chat.
- Use placeholders in examples.
- Prefer least-privilege scopes.
