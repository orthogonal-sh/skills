---
name: valyu
description: "Use when the agent needs to search the web, proprietary datasets, or news sources, get AI-generated answers grounded in search results, extract clean structured content from URLs, or run async deep research tasks with batch support via the Valyu API through orth."
---

# Valyu

Valyu provides four core capabilities through the `orth` CLI: real-time search across web, proprietary, and news datasets; AI-generated answers blended from search results; structured content extraction from URLs; and asynchronous deep research tasks that run for minutes to hours and produce reports, PDFs, or structured data. Deep research tasks support batching for parallel execution at scale.

## Workflow

1. **Determine the goal.** The agent identifies whether the user needs quick information retrieval (search/answer), content extraction from known URLs, or in-depth research on a complex topic.
2. **Select the right capability:**
   - For factual lookups or sourced results, the agent uses **Search** (`POST /v1/search`).
   - For a synthesized, AI-generated response grounded in search results, the agent uses **Answer** (`POST /v1/answer`).
   - For extracting clean text or screenshots from specific URLs, the agent uses **Contents** (`POST /v1/contents`).
   - For complex, long-running research that requires deep analysis, the agent uses **Deep Research** (`POST /v1/deepresearch/tasks`).
3. **Configure parameters.** The agent sets search type, filters, output format, and mode based on the user's requirements (see parameter references below).
4. **Execute the request.** The agent runs the appropriate `orth api run valyu` command.
5. **For deep research, monitor and manage.** Since tasks run asynchronously, the agent polls status, optionally adds follow-up instructions before the writing phase, and retrieves results when complete. For multiple related queries, the agent creates a batch and adds tasks to it.
6. **Return results.** The agent presents search results, answers, extracted content, or completed research reports to the user.

## Searching the Web, News, and Proprietary Datasets

The agent performs searches via `POST /v1/search`. Three search types are available: `web` for general web content, `proprietary` for Valyu's full-text multimodal indices (arxiv, pubmed, academic content), and `news` for news articles only.

**Parameters:**
- query* (string) - The query string for the search
- search_type (enum<string>) - `web`, `proprietary`, or `news`
- max_num_results (integer) - Maximum results to return (1-20 standard, up to 100 with special API key)
- fast_mode (boolean) - Reduced latency but shorter results; best for general purpose queries
- max_price (number<float>) - Maximum price in dollars per thousand retrievals (CPM); auto-adjusts if omitted
- relevance_threshold (number<float>) - Minimum relevance score (0.0-1.0)
- included_sources (string[]) - Restrict search to specific URLs, domains, or dataset names (e.g., `valyu.ai/blog` searches only that path; `valyu.ai` searches the entire domain)
- excluded_sources (string[]) - Exclude specific URLs, domains, or dataset names from results
- category (string) - Natural language guide phrase to steer relevance (e.g., `agentic use-cases`)
- response_length (default: `short`) - Content length per result: `short` (25k chars), `medium` (50k), `large` (100k), `max` (full), or a custom integer
- country_code (string) - 2-letter ISO country code to bias results geographically
- is_tool_call (boolean) - Tunes retrieval for AI agent tool calls vs. user queries
- start_date (string<date>) - Filter results from this date (YYYY-MM-DD)
- end_date (string<date>) - Filter results until this date (YYYY-MM-DD)
- url_only (boolean) - Return only URLs (no content); applies to `web` and `news` search types

```bash
orth api run valyu /v1/search --body '{"query": "AI agent frameworks comparison"}'
```

## Getting AI-Generated Answers

The agent uses `POST /v1/answer` to get an AI-synthesized response grounded in live search results. This is ideal when the user needs a direct answer rather than a list of sources.

**Parameters:**
- query* (string) - The search query
- system_instructions (string) - Custom instructions for AI processing
- structured_output (object) - JSON schema for structured output; enables JSON mode when provided
- search_type (string) - Type of search to perform
- fast_mode (boolean) - Reduced latency but shorter results
- data_max_price (number) - Maximum price in dollars for data retrieval (search costs only)
- included_sources (string[]) - Restrict to specific URLs, domains, or dataset names
- excluded_sources (string[]) - Exclude specific URLs, domains, or dataset names
- start_date (string) - Start date filter (YYYY-MM-DD)
- end_date (string) - End date filter (YYYY-MM-DD)
- country_code (string) - 2-letter ISO country code for geographic bias
- streaming (boolean) - Enable SSE streaming; returns chunks in order: search_results, content deltas, metadata, then `[DONE]`

```bash
orth api run valyu /v1/answer --body '{"query": "What are the best practices for building AI agents?"}'
```

## Extracting Content from URLs

The agent uses `POST /v1/contents` to extract clean, structured content from up to 10 URLs per request. The agent can control extraction quality, content length, and optionally capture page screenshots.

**Parameters:**
- urls* (string[]) - List of URLs to process (maximum 10 per request)
- response_length (default: `short`) - `short` (25k chars, good for summaries), `medium` (50k, articles), `large` (100k, academic papers), `max` (no limit), or a custom integer
- max_price_dollars (number) - Maximum cost in dollars for the entire request; defaults to 2x estimated cost if omitted
- extract_effort (string) - `normal` (fastest), `high` (better quality, slower), or `auto` (automatically selects effort level)
- screenshot (boolean) - When true, each result includes a `screenshot_url` with a pre-signed URL to a page screenshot
- summary (boolean) - Toggle AI processing (default: false)

```bash
orth api run valyu /v1/contents --body '{"urls": ["https://example.com/article"]}'
```

## Running Deep Research Tasks

Deep research tasks run asynchronously and produce comprehensive reports. The agent creates a task, monitors its progress, and retrieves results when complete. Three modes control depth and duration.

### Creating a Task

