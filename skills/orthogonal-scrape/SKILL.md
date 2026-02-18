---
name: scrape
description: Scrape websites, extract structured data, and automate browsers. Use when asked to scrape, extract, crawl, parse, or pull data from web pages or any URL.
---

# Scrape — General-Purpose Web Scraping & Data Extraction

Scrape websites, extract structured data, and automate browser interactions. Pick the best API for the task — or combine several for comprehensive extraction.

## 1. Scrapegraph — AI-Powered Scraping with Natural Language

Best for: Extracting data using plain English prompts, converting pages to markdown, crawling with AI extraction, and search-based scraping.

**AI-powered extraction** (describe what you want in natural language):
```bash
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://example.com/products",
  "user_prompt": "Extract all product names, prices, descriptions, and image URLs"
}'
```

**With output schema** (enforce structure):
```bash
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://example.com/products",
  "user_prompt": "Extract all products",
  "output_schema": {
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

**Search + scrape** (search the web and extract from results):
```bash
orth run scrapegraph /v1/searchscraper --body '{"user_prompt": "Find the latest iPhone prices from major retailers"}'
# Poll for results:
orth run scrapegraph /v1/searchscraper/{request_id}
```

**Convert page to markdown:**
```bash
orth run scrapegraph /v1/markdownify --body '{"website_url": "https://example.com/article"}'
```

**Crawl with AI extraction:**
```bash
orth run scrapegraph /v1/crawl --body '{
  "url": "https://docs.example.com",
  "prompt": "Extract all API endpoints and their descriptions",
  "max_pages": 20
}'
# Poll for results:
orth run scrapegraph /v1/crawl/{task_id}
```

**Raw HTML scrape:**
```bash
orth run scrapegraph /v1/scrape --body '{"website_url": "https://example.com"}'
```

**Get sitemap:**
```bash
orth run scrapegraph /v1/sitemap --body '{"website_url": "https://example.com"}'
```

Key parameters: `stealth` (bypass bot protection, +4 credits), `total_pages` (paginate up to 100), `number_of_scrolls` (infinite scroll pages), `render_heavy_js` (React/Vue/Angular SPAs), `steps` (interaction steps before extraction).

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

- **Simple page scrape**: Start with Olostep for raw content or Scrapegraph SmartScraper for AI-extracted data
- **Natural language extraction**: Scrapegraph is the go-to — describe what you want in English, optionally pass an `output_schema`
- **Structured/schema-based extraction**: Riveter lets you define exact fields and formats for consistent output
- **Brand assets & logos**: Brand.dev for logos, colors, fonts, design systems, and screenshots
- **Bot protection**: Use Scrapegraph's `stealth: true` or Notte's `proxies: true` + `solve_captchas: true`
- **JavaScript-heavy SPAs**: Use Scrapegraph's `render_heavy_js: true` or Notte browser sessions
- **Batch/bulk scraping**: Olostep batches for processing many URLs at once with constant processing time
- **Async crawls**: Olostep and Scrapegraph crawls are async — start with POST, poll for results
- **Page interactions**: Use Scrapegraph `steps` for simple interactions before extraction, or Notte sessions for complex multi-step flows
- **Pagination**: Scrapegraph's `total_pages` (up to 100) handles multi-page extraction automatically
- **Convert to markdown**: Scrapegraph `/v1/markdownify` for clean markdown from any page
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

Example: `orth api show scrapegraph /v1/smartscraper` for full parameter details.
