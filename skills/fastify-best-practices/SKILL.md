---
name: fastify-best-practices
description: Design, test, and debug Fastify services, plugins, schemas, hooks, routes, and performance-sensitive APIs.
---

# Fastify Best Practices

Use this skill when working on a Fastify server or API.

## Workflow

- Inspect plugin registration order, encapsulation boundaries, schemas, hooks, and decorators.
- Prefer JSON schema validation and typed route contracts where the project supports them.
- Keep handlers thin and move reusable logic into plugins or services.
- Test routes with Fastify injection or the repo's existing HTTP test harness.

## Watch For

- Async plugin registration mistakes.
- Decorator availability across scopes.
- Missing response schemas.
- Leaky shared state.
