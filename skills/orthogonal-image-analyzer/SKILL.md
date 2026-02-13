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

### Step 3: Describe Image Content
Get detailed image descriptions:

```bash
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{
    "role": "user",
    "content": "Describe the contents of this image in detail: https://example.com/image.jpg"
  }]
}'
```

### Step 4: Extract Structured Data
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

### Step 5: Capture Website Screenshots
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

# Analyze product image
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{"role": "user", "content": "What product is shown in this image? Identify brand, model, and features: [url]"}]
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

For full endpoint details and parameters:

```bash
orth api show brand-dev linkup perplexity riveter scrapegraph 
```
