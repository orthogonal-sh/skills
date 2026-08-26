---
name: clerk-nextjs-patterns
description: Implement Clerk auth patterns in Next.js with middleware, sessions, orgs, webhooks, and tests
---

# Clerk Next.js Patterns

Use this skill when adding or reviewing Clerk authentication in a Next.js app.

## Workflow

1. Identify the router mode, Clerk package versions, middleware file, and protected routes.
2. Model public, signed-in, signed-out, organization, and role-gated states.
3. Keep server-side auth checks close to data access.
4. Add webhook verification before processing user or organization events.
5. Test redirects, session loading states, and unauthorized paths.

## Checks

- Never expose secret keys to client bundles.
- Validate middleware matchers for static assets and APIs.
- Handle expired sessions and missing organizations.
- Keep local and production redirect URLs aligned.
