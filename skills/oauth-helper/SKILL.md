---
name: oauth-helper
description: Debug OAuth flows, scopes, redirects, token refresh, consent screens, and provider app settings.
---

# oauth-helper

Use this skill when an OAuth login, consent, callback, token exchange, refresh flow, or provider integration is failing or needs implementation guidance.

## Workflow

- Identify provider, grant type, redirect URI, client type, scopes, environment, and observed error.
- Verify app settings, redirect URI matching, PKCE requirements, state handling, token audience, and scope consent.
- Inspect request and response parameters without exposing secrets.
- Recommend the smallest fix, including provider-console changes, code changes, and tests for refresh and revocation paths.
