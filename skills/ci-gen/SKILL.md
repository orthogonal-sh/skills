---
name: ci-gen
description: Generate or improve CI/CD workflows from project structure, package scripts, and deploy targets.
---

# CI Generator

Use this skill when setting up CI from scratch, adding tests to automation, or improving GitHub Actions and other CI workflows.

## Stub Scope

- Inspect the repo before choosing language, package manager, test command, or deployment path.
- Prefer minimal workflows that run the checks developers already run locally.
- Include caching, concurrency, permissions, and secret handling where appropriate.

## Future Implementation Notes

- Add templates for Node, Python, Go, Rust, Docker, and monorepos.
- Add deploy patterns for Vercel, Fly.io, AWS, and generic container registries.
