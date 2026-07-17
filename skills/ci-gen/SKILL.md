---
name: ci-gen
description: Generate CI workflows for linting, testing, building, caching, and deployment checks.
---

# CI Generator

Use this skill when setting up or improving continuous integration.

## Workflow

- Detect the project language, package manager, test runner, build steps, and deployment targets.
- Define the minimum checks needed before merge.
- Add caching and dependency installation appropriate to the stack.
- Separate fast pull request checks from slower scheduled or release jobs.
- Document required secrets, permissions, and branch protection assumptions.

