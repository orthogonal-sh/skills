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
orth run scrapegraph /v1/smartscraper -d '{"website_url":"https://example.com/team","user_prompt":"Extract all team members with their names, titles, and LinkedIn URLs"}'
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
- **website_url** (required) - URL to scrape
- **user_prompt** (required) - Natural language description of what to extract

### Riveter
- **url** (required) - URL to scrape
- **schema** - JSON schema defining the data structure to extract

### Olostep Answer
- **task** (required) - Natural language task/question

## Response

### Scrape returns:
- Page content in requested format
- Extracted data
- Metadata (title, description, etc.)

### AI extraction returns:
- Structured data matching your prompt/schema
- Confidence scores
- Source URLs

## Examples

**User:** "Get all the product names and prices from this page"
```bash
orth run scrapegraph /v1/smartscraper -d '{"website_url":"https://example.com/products","user_prompt":"Extract all products with name, price, and description"}'
```

**User:** "Scrape the team page and get everyone's info"
```bash
orth run scrapegraph /v1/smartscraper -d '{"website_url":"https://example.com/about/team","user_prompt":"Extract team members: name, role, bio, photo URL, LinkedIn"}'
```

**User:** "What are Stripe's API pricing details?"
```bash
orth run olostep /v1/answers -d '{"task":"Find Stripe API pricing breakdown from stripe.com/pricing"}'
```

**User:** "Get all blog post titles and dates from this blog"
```bash
orth run riveter /v1/scrape -d '{"url":"https://blog.example.com","schema":{"posts":[{"title":"string","date":"string","url":"string"}]}}'
```

## Tips

- Scrapegraph is best for natural language extraction
- Riveter is best when you know the exact schema you want
- Olostep is great for general scraping and AI answers
- For dynamic sites (JavaScript-heavy), these tools handle rendering
- Be specific in your prompts for better extraction results
- Some sites may block automated access
