---
name: golang-testing
description: Write and review Go tests with table tests, fixtures, mocks, race checks, benchmarks, and integration coverage.
---

# Golang Testing

Use this skill when adding, fixing, or reviewing tests in Go projects.

## Workflow

1. Find the repo's existing test style before introducing new helpers.
2. Use table tests for behavior matrices and small fixtures for complex inputs.
3. Prefer real dependencies for cheap boundaries and fakes for slow or external systems.
4. Run the narrow package tests first, then broader suites when risk warrants it.

## Source

Discovered from `skills.sh`: `samber/cc-skills-golang` / `golang-testing`.
