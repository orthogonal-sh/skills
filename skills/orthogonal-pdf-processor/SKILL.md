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
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://example.com/report.pdf",
  "user_prompt": "Extract all financial figures, tables, and key metrics from this document"
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
orth api run scrapegraph /v1/markdownify --body '{"website_url": "https://example.com/document.pdf"}'
```

### Step 5: Ask Questions About PDF
Use AI to answer questions:

```bash
orth api run olostep /v1/answers --body '{
  "task": "What is the total revenue mentioned in this SEC filing? [url: https://example.com/10k.pdf]"
}'
```

## Example Usage

```bash
# Extract data from financial report
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://example.com/annual-report.pdf",
  "user_prompt": "Extract revenue, profit, and key business metrics with their values"
}'

# Get research paper summary
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{"role": "user", "content": "Summarize the key findings from this research paper: [url]"}]
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
orth api show olostep
orth api show perplexity
orth api show riveter
orth api show scrapegraph 
```

Example: `orth api show olostep /v1/scrapes` for endpoint parameters.
