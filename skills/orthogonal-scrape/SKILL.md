---
name: scrape
description: Scrape websites, extract structured data, and automate browsers. Use when asked to scrape, extract, crawl, parse, or pull data from web pages or any URL.
---

# Scrape — General-Purpose Web Scraping & Data Extraction

Scrape websites, extract structured data, and automate browser interactions. Pick the best API for the task — or combine several for comprehensive extraction.

## 1. Scrapegraph — AI-Powered Scraping with Natural Language

ScrapeGraphAI **v2 API** (base `https://v2-api.scrapegraphai.com`, paths under `/api`). Services: **Scrape**, **Extract**, **Search**, **Crawl**, **Monitor**, **Schema**, **History**.

Best for: fetching pages in any format (markdown/HTML/JSON/screenshot/branding), AI structured extraction from a URL or raw HTML/markdown, AI web search, and async multi-page crawling.

**Scrape a page** (request one or more `formats`):
```bash
orth run scrapegraph /api/scrape --body '{
  "url": "https://example.com/article",
  "formats": [{"type": "markdown"}, {"type": "links"}]
}'
```

**Scrape with AI extraction** (use the `json` format with a prompt + schema):
```bash
orth run scrapegraph /api/scrape --body '{
  "url": "https://example.com/products",
  "formats": [{
    "type": "json",
    "prompt": "Extract all products",
    "schema": {
      "type": "object",
      "properties": {
        "products": {
          "type": "array",
          "items": {
            "type": "object",
            "properties": {
              "name": {"type": "string"},
              "price": {"type": "number"},
              "description": {"type": "string"}
            }
          }
        }
      }
    }
  }]
}'
```
Format types: `markdown`, `html`, `links`, `images`, `summary`, `json` (opts: `prompt`, `schema`), `branding`, `screenshot` (opts: `fullPage`, `width`, `height`, `quality`). `markdown`/`html` take a `mode` of `normal`/`reader`/`prune`.

**AI extraction** (from a URL, or raw `html`/`markdown` you already have):
```bash
orth run scrapegraph /api/extract --body '{
  "url": "https://example.com/products",
  "prompt": "Extract all product names, prices, descriptions, and image URLs",
  "schema": {
    "type": "object",
    "properties": {
      "products": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "name": {"type": "string"},
            "price": {"type": "number"},
            "description": {"type": "string"}
          }
        }
      }
    }
  }
}'
```
Provide exactly one of `url`, `html` (≤2 MB), or `markdown` (≤2 MB). `mode` controls HTML preprocessing (`normal`/`reader`/`prune`).

**Search + extract** (search the web and extract structured data from results):
```bash
orth run scrapegraph /api/search --body '{
  "query": "latest iPhone prices from major retailers",
  "numResults": 5,
  "prompt": "Extract model name and price"
}'
```
`numResults` 1–20 (default 3), optional `schema` (needs `prompt`), `timeRange` (`past_hour`/`past_24_hours`/`past_week`/`past_month`/`past_year`), `locationGeoCode` (ISO country code).

**Crawl with AI extraction** (async):
```bash
# Step 1: Start crawl
orth run scrapegraph /api/crawl --body '{
  "url": "https://docs.example.com",
  "formats": [{"type": "json", "prompt": "Extract all API endpoints and their descriptions"}],
  "maxPages": 20,
  "maxDepth": 3,
  "includePatterns": ["/docs/**"]
}'
# Step 2: Poll status
orth run scrapegraph /api/crawl/{id}
# Step 3: Get page content
orth run scrapegraph /api/crawl/{id}/pages
```
Other crawl params: `maxLinksPerPage`, `excludePatterns`.

**Monitor a page for changes** (cron-scheduled, fires a webhook):
```bash
orth run scrapegraph /api/monitor --body '{
  "url": "https://example.com/pricing",
  "name": "Pricing watcher",
  "interval": "*/10 * * * *",
  "formats": [{"type": "markdown"}],
  "webhookUrl": "https://your-app.com/hooks/sgai"
}'
```

**`fetchConfig`** (optional on scrape/extract/search/crawl/monitor): `mode` (`auto`/`fast`/`js`), `stealth` (residential proxy + anti-detection), `headers`, `cookies`, `scrolls` (0–100, infinite scroll), `wait` (ms, 0–30000), `timeout` (ms, 1000–60000), `country` (ISO code). Use `mode: "js"` for React/Vue/Angular SPAs and `stealth: true` to bypass bot protection.