The agent submits a research task via `POST /v1/deepresearch/tasks`.

**Parameters:**
- query* (string) - Research query or task description
- mode (string) - `fast` (~2-5 min, lightweight), `standard` (~10-20 min, balanced), or `heavy` (up to ~90 min, in-depth)
- model (string) - Deprecated; use `mode` instead
- output_formats (string) - `['markdown']`, `['markdown', 'pdf']`, or a JSON schema object for structured output (cannot mix JSON schema with markdown/pdf)
- strategy (string) - Natural language strategy instructions prepended to the system prompt
- search (object) - Search configuration parameters
- urls (string[]) - URLs to extract content from (max 10)
- files (object[]) - File attachments: PDFs, images, documents (max 10)
- mcp_servers (object[]) - MCP server configurations for custom tools (max 5 servers)
- code_execution (boolean) - Enable/disable code execution during research
- previous_reports (string[]) - Previous deep research IDs to use as context (max 3)
- webhook_url (string) - HTTPS URL for webhook notifications; Valyu POSTs full results with `X-Webhook-Signature` and `X-Webhook-Timestamp` headers
- metadata (object) - Custom metadata for tracking
- deliverables (object[]) - Additional file outputs: CSV, Excel, PowerPoint, Word, PDF (max 10)

```bash
orth api run valyu /v1/deepresearch/tasks --body '{"query": "Comprehensive analysis of vector databases market", "mode": "standard"}'
```

### Managing Tasks

The agent monitors and controls running tasks using these endpoints:

- **Get status** via `GET /v1/deepresearch/tasks/{id}/status`:
  ```bash
  orth api run valyu /v1/deepresearch/tasks/{id}/status
  ```
- **Update a running task** via `POST /v1/deepresearch/tasks/{id}/update` (must be sent before the writing phase begins):
  - Parameters: instruction* (string) - Follow-up instruction to add
  ```bash
  orth api run valyu /v1/deepresearch/tasks/{id}/update --body '{"instruction": "Also include pricing comparisons"}'
  ```
- **Cancel a task** via `POST /v1/deepresearch/tasks/{id}/cancel`:
  ```bash
  orth api run valyu /v1/deepresearch/tasks/{id}/cancel
  ```
- **Delete a task** via `DELETE /v1/deepresearch/tasks/{id}/delete`:
  ```bash
  orth api run valyu /v1/deepresearch/tasks/{id}/delete
  ```

### Batch Operations

For running multiple research tasks in parallel, the agent creates a batch and adds tasks to it.

- **Create a batch** via `POST /v1/deepresearch/batches`:
  - Parameters: name (string), mode (enum<string>), output_formats ((string | object)[]), search (object) - applied to all tasks and cannot be overridden per task, webhook_url (string<uri>), metadata (object)
  ```bash
  orth api run valyu /v1/deepresearch/batches --body '{"name": "Competitor Research", "mode": "standard"}'
  ```
- **Add tasks to a batch** via `POST /v1/deepresearch/batches/{id}/tasks`:
  - Parameters: tasks* (object[]) - Array of 1-100 tasks per request
  ```bash
  orth api run valyu /v1/deepresearch/batches/{id}/tasks --body '{"tasks": [{"query": "Company A analysis"}, {"query": "Company B analysis"}]}'
  ```
- **Get batch status** via `GET /v1/deepresearch/batches/{id}`:
  ```bash
  orth api run valyu /v1/deepresearch/batches/{id}
  ```
- **List batch tasks** via `GET /v1/deepresearch/batches/{id}/tasks`:
  ```bash
  orth api run valyu /v1/deepresearch/batches/{id}/tasks
  ```
- **Cancel a batch** via `POST /v1/deepresearch/batches/{id}/cancel`:
  ```bash
  orth api run valyu /v1/deepresearch/batches/{id}/cancel
  ```

## Examples

### Example 1: Research a topic and get sourced results

The user asks for recent news about a specific technology. The agent searches news sources with a date filter.

```bash
orth api run valyu /v1/search --body '{"query": "large language model regulation 2025", "search_type": "news", "max_num_results": 10, "start_date": "2025-01-01", "country_code": "US"}'
```

The agent receives a list of news articles with titles, URLs, and content snippets, then summarizes the findings for the user.

### Example 2: Extract and summarize content from competitor pages

The user provides three competitor URLs and wants structured summaries. The agent extracts content with AI summarization enabled.

```bash
orth api run valyu /v1/contents --body '{"urls": ["https://competitor-a.com/pricing", "https://competitor-b.com/pricing", "https://competitor-c.com/pricing"], "response_length": "medium", "extract_effort": "high", "summary": true}'
```

The agent receives clean, structured content from each page with AI-generated summaries and presents a comparison to the user.

### Example 3: Run deep research with batch processing

The user needs market analysis reports for five product categories. The agent creates a batch and adds all tasks, then monitors completion.

```bash
# Step 1: Create the batch
orth api run valyu /v1/deepresearch/batches --body '{"name": "Q1 Market Analysis", "mode": "standard"}'

# Step 2: Add tasks (using the returned batch ID)
orth api run valyu /v1/deepresearch/batches/{batch_id}/tasks --body '{"tasks": [{"query": "Cloud infrastructure market analysis 2025"}, {"query": "AI chipset market trends and forecast"}, {"query": "Edge computing adoption in enterprise"}]}'

# Step 3: Monitor batch progress
orth api run valyu /v1/deepresearch/batches/{batch_id}
```

The agent polls batch status periodically and retrieves individual task results as they complete.

## Discover More

The agent can list all available Valyu endpoints and inspect specific endpoint details:

```bash
orth api show valyu              # List all endpoints
orth api show valyu /v1/deepresearch   # Get endpoint details
```
