---
name: golang-dependency-management
description: Manage Go modules, versions, replacements, vulnerability checks, and dependency update workflows
---

# Go Dependency Management

Use this skill when updating, auditing, or troubleshooting Go module dependencies.

## Workflow

1. Inspect `go.mod`, `go.sum`, toolchain version, and replace directives.
2. Check why a dependency is present before changing it.
3. Update the narrowest useful dependency set.
4. Run tests, vetting, and vulnerability checks where available.
5. Commit dependency files with a clear explanation of the change.

## Checks

- Avoid broad upgrades for unrelated work.
- Review transitive dependency changes.
- Keep generated files in sync.
- Remove stale replace directives after local testing.
