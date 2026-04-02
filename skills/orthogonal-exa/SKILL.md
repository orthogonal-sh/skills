---
name: exa
description: "Neural web search engine via the Exa API. Use when the agent needs to search the web semantically, find pages similar to a given URL, extract full page contents from URLs, get LLM-powered answers backed by web sources, or run async deep research tasks with citations. Supports neural, auto, fast, and deep search modes with domain filtering, date ranges, and content extraction."
---

# Exa - Neural Web Search & Research

## Workflow

1. **Determine the task type.** The agent should identify which capability fits the user’s request:
   - Need to find web pages by topic or query? Go to step 2 (Search).
   - Have a URL and need similar pages? Go to step 3 (Find Similar).
   - Have URLs and need their content? Go to step 4 (Get Contents).
   - Need a direct, sourced answer to a question? Go to step 5 (Answer).
   - Need comprehensive, multi-source research with citations? Go to step 6 (Research Tasks).
2. **Search the web.** The agent calls `/search` with a query string. Choose the `type` based on needs: `auto` (default, best general choice), `neural` (embeddings-based semantic search), `fast` (lower latency), or `deep` (comprehensive with query expansion). If results need page text, the agent sets `contents.text: true` in the same call. Proceed to step 7.
3. **Find similar pages.** The agent calls `/findSimilar` with a source URL. The agent can filter by domain, date range, or required text. Proceed to step 7.
4. **Get page contents.** The agent calls `/contents` with an array of URLs. The agent selects what to retrieve: full text, highlights, or summaries. If cached content is insufficient, the agent sets `livecrawl` to `"fallback"` or `"preferred"`. Proceed to step 7.
5. **Get a sourced answer.** The agent calls `/answer` with a question. Exa searches the web and returns an LLM-generated answer with supporting results. The agent can set `text: true` to include full source text. Proceed to step 7.
6. **Run an async research task.** The agent calls `POST /research/v1` with detailed instructions. The agent then polls `GET /research/v1/{researchId}` until the task completes. For structured output, the agent provides an `outputSchema`. Proceed to step 7.
7. **Process results.** The agent reviews the returned data and presents findings to the user, citing sources where available.

## Searching the Web

The `/search` endpoint performs intelligent web search with optional content extraction. By default it uses `auto` mode, which combines neural and keyword methods.

**Search type selection:**
- `auto` (default) — best general-purpose choice; combines methods automatically
- `neural` — pure embeddings-based semantic search; best for conceptual queries
- `fast` — streamlined models for lower latency
- `deep` — comprehensive search with query expansion via `additionalQueries`; best for thorough research

Parameters:
- query* (string) - The query string for the search.
- type (enum<string>) - The type of search: `neural`, `auto` (default), `fast`, or `deep`.
- additionalQueries (string[]) - Additional query variations for deep search. Only works with type="deep". When provided, these queries are used alongside the main query for comprehensive results.
- category (enum<string>) - A data category to focus on. The people and company categories have improved quality for finding LinkedIn profiles and company pages. Note: The company and people categories only support a limited set of filters. The following parameters are NOT supported for these categories: startPublishedDate, endPublishedDate, startCrawlDate, endCrawlDate, includeText, excludeText, excludeDomains. For people category, includeDomains only accepts LinkedIn domains. Using unsupported parameters will result in a 400 error.
- userLocation (string) - The two-letter ISO country code of the user, e.g. US.
- numResults (integer) - Number of results to return. Max 100 for neural and deep types.
- includeDomains (string[]) - List of domains to include in the search. If specified, results will only come from these domains.
- excludeDomains (string[]) - List of domains to exclude from search results.
- startCrawlDate (string<date-time>) - Results crawled after this date. ISO 8601 format.
- endCrawlDate (string<date-time>) - Results crawled before this date. ISO 8601 format.
- startPublishedDate (string<date-time>) - Only links published after this date. ISO 8601 format.
- endPublishedDate (string<date-time>) - Only links published before this date. ISO 8601 format.
- includeText (string[]) - Strings that must appear in results. Currently 1 string supported, up to 5 words.
- excludeText (string[]) - Strings that must not appear in results. Currently 1 string supported, up to 5 words. Checks from the first 1000 words.
- context (string) - When true, combines all result contents into one LLM-ready string. Recommended 10000+ characters for best RAG results.
- moderation (boolean) - Enable content moderation to filter unsafe content.
- contents (object) - Controls what page content to return inline with results.

```bash
orth api run exa /search --body ‘{
  "query": "startups building AI coding assistants",
  "num_results": 10,
  "contents": {"text": true}
}’
```

## Finding Similar Pages

The `/findSimilar` endpoint finds pages semantically similar to a given URL. The agent provides a source URL and receives related pages, with optional content extraction.

Parameters:
- url* (string) - The url for which to find similar links.
- numResults (integer) - Number of results to return. Max 100 for neural and deep types.
- includeDomains (string[]) - Restrict results to these domains only.
- excludeDomains (string[]) - Exclude results from these domains.
- startCrawlDate (string<date-time>) - Results crawled after this date. ISO 8601 format.
- endCrawlDate (string<date-time>) - Results crawled before this date. ISO 8601 format.
- startPublishedDate (string<date-time>) - Only links published after this date. ISO 8601 format.
- endPublishedDate (string<date-time>) - Only links published before this date. ISO 8601 format.
- includeText (string[]) - Strings that must appear in results. Currently 1 string supported, up to 5 words.
- excludeText (string[]) - Strings that must not appear in results. Currently 1 string supported, up to 5 words.
- context (string) - When true, combines all result contents into one LLM-ready string.
- moderation (boolean) - Enable content moderation to filter unsafe content.
- contents (object) - Controls what page content to return inline with results.

