---
name: auth-checker
description: Review authentication and session flows for security gaps and practical fixes.
---

# Auth Checker

Use this skill when auditing login, signup, sessions, password reset, OAuth, MFA, token handling, or authorization-adjacent auth flows.

## Stub Scope

- Check session lifetime, token storage, CSRF, reset flows, MFA bypasses, and account enumeration.
- Prioritize concrete exploit paths and remediation steps.
- Avoid handling real secrets or credentials in user-visible output.

## Future Implementation Notes

- Add framework-specific checklists for NextAuth, Clerk, Supabase Auth, Auth0, and custom JWT flows.
- Add test-case templates for auth regressions.
