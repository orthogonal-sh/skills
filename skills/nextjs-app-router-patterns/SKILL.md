---
name: nextjs-app-router-patterns
description: Implement and debug Next.js App Router routes, layouts, server components, actions, caching, and metadata.
---

# Next.js App Router Patterns

Use this skill when a task touches a Next.js App Router application.

## Workflow

- Identify whether the code runs in a server component, client component, route handler, middleware, or server action.
- Respect existing data fetching, cache, revalidation, and auth patterns.
- Keep client boundaries small and explicit.
- Test affected routes with the repo's unit, integration, or Playwright setup.

## Watch For

- Accidental client-side secrets.
- Stale cache or missing revalidation.
- Hydration mismatches.
- Metadata and layout regressions.
