---
name: finance-tracker
description: Track expenses from natural language, categorize spending, and summarize budgets or trends.
---

# Finance Tracker

Use this skill when the user wants to log spending, classify transactions, review budgets, or summarize personal finance trends.

## Workflow

1. Capture amount, merchant, category, date, account, and notes.
2. Normalize categories and flag uncertainty.
3. Summarize spending by period, category, merchant, and variance from budget.
4. Detect recurring charges or unusual spikes when enough history exists.

## Safety

- Treat financial data as private.
- Do not connect accounts, move money, or contact vendors without explicit confirmation.
