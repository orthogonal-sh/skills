---
name: app-store-changelog
description: Create App Store release notes from git history, tags, merged PRs, and user-facing changes.
---

# App Store Changelog

Use this skill when preparing App Store, TestFlight, or mobile release notes.

## Workflow

1. Identify the previous release tag, build number, or supplied comparison ref.
2. Review commits, merged PRs, issue links, and existing changelog entries.
3. Keep only user-visible changes, bug fixes, performance work, and compatibility updates.
4. Group items into concise release-note bullets.
5. Remove internal implementation detail, ticket IDs, and sensitive context.

## Output

Provide a short release note suitable for App Store Connect, plus an optional longer internal summary.
