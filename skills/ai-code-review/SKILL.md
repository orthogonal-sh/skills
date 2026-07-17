---
name: ai-code-review
description: Review staged or proposed code changes for bugs, regressions, security issues, and missing tests.
---

# AI Code Review

Use this skill when reviewing code changes before a commit, push, or pull request.

## Workflow

- Inspect the diff, surrounding code, and relevant tests.
- Prioritize concrete bugs, regressions, security risks, and contract breaks.
- Check for missing or weak tests proportional to the risk of the change.
- Avoid style commentary unless it hides a real maintainability problem.
- Report findings first with file and line references, then residual risk.

