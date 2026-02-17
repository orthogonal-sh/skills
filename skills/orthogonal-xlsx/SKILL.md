---
name: xlsx
description: Create, read, and manipulate Excel spreadsheets (.xlsx)
---

# Excel Spreadsheet Handler

Read, write, and manipulate Excel files programmatically.

## When to Use

- User wants to create or edit a spreadsheet
- User needs data analysis from Excel files
- User asks to generate reports in Excel format
- User needs CSV/JSON to Excel conversion

## How It Works

Uses `exceljs` or `xlsx` npm packages for full spreadsheet manipulation including formulas, charts, formatting, and multiple sheets.

## Source

Based on [anthropics/skills/xlsx](https://skills.sh/anthropics/skills/xlsx) (11.9K+ installs)

## Setup

```bash
npm install -g exceljs
```

## Key Features

- Read and write .xlsx files
- Formula support
- Cell formatting (colors, fonts, borders)
- Charts and data visualization
- Multiple worksheets
- CSV/JSON import/export
