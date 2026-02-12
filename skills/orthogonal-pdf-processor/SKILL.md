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
curl -X POST "https://api.orth.sh/v1/run/linkup/fetch" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"url": "https://example.com/document.pdf"}'
```

### Step 2: Extract with AI
Use ScrapeGraph to extract specific content:

```bash
curl -X POST "https://api.orth.sh/v1/run/scrapegraph/v1/smartscraper" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "website_url": "https://example.com/report.pdf",
    "user_prompt": "Extract all financial figures, tables, and key metrics from this document"
  }'
```

### Step 3: Extract Tables
Get structured table data:

```bash
curl -X POST "https://api.orth.sh/v1/run/riveter/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://example.com/report.pdf",
    "schema": {
      "tables": [{
        "title": "string",
        "headers": ["string"],
        "rows": [["string"]]
      }]
    }
  }'
```

### Step 4: Convert to Markdown
Get readable markdown output:

```bash
curl -X POST "https://api.orth.sh/v1/run/scrapegraph/v1/markdownify" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"website_url": "https://example.com/document.pdf"}'
```

### Step 5: Ask Questions About PDF
Use AI to answer questions:

```bash
curl -X POST "https://api.orth.sh/v1/run/olostep/v1/answers" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "question": "What is the total revenue mentioned in this SEC filing? [url: https://example.com/10k.pdf]"
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
  "url": "https://example.com/invoice.pdf",
  "schema": {"vendor": "string", "amount": "number", "date": "string", "items": [{"description": "string", "price": "number"}]}
}'
```

## Tips

- Specify exact data you need for better extraction
- Use schemas for consistent structured output
- Handle multi-page documents in chunks
- Verify extracted numbers against source
