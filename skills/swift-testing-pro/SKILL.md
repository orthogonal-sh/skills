---
name: swift-testing-pro
description: Write Swift tests with modern testing APIs, async coverage, fixtures, snapshots, and reliable CI behavior
---

# Swift Testing Pro

Use this skill when adding or improving Swift test coverage.

## Workflow

1. Identify the target module, test framework, fixtures, platform, and CI constraints.
2. Cover public behavior, edge cases, async flows, errors, and regressions.
3. Keep fixtures small and deterministic.
4. Use modern Swift testing APIs or XCTest consistently with the project.
5. Run focused tests locally and document any skipped platform coverage.

## Checks

- Avoid sleeps when expectations, clocks, or dependency injection can make tests deterministic.
- Keep tests isolated from network, filesystem, and keychain unless integration coverage requires them.
- Name tests after behavior, not implementation.
- Include failure messages that help diagnose CI breaks.
