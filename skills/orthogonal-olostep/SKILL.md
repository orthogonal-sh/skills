---
name: olostep
description: "Web scraping, crawling, and AI-powered answer extraction via the Olostep API. Use when the agent needs to scrape a web page for its content, crawl an entire website or section, discover all URLs on a site via sitemap mapping, get AI-synthesized answers from web sources, or process multiple URLs in batch. Supports geo-targeted requests, structured data extraction, LLM-based extraction, and content format selection."
---

# Olostep API

## Workflow

1. **Identify the task type.** The agent determines which operation fits the request:
   - Single page content needed → **Scrape** (`/v1/scrapes`)
   - AI-researched answer to a question → **Answer** (`/v1/answers`)
   - Discover all URLs on a website → **Maps** (`/v1/maps`)
   - Crawl multiple linked pages from a start URL → **Crawl** (`/v1/crawls`)
   - Process a known list of URLs at once → **Batch** (`/v1/batches`)
2. **Submit the request.** The agent calls the appropriate creation endpoint with required and optional parameters.
3. **Poll or retrieve results.** For asynchronous operations (crawls, batches), the agent checks status via the info endpoint, then fetches page-level results.
4. **Extract content.** The agent uses `/v1/retrieve` with the `retrieve_id` from crawl pages, scrape results, or batch items to get the final page content in the desired format.

## Scraping a Single Page

The agent initiates a scrape to extract content from one URL.

**Endpoint:** `POST /v1/scrapes`

Parameters:
- url_to_scrape* (string) - The URL to start scraping from.
- wait_before_scraping (integer) - Time to wait in milliseconds before starting the scraping.
- formats (string[]) - Formats in which the content should be returned.
- remove_css_selectors (string) - Remove certain CSS selectors from the content. Pass `"default"` to strip nav, footer, script, style, noscript, svg, and ARIA role elements. Pass `"none"` to keep all, or a JSON-stringified array of specific selectors. Available options: `default`, `none`, `array`
- actions (object[]) - Actions to perform on the page before getting the content.
- country (string) - Residential country to load the request from. Supported values: US, CA, IT, IN, GB, JP, MX, AU, ID, UA, RU, RANDOM. Google Search and Google News support all countries.
- transformer (string) - HTML transformer. `"postlight"` uses Mercury Parser to remove ads and unwanted content. Available options: `postlight`, `none`
- remove_images (boolean) - Remove images from scraped content. Defaults to false.
- remove_class_names (string[]) - List of class names to remove from the content.
- parser (object) - When using `json` format, specify the parser for structured content extraction. Olostep includes built-in parsers for common web pages; custom parsers are also supported.
- llm_extract (object) - LLM-based extraction configuration.
- links_on_page (object) - Get all links present on the scraped page.
- screen_size (object) - Screen size configuration. Presets via screen_type: desktop (1920x1080), mobile (414x896), or default (768x1024).
- metadata (object) - User-defined metadata. Not supported yet.

```bash
orth api run olostep /v1/scrapes --body '{"url_to_scrape": "https://example.com/page"}'
```

**Retrieve a completed scrape:**

```bash
orth api run olostep /v1/scrapes/{scrape_id}
```

## Getting AI-Powered Answers

The agent submits a research question and Olostep's AI searches and browses the web to produce an answer. Execution time is 3-30 seconds depending on complexity.

**Endpoint:** `POST /v1/answers`

Parameters:
- task* (string) - The task or question to be answered.
- json_format (object) - Desired output JSON schema with empty values, or a string describing the data structure needed.

```bash
orth api run olostep /v1/answers --body '{"task": "What are the latest AI developments?"}'
```

**Retrieve a completed answer:**

```bash
orth api run olostep /v1/answers/{answer_id}
```

## Discovering URLs on a Website (Maps)

The agent retrieves all URLs on a given website. Processing can take up to 120 seconds for complex sites. Large result sets use cursor-based pagination.

**Endpoint:** `POST /v1/maps`

Parameters:
- url* (string) - The URL of the website to map.
- search_query (string) - Sort returned links by search relevance.
- top_n (number) - Limit to only the top N links for a search query.
- include_subdomain (boolean) - Include subdomains. `true` by default.
- include_urls (string[]) - URL path patterns to include using glob syntax (e.g., `/blog/**`). Only matching URLs are returned.
- exclude_urls (string[]) - URL path patterns to exclude using glob syntax (e.g., `/careers/**`). Exclusions supersede inclusions.
- cursor (string) - Pagination cursor from a previous response for fetching the next set of URLs.

```bash
orth api run olostep /v1/maps --body '{"url": "https://example.com"}'
```

## Crawling a Website

The agent starts an asynchronous crawl from a URL. The crawl returns an `id` for tracking progress. Processing takes 1-10 minutes depending on site size, depth, and page count.

**Endpoint:** `POST /v1/crawls`

