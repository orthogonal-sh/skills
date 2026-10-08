---
name: data-reconciliation-exceptions
description: Reconcile datasets, isolate mismatches, classify exception causes, and produce audit-ready summaries.
---

# data-reconciliation-exceptions

Use this skill when comparing exports, ledgers, CRM records, spreadsheets, API results, or ETL outputs where mismatches need explanation rather than a raw diff.

## Workflow

- Identify keys, expected invariants, tolerances, and fields that may legitimately differ.
- Normalize formats, casing, dates, currency, IDs, and missing-value conventions before comparing.
- Group mismatches into clear exception classes such as missing records, stale records, duplicates, value drift, and schema changes.
- Produce a concise reconciliation summary with counts, examples, root-cause hypotheses, and recommended next actions.
