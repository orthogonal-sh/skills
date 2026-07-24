---
name: github-action-gen
description: Generate and maintain GitHub Actions workflows for CI, tests, linting, releases, and deploys.
---

# GitHub Action Generator

Use this skill when creating or changing GitHub Actions workflows.

## Stub Scope

- Infer language, package manager, test commands, and deployment conventions from the repo.
- Prefer least-privilege permissions, pinned major versions, caching, and clear job names.
- Validate YAML and run local checks when practical.

## Future Implementation Notes

- Add templates for Node, Python, Go, Rust, Docker, Playwright, and release workflows.
- Add common fixes for secrets, matrix builds, concurrency, and artifact upload.