Parameters:
- start_url* (string) - The starting point of the crawl.
- max_pages* (number) - Maximum number of pages to crawl.
- include_urls (string[]) - URL path patterns to include using glob syntax. Defaults to `/**` (all URLs). Examples: `/blog/**` for blog pages, `/products/*.html` for product pages.
- exclude_urls (string[]) - URL path patterns to exclude using glob syntax (e.g., `/careers/**`). Exclusions supersede inclusions.
- max_depth (number) - Maximum link depth to crawl.
- include_external (boolean) - Crawl first-degree external links.
- include_subdomain (boolean) - Include subdomains. `false` by default.
- search_query (string) - Find specific links and sort results by relevance.
- top_n (number) - Crawl only the top N most relevant links per page based on search query.
- webhook_url (string) - POST endpoint called when the crawl completes. The request body matches the `v1/crawls/{crawl_id}` response.
- timeout (number) - End the crawl after N seconds with pages completed so far. May take ~10s extra beyond the provided timeout.

```bash
orth api run olostep /v1/crawls --body '{
  "start_url": "https://example.com",
  "max_pages": 100
}'
```

**Check crawl status:**

```bash
orth api run olostep /v1/crawls/{crawl_id}
```

**List crawled pages:**

```bash
orth api run olostep /v1/crawls/{crawl_id}/pages
```

## Batch Processing Multiple URLs

The agent submits a list of URLs for parallel processing. Processing time is constant regardless of batch size.

**Endpoint:** `POST /v1/batches`

Parameters:
- items* (object[]) - Array of items to process. Each item contains a `url_to_scrape` field.
- country (string) - Country for batch execution in ISO 3166-1 alpha-2 codes (e.g., US, IN).
- parser (object) - Parser for structured content extraction. Built-in parsers are available for common web pages; custom parsers are also supported.
- links_on_page (object) - Get all links present on each page in the batch.

```bash
orth api run olostep /v1/batches --body '{
  "items": [
    {"url_to_scrape": "https://example.com/page1"},
    {"url_to_scrape": "https://example.com/page2"}
  ]
}'
```

**Check batch status:**

```bash
orth api run olostep /v1/batches/{batch_id}
```

**List processed batch items** (each item provides a `retrieve_id` for content retrieval):

```bash
orth api run olostep /v1/batches/{batch_id}/items
```

## Retrieving Page Content

After a scrape, crawl, or batch completes, the agent uses this endpoint to fetch the actual page content.

**Endpoint:** `POST /v1/retrieve`

Parameters:
- retrieve_id* (string) - The ID of the page content to retrieve. Available in responses from `/v1/crawls/{crawl_id}/pages`, `/v1/scrapes/{scrape_id}`, or `/v1/batches/{batch_id}/items`.
- formats (string[]) - Optional array to retrieve only specific formats. If not provided, all formats are returned.

```bash
orth api run olostep /v1/retrieve --body '{"retrieve_id": "abc123"}'
```

## Examples

### Research a topic with AI answers

The agent needs to answer a user question using live web data:

```bash
orth api run olostep /v1/answers --body '{
  "task": "What are the top 3 trending JavaScript frameworks in 2025?",
  "json_format": {"frameworks": [{"name": "", "description": "", "github_stars": ""}]}
}'
```

The response contains a structured JSON answer. If the agent needs to reference the answer later, it stores the `answer_id` and retrieves it with `GET /v1/answers/{answer_id}`.

### Crawl a documentation site and extract content

The agent needs to index all pages under a docs section:

```bash
# Step 1: Start the crawl scoped to /docs/
orth api run olostep /v1/crawls --body '{
  "start_url": "https://example.com/docs",
  "max_pages": 50,
  "include_urls": ["/docs/**"]
}'
# Response includes crawl_id, e.g. "crawl_abc123"

# Step 2: Poll until status is "completed"
orth api run olostep /v1/crawls/crawl_abc123

# Step 3: List crawled pages to get retrieve_ids
orth api run olostep /v1/crawls/crawl_abc123/pages

# Step 4: Retrieve content for each page
orth api run olostep /v1/retrieve --body '{"retrieve_id": "page_xyz", "formats": ["markdown"]}'
```

### Batch-scrape product pages with structured extraction

The agent has a list of product URLs and needs pricing data:

```bash
# Step 1: Submit the batch
orth api run olostep /v1/batches --body '{
  "items": [
    {"url_to_scrape": "https://store.example.com/product/1"},
    {"url_to_scrape": "https://store.example.com/product/2"},
    {"url_to_scrape": "https://store.example.com/product/3"}
  ],
  "parser": {"type": "custom", "schema": {"name": "", "price": "", "availability": ""}}
}'
# Response includes batch_id

# Step 2: Check batch status
orth api run olostep /v1/batches/{batch_id}

# Step 3: Get items with retrieve_ids
orth api run olostep /v1/batches/{batch_id}/items

# Step 4: Retrieve each item's content
orth api run olostep /v1/retrieve --body '{"retrieve_id": "item_001"}'
```

## Discover More

The agent can list all available endpoints and inspect parameter details:

```bash
orth api show olostep              # List all endpoints
orth api show olostep /v1/scrapes   # Get endpoint details
```
