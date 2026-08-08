---
name: github-pr
description: Fetch, inspect, test, and apply GitHub pull requests locally before merge.
---

# GitHub PR Tool

Use this skill when evaluating a pull request from GitHub.

## Workflow

1. Fetch PR metadata, diff, comments, checks, and changed files with `gh`.
2. Create or reuse a local branch or worktree for the PR.
3. Install only the dependencies required by the repo.
4. Run focused tests, linters, type checks, or manual verification steps.
5. Summarize risks, failures, and suggested fixes before approval or merge.

## Guardrails

Do not merge PRs unless explicitly asked. Preserve unrelated local changes.
