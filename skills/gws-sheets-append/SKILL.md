---
name: gws-sheets-append
description: Append rows to Google Sheets with schema checks, dedupe, formatting awareness, and audit notes
---

# Google Workspace Sheets Append

Use this skill when appending structured data to Google Sheets.

## Workflow

1. Identify spreadsheet ID, sheet name, columns, and expected row schema.
2. Read headers before preparing appended rows.
3. Normalize values for dates, currencies, links, booleans, and empty fields.
4. Check for obvious duplicates when the sheet has a natural key.
5. Append rows and report the affected range.

## Checks

- Do not overwrite existing rows during append.
- Preserve column order and formulas.
- Escape user-provided text safely.
- Keep sensitive fields out unless the user explicitly requested them.
