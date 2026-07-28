---
name: excel-weekly-dashboard
description: Build refreshable Excel KPI dashboards with validation, pivots, and weekly reporting
---

# Excel Weekly Dashboard

Use this skill when the user needs a repeatable Excel workbook for weekly metrics, KPI reporting, exception lists, reconciliation, or leadership dashboards.

## Workflow

1. Identify source files, refresh cadence, KPI definitions, and target audience.
2. Normalize inputs into structured tables with stable column names.
3. Add validation checks for missing IDs, duplicate rows, date gaps, and totals.
4. Build pivot tables, charts, and summary tabs that refresh from the source tables.
5. Document refresh steps and expected source file shape inside the workbook.

## Output

- Prefer `.xlsx` with source, checks, summary, and dashboard tabs.
- Keep formulas transparent and avoid hidden business logic.
