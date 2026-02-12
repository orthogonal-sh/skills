---
name: orthogonal
version: 1.0.0
description: Orthogonal API Platform - Access premium APIs using the SDK, Run API, or x402 direct payment. Browse available APIs and integrate them into your applications.
homepage: https://orthogonal.com
---

# Orthogonal Platform

Orthogonal is a platform for monetizing and consuming APIs. You can call any API on the platform using three methods:

1. **SDK** - Simplest integration with `@orth/sdk`
2. **Run API** - Direct HTTP calls to `api.orth.sh/v1/run`
3. **x402 Payment** - Direct USDC payment on Base blockchain

## Quick Start

### Option 1: SDK (Recommended)

```bash
npm install @orth/sdk
export ORTHOGONAL_API_KEY=orth_live_your_api_key
```

Get your API key at https://orthogonal.com/dashboard/settings

```javascript
import Orthogonal from "@orth/sdk";

const orthogonal = new Orthogonal({
  apiKey: process.env.ORTHOGONAL_API_KEY,
});

const result = await orthogonal.run({
  api: "api-slug",        // e.g., "olostep", "scrapegraph"
  path: "/endpoint/path", // e.g., "/v1/scrape"
  query: { /* query params */ },
  body: { /* body params */ }
});

console.log(result);
```

### Option 2: Run API (Direct HTTP)

```bash
curl -X POST 'https://api.orth.sh/v1/run' \
  -H 'Authorization: Bearer $ORTHOGONAL_API_KEY' \
  -H 'Content-Type: application/json' \
  -d '{"api": "api-slug", "path": "/endpoint/path", "query": {}, "body": {}}'
```

Python:
```python
import os
import requests

response = requests.post(
    'https://api.orth.sh/v1/run',
    json={
        'api': 'api-slug',
        'path': '/endpoint/path',
        'query': {},
        'body': {}
    },
    headers={
        'Authorization': f'Bearer {os.getenv("ORTHOGONAL_API_KEY")}',
        'Content-Type': 'application/json'
    }
)
print(response.json())
```

### Option 3: x402 Direct Payment

Pay directly with USDC on Base blockchain - no API key required, just a wallet.

```bash
npm install x402-fetch viem
export PRIVATE_KEY=0x...your_wallet_private_key
```

```javascript
import { wrapFetchWithPayment } from "x402-fetch";
import { privateKeyToAccount } from "viem/accounts";

const account = privateKeyToAccount(process.env.PRIVATE_KEY);
const fetchWithPayment = wrapFetchWithPayment(fetch, account);

const response = await fetchWithPayment(
  "https://x402.orth.sh/api-slug/endpoint-path",
  {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ /* body params */ })
  }
);

const data = await response.json();
```

Python:
```python
import os
from eth_account import Account
from x402.clients.requests import x402_http_adapter
import requests

account = Account.from_key(os.getenv("PRIVATE_KEY"))
session = requests.Session()
session.mount("https://", x402_http_adapter(account))

response = session.post("https://x402.orth.sh/api-slug/endpoint-path", json={})
print(response.json())
```

**How x402 works:**
1. Make request to `https://x402.orth.sh/{api-slug}/{endpoint-path}`
2. Server returns 402 Payment Required with payment details in `accepts` array
3. SDK signs USDC payment (EIP-3009 transferWithAuthorization)
4. Request retried with `X-PAYMENT` header containing signed payment
5. Payment verified, API response returned

## Response Format

SDK/Run API response:
```json
{
  "success": true,
  "price": "0.01",
  "data": { /* API response */ }
}
```

## Available APIs

### Olostep API ✓
- **Slug**: `olostep`
- **Description**: Olostep offers AI a way to search the web, extract structured data in real time and build custom research agents.
- **Target API**: https://api.olostep.com
- **Endpoints**:
  - `POST /v1/scrapes` - $0.01 - Initiate a web page scrape
    - Body: `url_to_scrape` (required), `wait_before_scraping`, `formats`, `remove_css_selectors`, `actions`, `country`, `transformer`, `remove_images`, `remove_class_names`, `parser`, `llm_extract`, `links_on_page`, `screen_size`, `metadata`
    - Docs: https://docs.olostep.com/api-reference/scrapes/create
  - `POST /v1/answers` - $0.05 - The AI will perform actions like searching and browsing web pages to find the answer to the provided task. Execution time is 3-30s depending upon complexity. For longer tasks, use the agent endpoint instead.
    - Body: `task` (required), `json_format`
    - Docs: https://docs.olostep.com/api-reference/answers/create
  - `POST /v1/maps` - $0.01 - This endpoint allows users to get all the urls on a certain website. It can take up to 120 seconds for complex websites. For large websites, results are paginated using cursor-based pagination
    - Body: `url` (required), `search_query`, `top_n`, `include_subdomain`, `include_urls`, `exclude_urls`, `cursor`
    - Docs: https://docs.olostep.com/api-reference/maps/create
  - `POST /v1/crawls` - Dynamic pricing - Starts a new crawl. You receive a `id` to track the progress. The operation may take 1-10 mins depending upon the site and depth and pages parameters.
    - Body: `start_url` (required), `max_pages` (required), `include_urls`, `exclude_urls`, `max_depth`, `include_external`, `include_subdomain`, `search_query`, `top_n`, `webhook_url`, `timeout`
    - Docs: https://docs.olostep.com/api-reference/crawls/create
  - `POST /v1/batches` - Dynamic pricing - Starts a new batch. You receive an `id` that you can use to track the progress of the batch as shown [here](/api-reference/batches/info). Note: Processing time is constant regardless of batch size
    - Body: `items` (required), `country`, `parser`, `links_on_page`
    - Docs: https://docs.olostep.com/api-reference/batches/create
  - `GET /v1/batches/{batch_id}/items` - Free - Retrieves the list of items processed for a batch. You can then use the `retrieve_id` to get the content with the Retrieve Endpoint
    - Docs: https://docs.olostep.com/api-reference/batches/items
  - `GET /v1/crawls/{crawl_id}` - Free - Fetches information about a specific crawl.
    - Docs: https://docs.olostep.com/api-reference/crawls/info
  - `GET /v1/crawls/{crawl_id}/pages` - Free - Fetches the list of pages for a specific crawl.
    - Docs: https://docs.olostep.com/api-reference/crawls/pages
  - `GET /v1/answers/{answer_id}` - Free - This endpoint retrieves a previously completed answer by its ID.
    - Docs: https://docs.olostep.com/api-reference/answers/get
  - `GET /v1/scrapes/{scrape_id}` - Free - Can be used to retrieve response for a scrape.
    - Docs: https://docs.olostep.com/api-reference/scrapes/get
  - `GET /v1/batches/{batch_id}` - Free - Retrieves the status and progress information about a batch. To retrieve the content for a batch, see here
    - Docs: https://docs.olostep.com/api-reference/batches/info
  - `GET /v1/retrieve` - Free - Retrieve page content of processed batches and crawls urls.
    - Body: `retrieve_id` (required), `formats`
    - Docs: https://docs.olostep.com/api-reference/retrieve

### Scrapegraphai API ✓
- **Slug**: `scrapegraph`
- **Description**: The ScrapeGraphAI API provides powerful endpoints for AI-powered web scraping and content extraction. Our RESTful API allows you to extract structured data from any website, perform AI-powered web searches, and convert web pages to clean markdown.
- **Target API**: https://api.scrapegraphai.com
- **Endpoints**:
  - `POST /v1/smartscraper` - Dynamic pricing - Extract content from a webpage using AI by providing a natural language prompt and a URL.
    - Body: `user_prompt` (required), `website_url` (required), `website_html`, `headers`, `output_schema`, `stealth`, ` website_markdown`, `total_pages`, ` number_of_scrolls`, ` render_heavy_js`, ` mock`, ` cookies`, ` steps`
    - Docs: https://docs.scrapegraphai.com/api-reference/endpoint/smartscraper/start
  - `POST /v1/searchscraper` - Dynamic pricing - Start a new AI-powered web search request
    - Body: `user_prompt` (required), `headers`, `output_schema`, `mock`, `stealth`
    - Docs: https://docs.scrapegraphai.com/api-reference/endpoint/searchscraper/start
  - `POST /v1/scrape` - Dynamic pricing - Extract raw HTML content from web pages with JavaScript rendering support
    - Body: `website_url` (required), `render_heavy_js`, `branding`, `stealth`
    - Docs: https://docs.scrapegraphai.com/services/scrape#example-response-with-branding-true
  - `POST /v1/crawl` - Dynamic pricing - Start a new web crawl request with AI extraction or markdown conversion
    - Body: `url` (required), `prompt`, `extraction_mode`, `cache_website`, `depth`, `max_pages`, `same_domain_only`, `batch_size`, `schema`, `rules`, `sitemap`, `render_heavy_js`, `stealth`
    - Docs: https://docs.scrapegraphai.com/api-reference/endpoint/smartcrawler/start
  - `POST /v1/sitemap` - Dynamic pricing - Extract all URLs from a website sitemap automatically.
    - Body: `website_url` (required), `headers`, `mock`, `stealth`
    - Docs: https://docs.scrapegraphai.com/api-reference/introduction
  - `POST /v1/markdownify` - Dynamic pricing - Convert any webpage into clean, readable Markdown format.
    - Body: `website_url` (required), `headers`, `stealth`
    - Docs: https://docs.scrapegraphai.com/api-reference/endpoint/markdownify/start
  - `GET /v1/searchscraper/{request_id}` - Free - Get the status and results of a previous search request
    - Docs: https://docs.scrapegraphai.com/api-reference/endpoint/searchscraper/get-status
  - `GET /v1/markdownify/{request_id}` - Free - Check the status and retrieve results of a Markdownify request.
    - Docs: https://docs.scrapegraphai.com/api-reference/endpoint/markdownify/get-status
  - `GET /v1/sitemap/{request_id}` - Free - Check the status and retrieve results of a Sitemap request.
    - Docs: https://docs.scrapegraphai.com/api-reference/endpoint/sitemap/get-status
  - `GET /v1/crawl/{task_id}` - Free - Get the status and results of a previous smartcrawl request
    - Docs: https://docs.scrapegraphai.com/api-reference/endpoint/smartcrawler/get-status
  - `GET /v1/smartscraper/{request_id}` - Free - Check the status and retrieve results of a SmartScraper request.
    - Docs: https://docs.scrapegraphai.com/api-reference/endpoint/smartscraper/get-status

### Tavily API
- **Slug**: `tavily`
- **Description**: Real-time search, extraction, and web crawling through a single, secure API.
- **Target API**: https://api.tavily.com
- **Endpoints**:
  - `POST /search` - $0.016 - Execute a search query using Tavily Search.
    - Body: `query` (required), `search_depth`, `chunks_per_source`, `max_results`, `topic`, `time_range`, `start_date`, `end_date`, `include_answer`, `include_raw_content`, `include_images`, `include_image_descriptions`, `include_favicon`, `include_domains`, `exclude_domains`, `country`, `auto_parameters`
    - Docs: https://docs.tavily.com/documentation/api-reference/endpoint/search
  - `GET /research/{request_id}` - Free - Retrieve the status and results of a research task using its request ID.
    - Docs: https://docs.tavily.com/documentation/api-reference/endpoint/research-get
  - `POST /research` - $0.5 - Tavily Research performs comprehensive research on a given topic by conducting multiple searches, analyzing sources, and generating a detailed research report.
    - Body: `input` (required), `model`, `stream`, `output_schema`, `citation_format`
    - Docs: https://docs.tavily.com/documentation/api-reference/endpoint/research
  - `POST /extract` - Dynamic pricing - Extract web page content from one or more specified URLs using Tavily Extract.
    - Body: `urls` (required), `query`, `chunks_per_source`, `extract_depth`, `include_images`, `include_favicon`, `format`, `timeout`
    - Docs: https://docs.tavily.com/documentation/api-reference/endpoint/extract
  - `POST /map` - Dynamic pricing - Tavily Map traverses websites like a graph and can explore hundreds of paths in parallel with intelligent discovery to generate comprehensive site maps.
    - Body: `url` (required), `instructions`, `max_depth`, `max_breadth`, `limit`, `select_paths`, `select_domains`, `exclude_paths`, `exclude_domains`, `allow_external`, `timeout`
    - Docs: https://docs.tavily.com/documentation/api-reference/endpoint/map
  - `POST /crawl` - Dynamic pricing - Tavily Crawl is a graph-based website traversal tool that can explore hundreds of paths in parallel with built-in extraction and intelligent discovery.
    - Body: `url` (required), `instructions`, `chunks_per_source`, `max_depth`, `max_breadth`, `limit`, `select_paths`, `select_domains`, `exclude_paths`, `exclude_domains`, `allow_external`, `include_images`, `extract_depth`, `format`, `include_favicon`, `timeout`
    - Docs: https://docs.tavily.com/documentation/api-reference/endpoint/crawl

