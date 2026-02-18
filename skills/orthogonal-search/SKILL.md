---
name: search
description: Search the web, platforms, and datasets. Use when asked to search, find, look up, research, or discover information from the web, YouTube, Amazon, eBay, news, academic sources, or any online platform.
---

# Search — General-Purpose Web & Platform Search

Search the web, platforms, and proprietary datasets. Pick the best API for the task — or combine several for comprehensive results.

## 1. Tavily — Comprehensive Web Search & Research

Best for: General web search, deep research reports, site mapping, and crawling.

**Search the web:**
```bash
orth run tavily /search --body '{
  "query": "latest developments in AI agents",
  "search_depth": "advanced",
  "include_answer": true,
  "max_results": 10
}'
```

**Deep research** (async — returns a report with citations):
```bash
# Step 1: Start research task
orth run tavily /research --body '{"input": "Compare AI agent frameworks for production use", "model": "pro"}'
# Step 2: Poll for results using request_id
orth run tavily /research/{request_id}
```

**Map a website** (discover all URLs):
```bash
orth run tavily /map --body '{"url": "https://docs.example.com", "limit": 200}'
```

**Crawl a website** (extract content from multiple pages):
```bash
orth run tavily /crawl --body '{
  "url": "https://docs.example.com",
  "max_depth": 3,
  "limit": 50
}'
```

Key parameters: `search_depth` (basic/fast/advanced/ultra-fast), `topic` (general/news), `time_range` (day/week/month/year), `include_domains`/`exclude_domains`, `include_answer`, `include_raw_content`, `country`.

## 2. Exa — Neural & Semantic Search

Best for: Finding similar content, semantic/embeddings-based search, category-filtered search (people, companies), and deep research.

**Neural web search:**
```bash
orth run exa /search --body '{
  "query": "startups building AI coding assistants",
  "numResults": 10,
  "type": "auto",
  "contents": {"text": true}
}'
```

**Find similar pages:**
```bash
orth run exa /findSimilar --body '{
  "url": "https://example.com/article",
  "numResults": 10,
  "contents": {"text": true}
}'
```

**Get a sourced AI answer:**
```bash
orth run exa /answer --body '{"query": "What are the best practices for prompt engineering?"}'
```

**Get page contents:**
```bash
orth run exa /contents --body '{"urls": ["https://example.com"], "text": true, "summary": true}'
```

**Deep research** (async):
```bash
# Step 1: Create task
orth run exa /research/v1 --body '{"instructions": "Research the current state of AI coding assistants", "model": "exa-research-pro"}'
# Step 2: Poll with researchId
orth run exa /research/v1/{researchId}
```

Key parameters: `type` (auto/neural/fast/deep), `category` (people/company), `includeDomains`/`excludeDomains`, `startPublishedDate`/`endPublishedDate`, `includeText`/`excludeText`.

## 3. Andi — Fast Web Search

Best for: Quick, high-quality web search with intelligent ranking and instant answers. Low latency.

```bash
orth run andi /v1/search --query 'q=how%20does%20RAG%20work&depth=deep&limit=20'
```

Key parameters: `q` (query), `limit` (1-100), `depth` (fast/deep), `intent` (NewsSearchIntent, VideoSearchIntent, ImageSearchIntent), `dateRange` (day/week/month/year), `includeDomains`/`excludeDomains`, `country`, `language`.

## 4. Linkup — Question-Based Search with Sourced Answers

Best for: Natural language questions, sourced answers with citations, structured output.

**Search with sourced answer:**
```bash
orth run linkup /search --body '{
  "q": "What are the latest AI agent frameworks?",
  "depth": "deep",
  "outputType": "sourcedAnswer"
}'
```

**Structured output search:**
```bash
orth run linkup /search --body '{
  "q": "Top 5 AI startups in 2025",
  "depth": "deep",
  "outputType": "structured",
  "structuredOutputSchema": {
    "type": "object",
    "properties": {
      "startups": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "name": {"type": "string"},
            "description": {"type": "string"},
            "funding": {"type": "string"}
          }
        }
      }
    }
  }
}'
```

Key parameters: `q` (natural language question), `depth` (standard/deep), `outputType` (searchResults/sourcedAnswer/structured), `fromDate`/`toDate`, `includeDomains`/`excludeDomains`, `maxResults`.

## 5. Valyu — Web, Proprietary Datasets & News Search

Best for: Searching across web, academic/proprietary datasets, and news. AI-generated answers. Deep research tasks.

**Web search:**
```bash
orth run valyu /v1/search --body '{"query": "AI agent frameworks comparison", "search_type": "web", "max_num_results": 10}'
```

**Academic/proprietary search:**
```bash
orth run valyu /v1/search --body '{"query": "transformer architecture improvements", "search_type": "proprietary"}'
```

**News search:**
```bash
orth run valyu /v1/search --body '{"query": "OpenAI latest announcements", "search_type": "news"}'
```

