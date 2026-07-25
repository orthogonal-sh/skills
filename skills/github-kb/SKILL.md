---
name: github-kb
description: Build and query a local GitHub knowledge base from repos, issues, PRs, and docs.
---

# GitHub Knowledge Base

Use this skill when the user wants reusable GitHub context, repo intelligence, or cross-repo search.

## Workflow

1. Identify repos, orgs, issues, PRs, docs, and branches to include.
2. Clone or fetch only the needed public or authorized content.
3. Index key files, metadata, and relationships.
4. Answer questions with source-backed references.
5. Refresh stale repos before making current claims.

## Guardrails

- Respect private repo boundaries.
- Avoid storing secrets from cloned code.
- Track source commit hashes when accuracy matters.