### Fiber AI API ✓
- **Slug**: `fiber`
- **Description**: Reach anyone on the planet with verified contacts. Fiber AI delivers the most accurate contact data, period.
- **Target API**: https://api.fiber.ai
- **Endpoints**:
  - `POST /v1/natural-language-search/profiles` - Dynamic pricing - Takes free-form text (e.g., 'Software engineers in US with 5+ years of experience') and returns a list of matching profiles.             The endpoint interprets natural language queries and applies structured filters such as job titles, seniority, skills, locations, past jobs, education, and languages to identify relevant people.
    - Body: `query` (required), `pageSize`, `getDetailedEducation`, `getDetailedWorkExperience`, `cursor`
    - Docs: https://api.fiber.ai/docs/#tag/agentic-search/POST/v1/natural-language-search/profiles
  - `POST /v1/natural-language-search/companies` - Dynamic pricing - Takes free-form text (e.g., 'Series A startups in USA with 50–200 employees') and returns a list of matching companies.           The endpoint interprets natural language queries and applies structured filters such as industries, funding stages, headcount ranges, and locations to identify relevant companies.
    - Body: `query` (required), `pageSize`, `cursor`
    - Docs: https://api.fiber.ai/docs/#tag/agentic-search/POST/v1/natural-language-search/companies
  - `POST /v1/email-to-person/single` - $0.04 - Do a reverse lookup: given an email address, find someone's LinkedIn profile and personal details. Note: if you also have the person's name, company, etc., you'll get better results with the Kitchen Sink endpoint, where you can pass all the information you have.
    - Body: `email` (required), `num_profiles`
    - Docs: https://api.fiber.ai/docs/#tag/email-lookup/POST/v1/email-to-person/single
  - `POST /v1/linkedin-live-fetch/profile/single` - $0.04 - Returns an enriched profile with details for a given LinkedIn profile identifier
    - Body: `identifier` (required), `getDetailedEducation`, `getDetailedWorkExperience`
    - Docs: https://api.fiber.ai/docs/#tag/live-fetch/POST/v1/linkedin-live-fetch/profile/single
  - `POST /v1/kitchen-sink/person` - Dynamic pricing - Search for a person using a variety of parameters such as LinkedIn slug, LinkedIn URL, or their current company information. Returns profile data for the person if found.
    - Body: `profileIdentifier`, `emailAddress`, `personName`, `jobTitle`, `companyIdentifier`, `companyName`, `companyDomain`, `numProfiles`, `liveFetch`, `forceCompanyMatch`, `fuzzySearch`, `getDetailedEducation`, `getDetailedWorkExperience`
    - Docs: https://api.fiber.ai/docs/#tag/kitchen-sink/POST/v1/kitchen-sink/person
  - `POST /v1/kitchen-sink/company` - Dynamic pricing - Search for a company using a variety of parameters such as LinkedIn slug, LinkedIn URL, name, etc. Returns complete company data if found.
    - Body: `companyIdentifier`, `companyName`, `companyDomain`, `numCompanies`
    - Docs: https://api.fiber.ai/docs/#tag/kitchen-sink/POST/v1/kitchen-sink/company
  - `POST /v1/validate-email/single` - $0.02 - Checks if a given email is likely to bounce using a waterfall of strategies. Works for catch-all email addresses, which are increasingly common yet hard for other APIs to validate.
    - Body: `email` (required)
    - Docs: https://api.fiber.ai/docs/#tag/validation/POST/v1/validate-email/single
  - `POST /v1/investor-search` - Dynamic pricing - Search for investors with flexible filtering capabilities
    - Body: `searchParams` (required), `pageSize`, `cursor`
    - Docs: https://api.fiber.ai/docs/#tag/search/POST/v1/investor-search
  - `POST /v1/linkedin-live-fetch/profile-posts` - $0.04 - Fetches recent posts from a LinkedIn profile. Returns a paginated feed of posts with optional cursor for pagination. Each page returns up to 50 posts.
    - Body: `identifier` (required), `cursor`
    - Docs: https://api.fiber.ai/docs/#tag/live-fetch/POST/v1/linkedin-live-fetch/profile-posts
  - `POST /v1/linkedin-live-fetch/company/single` - $0.04 - Returns an enriched company with details for a given LinkedIn company identifier
    - Body: `type` (required), `value` (required)
    - Docs: https://api.fiber.ai/docs/#tag/live-fetch/POST/v1/linkedin-live-fetch/company/single
  - `POST /v1/linkedin-live-fetch/post-comments` - $0.04 - Fetches paginated comments for a LinkedIn post. Each page contains up to 10 comments.
    - Body: `contentId` (required), `cursor`
    - Docs: https://api.fiber.ai/docs/#tag/live-fetch/POST/v1/linkedin-live-fetch/post-comments
  - `POST /v1/company-search` - Dynamic pricing - Search for companies using filters
    - Body: `searchParams` (required), `pageSize`, `cursor`, `companyExclusionListIDs`
    - Docs: https://api.fiber.ai/docs/#tag/search/POST/v1/company-search
  - `POST /v1/text-to-search-params/companies` - $0.04 - Takes free-form text (e.g., 'Series A startups in USA with 50–200 employees') and converts it into a structured set of filters for company search.         This endpoint helps transform natural language queries into standardized search parameters such as industries, funding stages, headcount ranges, locations, and more.
    - Body: `query` (required)
    - Docs: https://api.fiber.ai/docs/#tag/agentic-search/POST/v1/text-to-search-params/companies
  - `POST /v1/text-to-search-params/profiles` - $0.04 - Takes free-form text (e.g., 'Software engineers in US with 5+ years of experience') and converts it into a structured set of filters for profile search.           This endpoint helps transform natural language queries into standardized search parameters such as job titles, skills, seniority, locations, past experiences, education, languages, and more.
    - Body: `query` (required)
    - Docs: https://api.fiber.ai/docs/#tag/agentic-search/POST/v1/text-to-search-params/profiles
  - `POST /v1/people-search` - Dynamic pricing - Search for people using filters
    - Body: `searchParams`, `pageSize`, `cursor`, `currentCompanies`, `prospectExclusionListIDs`, `companyExclusionListIDs`
    - Docs: https://api.fiber.ai/docs/#tag/search/POST/v1/people-search
  - `POST /v1/job-search` - Dynamic pricing - Search for job postings with flexible filtering capabilities
    - Body: `searchParams` (required), `pageSize`, `cursor`
    - Docs: https://api.fiber.ai/docs/#tag/search/POST/v1/job-search
  - `POST /v1/linkedin-live-fetch/post-reactions` - $0.04 - Fetches paginated reactions of a specific type for a LinkedIn post. Each page contains up to 10 reactions.
    - Body: `contentId` (required), `reactionType`, `cursor`
    - Docs: https://api.fiber.ai/docs/#tag/live-fetch/POST/v1/linkedin-live-fetch/post-reactions

### Riveter API ✓
- **Slug**: `riveter`
- **Description**: Power your product with data from the web. Riveter's agents manage web search, scraping, browser infrastructure, and proxies for you. Every result has a source.
- **Target API**: https://api.riveterhq.com
- **Endpoints**:
  - `POST /v1/scrape` - Dynamic pricing - Scrape a webpage and return the text content. This endpoint allows you to extract text content from any public webpage.
    - Body: `url` (required), `proxy_country_code`, `skip_cache`
    - Docs: https://docs.riveterhq.com/#tag/tools/post/scrape
  - `POST /v1/run` - Dynamic pricing - Copy link Define the structure of your output directly in the API request. This endpoint allows you to define both your input data and output configuration in a single request.
    - Query: `run_key`
    - Body: `input` (required), `output` (required)
    - Docs: https://docs.riveterhq.com/#tag/run-from-configuration/post/run
  - `GET /v1/run_data` - Free - Retrieve the processed data from a completed project run
    - Query: `run_key` (required)
    - Docs: https://docs.riveterhq.com/#tag/runs/get/run_data
  - `GET /v1/run_status` - Free - Check the current status of a project run
    - Query: `run_key` (required)
    - Docs: https://docs.riveterhq.com/#tag/runs/get/run_status
  - `POST /v1/stop_run` - Free - Stop a currently running project. This will halt all processing and mark the run as stopped. Behavior:  If the run is already stopped or success, returns success with current status. If the run is in progress, stops all pending cells and marks the run as stopped.  Stopped runs cannot be resumed
    - Query: `run_key` (required)
    - Docs: https://docs.riveterhq.com/#tag/runs/post/stop_run

### Sixtyfour API ✓
- **Slug**: `sixtyfour`
- **Description**: Build custom research agents to enrich people and company data, and surface real-time signals all with a simple API call.
- **Target API**: https://api.sixtyfour.ai
- **Endpoints**:
  - `POST /find-email` - Dynamic pricing - Find email address for a lead.
    - Body: `lead` (required), `mode`
    - Docs: https://docs.sixtyfour.ai/api-reference/endpoint/find-email
  - `POST /enrich-lead` - $0.1 - Enrich lead information with additional details such as contact information, social profiles, and company details.
    - Body: `lead_info` (required), `struct` (required), `research_plan`
    - Docs: https://docs.sixtyfour.ai/api-reference/endpoint/enrich-lead
  - `POST /find-phone` - $0.3 - The Find Phone API uses Sixtyfour AI to discover phone numbers for leads. It extracts contact information from lead data and returns enriched results with phone numbers.
    - Body: `lead` (required), `name`, `company`, `linkedin_url`, `domain`, `email`
    - Docs: https://docs.sixtyfour.ai/api-reference/endpoint/find-phone
  - `POST /enrich-company` - $0.1 - Enrich company data with additional information and find associated people.
    - Body: `target_company` (required), `struct` (required), `lead_struct`, `find_people`, `research_plan`, `people_focus_prompt`
    - Docs: https://docs.sixtyfour.ai/api-reference/endpoint/enrich-company

### Logo.dev
- **Slug**: `logo`
- **Description**: Logo.dev - Brand search and company data API
- **Target API**: https://api.logo.dev
- **Endpoints**:
  - `GET /search` - $0.01 - Search for company domains by brand name
    - Query: `q` (required), `strategy`

### Baseten Model APIs ✓
- **Slug**: `baseten`
- **Description**: OpenAI-compatible inference API for high-performance LLMs. Drop-in replacement for OpenAI SDK - just change base_url and api_key.

**Supported Models:**

| Model | Slug | Context |
|-------|------|--------|
| DeepSeek V3 0324 | `deepseek-ai/DeepSeek-V3-0324` | 164k |
| DeepSeek V3.1 | `deepseek-ai/DeepSeek-V3.1` | 164k |
| GLM 4.6 (Zhipu) | `zai-org/GLM-4.6` | 200k |
| GLM 4.7 (Zhipu) | `zai-org/GLM-4.7` | 200k |
| Kimi K2 0905 | `moonshotai/Kimi-K2-Instruct-0905` | 128k |
| Kimi K2 Thinking | `moonshotai/Kimi-K2-Thinking` | 262k |
| Kimi K2.5 | `moonshotai/Kimi-K2.5` | 262k |
| OpenAI GPT OSS 120B | `openai/gpt-oss-120b` | 128k |

