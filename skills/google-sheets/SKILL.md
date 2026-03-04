---
name: google-sheets
description: Create spreadsheets, read data, and manage Google Sheets. Use when asked to create sheets, add data to spreadsheets, lookup rows, update cells, or manage sheet data.
---

# Google Sheets

Create spreadsheets, read data, add rows, and manage Google Sheets. Connect your Google account to work with spreadsheet data, perform lookups, and automate sheet operations.

## Requirements

- Install the `orth` CLI
- Connect your Google Sheets at https://orthogonal.com/dashboard/integrations
- OAuth connection must be active (HTTP 428 response means not connected)

## Actions

### Create Spreadsheet

Create a new Google Sheets spreadsheet.

```bash
orth run google-sheets /create-spreadsheet --body '{
  "title": "Project Tracker"
}'
```

**Parameters:**
- `title` (required) - Title for the new spreadsheet

### Get Sheet Names

Retrieve all sheet names and IDs from a spreadsheet.

```bash
orth run google-sheets /get-sheet-names --body '{
  "spreadsheet_id": "1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms"
}'
```

**Parameters:**
- `spreadsheet_id` (required) - Google Sheets spreadsheet ID

### Add Row

Add a new row to a specific sheet.

```bash
orth run google-sheets /add-row --body '{
  "spreadsheet_id": "1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms",
  "sheet_id": 0,
  "insert_index": 2
}'
```

**Parameters:**
- `spreadsheet_id` (required) - Google Sheets spreadsheet ID
- `sheet_id` (required) - Sheet ID (numeric gid, not sheet name)
- `insert_index` - Row index to insert at (0-based)
- `inherit_from_before` - Inherit formatting from row above (true/false)

### Lookup Row

Search for rows matching a query in the spreadsheet.

```bash
orth run google-sheets /lookup-row --body '{
  "spreadsheet_id": "1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms",
  "query": "John Doe",
  "range": "Sheet1!A1:Z1000"
}'
```

**Parameters:**
- `spreadsheet_id` (required) - Google Sheets spreadsheet ID
- `query` (required) - Text to search for in the sheet
- `range` - Range to search in (A1 notation, e.g., "Sheet1!A1:Z100")
- `case_sensitive` - Case-sensitive search (true/false)

### Get Values

Retrieve data from specific ranges in the spreadsheet.

```bash
orth run google-sheets /get-values --body '{
  "spreadsheet_id": "1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms",
  "ranges": ["Sheet1!A1:C10", "Sheet2!A1:B5"]
}'
```

**Parameters:**
- `spreadsheet_id` (required) - Google Sheets spreadsheet ID
- `ranges` (required) - Array of ranges in A1 notation to retrieve

### Update Values

Update data in specific cells or ranges.

```bash
orth run google-sheets /update-values --body '{
  "spreadsheet_id": "1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms",
  "sheet_name": "Sheet1",
  "values": [["Name", "Age", "Email"], ["John Doe", "30", "john@example.com"]],
  "first_cell_location": "A1"
}'
```

**Parameters:**
- `spreadsheet_id` (required) - Google Sheets spreadsheet ID
- `sheet_name` (required) - Name of the sheet to update
- `values` (required) - 2D array of values to write
- `first_cell_location` - Starting cell location (A1 notation, defaults to A1)
- `valueInputOption` - How values are interpreted (USER_ENTERED, RAW)
- `includeValuesInResponse` - Return updated values in response (true/false)

## Usage Examples

**Create project tracking sheet:**
```bash
orth run google-sheets /create-spreadsheet -b '{"title":"Q1 Project Dashboard"}'
```

**Get all sheet names:**
```bash
orth run google-sheets /get-sheet-names -b '{"spreadsheet_id":"1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms"}'
```

**Add empty row:**
```bash
orth run google-sheets /add-row -b '{"spreadsheet_id":"1ABC...","sheet_id":0,"insert_index":5}'
```

**Search for customer:**
```bash
orth run google-sheets /lookup-row -b '{"spreadsheet_id":"1ABC...","query":"john@company.com","range":"Customers!A:Z"}'
```

**Get header row:**
```bash
orth run google-sheets /get-values -b '{"spreadsheet_id":"1ABC...","ranges":["Sheet1!1:1"]}'
```

**Get specific columns:**
```bash
orth run google-sheets /get-values -b '{"spreadsheet_id":"1ABC...","ranges":["Sheet1!A:A","Sheet1!C:C"]}'
```

**Add new data row:**
```bash
orth run google-sheets /update-values -b '{"spreadsheet_id":"1ABC...","sheet_name":"Sheet1","values":[["New Customer","John Smith","john@example.com","2024-03-15"]],"first_cell_location":"A2"}'
```

**Update multiple cells:**
```bash
orth run google-sheets /update-values -b '{"spreadsheet_id":"1ABC...","sheet_name":"Data","values":[["Updated","Value"],["Another","Update"]],"first_cell_location":"B5","valueInputOption":"USER_ENTERED"}'
```

**Add headers to new sheet:**
```bash
orth run google-sheets /update-values -b '{"spreadsheet_id":"1ABC...","sheet_name":"Customers","values":[["Name","Email","Phone","Date Added"]],"first_cell_location":"A1"}'
```

## A1 Notation Guide

Google Sheets uses A1 notation for cell references:

**Basic ranges:**
- `A1` - Single cell
- `A1:B2` - 2x2 range
- `A:A` - Entire column A
- `1:1` - Entire row 1
- `A1:Z` - Column A to Z in row 1

**Sheet references:**
- `Sheet1!A1:B2` - Range in specific sheet
- `'My Sheet'!A1` - Sheet with spaces (use quotes)

**Open ranges:**
- `A1:C` - From A1 to end of column C
- `A1:1` - From A1 to end of row 1

## Error Handling

- **HTTP 428** - Google Sheets integration not connected. Visit https://orthogonal.com/dashboard/integrations to connect your account
- **400 Bad Request** - Invalid spreadsheet ID, range, or data format
- **403 Forbidden** - Insufficient permissions to access or edit spreadsheet
- **404 Not Found** - Spreadsheet or sheet does not exist
- **429 Rate Limited** - Google Sheets API quota exceeded

## Tips

- Spreadsheet IDs are found in the Google Sheets URL
- Sheet IDs are numeric (gid parameter in URL), different from sheet names
- Use sheet names (not IDs) for update-values action
- Values array must be 2D: `[["row1col1", "row1col2"], ["row2col1", "row2col2"]]`
- USER_ENTERED interprets formulas and formats, RAW inserts literal values
- A1 notation is case-insensitive (a1 same as A1)
- Use quotes around sheet names containing spaces
- Empty cells in values arrays are represented as empty strings
- Lookup searches all text in the specified range