```bash
orth api run exa /findSimilar --body ‘{
  "url": "https://example.com/article",
  "num_results": 10
}’
```

## Extracting Page Contents

The `/contents` endpoint retrieves full page text, summaries, and metadata for a list of URLs. Returns instant results from cache, with automatic live crawling as fallback for uncached pages.

Parameters:
- urls* (string[]) - Array of URLs to retrieve (backwards compatible with ‘ids’ parameter).
- ids (string[]) - Deprecated - use ‘urls’ instead. Array of document IDs obtained from searches.
- text (string) - If true, returns full page text with default settings. If false, disables text return.
- highlights (object) - Text snippets the LLM identifies as most relevant from each page.
- summary (object) - Summary of the webpage.
- livecrawl (enum<string>) - Livecrawl options: ‘never’ (default for neural search), ‘fallback’ (crawl when cache is empty), ‘preferred’ (try crawl first, fall back to cache), ‘always’ (never use cache — not recommended unless consulted with Exa team).
- livecrawlTimeout (integer) - The timeout for livecrawling in milliseconds.
- subpages (integer) - The number of subpages to crawl. May be limited by system constraints.
- subpageTarget (string) - Term to find specific subpages. Can be a single string or comma-delimited array.
- extras (object) - Extra parameters to pass.
- context (string) - When true, combines all result contents into one LLM-ready string.

```bash
orth api run exa /contents --body ‘{
  "urls": ["https://example.com"],
  "text": true,
  "summary": true
}’
```

## Getting Sourced Answers

The `/answer` endpoint performs an Exa search and uses an LLM to generate a direct answer backed by web sources.

Parameters:
- query* (string) - The question or query to answer.
- stream (boolean) - If true, the response is returned as a server-sent events (SSE) stream.
- text (boolean) - If true, the response includes full text content in the search results.

```bash
orth api run exa /answer --body ‘{"query": "What are the best practices for prompt engineering?"}’
```

## Running Async Research Tasks

Research tasks allow the agent to launch comprehensive, asynchronous investigations that explore the web, gather sources, synthesize findings, and return results with citations.

### Creating a Task

Parameters:
- instructions* (string) - Detailed instructions for the research. A good prompt clearly defines what information to find, how research should be conducted, and what the output should look like.
- model (enum<string>) - Research model: `exa-research` (faster, cheaper) or `exa-research-pro` (more thorough analysis, stronger reasoning).
- outputSchema (object) - JSON Schema to enforce structured output. The research output will be validated against this schema and returned as parsed JSON.

```bash
orth api run exa /research/v1 --body ‘{"instructions": "Research the current state of AI coding assistants"}’
```

### Polling a Task

The agent uses the `researchId` returned from task creation to poll until the task finishes.

Parameters:
- stream (string) - Set to "true" to receive real-time updates via Server-Sent Events (SSE).
- events (string) - Set to "true" to include the detailed event log of all operations performed.

```bash
orth api run exa /research/v1/{researchId}
```

### Listing Research Tasks

The agent retrieves a paginated list of research tasks. The response uses cursor-based pagination.

Parameters:
- cursor (string) - Cursor to paginate through results. Minimum string length: `1`.
- limit (number) - Number of results per page (1-50). Required range: `1 <= x <= 50`.

```bash
orth api run exa /research/v1
```

## Examples

### Example 1: Competitive landscape research

The user asks: "Find companies building AI developer tools similar to Cursor."

1. The agent searches for relevant companies:
```bash
orth api run exa /search --body ‘{
  "query": "AI coding assistant startups similar to Cursor",
  "type": "deep",
  "numResults": 15,
  "contents": {"text": true}
}’
```
2. The agent reviews results and presents a summary of competing products with links.

### Example 2: Extract and summarize content from known URLs

The user provides three blog post URLs and asks for summaries.

1. The agent fetches contents with summaries enabled:
```bash
orth api run exa /contents --body ‘{
  "urls": [
    "https://blog.example.com/post-1",
    "https://blog.example.com/post-2",
    "https://blog.example.com/post-3"
  ],
  "summary": true,
  "text": false
}’
```
2. The agent presents each summary to the user.

### Example 3: Deep research with structured output

The user asks: "Research the top 5 open-source LLM frameworks and compare them."

1. The agent creates an async research task with a structured schema:
```bash
orth api run exa /research/v1 --body ‘{
  "instructions": "Research the top 5 open-source LLM frameworks. For each, provide the name, GitHub URL, primary language, key features, and community size. Compare their strengths and weaknesses.",
  "model": "exa-research-pro",
  "outputSchema": {
    "type": "object",
    "properties": {
      "frameworks": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "name": {"type": "string"},
            "github_url": {"type": "string"},
            "language": {"type": "string"},
            "key_features": {"type": "array", "items": {"type": "string"}},
            "community_size": {"type": "string"}
          }
        }
      },
      "comparison_summary": {"type": "string"}
    }
  }
}’
```
2. The agent polls for completion:
```bash
orth api run exa /research/v1/{researchId}
```
3. Once complete, the agent presents the structured comparison to the user.

## Discover More

For full endpoint details and parameters:

```bash
orth api show exa              # List all endpoints
orth api show exa /research   # Get endpoint details
```