**Features:** Chat completions, streaming, tool calling, structured outputs, reasoning modes.

**Pricing:** ~$0.60/1M tokens (varies by model)
- **Target API**: https://inference.baseten.co
- **Endpoints**:
  - `POST /v1/chat/completions` - Dynamic pricing - Create a chat completion using OpenAI-compatible API.

**Supported Models:**
- `deepseek-ai/DeepSeek-V3-0324` - DeepSeek V3 0324 (164k context) 🧠
- `deepseek-ai/DeepSeek-V3.1` - DeepSeek V3.1 (164k context) 🧠
- `zai-org/GLM-4.6` - GLM 4.6 (200k context) 🧠
- `zai-org/GLM-4.7` - GLM 4.7 (200k context) 🧠
- `moonshotai/Kimi-K2-Instruct-0905` - Kimi K2 0905 (128k context)
- `moonshotai/Kimi-K2-Thinking` - Kimi K2 Thinking (262k context) 🧠 always-on
- `moonshotai/Kimi-K2.5` - Kimi K2.5 (262k context)
- `openai/gpt-oss-120b` - OpenAI GPT OSS 120B (128k context)

🧠 = Reasoning model. Use `reasoning_effort` param (low/medium/high) to control thinking depth. Response includes `reasoning_content` field with chain-of-thought.

Supports streaming, tool calling, structured outputs.
    - Body: `messages` (required), `model` (required), `frequency_penalty`, `logit_bias`, `logprobs`, `top_logprobs`, `max_tokens`, `n`, `presence_penalty`, `response_format`, `seed`, `stop`, `stream`, `stream_options`, `temperature`, `top_p`, `tools`, `tool_choice`, `parallel_tool_calls`, `user`, `top_k`, `top_p_min`, `min_p`, `repetition_penalty`, `length_penalty`, `early_stopping`, `bad`, `bad_token_ids`, `stop_token_ids`, `include_stop_str_in_output`, `ignore_eos`, `min_tokens`, `skip_special_tokens`, `spaces_between_special_tokens`, `truncate_prompt_tokens`, `echo`, `add_generation_prompt`, `add_special_tokens`, `documents`, `chat_template`, `chat_template_args`, `best_of`, `disaggregated_params`, `reasoning_effort`

### Perplexity API
- **Slug**: `perplexity`
- **Description**: Build with the best AI answer engine. Power your products with the fastest, cheapest search APIs out there.
- **Target API**: https://api.perplexity.ai
- **Endpoints**:
  - `POST /chat/completions` - $0.01 - Generates a model’s response for the given chat conversation.
    - Body: `model` (required), `messages` (required), `search_mode`, `reasoning_effort`, `max_tokens`, `temperature`, `top_p`, `language_preference`, `search_domain_filter`, `return_images`, `return_related_questions`, `search_recency_filter`, `search_after_date_filter`, `search_before_date_filter`, `last_updated_after_filter`, `last_updated_before_filter`, `top_k`, `stream`, `presence_penalty`, `frequency_penalty`, `response_format`, `disable_search`, `enable_search_classifier`, `web_search_options`, `media_response`
    - Docs: https://docs.perplexity.ai/api-reference/chat-completions-post
  - `POST /search` - $0.01 - Get ranked search results from Perplexity’s continuously refreshed index with advanced filtering and customization options.
    - Body: `query` (required), `max_results`, `max_tokens`, `search_domain_filter`, `max_tokens_per_page`, `country`, `search_recency_filter`, `search_after_date`, `search_before_date`, `last_updated_after_filter`, `last_updated_before_filter`, `search_language_filter`
    - Docs: https://docs.perplexity.ai/api-reference/search-post
  - `POST /async/chat/completions` - $0.01 - Creates an asynchronous chat completion job.
    - Body: `request`
    - Docs: https://docs.perplexity.ai/api-reference/async-chat-completions-post
  - `GET /async/chat/completions/{request_id}` - $0.01 - Retrieves the status and result of a specific asynchronous chat completion job.
    - Docs: https://docs.perplexity.ai/api-reference/async-chat-completions-request_id-get
  - `GET /async/chat/completions` - $0.01 - Lists all asynchronous chat completion requests for the authenticated user.
    - Query: `limit`, `next_token`
    - Docs: https://docs.perplexity.ai/api-reference/async-chat-completions-get

### Tavus API
- **Slug**: `tavus`
- **Description**: Tavus APIs allow you to create a Conversational Video Interface (CVI), an end-to-end pipeline for building real-time video conversations with an AI replica. Each replica is integrated with a persona that enables it to see, hear, and respond like a human.
- **Target API**: https://tavusapi.com
- **Endpoints**:
  - `GET /v2/personas` - $0.01 - This endpoint returns a list of all Personas. You can first list the Personas to choose which one you'd like to create a conversation with. Then, using the Create Conversation endpoint, you can start a conversation with that persona providing the persona ID.
  - `POST /v2/conversations` - $0.02 - This endpoint starts a real-time video conversation with your AI replica, powered by a persona that allows it to see, hear, and respond like a human. Provide the most relevant persona_id obtained from the List Personas endpoint.
    - Body: `persona_id` (required)
    - Docs: https://docs.tavus.io/api-reference/conversations/create-conversation

### Precip AI - Hyperlocal Weather Data API ✓
- **Slug**: `precip`
- **Description**: Precip offers highly accurate, site-specific rainfall accumulation data. 
- **Target API**: https://api.precip.ai
- **Endpoints**:
  - `GET /api/v1/last-48` - Dynamic pricing - Total precipitation in the last 48 hours for the given location(s).
    - Query: `longitude` (required), `latitude` (required), `timeZoneId`, `format`
    - Docs: https://api-docs.precip.ai/api/precipitation-data#last-48-hours-precipitation-data
  - `GET /api/v1/temperature-hourly` - Dynamic pricing - Hourly near-surface air temperature in Celsius (°C)
    - Query: `start` (required), `end` (required), `longitude` (required), `latitude` (required), `timeZoneId`, `format`
    - Docs: https://api-docs.precip.ai/api/atmospheric-data#air-temperature
  - `GET /api/v1/soil-moisture-hourly` - Dynamic pricing - Hourly soil moisture percentage relative to holding capacity at 0-10cm depth
    - Query: `start` (required), `end` (required), `longitude` (required), `latitude` (required), `timeZoneId`, `format`
    - Docs: https://api-docs.precip.ai/api/soil-data#hourly-soil-moisture
  - `GET /api/v1/wind-direction-hourly` - Dynamic pricing - Hourly wind direction in compass degrees (0-360)
    - Query: `start` (required), `end` (required), `longitude` (required), `latitude` (required), `timeZoneId`, `format`
    - Docs: https://api-docs.precip.ai/api/atmospheric-data#wind-direction
  - `GET /api/v1/daily` - Dynamic pricing - Returns comprehensive daily precipitation data for the given time range and location(s). Each day includes precipitation amount, type (rain/snow/mixed), probability (for forecasts), and data source. Seamlessly combines historical observations with forecast data depending on the requested time range.
    - Query: `start` (required), `end` (required), `longitude` (required), `latitude` (required), `timeZoneId`, `format`
    - Docs: https://api-docs.precip.ai/api/precipitation-data#daily-precipitation-data
  - `GET /api/v1/wind-speed-gust-hourly` - Dynamic pricing - Hourly wind gust speed in meters per second (m/s)
    - Query: `start` (required), `end` (required), `longitude` (required), `latitude` (required), `timeZoneId`, `format`
    - Docs: https://api-docs.precip.ai/api/atmospheric-data#wind-gusts
  - `GET /api/v1/recent-rain` - Dynamic pricing - Returns detailed information about the most recent precipitation event for the given location(s), including total amounts, precipitation type (rain/snow), timing, and how long ago it occurred. A rain event is defined as more than 1/10 inch (2.5mm) of precipitation with less than a 24-hour gap between occurrences.
    - Query: `longitude` (required), `latitude` (required), `timeZoneId`, `format`
    - Docs: https://api-docs.precip.ai/api/precipitation-data#recent-rain-event
  - `GET /api/v1/map/{serviceName}/ImageServer/tile/{z}/{y}/{x}` - Dynamic pricing - Map tiles compatible with most web mapping or GIS tools. Software such as Mapbox, Google Maps, ArcGIS, Leaflet, OpenLayers or QGIS will require an `x/y/z` url eg `https://api.precip.ai/api/v1/map/last-48/ImageServer/tile/{z}/{y}/{x}`. See the examples for more details.
    - Query: `time`
    - Docs: https://api-docs.precip.ai/api/map-services#map-layer-tiles
  - `GET /api/v1/wind-speed-hourly` - Dynamic pricing - Hourly near-surface wind speed in meters per second (m/s)
    - Query: `start` (required), `end` (required), `longitude` (required), `latitude` (required), `timeZoneId`, `format`
    - Docs: https://api-docs.precip.ai/api/atmospheric-data#wind-speed
  - `GET /api/v1/cloud-cover-hourly` - Dynamic pricing - Hourly cloud cover fraction (0-1, where 0 is clear and 1 is overcast)
    - Query: `start` (required), `end` (required), `longitude` (required), `latitude` (required), `timeZoneId`, `format`
    - Docs: https://api-docs.precip.ai/api/atmospheric-data#cloud-cover
  - `GET /api/v1/temp-0-10cm-hourly` - Dynamic pricing - Hourly soil temperature data at 0-10cm depth in Celsius (°C)
    - Query: `start` (required), `end` (required), `longitude` (required), `latitude` (required), `timeZoneId`, `format`
    - Docs: https://api-docs.precip.ai/api/soil-data#soil-temperature
  - `GET /api/v1/specific-humidity-hourly` - Dynamic pricing - Hourly specific humidity (kg/kg)
    - Query: `start` (required), `end` (required), `longitude` (required), `latitude` (required), `timeZoneId`, `format`
    - Docs: https://api-docs.precip.ai/api/atmospheric-data#specific-humidity
  - `GET /api/v1/hourly` - Dynamic pricing - Returns comprehensive hourly precipitation data for the given time range and location(s). Each hour includes precipitation amount, type (rain/snow/mixed), probability (for forecasts), and data source. Seamlessly combines historical observations with forecast data depending on the requested time range.
    - Query: `start` (required), `end` (required), `longitude` (required), `latitude` (required), `timeZoneId`, `format`
    - Docs: https://api-docs.precip.ai/api/precipitation-data#hourly-precipitation-data
  - `GET /api/v1/soil-moisture-daily` - Dynamic pricing - Daily soil moisture percentage relative to holding capacity at 0-10cm depth
    - Query: `start` (required), `end` (required), `longitude` (required), `latitude` (required), `timeZoneId`, `format`
    - Docs: https://api-docs.precip.ai/api/soil-data#daily-soil-moisture
  - `GET /embed/location` - $0.1 - Returns a complete, HTML page displaying comprehensive weather data for a specific location. See the examples page for more details. 

 Authorization headers set automatically from query parameters on this endpoint. 
    - Query: `lat` (required), `lon` (required), `apiKey` (required), `units`, `widgets`
    - Docs: https://api-docs.precip.ai/api/embed-widgets#embeddable-html-ui
  - `GET /api/v1/solar-radiation-hourly` - Dynamic pricing - Hourly downward short-wave radiation flux in watts per square meter (W/m²)
    - Query: `start` (required), `end` (required), `longitude` (required), `latitude` (required), `timeZoneId`, `format`
    - Docs: https://api-docs.precip.ai/api/atmospheric-data#solar-radiation
  - `GET /api/v1/relative-humidity-hourly` - Dynamic pricing - Hourly relative humidity as a percentage (0-100%)
    - Query: `start` (required), `end` (required), `longitude` (required), `latitude` (required), `timeZoneId`, `format`
    - Docs: https://api-docs.precip.ai/api/atmospheric-data#relative-humidity

