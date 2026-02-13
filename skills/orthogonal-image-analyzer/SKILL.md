---
name: image-analyzer
description: Analyze images with AI - extract text, describe content, detect objects
---

# Image Analyzer - AI Image Analysis

Analyze images to extract text, describe content, and detect objects using AI.

## Workflow

### Step 1: Get Image from URL
Fetch image content:

```bash
orth api run linkup /fetch --body '{"url": "https://example.com/image.jpg"}'
```

### Step 2: Extract Text (OCR)
Use AI to extract text from images:

```bash
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://example.com/screenshot.png",
  "user_prompt": "Extract all visible text from this image"
}'
```

### Step 3: Extract Structured Data
Get specific data from images:

```bash
orth api run riveter /v1/run --body '{
  "url": "https://example.com/receipt.jpg",
  "schema": {
    "store_name": "string",
    "date": "string",
    "items": [{"name": "string", "price": "number"}],
    "total": "number"
  }
}'
```

### Step 4: Capture Website Screenshots
Get screenshots of web pages:

```bash
orth api run brand-dev /v1/brand/screenshot --query 'domain=stripe.com'
```

## Example Usage

```bash
# Extract receipt data
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://example.com/receipt.jpg",
  "user_prompt": "Extract store name, date, all items with prices, and total amount"
}'

# Get website screenshot
orth api run brand-dev /v1/brand/screenshot --query 'domain=openai.com'
```

## Tips

- Use clear, high-resolution images
- Specify exact data needed for extraction
- Combine with OCR for text-heavy images
- Use screenshots for website analysis

## Discover More

List all endpoints, or add a path for parameter details:

```bash
orth api show brand-dev
orth api show linkup
orth api show riveter
orth api show scrapegraph
```

Example: `orth api show olostep /v1/scrapes` for endpoint parameters.
