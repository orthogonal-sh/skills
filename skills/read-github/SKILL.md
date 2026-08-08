---
name: read-github
description: Read GitHub repositories through clone, sparse checkout, raw files, or semantic repo docs.
---

# Read GitHub

Use this skill when the user asks to inspect a GitHub repository.

## Workflow

1. Identify the repo, branch, paths, and question.
2. Prefer `gh`, `git clone --depth 1`, sparse checkout, or raw file fetches over search snippets.
3. Read README, package manifests, docs, tests, and the relevant source files.
4. Use `rg` for symbols and behavior paths.
5. Answer with concrete file references and note any unverified assumptions.

## Guardrails

Do not run untrusted repo code until dependencies and scripts have been inspected.