### Z.ai API
- **Slug**: `zai`
- **Description**: Z.ai’s GLM series large language models, including GLM-4.5 and GLM-4.6, focus on advanced reasoning, coding, and agentic capabilities through a unique Mixture-of-Experts (MoE) architecture that prioritizes model depth over width for better efficiency and reasoning.
- **Target API**: https://api.z.ai
- **Endpoints**:
  - `POST /api/paas/v4/files` - $0.01 - This API is designed for uploading auxiliary files (such as glossaries, terminology lists) to support the translation service. It allows users to upload reference materials that can enhance translation accuracy and consistency.
    - Body: `purpose` (required), `file` (required)
    - Docs: https://docs.z.ai/api-reference/agents/file-upload
  - `POST /api/paas/v4/chat/completions` - $0.01 - Create a chat completion model that generates AI replies for given conversation messages. It supports multimodal inputs (text, images, audio, video, file), offers configurable parameters (like temperature, max tokens, tool use), and supports both streaming and non-streaming output modes.
    - Body: `model` (required), `messages` (required), `request_id`, `do_sample`, `stream`, `thinking`, `temperature`, `top_p`, `max_tokens`, `tool_stream`, `tools`, `tool_choice`, `stop`, `response_format`, `user_id`
    - Docs: https://docs.z.ai/api-reference/llm/chat-completion
  - `GET /api/paas/v4/async-result/{id}` - Free - This endpoint is used to query the result of an asynchronous request.
    - Docs: https://docs.z.ai/api-reference/video/get-video-status
  - `POST /api/v1/agents/conversation` - $0.01 - This endpoint is used to query the agent conversation history.Only support slides_glm_agent
    - Body: `agent_id` (required), `conversation_id` (required), `custom_variables` (required)
    - Docs: https://docs.z.ai/api-reference/agents/agent-conversation
  - `POST /v1/agents/async-result` - $0.01 - This endpoint is used to query the result of an asynchronous request.
    - Body: `agent_id` (required), `async_id` (required)
    - Docs: https://docs.z.ai/api-reference/agents/get-async-result
  - `POST /api/v1/agents` - $0.01 - General Translation API provides large model-based multilingual translation services, including general translation, paraphrase translation, two-step translation, and three-pass translation strategies. It supports automatic language detection, glossary customization, translation suggestions, and streaming output. Users only need to call the Translation API, input the text to be processed, specify the source language (auto-detection supported) and target language to receive high-quality translation results.
    - Body: `agent_id` (required), `messages` (required), `stream`, `custom_variables`
    - Docs: https://docs.z.ai/api-reference/agents/agent
  - `POST /api/paas/v4/videos/generations` - $0.01 - CogVideoX is a video generation large model developed by Z.AI, equipped with powerful video generation capabilities. Simply inputting text or images allows for effortless video creation. Vidu: A high-performance video large model that combines high consistency and high dynamism, with precise semantic understanding and exceptional reasoning speed.
    - Body: `model` (required), `prompt`, `quality`, `with_audio`, `image_url`, `size`, `fps`, `duration`, `request_id`, `user_id`
    - Docs: https://docs.z.ai/api-reference/video/generate-video
  - `POST /api/paas/v4/images/generations` - $0.01 - Use CogView-4 series models to generate high-quality images from text prompts. `CogView-4-250304` is suitable for image generation tasks, with quick and accurate understanding of user text descriptions to let `AI` express images more precisely and personally.
    - Body: `model` (required), `prompt` (required), `quality`, `size`, `user_id`
    - Docs: https://docs.z.ai/api-reference/image/generate-image
  - `POST /api/paas/v4/web_search` - $0.01 - The Web Search is a specialized search engine for large language models. Building upon traditional search engine capabilities like web crawling and ranking, it enhances intent recognition to return results better suited for LLM processing (including webpage titles, URLs, summaries, site names, favicons etc.).
    - Body: `search_engine` (required), `search_query` (required), `count`, `search_domain_filter`, `search_recency_filter`, `request_id`, `user_id`
    - Docs: https://docs.z.ai/api-reference/tools/web-search
  - `POST /api/paas/v4/reader` - $0.01 - Reads and parses the content of the specified URL. Supports selectable return formats, cache control, image retention, and summary options.
    - Body: `url` (required), `timeout`, `no_cache`, `return_format`, `retain_images`, `no_gfm`, `keep_img_data_url`, `with_images_summary`, `with_links_summary`
    - Docs: https://docs.z.ai/api-reference/tools/web-reader

### Textbelt API
- **Slug**: `textbelt`
- **Description**: Textbelt is an SMS API that is built for developers who just want to send and receive SMS.  Sending an SMS is a simple thing.  Our goal is to provide an API that is correspondingly simple, without requiring account configuration, logins, or extra recurring billing.
- **Target API**: https://textbelt.com
- **Endpoints**:
  - `GET /status/{id}` - Free - Checking SMS delivery status
    - Docs: https://docs.textbelt.com/other-api-endpoints
  - `POST /text` - $0.025 - Send an SMS using HTTP POST.
Note: No Urls in text message.
Max 800 characters
    - Body: `phone` (required), `message` (required), `sender`, `replyWebhookUrl`, `webhookData`
    - Docs: https://docs.textbelt.com

### Shofo API ✓
- **Slug**: `shofo`
- **Description**: Complete Social Media Data Indexes
- **Target API**: https://api.shofo.ai/api
- **Endpoints**:
  - `GET /instagram/hashtag` - $0.01 - Get posts for an Instagram hashtag.
    - Query: `keyword` (required), `count` (required), `feed_type`
    - Docs: https://www.shofo.ai/docs/instagram/hashtag
  - `GET /x/comments` - $0.01 - Get comments/replies from an X tweet.
    - Query: `tweet_id` (required), `count`, `cursor`
    - Docs: https://www.shofo.ai/docs/x/comments
  - `GET /linkedin/company-posts` - $0.01 - Get recent posts from a LinkedIn company page.
    - Query: `company`, `company_id`, `count` (required), `sort_by`
    - Docs: https://www.shofo.ai/docs/linkedin/company-posts
  - `GET /tiktok/hashtag` - $0.01 - Get videos for a specific hashtag. Great for campaign tracking and trend monitoring.
    - Query: `hashtag`, `challenge_id`, `count` (required), `cursor`
    - Docs: https://www.shofo.ai/docs/tiktok/hashtag
  - `GET /x/user-profile` - $0.01 - Get X/Twitter profile data including bio, follower counts, and profile info.
    - Query: `username` (required)
    - Docs: https://www.shofo.ai/docs/x/user-profile
  - `GET /tiktok/feed` - $0.01 - Get videos from TikTok's recommendation feed. Perfect for trend analysis and content discovery.
    - Query: `count` (required)
    - Docs: https://www.shofo.ai/docs/tiktok/feed
  - `GET /instagram/user-profile` - $0.01 - Get Instagram profile data with optional followers and following lists.
    - Query: `username` (required), `max_followers`, `max_following`
    - Docs: https://www.shofo.ai/docs/instagram/user-profile
  - `GET /tiktok/profile` - $0.01 - Get videos from a specific TikTok user's profile.
    - Query: `username`, `sec_uid`, `count` (required), `cursor`
    - Docs: https://www.shofo.ai/docs/tiktok/profile
  - `GET /tiktok/comments` - $0.01 - Get comments from a TikTok video.
    - Query: `video_id` (required), `count`, `cursor`
    - Docs: https://www.shofo.ai/docs/tiktok/comments
  - `GET /linkedin/user-profile` - $0.01 - Get comprehensive LinkedIn profile data including work experience, education, skills, and contact info.
    - Query: `username` (required)
    - Docs: https://www.shofo.ai/docs/linkedin/user-profile
  - `GET /linkedin/user-posts` - $0.01 - Get recent posts and activity from a LinkedIn user.
    - Query: `username` (required), `count` (required)
    - Docs: https://www.shofo.ai/docs/linkedin/user-posts
  - `GET /linkedin/company-profile` - $0.01 - Get company information including size, industry, locations, and specialties.
    - Query: `company`, `company_id`, `employee_count`
    - Docs: https://www.shofo.ai/docs/linkedin/company-profile
  - `GET /linkedin/search-employees` - $0.01 - Search LinkedIn people by company or school.
    - Query: `company`, `school`, `current_company`, `count` (required)
    - Docs: https://www.shofo.ai/docs/linkedin/search-employees
  - `GET /instagram/user-posts` - $0.01 - Get posts or reels from an Instagram user's profile.
    - Query: `username` (required), `count` (required), `reels_only`
    - Docs: https://www.shofo.ai/docs/instagram/user-posts
  - `GET /instagram/post` - $0.01 - Get detailed data for a specific Instagram post by shortcode or URL.
    - Query: `code_or_url` (required)
    - Docs: https://www.shofo.ai/docs/instagram/post
  - `GET /instagram/comments` - $0.01 - Get comments from an Instagram post.
    - Query: `media_id` (required), `count`, `sort_order`, `cursor`
    - Docs: https://www.shofo.ai/docs/instagram/comments
  - `GET /x/user-posts` - $0.01 - Get tweets from a user's profile.
    - Query: `username` (required), `count` (required)
    - Docs: https://www.shofo.ai/docs/x/user-posts
  - `GET /x/post` - $0.01 - Get detailed data for a specific tweet by ID or URL.
    - Query: `tweet_id_or_url` (required)
    - Docs: https://www.shofo.ai/docs/x/post

### Exa API
- **Slug**: `exa`
- **Description**: Exa is a search engine made for AIs.
- **Target API**: https://api.exa.ai
- **Endpoints**:
  - `GET /research/v1` - $0.01 - Retrieve a paginated list of your research tasks. The response follows a cursor-based pagination pattern. Pass the `limit` parameter to control page size (max 50) and use the `cursor` token returned in the response to fetch subsequent pages.
    - Query: `cursor`, `limit`
    - Docs: https://exa.ai/docs/reference/research/list-tasks
  - `POST /answer` - $0.01 - Get an LLM answer to a question informed by Exa search results. /answer performs an Exa search and uses an LLM to generate either:

A direct answer for specific queries. (i.e. “What is the capital of France?” would return “Paris”)
A detailed summary with citations for open-ended queries (i.e. “What is the state of ai in healthcare?” would return a summary with citations to relevant sources)

The response includes both the generated answer and the sources used to create it. The endpoint also supports streaming (as stream=True), which will return tokens as they are generated.
Alternatively, you can use the OpenAI compatible chat completions interface.
    - Body: `query` (required), `stream`, `text`
    - Docs: https://exa.ai/docs/reference/answer
  - `POST /search` - $0.01 - The search endpoint lets you intelligently search the web and extract contents from the results.By default, it automatically chooses the best search method using Exa’s embeddings-based model and other techniques to find the most relevant results for your query. You can also use Deep search for comprehensive results with query expansion and detailed context.
    - Body: `query` (required), `additionalQueries`, `type`, `category`, `userLocation`, `numResults`, `includeDomains`, `excludeDomains`, `startCrawlDate`, `endCrawlDate`, `startPublishedDate`, `endPublishedDate`, `includeText`, `excludeText`, `context`, `moderation`, `contents`
    - Docs: https://exa.ai/docs/reference/search
  - `GET /research/v1/{researchId}` - $0.01 - Retrieve the status and results of a previously created research task.Use the unique researchId returned from POST /research/v1 to poll until the task is finished.
    - Query: `stream`, `events`
    - Docs: https://exa.ai/docs/reference/research/get-a-task
  - `POST /findSimilar` - $0.01 - Find similar links to the link provided and optionally return the contents of the pages.
    - Body: `url` (required), `numResults`, `includeDomains`, `excludeDomains`, `startCrawlDate`, `endCrawlDate`, `startPublishedDate`, `endPublishedDate`, `includeText`, `excludeText`, `context`, `moderation`, `contents`
    - Docs: https://exa.ai/docs/reference/find-similar-links
  - `POST /research/v1` - $0.01 - Create an asynchronous research task that explores the web, gathers sources, synthesizes findings, and returns results with citations. Can be used to generate:

Structured JSON matching an outputSchema you provide.
A detailed markdown report when no schema is provided.

The API responds immediately with a researchId for polling completion status. For more details, see Exa Research.
Alternatively, you can use the OpenAI compatible chat completions interface.
    - Body: `instructions` (required), `model`, `outputSchema`
    - Docs: https://exa.ai/docs/reference/research/create-a-task
  - `POST /contents` - $0.01 - Get the full page contents, summaries, and metadata for a list of URLs.Returns instant results from our cache, with automatic live crawling as fallback for uncached pages.
    - Body: `urls` (required), `ids`, `text`, `highlights`, `summary`, `livecrawl`, `livecrawlTimeout`, `subpages`, `subpageTarget`, `extras`, `context`
    - Docs: https://exa.ai/docs/reference/get-contents

### Parallel API
- **Slug**: `parallel`
- **Description**: A web API purpose-built for AIs. Powering millions of daily requests
- **Target API**: https://api.parallel.ai
- **Endpoints**:
  - `GET /v1beta/findall/runs/{findall_id}` - Free - Retrieve a FindAll run.
    - Docs: https://docs.parallel.ai/api-reference/findall-api-beta/retrieve-findall-run-status
  - `GET /v1beta/findall/runs/{findall_id}/result` - Free - Retrieve the FindAll run result at the time of the request.
    - Docs: https://docs.parallel.ai/api-reference/findall-api-beta/findall-run-result
  - `POST /v1beta/findall/runs/{findall_id}/cancel` - Free - Cancel a FindAll run.
    - Docs: https://docs.parallel.ai/api-reference/findall-api-beta/cancel-findall-run
  - `GET /v1/tasks/runs/{run_id}/input` - Free - Retrieves the input of a run by run_id.
    - Docs: https://docs.parallel.ai/api-reference/tasks-v1/retrieve-task-run-input
  - `GET /v1/tasks/runs/{run_id}` - Free - Retrieves run status by run_id.The run result is available from the /result endpoint.
    - Docs: https://docs.parallel.ai/api-reference/tasks-v1/retrieve-task-run
  - `POST /v1beta/findall/ingest` - $0.01 - Transforms a natural language search objective into a structured FindAll spec.Note: Access to this endpoint requires the parallel-beta header.The generated specification serves as a suggested starting point and can be furthercustomized by the user.
    - Body: `objective` (required)
    - Docs: https://docs.parallel.ai/api-reference/findall-api-beta/ingest-findall-run
  - `GET /v1/tasks/runs/{run_id}/result` - Free - Retrieves a run result by run_id, blocking until the run is completed.
    - Query: `timeout`
    - Docs: https://docs.parallel.ai/api-reference/tasks-v1/retrieve-task-run-result
  - `POST /v1beta/findall/runs` - $0.01 - Starts a FindAll run.This endpoint immediately returns a FindAll run object with status set to ‘queued’.You can get the run result snapshot using the GET /v1beta/findall/runs//result endpoint.You can track the progress of the run by:Polling the status using the GET /v1beta/findall/runs/ endpoint,Subscribing to real-time updates via the /v1beta/findall/runs//eventsendpoint,Or specifying a webhook with relevant event types during run creation to receivenotifications.
    - Body: `objective` (required), `entity_type` (required), `match_conditions` (required), `generator` (required), `match_limit` (required), `exclude_list`, `metadata`, `webhook`
    - Docs: https://docs.parallel.ai/api-reference/findall-api-beta/create-findall-run
  - `POST /v1beta/search` - $0.01 - Searches the web.To access this endpoint, pass the parallel-beta header with the valuesearch-extract-2025-10-10.
    - Body: `mode`, `objective`, `search_queries`, `processor`, `max_results`, `max_chars_per_result`, `excerpts`, `source_policy`, `fetch_policy`
    - Docs: https://docs.parallel.ai/api-reference/search-beta/search
  - `POST /chat/completions` - $0.01 - Parallel Chat is a web research API that returns OpenAI ChatCompletions compatible streaming text and JSON. The Chat API supports multiple models—from the `speed` model for low latency across a broad range of use cases, to research models (`lite`, `base`, `core`) for deeper research-grade outputs where you can afford to wait longer for even more comprehensive responses with full [research basis](/task-api/guides/access-research-basis) support.
    - Body: `model`, `messages`, `stream`, `response_format`
    - Docs: https://docs.parallel.ai/chat-api/chat-quickstart
  - `POST /v1beta/extract` - $0.01 - Extracts relevant content from specific web URLs.To access this endpoint, pass the parallel-beta header with the valuesearch-extract-2025-10-10.
    - Body: `urls` (required), `objective`, `search_queries`, `fetch_policy`, `excerpts`, `full_content`
    - Docs: https://docs.parallel.ai/api-reference/extract-beta/extract
  - `POST /v1/tasks/runs` - $0.01 - Initiates a task run.Returns immediately with a run object in status ‘queued’.Beta features can be enabled by setting the ‘parallel-beta’ header.
    - Body: `processor` (required), `input` (required), `metadata`, `source_policy`, `task_spec`, `mcp_servers`, `enable_events`, `webhook`
    - Docs: https://docs.parallel.ai/api-reference/tasks-v1/create-task-run

### Apollo API
- **Slug**: `apollo`
- **Description**: Apollo.io API for people and company enrichment, search, and prospecting. Access the Apollo database of 270M+ contacts and 60M+ companies.
- **Target API**: https://api.apollo.io
- **Endpoints**:
  - `GET /api/v1/organizations/enrich` - $0.01 - Enrich a company by domain. Returns industry, revenue, employee count, funding, locations, and more.
    - Query: `domain` (required)
  - `POST /api/v1/mixed_companies/search` - $0.01 - Search Apollo database for companies matching filters. Returns up to 100 results per page.
    - Body: `organization_locations`, `organization_num_employees_ranges`, `organization_industry_tag_ids`, `q_keywords`, `page`, `per_page`
  - `POST /api/v1/news_articles/search` - $0.01 - Search for news articles related to companies in the Apollo database.
    - Body: `organization_ids` (required), `q_keywords`, `page`, `per_page`
  - `POST /api/v1/organizations/bulk_enrich` - $0.05 - Enrich up to 10 organizations in a single request.
    - Body: `domains` (required)
  - `POST /api/v1/people/bulk_match` - $0.05 - Enrich up to 10 people in a single request. Webhook required for async results.
    - Body: `details` (required), `reveal_personal_emails`, `reveal_phone_number`, `webhook_url` (required)
  - `POST /api/v1/mixed_people/api_search` - $0.01 - Search Apollo database for people matching filters. Returns up to 100 results per page. Does not include emails/phones - use enrichment endpoints for that.
    - Body: `person_titles`, `person_seniorities`, `organization_locations`, `organization_num_employees_ranges`, `person_locations`, `q_keywords`, `page`, `per_page`
  - `GET /api/v1/organizations/{organization_id}/job_postings` - $0.01 - Get current job postings for a company by Apollo organization ID.
    - Query: `organization_id` (required)
  - `POST /api/v1/people/match` - $0.01 - Enrich a person by email, LinkedIn URL, name+company, or other identifiers. Returns contact details, job info, and social profiles.
    - Body: `email`, `linkedin_url`, `first_name`, `last_name`, `organization_name`, `domain`, `reveal_personal_emails`, `reveal_phone_number`
  - `GET /api/v1/organizations/{id}` - $0.01 - Get complete organization info by Apollo organization ID.
    - Query: `id` (required)

### Tomba API ✓
- **Slug**: `tomba`
- **Description**: Email finding and verification API
- **Target API**: https://api.tomba.io
- **Endpoints**:
  - `GET /v1/phone-validator` - $0.01 - Validate a phone number and get carrier information.
    - Query: `phone` (required), `country_code`
  - `GET /v1/domain-status` - $0.01 - Check the status and availability of a domain.
    - Query: `domain` (required)
  - `GET /v1/email-format` - $0.01 - Get the email format patterns used by a domain (e.g. first.last, firstlast).
    - Query: `domain` (required)
  - `GET /v1/people/find` - $0.01 - Get person information from an email address.
    - Query: `email` (required)
  - `GET /v1/combined/find` - $0.01 - Get combined person and company information from an email.
    - Query: `email` (required)
  - `GET /v1/domain-suggestions` - $0.01 - Get domain suggestions for a company name
    - Query: `query` (required)
  - `GET /v1/email-count` - $0.01 - Get the count of email addresses for a domain, broken down by department and seniority.
    - Query: `domain` (required)
  - `GET /v1/author-finder` - $0.01 - Find the email address of a blog post author from the article URL.
    - Query: `url` (required)
  - `GET /v1/linkedin` - $0.01 - Find the email address from a LinkedIn profile URL.
    - Query: `url` (required), `enrich_mobile`
  - `GET /v1/technology` - $0.01 - Discover technologies used by a website.
    - Query: `domain` (required)
  - `GET /v1/email-verifier` - $0.01 - Verify the deliverability of an email address.
    - Query: `email` (required)
  - `GET /v1/companies/find` - $0.01 - Get company information from a domain.
    - Query: `domain` (required)
  - `GET /v1/location` - $0.01 - Get employee location distribution for a domain.
    - Query: `domain` (required)
  - `GET /v1/domain-search` - $0.01 - Search emails based on a website domain. Returns all email addresses found on the internet for a given domain, with organization info and employee details.
    - Query: `domain` (required), `company` (required), `page`, `limit`, `country`, `department`
  - `GET /v1/enrich` - $0.01 - Enrich an email address with person and company data (name, location, social handles).
    - Query: `email` (required), `enrich_mobile`
  - `GET /v1/phone-finder` - $0.01 - Find phone numbers associated with an email, domain, or LinkedIn profile.
    - Query: `email`, `domain`, `linkedin`, `full`
  - `GET /v1/similar` - $0.01 - Find domains similar to a given domain.
    - Query: `domain` (required)
  - `GET /v1/email-finder` - $0.01 - Find the most likely email address from a domain name, first name, and last name.
    - Query: `domain` (required), `company` (required), `full_name`, `first_name`, `last_name`, `enrich_mobile`
  - `GET /v1/email-sources` - $0.01 - Find the sources where an email was found on the web.
    - Query: `email` (required)
  - `POST /v1/reveal/search` - $0.01 - Search for companies using natural language queries or structured filters. AI assistant generates appropriate filters from your query.
    - Body: `query`, `filters`, `page`

