---
name: exa
description: Neural web search - find similar content, extract pages, and run deep research
---

# Exa - Neural Web Search & Research

Neural search engine for finding similar content, extracting pages, and deep research.

## Capabilities

- **Exa Research**: Retrieve a paginated list of your research tasks ($0.01)
- **Answer**: Get an LLM answer to a question informed by Exa search results ($0.01)
- **Search**: The search endpoint lets you intelligently search the web and extract contents from the results ($0.01)
- **Get a task**: Retrieve the status and results of a previously created research task ($0.01)
- **Find similar links**: Find similar links to the link provided and optionally return the contents of the pages ($0.01)
- **Create a task**: Create an asynchronous research task that explores the web, gathers sources, synthesizes findings, and returns results with citations ($0.01)
- **Get contents**: Get the full page contents, summaries, and metadata for a list of URLs ($0.01)

## Usage

### Exa Research ($0.01)
Retrieve a paginated list of your research tasks. The response follows a cursor-based pagination pattern. Pass the `limit` parameter to control page size (max 50) and use the `cursor` token returned in the response to fetch subsequent pages.

Parameters:
- cursor (string) - The cursor to paginate through the results Minimum string length: `1`
- limit (number) - Number of results per page (1-50) Required range: `1 <= x <= 50`

```bash
orth api run exa /research/v1
```

### Answer ($0.01)
Get an LLM answer to a question informed by Exa search results. /answer performs an Exa search and uses an LLM to generate either:

