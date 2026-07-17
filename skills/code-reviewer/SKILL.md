---
name: code-reviewer
description: Perform senior-engineer code reviews focused on correctness, behavior, and maintainability.
---

# Code Reviewer

Use this skill when asked to review a patch, branch, pull request, or design-level code change.

## Workflow

- Read the diff and enough surrounding code to understand the behavior.
- Look first for correctness bugs, regressions, race conditions, data loss, and security issues.
- Check whether tests cover the risky paths and expected failures.
- Keep comments actionable and grounded in file and line references.
- If no issues are found, state that clearly and mention remaining test gaps.