### Didit API ✓
- **Slug**: `didit`
- **Description**: The all-in-one identity platform. Powering the fastest identity verification while fighting fraud and unifying all identity checks.
- **Target API**: https://verification.didit.me
- **Endpoints**:
  - `POST /v3/email/send` - $0.04 - Send a one-time verification code to an email address.
    - Body: `email` (required), `options`, `signals`, `vendor_data`
    - Docs: https://docs.didit.me/reference/send-email-verification-code-api
  - `POST /v3/phone/check` - Free - Verify a one-time code sent to a phone number. Maximum of three verification attempts per code.
    - Body: `phone_number` (required), `code` (required), `duplicated_phone_number_action`, `disposable_number_action`, `voip_number_action`
    - Docs: https://docs.didit.me/reference/check-phone-verification-code-api-1
  - `POST /v3/phone/send` - $0.3 - Send a one-time verification code to a phone number.
    - Body: `phone_number` (required), `options`, `signals`, `vendor_data`
    - Docs: https://docs.didit.me/reference/send-phone-verification-code-api
  - `POST /v3/aml` - $0.36 - The AML Screening API allows you to screen individuals or companies against global watchlists and high-risk databases. This API provides real-time screening capabilities to detect potential matches and mitigate risks associated with financial fraud and terrorism. You can screen both persons and companies by specifying the `entity_type` parameter.
    - Body: `full_name` (required), `entity_type`, `date_of_birth`, `nationality`, `document_number`, `aml_score_approve_threshold`, `aml_score_review_threshold`, `aml_name_weight`, `aml_dob_weight`, `aml_country_weight`, `aml_match_score_threshold`, `include_adverse_media`, `include_ongoing_monitoring`, `save_api_request`, `vendor_data`
    - Docs: https://docs.didit.me/reference/aml-screening-standalone-api
  - `POST /v3/email/check` - Free - Verify a code sent to an email address.
    - Body: `email` (required), `code` (required), `duplicated_email_action`, `breached_email_action`, `disposable_email_action`, `undeliverable_email_action`
    - Docs: https://docs.didit.me/reference/check-email-verification-code-api
  - `POST /v3/database-validation` - $0.31 - Validate user-provided identity data against authoritative national and global data sources.
    - Body: `issuing_state` (required), `validation_type` (required), `identification_number` (required), `document_type`, `expiration_date`, `first_name`, `last_name`, `date_of_birth`, `nationality`, `address`
    - Docs: https://docs.didit.me/reference/database-validation-api

### Jina Search Foundation API
- **Slug**: `jina-s`
- **Description**: Your Search Foundation, Supercharged. Search AI for multilingual and multimodal data.
- **Target API**: https://s.jina.ai
- **Endpoints**:
  - `GET /` - $0.01 - Use s.jina.ai to search the web and get SERP
    - Query: `q`
    - Docs: https://s.jina.ai/docs

### Notte ✓
- **Slug**: `notte`
- **Description**: Browser automation API for AI agents. Start browser sessions, run AI agents, scrape webpages, and automate browser tasks with headless Chrome/Firefox. Features include CAPTCHA solving, proxy support, and persistent browser profiles.
- **Target API**: https://api.notte.cc
- **Endpoints**:
  - `POST /sessions/{session_id}/page/screenshot` - $0.001 - Take a screenshot of the current page.
    - Query: `session_id` (required)
    - Body: `full_page`
  - `GET /sessions/{session_id}` - Free - Get session status and details.
    - Query: `session_id` (required)
  - `DELETE /sessions/{session_id}/stop` - Free - Stop and clean up a browser session.
    - Query: `session_id` (required)
  - `GET /sessions/{session_id}/cookies` - Free - Get all cookies from the browser session.
    - Query: `session_id` (required)
  - `GET /sessions/{session_id}/network/logs` - Free - Get network request/response logs from the session.
    - Query: `session_id` (required)
  - `GET /agents/{agent_id}` - Free - Get agent execution status and results.
    - Query: `agent_id` (required)
  - `POST /sessions/{session_id}/page/observe` - $0.005 - Observe the current page state and get available actions.
    - Query: `session_id` (required)
    - Body: `max_nb_actions`, `min_nb_actions`, `instruction`
  - `DELETE /agents/{agent_id}/stop` - Free - Stop a running agent.
    - Query: `session_id` (required)
  - `POST /scrape` - $0.01 - Scrape content from a URL without managing sessions.
    - Body: `url` (required), `schema`
  - `POST /sessions/{session_id}/page/execute` - $0.002 - Execute an action on the page (click, type, navigate, etc.).
    - Query: `session_id` (required)
    - Body: `type` (required), `url`, `ref`, `text`, `value`, `direction`, `amount`, `timeout`
  - `POST /sessions/{session_id}/cookies` - $0.001 - Set cookies in the browser session.
    - Query: `session_id` (required)
    - Body: `cookies` (required)
  - `POST /sessions/start` - Dynamic pricing - Start a new browser session. Configure browser type, proxies, viewport, and session timeout.
    - Body: `headless`, `browser_type`, `proxies`, `solve_captchas`, `idle_timeout_minutes`, `max_duration_minutes`, `viewport_width`, `viewport_height`, `user_agent`
  - `POST /scrape_from_html` - $0.002 - Extract structured content from raw HTML without using a browser
    - Body: `frames` (required)
  - `POST /agents/start` - Dynamic pricing - Start an AI agent to autonomously complete a browser task.
    - Body: `task` (required), `session_id` (required), `url`, `max_steps`, `use_vision`
  - `POST /sessions/{session_id}/page/scrape` - $0.003 - Scrape content from the current page in the session.
    - Query: `session_id` (required)
    - Body: `selector`, `scrape_links`, `scrape_images`, `only_main_content`, `response_format`, `instructions`

### Dome API
- **Slug**: `dome`
- **Description**: Dome API provides comprehensive access to prediction market data across multiple platforms including Polymarket and Kalshi.
- **Target API**: https://api.domeapi.io/v1
- **Endpoints**:
  - `GET /kalshi/orderbooks` - $0.01 - Fetches historical orderbook snapshots for a specific Kalshi market (ticker) over a specified time range. If no start_time and end_time are provided, returns the latest orderbook snapshot for the market. Returns snapshots of the order book including yes/no bids and asks with prices in both cents and dollars. All timestamps are in milliseconds. Orderbook data has history starting from October 29th, 2025. Note: When fetching the latest orderbook (without start/end times), the limit parameter is ignored.
    - Query: `ticker` (required), `start_time`, `end_time`, `limit`
    - Docs: https://docs.domeapi.io/api-reference/endpoint/get-kalshi-orderbook-history
  - `GET /polymarket/market-price/{token_id}` - $0.01 - Fetches the current market price for a market by token_id. Allows historical lookups via the at_time query parameter.
    - Query: `at_time`
    - Docs: https://docs.domeapi.io/api-reference/endpoint/get-market-price
  - `GET /kalshi/market-price/{market_ticker}` - $0.01 - Fetches the current market price for a Kalshi market by market_ticker. Returns prices for both yes and no sides. Allows historical lookups via the at_time query parameter.
    - Query: `at_time`
    - Docs: https://docs.domeapi.io/api-reference/endpoint/get-kalshi-market-price
  - `GET /kalshi/trades` - $0.01 - Fetches historical trade data for Kalshi markets with optional filtering by ticker and time range. Returns executed trades with pricing, volume, and taker side information. All timestamps are in seconds.
    - Query: `ticker`, `start_time`, `end_time`, `limit`, `offset`
    - Docs: https://docs.domeapi.io/api-reference/endpoint/get-kalshi-trades
  - `GET /matching-markets/sports/{sport}` - $0.01 - Find equivalent markets across different prediction market platforms (Polymarket, Kalshi, etc.) for sports events by sport and date.
    - Query: `date` (required)
    - Docs: https://docs.domeapi.io/api-reference/endpoint/get-matching-markets-sports-sport
  - `GET /matching-markets/sports` - $0.01 - Find equivalent markets across different prediction market platforms (Polymarket, Kalshi, etc.) for sports events using a Polymarket market slug or a Kalshi event ticker.
    - Query: `polymarket_market_slug`, `kalshi_event_ticker`
    - Docs: https://docs.domeapi.io/api-reference/endpoint/get-matching-markets-sports
  - `GET /polymarket/positions/wallet/{wallet_address}` - $0.01 - Fetches all Polymarket positions for a proxy wallet address. Returns positions with balance >= 10,000 shares (0.01 normalized) with market info.
    - Query: `limit`, `pagination_key`
    - Docs: https://docs.domeapi.io/api-reference/endpoint/get-positions
  - `GET /crypto-prices/binance` - $0.01 - Fetches historical crypto price data from Binance. Returns price data for a specific currency pair over an optional time range. When no time range is provided, returns the most recent price. All timestamps are in Unix milliseconds. Currency format: lowercase alphanumeric with no separators (e.g., btcusdt, ethusdt).
    - Query: `currency` (required), `start_time`, `end_time`, `limit`, `pagination_key`
    - Docs: https://docs.domeapi.io/api-reference/endpoint/get-binance-crypto-prices
  - `GET /polymarket/activity` - $0.01 - Fetches activity data for a specific user with optional filtering by market, condition, and time range. Returns trading activity including MERGES, SPLITS, and REDEEMS.
    - Query: `user` (required), `start_time`, `end_time`, `market_slug`, `condition_id`, `limit`, `offset`
    - Docs: https://docs.domeapi.io/api-reference/endpoint/get-activity
  - `GET /polymarket/markets` - $0.01 - Find markets on Polymarket using various filters including the ability to search
    - Query: `market_slug`, `event_slug`, `condition_id`, `tags`, `search`, `status`, `min_volume`, `limit`, `offset`, `start_time`, `end_time`
    - Docs: https://docs.domeapi.io/api-reference/endpoint/get-markets
  - `GET /polymarket/orderbooks` - $0.01 - Fetches historical orderbook snapshots for a specific asset (token ID) over a specified time range. If no start_time and end_time are provided, returns the latest orderbook snapshot for the market. Returns snapshots of the order book including bids, asks, and market metadata in order. All timestamps are in milliseconds. Orderbook data has history starting from October 14th, 2025. Note: When fetching the latest orderbook (without start/end times), the limit and pagination_key parameters are ignored.
    - Query: `token_id` (required), `start_time`, `end_time`, `limit`, `pagination_key`
    - Docs: https://docs.domeapi.io/api-reference/endpoint/get-orderbook-history
  - `GET /polymarket/wallet` - $0.01 - Fetches wallet information by providing either an EOA (Externally Owned Account) address or a proxy wallet address. Returns the associated EOA, proxy, and wallet type. Optionally returns trading metrics including total volume, number of trades, and unique markets traded when with_metrics=true.
    - Query: `eoa`, `proxy`, `with_metrics`, `start_time`, `end_time`
    - Docs: https://docs.domeapi.io/api-reference/endpoint/get-wallet
  - `GET /polymarket/candlesticks/{condition_id}` - $0.01 - Fetches historical candlestick data for a market identified by condition_id, over a specified interval.
    - Query: `start_time` (required), `end_time` (required), `interval`
    - Docs: https://docs.domeapi.io/api-reference/endpoint/get-candlestick
  - `GET /crypto-prices/chainlink` - $0.01 - Fetches historical crypto price data from Chainlink. Returns price data for a specific currency pair over an optional time range. When no time range is provided, returns the most recent price. All timestamps are in Unix milliseconds. Currency format: slash-separated (e.g., btc/usd, eth/usd).
    - Query: `currency` (required), `start_time`, `end_time`, `limit`, `pagination_key`
    - Docs: https://docs.domeapi.io/api-reference/endpoint/get-chainlink-crypto-prices
  - `GET /polymarket/wallet/pnl/{wallet_address}` - $0.01 - Fetches the realized profit and loss (PnL) for a specific wallet address over a specified time range and granularity. Note: This will differ to what you see on Polymarket’s dashboard since Polymarket showcases historical unrealized PnL. This API tracks realized gains only - from either confirmed sells or redeems. We do not realize a gain/loss until a finished market is redeemed.
    - Query: `granularity` (required), `start_time`, `end_time`
    - Docs: https://docs.domeapi.io/api-reference/endpoint/get-wallet-pnl
  - `GET /polymarket/orders` - $0.01 - Fetches historical trade data with optional filtering by market, condition, token, time range, and user’s wallet address.
    - Query: `market_slug`, `condition_id`, `token_id`, `start_time`, `end_time`, `limit`, `offset`, `user`
    - Docs: https://docs.domeapi.io/api-reference/endpoint/get-trade-history
  - `GET /kalshi/markets` - $0.01 - Find markets on Kalshi using various filters including market ticker, event ticker, status, and volume
    - Query: `market_ticker`, `event_ticker`, `search`, `status`, `min_volume`, `limit`, `offset`
    - Docs: https://docs.domeapi.io/api-reference/endpoint/get-kalshi-markets

