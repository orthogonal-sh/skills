---
name: prisma-client-api
description: Use Prisma Client APIs safely in application code
---

# Prisma Client API

Use this skill when implementing, reviewing, or debugging code that calls Prisma Client.

## Workflow

1. Inspect the Prisma schema, generated client version, and datasource.
2. Choose typed client methods that match the data model and relation needs.
3. Handle pagination, transactions, nested writes, and error cases explicitly.
4. Avoid N+1 queries and accidental broad reads.
5. Add focused tests around query shape and edge cases.

## Guardrails

- Do not change migrations unless the user asked for schema changes.
- Check official Prisma docs when behavior may be version-sensitive.

## Source

Discovered from skills.sh trending: `prisma/skills`.
