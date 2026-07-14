---
name: vitest
description: Add, run, and debug Vitest unit tests, mocks, fixtures, coverage, and watch-mode workflows.
---

# Vitest

Use this skill when the repo uses Vitest or the user asks for JavaScript or TypeScript unit tests.

## Workflow

- Inspect existing test patterns, setup files, mock helpers, and aliases.
- Add the narrowest useful test near the code under change.
- Prefer behavior-focused assertions over implementation details.
- Run targeted tests first, then broader suites when the change affects shared behavior.

## Common Commands

- `npm test`
- `npm run test`
- `npx vitest run path/to/test`
- `npx vitest --coverage`
