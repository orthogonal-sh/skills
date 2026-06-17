---
name: extract-webpage-data
description: Extract structured data from web pages using AI
---

# Extract Webpage Data

Extract structured data from any web page using AI. Turn messy HTML into clean, organized data.

## When to Use

- User wants to extract specific data from a website
- User asks to scrape information from a page
- User needs structured data from unstructured content
- User wants to pull product info, contact details, etc.
- Converting web content to usable data

## How It Works

Uses Olostep, Scrapegraph, or Riveter APIs for AI-powered data extraction.

## Usage

### Simple Scrape with Olostep

```bash
orth run olostep /v1/scrapes -d '{"url_to_scrape":"https://example.com/products"}'
```

### AI-Powered Extraction with Scrapegraph

```bash
orth run scrapegraph /api/extract -d '{"url":"https://example.com/team","prompt":"Extract all team members with their names, titles, and LinkedIn URLs"}'
```

### Schema-Based Extraction with Riveter

```bash
orth run riveter /v1/scrape -d '{"url":"https://example.com","schema":{"name":"string","price":"number","description":"string"}}'
```

### Get AI Answer from Web

```bash
orth run olostep /v1/answers -d '{"task":"Find the pricing for Notion Teams plan from their website"}'
```

### Crawl Multiple Pages

```bash
orth run olostep /v1/crawls -d '{"start_url":"https://example.com","max_pages":10}'
```

## Parameters

### Olostep Scrape
- **url_to_scrape** (required) - URL to scrape
- **formats** - Output formats (markdown, html, text)

### Scrapegraph
- **url** (required) - URL to scrape
- **prompt** (required) - Natural language description of what to extract

### Riveter
- **url** (required) - URL to scrape
- **schema** - JSON schema defining the data structure to extract

### Olostep Answer
- **task** (required) - Natural language task/question

## Response

### Olostep Response
Returns a scrape object:
- **id** (string) - Scrape ID (e.g., `scrape_z926lxxon3`)
- **result.markdown_content** (string|null) - Page content as markdown
- **result.html_content** (string|null) - Raw HTML (if requested via `formats`)
- **result.text_content** (string|null) - Plain text (if requested)
- **result.markdown_hosted_url** (string|null) - S3 URL for large content
- **result.links_on_page** (array) - Links found on the page
- **result.screenshot_hosted_url** (string|null) - Screenshot URL (if requested)
- **result.page_metadata** (object) - `status_code` of the page
- **credits_consumed** (integer) - Credits used for this scrape

**Async crawls**: POST `/v1/crawls` returns an `id`. Poll with GET `/v1/crawls/{id}` until complete.

### Scrapegraph Response
`/api/extract` is synchronous — the structured result is returned directly:
- **id** (string) - UUID for the extraction call
- **json** (object) - AI-extracted data matching your prompt/schema (dynamic keys)
- **raw** (string) - Raw model output before JSON parsing, when available
- **usage** (object) - Token accounting (`promptTokens`, `completionTokens`)
- **metadata** (object) - Diagnostic info (chunker, fetch details)

### Riveter Response
Returns scrape result:
- **request_status** (string) - `success` or `error`
- **message** (string) - Human-readable status
- **text** (string) - Extracted page text content
- **url** (string) - URL that was scraped
- **status_code** (integer) - HTTP status of the page
- **run_key** (string) - Unique run identifier
- **base_url_for_links** (string) - Base URL for resolving relative links
- **riveter_app_link** (string) - Link to view run in Riveter dashboard
- **credit_used** (integer) - Credits consumed

## Examples

**User:** "Get all the product names and prices from this page"
```bash
orth run scrapegraph /api/extract -d '{"url":"https://example.com/products","prompt":"Extract all products with name, price, and description"}'
```

**User:** "Scrape the team page and get everyone's info"
```bash
orth run scrapegraph /api/extract -d '{"url":"https://example.com/about/team","prompt":"Extract team members: name, role, bio, photo URL, LinkedIn"}'
```

**User:** "What are Stripe's API pricing details?"
```bash
orth run olostep /v1/answers -d '{"task":"Find Stripe API pricing breakdown from stripe.com/pricing"}'
```

**User:** "Get all blog post titles and dates from this blog"
```bash
orth run riveter /v1/scrape -d '{"url":"https://blog.example.com","schema":{"posts":[{"title":"string","date":"string","url":"string"}]}}'
```

## Error Handling

- **504** - Olostep timeout on slow pages — retry or try a simpler URL
- **400** - Missing required parameters (`url_to_scrape` for Olostep, `url` + `prompt` for Scrapegraph, `url` for Riveter)
- Scrapegraph returns `error` field in response body — check it even on 200 status
- Riveter returns `request_status: "error"` with details in `message`
- Some sites block automated scraping — try a different API if one fails

## Tips

- Scrapegraph is best for natural language extraction
- Riveter is best when you know the exact schema you want
- Olostep is great for general scraping and AI answers
- For dynamic sites (JavaScript-heavy), these tools handle rendering
- Be specific in your prompts for better extraction results
- Some sites may block automated access