### Linkup API ✓
- **Slug**: `linkup`
- **Description**: Linkup is a web search engine for AI apps. We connect your AI application to the internet. Our API provides grounding data to enrich your AI’s output and increase its precision, accuracy and factuality.
- **Target API**: https://api.linkup.so/v1
- **Endpoints**:
  - `POST /search` - $0.01 - The /search endpoint allows you to retrieve web content.
    - Body: `q` (required), `depth` (required), `outputType` (required), `structuredOutputSchema`, `includeSources`, `includeImages`, `fromDate`, `toDate`, `includeDomains`, `excludeDomains`, `includeInlineCitations`, `maxResults`
    - Docs: https://docs.linkup.so/pages/documentation/api-reference/endpoint/post-search
  - `POST /fetch` - $0.01 - The /fetch endpoint allows you to fetch a single webpage from a given URL.
    - Body: `url` (required), `renderJs`, `includeRawHtml`, `extractImages`
    - Docs: https://docs.linkup.so/pages/documentation/api-reference/endpoint/post-fetch

### Valyu API
- **Slug**: `valyu`
- **Description**: Valyu’s Search API lets your AI search for the information it needs. Access high-quality content from the web and proprietary sources, with full-text multimodal retrieval.
- **Target API**: https://api.valyu.ai
- **Endpoints**:
  - `GET /v1/deepresearch/tasks/{id}/status` - $0.01 - Reference for getting deep research task status via GET /v1/deepresearch/tasks/{id}/status.
    - Docs: https://docs.valyu.ai/api-reference/endpoint/deepresearch-status
  - `POST /v1/deepresearch/tasks/{id}/update` - $0.01 - Reference for adding follow-up instructions to a running task via POST /v1/deepresearch/tasks/{id}/update.
    - Body: `instruction` (required)
    - Docs: https://docs.valyu.ai/api-reference/endpoint/deepresearch-update
  - `POST /v1/deepresearch/tasks/{id}/cancel` - $0.01 - Reference for cancelling a running task via POST /v1/deepresearch/tasks/{id}/cancel.
    - Docs: https://docs.valyu.ai/api-reference/endpoint/deepresearch-cancel
  - `DELETE /v1/deepresearch/tasks/{id}/delete` - $0.01 - Reference for deleting a task via DELETE /v1/deepresearch/tasks/{id}/delete.
    - Docs: https://docs.valyu.ai/api-reference/endpoint/deepresearch-delete
  - `GET /v1/deepresearch/batches/{id}` - $0.01 - Reference for getting batch status via GET /v1/deepresearch/batches/.
    - Docs: https://docs.valyu.ai/api-reference/endpoint/deepresearch-batch-status
  - `GET /v1/deepresearch/batches/{id}/tasks` - $0.01 - Reference for listing tasks in a batch via GET /v1/deepresearch/batches//tasks.
    - Docs: https://docs.valyu.ai/api-reference/endpoint/deepresearch-batch-list-tasks
  - `POST /v1/deepresearch/batches/{id}/cancel` - $0.01 - Reference for cancelling a batch via POST /v1/deepresearch/batches//cancel.
    - Docs: http://docs.valyu.ai/api-reference/endpoint/deepresearch-batch-cancel
  - `POST /v1/search` - $0.01 - Reference for the Valyu Search endpoint to search the web, research, and proprietary datasets via POST /v1/search.
    - Body: `query` (required), `max_num_results`, `search_type`, `fast_mode`, `max_price`, `relevance_threshold`, `included_sources`, `excluded_sources`, `category`, `response_length`, `country_code`, `is_tool_call`, `start_date`, `end_date`, `url_only`
    - Docs: https://docs.valyu.ai/api-reference/endpoint/search
  - `POST /v1/answer` - $0.01 - Reference for the Valyu Answer endpoint that blends search results into AI-generated answers via POST /v1/answer.
    - Body: `query` (required), `system_instructions`, `structured_output`, `search_type`, `fast_mode`, `data_max_price`, `included_sources`, `excluded_sources`, `start_date`, `end_date`, `country_code`, `streaming`
    - Docs: https://docs.valyu.ai/api-reference/endpoint/answer
  - `POST /v1/contents` - $0.01 - Reference for the Valyu Contents endpoint that extracts clean, structured content from any URL via POST /v1/contents.
    - Body: `urls` (required), `response_length`, `max_price_dollars`, `extract_effort`, `screenshot`, `summary`
    - Docs: https://docs.valyu.ai/api-reference/endpoint/contents
  - `POST /v1/deepresearch/batches` - $0.01 - Reference for creating a new batch via POST /v1/deepresearch/batches.
    - Body: `name`, `mode`, `output_formats`, `search`, `webhook_url`, `metadata`
    - Docs: https://docs.valyu.ai/api-reference/endpoint/deepresearch-batch-create
  - `POST /v1/deepresearch/tasks` - $0.01 - Reference for creating a new deep research task via POST /v1/deepresearch/tasks.
    - Body: `query` (required), `mode`, `model`, `output_formats`, `strategy`, `search`, `urls`, `files`, `mcp_servers`, `code_execution`, `previous_reports`, `webhook_url`, `metadata`, `deliverables`
    - Docs: https://docs.valyu.ai/api-reference/endpoint/deepresearch-create
  - `POST /v1/deepresearch/batches/{id}/tasks` - $0.01 - Reference for adding tasks to a batch via POST /v1/deepresearch/batches//tasks.
    - Body: `tasks` (required)
    - Docs: https://docs.valyu.ai/api-reference/endpoint/deepresearch-batch-add-tasks

### Brand.dev API ✓
- **Slug**: `brand-dev`
- **Description**: API to personalize your product with logos, colors, and company info from any domain.
- **Target API**: https://api.brand.dev
- **Endpoints**:
  - `GET /v1/brand/fonts` - $0.03 - Extract font information from a brand’s website including font families, usage statistics, fallbacks, and element/word counts.
    - Query: `domain` (required), `timeoutMS`
    - Docs: https://docs.brand.dev/api-reference/screenshot-styleguide/extract-fonts-from-website
  - `GET /v1/brand/transaction_identifier` - $0.03 - Endpoint specially designed for platforms that want to identify transaction data by the transaction title.
    - Query: `transaction_info` (required), `force_language`, `maxSpeed`, `country_gl`, `city`, `mcc`, `phone`, `timeoutMS`
    - Docs: https://docs.brand.dev/api-reference/retrieve-brand/identify-brand-from-transaction-data
  - `GET /v1/brand/naics` - $0.03 - Endpoint to classify any brand into a 2022 NAICS code.
    - Query: `input` (required), `timeoutMS`, `minResults`, `maxResults`
    - Docs: https://docs.brand.dev/api-reference/industry-classification/retrieve-naics-code-for-any-brand
  - `GET /v1/brand/retrieve-by-email` - $0.03 - Retrieve brand information using an email address while detecting disposable and free email addresses. This endpoint extracts the domain from the email address and returns brand data for that domain. Disposable and free email addresses (like gmail.com, yahoo.com) will throw a 422 error.
    - Query: `email` (required), `force_language`, `maxSpeed`, `timeoutMS`
    - Docs: https://docs.brand.dev/api-reference/retrieve-brand/retrieve-brand-data-by-email-address
  - `GET /v1/brand/retrieve-simplified` - $0.03 - Returns a simplified version of brand data containing only essential information: domain, title, colors, logos, and backdrops. This endpoint is optimized for faster responses and reduced data transfer.
    - Query: `domain` (required), `timeoutMS`
    - Docs: https://docs.brand.dev/api-reference/retrieve-brand/retrieve-simplified-brand-data-by-domain
  - `GET /v1/brand/retrieve-by-isin` - $0.03 - Retrieve brand information using an ISIN (International Securities Identification Number). This endpoint looks up the company associated with the ISIN and returns its brand data.
    - Query: `isin` (required), `force_language`, `maxSpeed`, `timeoutMS`
    - Docs: https://docs.brand.dev/api-reference/retrieve-brand/retrieve-brand-data-by-isin
  - `POST /v1/brand/ai/products` - $0.03 - Beta feature: Extract product information from a brand’s website. Brand.dev will analyze the website and return a list of products with details such as name, description, image, pricing, features, and more.
    - Body: `domain` (required), `maxProducts`, `timeoutMS`
    - Docs: https://docs.brand.dev/api-reference/ai-data-extraction/extract-products-from-a-brands-website
  - `GET /v1/brand/retrieve` - $0.03 - Retrieve logos, backdrops, colors, industry, description, and more from any domain
    - Query: `domain` (required), `force_language`, `maxSpeed`, `timeoutMS`
    - Docs: https://docs.brand.dev/api-reference/retrieve-brand/retrieve-brand-data-by-domain
  - `GET /v1/brand/retrieve-by-name` - $0.03 - Retrieve brand information using a company name. This endpoint searches for the company by name and returns its brand data.
    - Query: `name` (required), `force_language`, `maxSpeed`, `timeoutMS`
    - Docs: https://docs.brand.dev/api-reference/retrieve-brand/retrieve-brand-data-by-company-name
  - `GET /v1/brand/retrieve-by-ticker` - $0.03 - Retrieve brand information using a stock ticker symbol. This endpoint looks up the company associated with the ticker and returns its brand data.
    - Query: `ticker` (required), `ticker_exchange`, `force_language`, `maxSpeed`, `timeoutMS`
    - Docs: https://docs.brand.dev/api-reference/retrieve-brand/retrieve-brand-data-by-stock-ticker
  - `GET /v1/brand/styleguide` - $0.03 - Automatically extract comprehensive design system information from a brand’s website including colors, typography, spacing, shadows, and UI components.
    - Query: `domain` (required), `timeoutMS`, `prioritize`
    - Docs: https://docs.brand.dev/api-reference/screenshot-styleguide/extract-design-system-and-styleguide-from-website
  - `GET /v1/brand/screenshot` - $0.03 - Capture a screenshot of a website. Supports both viewport (standard browser view) and full-page screenshots. Can also screenshot specific page types (login, pricing, etc.) by using heuristics to find the appropriate URL. Returns a URL to the uploaded screenshot image hosted on our CDN.
    - Query: `domain` (required), `fullScreenshot`, `page`, `prioritize`
    - Docs: https://docs.brand.dev/api-reference/screenshot-styleguide/take-screenshot-of-website
  - `POST /v1/brand/ai/query` - $0.03 - Use AI to extract specific data points from a brand’s website. The AI will crawl the website and extract the requested information based on the provided data points.
    - Body: `domain` (required), `data_to_extract` (required), `timeoutMS`, `specific_pages`
    - Docs: https://docs.brand.dev/api-reference/ai-data-extraction/query-website-data-using-ai

### Andi Search API ✓
- **Slug**: `andi`
- **Description**: AI Search for the Next Generation
- **Target API**: https://search-api.andisearch.com/api
- **Endpoints**:
  - `GET /v1/search` - $0.01 - Fast, high-quality search API with intelligent ranking, instant answers, and result enrichment.
    - Query: `q` (required), `limit`, `depth`, `intent`, `metadata`, `format`, `extracts`, `safe`, `country`, `language`, `units`, `noCache `, `dateRange`, `includeDomains`, `excludeDomains`, `includeTerms`, `excludeTerms`, `parseOperators`
    - Docs: https://www.andi.co/api

