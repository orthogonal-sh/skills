---
name: prisma-cli
description: Use the Prisma CLI for schema, migration, and database tasks
---

# Prisma CLI

Use this skill when a task involves Prisma schema validation, migrations, generation, seeding, or local database inspection.

## Workflow

1. Inspect `schema.prisma`, package scripts, and the configured Prisma version.
2. Prefer existing npm scripts before raw `prisma` commands.
3. Use `prisma validate`, `prisma format`, and `prisma generate` for safe checks.
4. Treat migrations as user-visible data changes and explain their impact.
5. Verify generated client usage with tests or a small smoke command.

## Guardrails

- Do not run destructive reset commands without explicit approval.
- Do not read production database credentials.

## Source

Discovered from skills.sh trending: `prisma/skills`.