**AI-generated answer:**
```bash
orth run valyu /v1/answer --body '{"query": "What are best practices for building AI agents?"}'
```

**Deep research** (async):
```bash
# Step 1: Create task
orth run valyu /v1/deepresearch/tasks --body '{"query": "Comprehensive analysis of vector databases market", "mode": "standard"}'
# Step 2: Poll for status
orth run valyu /v1/deepresearch/tasks/{id}/status
```

Key parameters: `search_type` (web/proprietary/news), `fast_mode`, `included_sources`/`excluded_sources`, `relevance_threshold`, `start_date`/`end_date`, `country_code`.

## 6. SearchAPI — Multi-Platform Search

Best for: Searching specific platforms — Amazon, eBay, Walmart, YouTube, Airbnb, TripAdvisor, app stores, and ad libraries (Meta, TikTok, Reddit, LinkedIn).

All SearchAPI calls use the same endpoint with different `engine` values:

**Amazon product search:**
```bash
orth run searchapi /api/v1/search --query 'engine=amazon_search&q=wireless%20headphones'
```

**eBay search:**
```bash
orth run searchapi /api/v1/search --query 'engine=ebay_search&q=vintage%20watch'
```

**Walmart search:**
```bash
orth run searchapi /api/v1/search --query 'engine=walmart_search&q=laptop'
```

**YouTube search:**
```bash
orth run searchapi /api/v1/search --query 'engine=youtube&q=AI%20agents'
```

**YouTube video details / comments / transcripts:**
```bash
orth run searchapi /api/v1/search --query 'engine=youtube_video&video_id=dQw4w9WgXcQ'
orth run searchapi /api/v1/search --query 'engine=youtube_comments&video_id=dQw4w9WgXcQ'
orth run searchapi /api/v1/search --query 'engine=youtube_transcripts&video_id=dQw4w9WgXcQ'
```

**Airbnb search:**
```bash
orth run searchapi /api/v1/search --query 'engine=airbnb&q=Paris&adults=2&check_in_date=2025-06-01&check_out_date=2025-06-07'
```

**TripAdvisor search:**
```bash
orth run searchapi /api/v1/search --query 'engine=tripadvisor&q=best%20restaurants%20NYC'
```

**Apple App Store:**
```bash
orth run searchapi /api/v1/search --query 'engine=apple_app_store&term=productivity'
```

**Ad library search** (Meta, TikTok, Reddit, LinkedIn):
```bash
orth run searchapi /api/v1/search --query 'engine=meta_ad_library&q=AI%20tools'
orth run searchapi /api/v1/search --query 'engine=tiktok_ads_library&q=AI'
orth run searchapi /api/v1/search --query 'engine=reddit_ad_library&q=software'
orth run searchapi /api/v1/search --query 'engine=linkedin_ad_library&q=hiring'
```

**Social media profiles:**
```bash
orth run searchapi /api/v1/search --query 'engine=tiktok_profile&username=openai'
orth run searchapi /api/v1/search --query 'engine=instagram_profile&username=openai'
```

Available engines: `amazon_search`, `ebay_search`, `walmart_search`, `youtube`, `youtube_video`, `youtube_comments`, `youtube_transcripts`, `youtube_channel`, `youtube_channel_videos`, `airbnb`, `tripadvisor`, `apple_app_store`, `meta_ad_library`, `tiktok_ads_library`, `reddit_ad_library`, `linkedin_ad_library`, `tiktok_profile`, `instagram_profile`.

## Tips

- **General web search**: Start with Tavily (`search_depth: "advanced"`) or Exa (`type: "auto"`) for best relevance
- **Speed matters**: Use Andi for fast results, Tavily `ultra-fast` for lowest latency
- **Sourced answers**: Linkup and Valyu both generate answers with citations — Linkup is best for Q&A, Valyu for blending web + proprietary data
- **Academic/research data**: Valyu's `proprietary` search type covers arxiv, pubmed, and academic datasets
- **News**: Use Valyu (`search_type: "news"`) or Tavily (`topic: "news"`) for current events
- **Deep research**: Tavily, Exa, and Valyu all offer async research tasks — Tavily for web-focused, Exa for comprehensive with citations, Valyu for web + academic mix
- **Find similar content**: Exa's `/findSimilar` is unique — pass a URL and get semantically similar pages
- **Platform-specific search**: SearchAPI is the only option for Amazon, eBay, Walmart, YouTube, Airbnb, TripAdvisor, and ad libraries
- **Domain filtering**: Most APIs support `include_domains`/`exclude_domains` to scope results
- **Async patterns**: Deep research tasks (Tavily, Exa, Valyu) are async — POST to start, GET to poll for results
- **Combine APIs**: For thorough research, run Tavily + Exa + Linkup in parallel and cross-reference results

## Discover More

List all endpoints for any API, or add a path for parameter details:

```bash
orth api show tavily
orth api show exa
orth api show andi
orth api show linkup
orth api show valyu
orth api show searchapi
```

Example: `orth api show tavily /search` for full parameter details.
