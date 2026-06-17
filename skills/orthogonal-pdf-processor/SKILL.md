---
name: pdf-processor
description: Process PDFs - extract text, tables, and structured data from documents
---

# PDF Processor - Extract Data from PDFs

Extract text, tables, and structured data from PDF documents.

## Workflow

### Step 1: Fetch PDF Content
Use Linkup to fetch PDF URLs:

```bash
orth api run linkup /fetch --body '{"url": "https://example.com/document.pdf"}'
```

### Step 2: Extract with AI
Use ScrapeGraph to extract specific content:

```bash
orth api run scrapegraph /api/extract --body '{
  "url": "https://example.com/report.pdf",
  "prompt": "Extract all financial figures, tables, and key metrics from this document"
}'
```

### Step 3: Extract Tables
Get structured table data:

```bash
orth api run riveter /v1/run --body '{
  "input": {
    "urls": ["https://example.com/report.pdf"]
  },
  "output": {
    "tables": {"prompt": "Extract all tables with titles, headers, and rows", "contexts": ["urls"]}
  }
}'
```

### Step 4: Convert to Markdown
Get readable markdown output:

```bash
orth api run scrapegraph /api/scrape --body '{"url": "https://example.com/document.pdf", "formats": [{"type": "markdown"}]}'
```

## Example Usage

```bash
# Extract data from financial report
orth api run scrapegraph /api/extract --body '{
  "url": "https://example.com/annual-report.pdf",
  "prompt": "Extract revenue, profit, and key business metrics with their values"
}'

# Extract invoice data
orth api run riveter /v1/run --body '{
  "input": {"urls": ["https://example.com/invoice.pdf"]},
  "output": {
    "vendor": {"prompt": "Vendor name", "contexts": ["urls"]},
    "amount": {"prompt": "Total amount", "contexts": ["urls"]},
    "date": {"prompt": "Invoice date", "contexts": ["urls"]}
  }
}'
```

## Tips

- Specify exact data you need for better extraction
- Use schemas for consistent structured output
- Handle multi-page documents in chunks
- Verify extracted numbers against source

## Discover More

List all endpoints, or add a path for parameter details:

```bash
orth api show linkup
orth api show riveter
orth api show scrapegraph
```

Example: `orth api show olostep /v1/scrapes` for endpoint parameters.