## 2. Olostep — Scalable Scraping & Batch Jobs

Best for: High-volume scraping, batch processing, site crawling, URL discovery, and AI-powered answers from pages.

**Scrape a single page:**
```bash
orth run olostep /v1/scrapes --body '{"url_to_scrape": "https://example.com/page"}'
```

**AI-powered answer from the web:**
```bash
orth run olostep /v1/answers --body '{"task": "What is the pricing for Stripe?"}'
```

**Discover all URLs on a site:**
```bash
orth run olostep /v1/maps --body '{"url": "https://example.com", "search_query": "pricing"}'
```

**Crawl a site** (async):
```bash
# Step 1: Start crawl
orth run olostep /v1/crawls --body '{
  "start_url": "https://docs.example.com",
  "max_pages": 100,
  "include_urls": ["/docs/**"]
}'
# Step 2: Check status
orth run olostep /v1/crawls/{crawl_id}
# Step 3: Get pages
orth run olostep /v1/crawls/{crawl_id}/pages
# Step 4: Retrieve content
orth run olostep /v1/retrieve --body '{"retrieve_id": "RETRIEVE_ID"}'
```

**Batch scrape** (process many URLs at once):
```bash
orth run olostep /v1/batches --body '{
  "items": [
    {"url_to_scrape": "https://example.com/page1"},
    {"url_to_scrape": "https://example.com/page2"},
    {"url_to_scrape": "https://example.com/page3"}
  ]
}'
# Check status:
orth run olostep /v1/batches/{batch_id}
# Get items:
orth run olostep /v1/batches/{batch_id}/items
```

Key parameters: `formats` (markdown/html/text), `country` (US, CA, IT, IN, GB, JP, etc.), `actions` (page interactions before scraping), `wait_before_scraping`, `remove_css_selectors`, `llm_extract`.

## 3. Riveter — Structured Extraction with Defined Schemas

Best for: Extracting data into a consistent, predefined structure. Define input URLs and output fields with prompts.

**Simple page scrape:**
```bash
orth run riveter /v1/scrape --body '{"url": "https://example.com/article"}'
```

**Structured extraction** (define your output schema):
```bash
orth run riveter /v1/run --body '{
  "input": {
    "urls": ["https://example.com/products"]
  },
  "output": {
    "name": {"prompt": "Product name", "contexts": ["urls"]},
    "price": {"prompt": "Product price", "contexts": ["urls"], "format": "number"},
    "description": {"prompt": "Product description", "contexts": ["urls"]}
  }
}'
# Check status:
orth run riveter /v1/run_status --query 'run_key=RUN_KEY'
# Get data:
orth run riveter /v1/run_data --query 'run_key=RUN_KEY'
```

**Multi-URL extraction with tools:**
```bash
orth run riveter /v1/run --body '{
  "input": {
    "company_urls": ["https://stripe.com", "https://vercel.com"]
  },
  "output": {
    "company_name": {"prompt": "Company name", "contexts": ["company_urls"]},
    "pricing_url": {"prompt": "URL to pricing page", "contexts": ["company_urls"], "format": "url"},
    "pricing_details": {"prompt": "Pricing tiers and costs", "contexts": ["pricing_url"], "tools": ["web_scrape"]}
  }
}'
```

Key parameters: Output `format` options (number/json/url/text/email/tag/date/boolean), `tools` (web_search/web_scrape/query_pdf/query_image), `max_tool_calls` (0-10), `run_when` (always/any_filled/all_filled).

## 4. Brand.dev — Brand Assets, Logos & Company Data

Best for: Extracting brand logos, colors, fonts, design systems, screenshots, and AI-powered data extraction from company websites.

**Get full brand data:**
```bash
orth run brand-dev /v1/brand/retrieve --query 'domain=stripe.com'
```

**By company name / email / ticker:**
```bash
orth run brand-dev /v1/brand/retrieve-by-name --query 'name=Stripe'
orth run brand-dev /v1/brand/retrieve-by-email --query 'email=john@stripe.com'
orth run brand-dev /v1/brand/retrieve-by-ticker --query 'ticker=AAPL'
```

**Extract design system / styleguide:**
```bash
orth run brand-dev /v1/brand/styleguide --query 'domain=linear.app'
```

