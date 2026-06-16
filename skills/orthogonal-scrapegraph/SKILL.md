---
name: scrapegraph
description: “Use when the user needs to extract data from websites using natural language prompts, scrape raw HTML, crawl multi-page sites, convert pages to markdown, discover sitemap URLs, or search the web with AI-powered extraction. ScrapeGraph handles JavaScript-heavy SPAs, bot-protected pages (stealth mode), pagination, and infinite scroll without writing CSS selectors or XPath.”
---

# ScrapeGraph AI

ScrapeGraph provides six action endpoints and five free status-check endpoints. The agent should select the endpoint that matches the task — single-page extraction, multi-page crawling, raw HTML retrieval, web search, sitemap discovery, or markdown conversion — then poll the corresponding status endpoint for results.

## Workflow

1. **Identify the task type.** Determine which category the user request falls into:
   - Extract structured data from a known URL → SmartScraper (`/v1/smartscraper`)
   - Search the web and extract answers without a specific URL → SearchScraper (`/v1/searchscraper`)
   - Retrieve raw HTML (with optional JS rendering) → Scrape (`/v1/scrape`)
   - Crawl multiple pages from a site with AI extraction → SmartCrawler (`/v1/crawl`)
   - List all URLs on a site → Sitemap (`/v1/sitemap`)
   - Convert a page to clean markdown → Markdownify (`/v1/markdownify`)
2. **Build the request body.** Include required parameters (marked with `*`) and any optional parameters relevant to the task. If the target site is JavaScript-heavy or bot-protected, the agent should set `render_heavy_js` and/or `stealth` as needed.
3. **Submit the request.** Call the appropriate action endpoint via `orth api run scrapegraph <path> --body ‘<json>’`.
4. **Poll for results.** For async endpoints (SmartScraper, SearchScraper, SmartCrawler, Sitemap, Markdownify), capture the `request_id` or `task_id` from the response, then call the matching status endpoint until the status is complete. Status checks are free.
5. **Return results to the user.** Parse the response and present the extracted data, HTML, markdown, or URL list as appropriate.

## Extracting Structured Data from a URL

**Endpoint:** `/v1/smartscraper` (POST)

The agent uses SmartScraper when the user provides a URL and wants specific data extracted using a natural language prompt. Supports pagination, infinite scroll, page interaction steps, and structured output schemas.

**Required parameters:**
- `user_prompt` (string) — natural language description of what to extract
- One of `website_url` (string), `website_html` (string, max 2MB), or `website_markdown` (string, max 2MB) — mutually exclusive content sources

**Optional parameters:**
- `headers` (object) — custom HTTP headers (User-Agent, cookies, auth tokens)
- `cookies` (object) — cookies for authentication/session management
- `output_schema` (object) — JSON schema to structure output
- `stealth` (boolean) — bypass bot protection (+4 credits). Default: false
- `total_pages` (number) — paginate across multiple pages. Range: 1–100. Default: 1
- `number_of_scrolls` (number) — scroll to load dynamic content. Range: 0–50. Default: 0
- `render_heavy_js` (boolean) — enhanced JS rendering for SPAs (React, Vue, Angular). Default: false
- `steps` (array of strings) — interaction steps before extraction (e.g., `[“click on filter button”, “wait for results”]`)
- `mock` (boolean) — return mock data for testing. Default: false

**Status check:** `GET /v1/smartscraper/{request_id}` (free)

```bash
orth api run scrapegraph /v1/smartscraper --body ‘{
  “website_url”: “https://example.com/products”,
  “user_prompt”: “Extract all product names and prices”
}’
# Poll for results:
orth api run scrapegraph /v1/smartscraper/{request_id}
```

## Searching the Web with AI

**Endpoint:** `/v1/searchscraper` (POST)

The agent uses SearchScraper when the user wants to find and extract information from the web without specifying a particular URL. The AI searches, finds relevant sources, and extracts structured answers.

**Required parameters:**
- `user_prompt` (string) — the search query or question to answer

**Optional parameters:**
- `headers` (object) — custom HTTP headers
- `output_schema` (object) — JSON schema to structure output
- `stealth` (boolean) — anti-detection techniques (+4 credits). Default: false
- `mock` (string) — return mock data for testing. Default: false

**Status check:** `GET /v1/searchscraper/{request_id}` (free)

```bash
orth api run scrapegraph /v1/searchscraper --body ‘{
  “user_prompt”: “Find the latest iPhone prices from major retailers”
}’
# Poll for results:
orth api run scrapegraph /v1/searchscraper/{request_id}
```

## Retrieving Raw HTML

**Endpoint:** `/v1/scrape` (POST)

The agent uses Scrape when raw HTML is needed rather than AI-extracted data — useful for downstream processing, caching, or brand metadata extraction.

**Required parameters:**
- `website_url` (string) — the URL to scrape

**Optional parameters:**
- `render_heavy_js` (boolean) — enable heavy JS rendering for SPAs. Default: false
- `branding` (boolean) — return extracted brand design and metadata. Default: false
- `stealth` (string) — anti-bot protection (+additional credits). Default: false

```bash
orth api run scrapegraph /v1/scrape --body ‘{“website_url”: “https://example.com”}’
```

## Crawling Multiple Pages

