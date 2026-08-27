---
name: clerk-cli
description: Use Clerk CLI workflows for apps, auth config, users, envs, testing, and deployment checks
---

# Clerk CLI

Use this skill when working with Clerk from the command line.

## Workflow

1. Identify the Clerk app, environment, framework, auth flow, and desired CLI action.
2. Verify login, project selection, and environment variables before making changes.
3. Inspect users, organizations, sessions, domains, and configuration through supported commands.
4. Pair CLI changes with application code, middleware, webhook, and dashboard updates when needed.
5. Document any production-impacting configuration and rollback steps.

## Checks

- Do not expose Clerk secrets or session tokens.
- Separate development, staging, and production instances.
- Confirm webhook signing secrets and redirect URLs after changes.
- Test sign-in, sign-out, protected routes, and organization flows.