**Extract fonts:**
```bash
orth run brand-dev /v1/brand/fonts --query 'domain=vercel.com'
```

**Take website screenshot:**
```bash
orth run brand-dev /v1/brand/screenshot --query 'domain=github.com&fullScreenshot=true'
```

**AI-powered data extraction:**
```bash
orth run brand-dev /v1/brand/ai/query --body '{
  "domain": "anthropic.com",
  "data_to_extract": [{"name": "products", "description": "What products does this company offer?"}]
}'
```

**Extract products:**
```bash
orth run brand-dev /v1/brand/ai/products --body '{"domain": "stripe.com"}'
```

## 5. Notte — Browser Automation & Page Interaction

Best for: Scraping pages that require browser interaction, CAPTCHAs, login flows, or complex JavaScript rendering. Also supports autonomous AI agents for multi-step browser tasks.

**Quick scrape** (no session needed):
```bash
orth run notte /scrape --body '{"url": "https://example.com"}'
```

**Session-based scraping** (for complex interactions):
```bash
# Step 1: Start a browser session
orth run notte /sessions/start --body '{"url": "https://example.com", "proxies": true, "solve_captchas": true}'

# Step 2: Observe available actions
orth run notte /sessions/{session_id}/page/observe --body '{"instruction": "Find the search box"}'

# Step 3: Execute actions
orth run notte /sessions/{session_id}/page/execute --body '{"instruction": "Click the search button"}'

# Step 4: Scrape the page
orth run notte /sessions/{session_id}/page/scrape --body '{"only_main_content": true}'

# Step 5: Stop session
orth run notte /sessions/{session_id}/stop
```

**AI agent** (autonomous multi-step browser task):
```bash
orth run notte /agents/start --body '{
  "task": "Go to Google, search for AI news, and summarize the top 5 results",
  "url": "https://google.com",
  "max_steps": 20
}'
# Check status:
orth run notte /agents/{agent_id}
```

**Take screenshot:**
```bash
orth run notte /sessions/{session_id}/page/screenshot --body '{"full_page": true}'
```

Key parameters: `proxies` (rotate proxies), `solve_captchas` (auto-solve), `headless` (default true), `browser_type` (chromium/chrome/firefox), `viewport_width`/`viewport_height`.

## Tips

- **Simple page scrape**: Start with Olostep for raw content or Scrapegraph `/api/scrape` (`markdown` format) for clean content
- **Natural language extraction**: Scrapegraph is the go-to — `/api/extract` (from a URL or raw HTML/markdown) or the `json` format on `/api/scrape`; describe what you want in English, optionally pass a `schema`
- **Structured/schema-based extraction**: Riveter lets you define exact fields and formats; Scrapegraph's `schema` enforces output shape for one-shot extraction
- **Brand assets & logos**: Brand.dev for logos, colors, fonts, design systems, and screenshots — or Scrapegraph's `branding`/`screenshot` formats
- **Bot protection**: Use Scrapegraph's `fetchConfig.stealth: true` or Notte's `proxies: true` + `solve_captchas: true`
- **JavaScript-heavy SPAs**: Use Scrapegraph's `fetchConfig.mode: "js"` or Notte browser sessions
- **Batch/bulk scraping**: Olostep batches for processing many URLs at once with constant processing time
- **Async crawls**: Olostep and Scrapegraph crawls are async — start with POST, poll for results (`GET /api/crawl/{id}`, then `/pages`)
- **Infinite scroll / waits**: Scrapegraph `fetchConfig.scrolls` (0–100) and `fetchConfig.wait` (ms) for lazy-loaded content, or Notte sessions for complex multi-step flows
- **Change monitoring**: Scrapegraph `/api/monitor` runs cron-scheduled scrapes and fires a webhook on each run
- **Convert to markdown**: Scrapegraph `/api/scrape` with `formats: [{"type": "markdown"}]` for clean markdown from any page
- **Combine APIs**: For maximum data, use Scrapegraph for AI extraction + Riveter for structured validation + Olostep for raw content

## Discover More

List all endpoints for any API, or add a path for parameter details:

```bash
orth api show scrapegraph
orth api show olostep
orth api show riveter
orth api show brand-dev
orth api show notte
```

Example: `orth api show scrapegraph /api/scrape` for full parameter details.