**Endpoint:** `/v1/crawl` (POST)

The agent uses SmartCrawler to traverse a website and extract data or convert pages to markdown across multiple pages and depth levels. Ideal for documentation sites, knowledge bases, or any multi-page extraction.

**Required parameters:**
- `url` (string) — the starting URL for the crawl

**Optional parameters:**
- `prompt` (string) — natural language extraction instructions
- `extraction_mode` (boolean) — enable AI-based extraction
- `depth` (number) — how many link levels deep to crawl
- `max_pages` (number) — maximum pages to process
- `same_domain_only` (boolean) — restrict crawl to the same domain
- `batch_size` (integer) — number of pages to process per batch
- `schema` (object) — JSON schema for structured output
- `rules` (object) — crawling rules and filters
- `sitemap` (string) — provide a sitemap URL to guide crawling
- `cache_website` (boolean) — cache pages during the crawl
- `render_heavy_js` (string) — enhanced JS rendering
- `stealth` (string) — anti-bot protection

**Status check:** `GET /v1/crawl/{task_id}` (free)

```bash
orth api run scrapegraph /v1/crawl --body ‘{
  “url”: “https://docs.example.com”,
  “prompt”: “Extract all API endpoints and their descriptions”,
  “depth”: 2,
  “same_domain_only”: true
}’
# Poll for results:
orth api run scrapegraph /v1/crawl/{task_id}
```

## Discovering Sitemap URLs

**Endpoint:** `/v1/sitemap` (POST)

The agent uses Sitemap to extract all URLs from a website’s sitemap. The API automatically locates the sitemap.xml file. Useful for auditing site structure or planning a targeted crawl.

**Required parameters:**
- `website_url` (string) — the website to extract the sitemap from

**Optional parameters:**
- `headers` (object) — custom HTTP headers
- `stealth` (boolean) — anti-bot protection (+4 credits)
- `mock` (boolean) — return mock data for testing

**Status check:** `GET /v1/sitemap/{request_id}` (free)

```bash
orth api run scrapegraph /v1/sitemap --body ‘{“website_url”: “https://example.com”}’
# Poll for results:
orth api run scrapegraph /v1/sitemap/{request_id}
```

## Converting Pages to Markdown

**Endpoint:** `/v1/markdownify` (POST)

The agent uses Markdownify to convert any webpage into clean, readable markdown. Ideal for feeding web content into LLMs, storing documentation, or creating readable archives.

**Required parameters:**
- `website_url` (string) — the URL to convert

**Optional parameters:**
- `headers` (object) — custom HTTP headers (cookies, user agent)
- `stealth` (boolean) — bypass bot protection (+4 credits)

**Status check:** `GET /v1/markdownify/{request_id}` (free)

```bash
orth api run scrapegraph /v1/markdownify --body ‘{“website_url”: “https://example.com/article”}’
# Poll for results:
orth api run scrapegraph /v1/markdownify/{request_id}
```

## Examples

### Example 1: Extract product data with a structured schema

The user asks: “Get me all product names, prices, and ratings from this store page.”

```bash
orth api run scrapegraph /v1/smartscraper --body ‘{
  “website_url”: “https://store.example.com/electronics”,
  “user_prompt”: “Extract every product with its name, price, and star rating”,
  “output_schema”: {
    “properties”: {
      “products”: {
        “type”: “array”,
        “items”: {
          “type”: “object”,
          “properties”: {
            “name”: {“type”: “string”},
            “price”: {“type”: “string”},
            “rating”: {“type”: “number”}
          }
        }
      }
    }
  }
}’
```

The agent then polls `/v1/smartscraper/{request_id}` until the response contains the structured product list.

### Example 2: Research a topic without a specific URL

The user asks: “What are the current mortgage rates from the top 5 US lenders?”

```bash
orth api run scrapegraph /v1/searchscraper --body ‘{
  “user_prompt”: “What are the current 30-year fixed mortgage rates from the top 5 US lenders?”,
  “output_schema”: {
    “properties”: {
      “lenders”: {
        “type”: “array”,
        “items”: {
          “type”: “object”,
          “properties”: {
            “name”: {“type”: “string”},
            “rate”: {“type”: “string”}
          }
        }
      }
    }
  }
}’
```

The agent polls `/v1/searchscraper/{request_id}` and returns the comparison table to the user.

### Example 3: Crawl documentation and convert to markdown

The user asks: “Download the entire API docs from this site as markdown for our knowledge base.”

```bash
# Step 1: Discover all pages via sitemap
orth api run scrapegraph /v1/sitemap --body ‘{“website_url”: “https://docs.example.com”}’
# Step 2: Crawl with markdown conversion
orth api run scrapegraph /v1/crawl --body ‘{
  “url”: “https://docs.example.com”,
  “prompt”: “Convert each page to clean markdown preserving code blocks and headings”,
  “depth”: 3,
  “same_domain_only”: true,
  “max_pages”: 50
}’
# Step 3: Poll for results
orth api run scrapegraph /v1/crawl/{task_id}
```

## Discover More

The agent can inspect all available endpoints and their full parameter details:

```bash
orth api show scrapegraph              # List all endpoints
orth api show scrapegraph /v1/smartscraper   # Get endpoint details
```
