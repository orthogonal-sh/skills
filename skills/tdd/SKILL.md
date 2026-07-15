---
name: tdd
description: Drive changes with failing tests first, then implementation and cleanup.
---

# TDD

Use this skill when the user asks for test-driven development, red-green-refactor, or a cautious workflow for behavior changes.

## Workflow

1. Define the behavior in one or more focused tests before editing production code.
2. Run the targeted test and confirm it fails for the expected reason.
3. Implement the smallest production change that satisfies the test.
4. Run the targeted tests again, then expand to nearby suites when risk warrants it.
5. Refactor only after the behavior is covered and passing.

Keep tests readable and behavior-oriented.
