---
name: data-reconciliation-exceptions
description: Reconcile datasets and produce exception reports with stable identifiers
---

# Data Reconciliation Exceptions

Use this skill when the user needs to compare two or more datasets, find mismatches, validate totals, or produce an exceptions report for operational review.

## Workflow

1. Identify authoritative keys, secondary match fields, and required totals.
2. Load data with a structured parser, preserving original row references.
3. Normalize dates, casing, whitespace, IDs, and currency formats.
4. Join records by stable identifiers first, then controlled fuzzy matching if approved.
5. Produce matched, missing-left, missing-right, duplicate, and value-mismatch outputs.

## Output

- Prefer CSV/XLSX exception files plus a short summary.
- Include enough columns for humans to resolve each exception.
