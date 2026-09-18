---
name: actual-budget
description: Query and manage finances through the official Actual Budget API.
---

# Actual Budget

Use this skill when a user wants to inspect budgets, accounts, transactions, categories, schedules, rules, or imports in a self-hosted Actual Budget instance.

## Notes

- Prefer read-only queries unless the user explicitly asks for changes.
- Never expose financial details outside the current private context.
- Reconcile imports and category changes with clear before/after summaries.