A direct answer for specific queries. (i.e.

Parameters:
- query* (string) - The question or query to answer.
- stream (boolean) - If true, the response is returned as a server-sent events (SSS) stream.
- text (boolean) - If true, the response includes full text content in the search results

```bash
orth api run exa /answer --body '{"query": "What are the best practices for prompt engineering?"}'
```

### Search ($0.01)
The search endpoint lets you intelligently search the web and extract contents from the results.By default, it automatically chooses the best search method using Exa’s embeddings-based model and other techniques to find the most relevant results for your query.

Parameters:
- query* (string) - The query string for the search.
- additionalQueries (string[]) - Additional query variations for deep search. Only works with type="deep". When provided, these queries are used alongside the main query for comprehensive results.
- type (enum<string>) - The type of search. Neural uses an embeddings-based model, auto (default) intelligently combines neural and other search methods, fast uses streamlined versions of the search models, and deep provides comprehensive search with query expansion and detailed context.
- category (enum<string>) - A data category to focus on. The people and company categories have improved quality for finding LinkedIn profiles and company pages. Note: The company and people categories only support a limited set of filters. The following parameters are NOT supported for these categories: startPublishedDate, endPublishedDate, startCrawlDate, endCrawlDate, includeText, excludeText, excludeDomains. For people category, includeDomains only accepts LinkedIn domains. Using unsupported parameters will result in a 400 error.
- userLocation (string) - The two-letter ISO country code of the user, e.g. US.
- numResults (integer) - Number of results to return. Limits vary by search type: With "neural": max 100 results With "deep": max 100 results If you want to increase the num results beyond these limits, contact sales (hello@exa.ai)
- includeDomains (string[]) - List of domains to include in the search. If specified, results will only come from these domains.
- excludeDomains (string[]) - List of domains to exclude from search results. If specified, no results will be returned from these domains.
- startCrawlDate (string<date-time>) - Crawl date refers to the date that Exa discovered a link. Results will include links that were crawled after this date. Must be specified in ISO 8601 format.
- endCrawlDate (string<date-time>) - Crawl date refers to the date that Exa discovered a link. Results will include links that were crawled before this date. Must be specified in ISO 8601 format.
- startPublishedDate (string<date-time>) - Only links with a published date after this will be returned. Must be specified in ISO 8601 format.
- endPublishedDate (string<date-time>) - Only links with a published date before this will be returned. Must be specified in ISO 8601 format.
- includeText (string[]) - List of strings that must be present in webpage text of results. Currently, only 1 string is supported, of up to 5 words.
- excludeText (string[]) - List of strings that must not be present in webpage text of results. Currently, only 1 string is supported, of up to 5 words. Checks from the first 1000 words of the webpage text.
- context (string) - Return page contents as a context string for LLM. When true, combines all result contents into one string. We recommend using 10000+ characters for best results, though no limit works best. Context strings often perform better than highlights for RAG applications.
- moderation (boolean) - Enable content moderation to filter unsafe content from search results.
- contents (object)

```bash
orth api run exa /search --body '{
  "query": "startups building AI coding assistants",
  "num_results": 10,
  "contents": {"text": true}
}'
```

### Get a task ($0.01)
Retrieve the status and results of a previously created research task.Use the unique researchId returned from POST /research/v1 to poll until the task is finished.

Parameters:
- stream (string) - Set to "true" to receive real-time updates via Server-Sent Events (SSE)
- events (string) - Set to "true" to include the detailed event log of all operations performed

```bash
orth api run exa /research/v1/{researchId}
```

### Find similar links ($0.01)
Find similar links to the link provided and optionally return the contents of the pages.

Parameters:
- url* (string) - The url for which you would like to find similar links.
- numResults (integer) - Number of results to return. Limits vary by search type: With "neural": max 100 results With "deep": max 100 results If you want to increase the num results beyond these limits, contact sales (hello@exa.ai)
- includeDomains (string[]) - List of domains to include in the search. If specified, results will only come from these domains.
- excludeDomains (string[]) - List of domains to exclude from search results. If specified, no results will be returned from these domains.
- startCrawlDate (string<date-time>) - Crawl date refers to the date that Exa discovered a link. Results will include links that were crawled after this date. Must be specified in ISO 8601 format.
- endCrawlDate (string<date-time>) - Crawl date refers to the date that Exa discovered a link. Results will include links that were crawled before this date. Must be specified in ISO 8601 format.
- startPublishedDate (string<date-time>) - Only links with a published date after this will be returned. Must be specified in ISO 8601 format.
- endPublishedDate (string<date-time>) - Only links with a published date before this will be returned. Must be specified in ISO 8601 format.
- includeText (string[]) - List of strings that must be present in webpage text of results. Currently, only 1 string is supported, of up to 5 words.
- excludeText (string[]) - List of strings that must not be present in webpage text of results. Currently, only 1 string is supported, of up to 5 words. Checks from the first 1000 words of the webpage text.
- context (string) - Return page contents as a context string for LLM. When true, combines all result contents into one string. We recommend using 10000+ characters for best results, though no limit works best. Context strings often perform better than highlights for RAG applications.
- moderation (boolean) - Enable content moderation to filter unsafe content from search results.
- contents (object)

```bash
orth api run exa /findSimilar --body '{
  "url": "https://example.com/article",
  "num_results": 10
}'
```

### Create a task ($0.01)
Create an asynchronous research task that explores the web, gathers sources, synthesizes findings, and returns results with citations.

Parameters:
- instructions* (string) - Instructions for what you would like research on. A good prompt clearly defines what information you want to find, how research should be conducted, and what the output should look like.
- model (enum<string>) - Research model to use. exa-research is faster and cheaper, while exa-research-pro provides more thorough analysis and stronger reasoning.
- outputSchema (object) - JSON Schema to enforce structured output. When provided, the research output will be validated against this schema and returned as parsed JSON.

```bash
orth api run exa /research/v1 --body '{"instructions": "Research the current state of AI coding assistants"}'
```

### Get contents ($0.01)
Get the full page contents, summaries, and metadata for a list of URLs.Returns instant results from our cache, with automatic live crawling as fallback for uncached pages.

Parameters:
- urls* (string[]) - Array of URLs to crawl (backwards compatible with 'ids' parameter).
- ids (string[]) - Deprecated - use 'urls' instead. Array of document IDs obtained from searches.
- text (string) - If true, returns full page text with default settings. If false, disables text return.
- highlights (object) - Text snippets the LLM identifies as most relevant from each page.
- summary (object) - Summary of the webpage
- livecrawl (enum<string>) - Options for livecrawling pages.'never': Disable livecrawling (default for neural search).'fallback': Livecrawl when cache is empty.'preferred': Always try to livecrawl, but fall back to cache if crawling fails.'always': Always live-crawl, never use cache. Only use if you cannot tolerate any cached content. This option is not recommended unless consulted with the Exa team.
- livecrawlTimeout (integer) - The timeout for livecrawling in milliseconds.
- subpages (integer) - The number of subpages to crawl. The actual number crawled may be limited by system constraints.
- subpageTarget (string) - Term to find specific subpages of search results. Can be a single string or an array of strings, comma delimited.
- extras (object) - Extra parameters to pass.
- context (string) - Return page contents as a context string for LLM. When true, combines all result contents into one string. We recommend using 10000+ characters for best results, though no limit works best. Context strings often perform better than highlights for RAG applications.

```bash
orth api run exa /contents --body '{
  "ids": ["https://example.com"],
  "text": true,
  "summary": true
}'
```

## Use Cases

1. **Competitive Research**: Find companies similar to competitors
2. **Content Discovery**: Find related articles and resources
3. **Market Research**: Discover companies in specific niches
4. **Fact-Finding**: Get sourced answers to questions
5. **Deep Research**: Comprehensive research on complex topics

## Discover More

For full endpoint details and parameters:

```bash
orth api show exa              # List all endpoints
orth api show exa <endpoint>   # Get endpoint parameters
```
