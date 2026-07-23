---
name: codemod-gen
description: Design AST-based codemods for large-scale refactors and API migrations.
---

# Codemod Generator

Use this skill when changing a repeated code pattern across many files where plain search and replace is risky.

## Stub Scope

- Identify the exact syntax pattern and safe transformation boundary.
- Prefer AST tools suited to the language and framework.
- Include dry-run, fixture, and rollback steps before applying broadly.

## Future Implementation Notes

- Add recipes for jscodeshift, ts-morph, Babel, Bowler, LibCST, and Comby.
- Add migration templates for dependency upgrades and API renames.