### Hunter
- **Slug**: `hunter`
- **Description**: Hunter.io API for finding and verifying professional email addresses. Domain search, email finder, email verification, and company/person enrichment.
- **Target API**: https://api.hunter.io
- **Endpoints**:
  - `GET /v2/combined/find` - $0.01 - Get both person AND company information from an email address in a single request.
    - Query: `email` (required)
  - `GET /v2/people/find` - $0.01 - Get detailed person information from an email address - name, location, employment, social profiles.
    - Query: `email`, `linkedin_handle`
  - `GET /v2/email-count` - $0.01 - Get count of email addresses we have for a domain, broken down by department and seniority. FREE endpoint.
    - Query: `domain`, `company`, `type`
  - `POST /v2/discover` - $0.01 - Find companies matching criteria using filters or natural language. Returns up to 100 companies per request. FREE endpoint.
    - Body: `query`, `headquarters_location`, `industry`, `headcount`, `limit`, `offset`
  - `GET /v2/companies/find` - $0.01 - Get detailed company information from a domain - industry, description, location, size, tech stack, funding.
    - Query: `domain` (required)
  - `GET /v2/domain-search` - $0.01 - Find all email addresses for a domain. Returns emails with sources, confidence scores, and verification status.
    - Query: `domain` (required), `limit`, `offset`, `type`, `seniority`, `department`
  - `GET /v2/email-finder` - $0.01 - Find the most likely email address for a person given their name and company domain.
    - Query: `domain`, `company`, `first_name`, `last_name`, `full_name`, `linkedin_handle`
  - `GET /v2/email-verifier` - $0.01 - Verify if an email address is deliverable. Returns status (valid, invalid, accept_all, webmail, disposable, unknown).
    - Query: `email` (required)

### SearchAPI
- **Slug**: `searchapi`
- **Description**: Real-time SERP scraping API - Search YouTube, Google, Amazon, TikTok, Instagram, and 100+ other platforms
- **Target API**: https://www.searchapi.io
- **Endpoints**:
  - `GET /api/v1/search` - $0.01 - Search TripAdvisor listings
    - Query: `engine` (required), `q` (required), `tripadvisor_domain`, `category`, `location`, `lat`, `lon`, `page`, `num`
  - `GET /api/v1/search` - $0.01 - Get comments on a YouTube video
    - Query: `engine` (required), `video_id` (required), `gl`, `hl`, `next_page_token`
  - `GET /api/v1/search` - $0.01 - Get YouTube channel info
    - Query: `engine` (required), `channel_id` (required), `gl`, `hl`
  - `GET /api/v1/search` - $0.01 - Search Reddit ads library
    - Query: `engine` (required), `q` (required), `industry`, `objective_type`, `budget_category`, `placements`, `post_type`
  - `GET /api/v1/search` - $0.01 - Search Meta/Facebook ads library
    - Query: `engine` (required), `q`, `page_id`, `location_id`, `country`, `content_languages`, `active_status`, `ad_type`, `media_type`, `platforms`, `sort_by`, `start_date`, `end_date`, `next_page_token`
  - `GET /api/v1/search` - $0.01 - Get video transcript/captions
    - Query: `engine` (required), `video_id` (required), `lang`, `transcript_type`, `transcript_name`, `only_available`
  - `GET /api/v1/search` - $0.01 - Search Amazon products
    - Query: `engine` (required), `q` (required), `amazon_domain`, `language`, `delivery_country`, `page`, `sort_by`, `price_min`, `price_max`, `rh`
  - `GET /api/v1/search` - $0.01 - Search eBay listings
    - Query: `engine` (required), `q` (required), `ebay_domain`, `country`, `delivery_country`, `page`, `num`, `layout`, `sort_by`, `price_min`, `price_max`, `condition`, `buying_format`, `category_id`, `postal_code`, `distance_radius`
  - `GET /api/v1/search` - $0.01 - Get detailed info about a YouTube video
    - Query: `engine` (required), `video_id` (required), `gl`, `hl`
  - `GET /api/v1/search` - $0.01 - Get videos from a YouTube channel
    - Query: `engine` (required), `channel_id` (required), `gl`, `hl`
  - `GET /api/v1/search` - $0.01 - Search Apple App Store apps
    - Query: `engine` (required), `term` (required), `country`, `lang`, `page`, `num`, `device`, `property`, `include_explicit`
  - `GET /api/v1/search` - $0.01 - Search Airbnb listings
    - Query: `engine` (required), `q` (required), `airbnb_domain`, `currency`, `check_in_date`, `check_out_date`, `time_period`, `adults`, `children`, `infants`, `pets`, `price_min`, `price_max`, `bedrooms`, `beds`, `bathrooms`, `property_types`, `type_of_place`, `amenities`
  - `GET /api/v1/search` - $0.01 - Get TikTok user profile info
    - Query: `engine` (required), `username` (required)
  - `GET /api/v1/search` - $0.01 - Get Instagram profile info
    - Query: `engine` (required), `username` (required)
  - `GET /api/v1/search` - $0.01 - Search Walmart products
    - Query: `engine` (required), `q` (required), `page`, `sort_by`, `price_min`, `price_max`, `category_id`, `store_id`, `filters`
  - `GET /api/v1/search` - $0.01 - Search TikTok ads library
    - Query: `engine` (required), `q`, `advertiser_id`, `country`, `time_period`, `sort_by`, `next_page_token`
  - `GET /api/v1/search` - $0.01 - Search LinkedIn ads library
    - Query: `engine` (required), `q`, `advertiser`, `country`, `time_period`, `next_page_token`
  - `GET /api/v1/search` - $0.01 - Search YouTube videos by query
    - Query: `engine` (required), `q` (required), `sp`, `gl`, `hl`

### Nyne.ai ✓
- **Slug**: `nyne`
- **Description**: People and company intelligence platform. Find contacts, enrich profiles, get social media activity, and discover event attendees.
- **Target API**: https://api.nyne.ai
- **Endpoints**:
  - `GET /person/search` - Free - Poll for person search results using requestId.
    - Query: `request_id` (required)
    - Docs: https://api.nyne.ai/documentation/person/search
  - `GET /person/enrichment` - Free - Poll for person enrichment results using requestId.
    - Query: `request_id` (required)
    - Docs: https://api.nyne.ai/documentation/person/enrichment
  - `GET /person/events` - Free - Poll for person events results using requestId.
    - Query: `request_id` (required)
    - Docs: https://api.nyne.ai/documentation/person/events
  - `GET /person/single-social-lookup` - Free - Poll for single social lookup results using requestId.
    - Query: `request_id` (required)
    - Docs: https://api.nyne.ai/documentation/person/single-social-lookup
  - `GET /person/social-profiles` - Free - Poll for social profiles results using requestId.
    - Query: `request_id` (required)
    - Docs: https://api.nyne.ai/documentation/person/social-profiles
  - `GET /person/interactions` - Free - Poll for interactions results using requestId.
    - Query: `request_id` (required)
    - Docs: https://api.nyne.ai/documentation/person/interactions
  - `GET /company/search` - Free - Poll for company search results using requestId.
    - Query: `request_id` (required)
    - Docs: https://api.nyne.ai/documentation/company/search
  - `GET /company/enrichment` - Free - Poll for company enrichment results using requestId.
    - Query: `request_id` (required)
    - Docs: https://api.nyne.ai/documentation/company/enrichment
  - `GET /company/checkseller` - Free - Poll for checkseller results using requestId.
    - Query: `request_id` (required)
    - Docs: https://api.nyne.ai/documentation/company/checkseller
  - `GET /company/needs` - Free - Poll for company needs results using requestId.
    - Query: `request_id` (required)
    - Docs: https://api.nyne.ai/documentation/company/needs
  - `POST /company/funding` - $0.578 - Start async retrieval of company funding history and investment details.
    - Body: `company_name`, `company_domain`, `callback_url`
    - Docs: https://api.nyne.ai/documentation/company/funding
  - `GET /company/funding` - Free - Poll for company funding results using requestId.
    - Query: `request_id` (required)
    - Docs: https://api.nyne.ai/documentation/company/funding
  - `GET /company/funders` - Free - Poll for company funders results using requestId.
    - Query: `request_id` (required)
    - Docs: https://api.nyne.ai/documentation/company/funders
  - `GET /person/interests` - Free - Poll for interests results using requestId.
    - Query: `request_id` (required)
    - Docs: https://api.nyne.ai/documentation/person/interests
  - `POST /person/interactions` - $0.219 - Start async retrieval of social media interactions. Requires social_media_url and type.
    - Body: `type` (required), `social_media_url` (required), `max_results`, `callback_url`
    - Docs: https://api.nyne.ai/documentation/person/interactions
  - `POST /person/search` - Dynamic pricing - Start async person search by company name, role, geography, and person name. Returns requestId for polling.
    - Body: `query` (required), `limit`, `offset`, `cursor`, `request_id`, `force_new`, `type`, `show_emails`, `show_phone_numbers`, `require_emails`, `require_phone_numbers`, `require_phones_or_emails`, `insights`, `high_freshness`, `profile_scoring`, `callback_url`, `custom_filters`
    - Docs: https://api.nyne.ai/documentation/person/search
  - `POST /company/enrichment` - $0.076 - Start async company enrichment. Requires at least one of: email, phone, or social_media_url.
    - Body: `email`, `phone`, `social_media_url`, `callback_url`
    - Docs: https://api.nyne.ai/documentation/company/enrichment
  - `POST /person/newsfeed` - $0.435 - Start async retrieval of social media newsfeed data from LinkedIn, Twitter, Instagram, GitHub, or Facebook profiles.
    - Body: `social_media_url` (required), `callback_url`
    - Docs: https://api.nyne.ai/documentation/person/newsfeed
  - `POST /person/interests` - $0.363 - Start async retrieval of interests, skills, and topics a person engages with.
    - Body: `email`, `phone`, `social_media_url`, `callback_url`
    - Docs: https://api.nyne.ai/documentation/person/interests
  - `POST /company/search` - $0.363 - Start async company search. Requires at least one of: industry or website_keyword.
    - Body: `industry`, `website_keyword`, `location`, `max_results`, `validate_keyword`, `callback_url`
    - Docs: https://api.nyne.ai/documentation/company/search
  - `POST /company/funders` - $1.44 - Start async retrieval of investors and funders associated with a company.
    - Body: `company_name`, `company_domain`, `callback_url`
    - Docs: https://api.nyne.ai/documentation/company/funders
  - `POST /person/events` - $0.219 - Start async retrieval of life events and career milestones. Requires event parameter.
    - Body: `event` (required), `company_name`, `role`, `industry`, `location`, `callback_url`
    - Docs: https://api.nyne.ai/documentation/person/events
  - `POST /person/social-profiles` - $0.363 - Start async retrieval of all social media profiles associated with a person.
    - Body: `email`, `phone`, `social_media_url`, `callback_url`
    - Docs: https://api.nyne.ai/documentation/person/social-profiles
  - `POST /person/single-social-lookup` - $0.148 - Start async lookup of a single social media profile. Requires both social_media_url and site.
    - Body: `social_media_url`, `email`, `site` (required), `callback_url`
    - Docs: https://api.nyne.ai/documentation/person/single-social-lookup
  - `POST /company/checkseller` - $0.148 - Start async check if a company sells a specific product/service.
    - Body: `company_name` (required), `product_service` (required), `callback_url`
    - Docs: https://api.nyne.ai/documentation/company/checkseller
  - `POST /person/enrichment` - Dynamic pricing - Start async person enrichment. Requires at least one of: email, phone, or social_media_url.
    - Body: `email`, `phone`, `social_media_url`, `name`, `company`, `callback_url`, `newsfeed`, `ai_enhanced_search`, `strict_email_check`, `lite_enrich`, `probability_score`
    - Docs: https://api.nyne.ai/documentation/person/enrichment
  - `GET /person/newsfeed` - Free - Poll for person newsfeed results using requestId.
    - Query: `request_id` (required)
    - Docs: https://api.nyne.ai/documentation/person/newsfeed
  - `POST /company/needs` - $0.219 - Start async analysis of company needs based on provided content.
    - Body: `company_name` (required), `content` (required), `filing`, `callback_url`
    - Docs: https://api.nyne.ai/documentation/company/needs


## Browse APIs

Visit https://orthogonal.com/discover to browse all available APIs with detailed documentation, pricing, and integration examples.

## Support

- Documentation: https://orthogonal.com/dashboard/docs
- Book a call: https://orthogonal.com/book