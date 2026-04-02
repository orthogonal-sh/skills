---
name: parallel
description: "Use when the user needs to search the web, extract content from URLs, run research tasks asynchronously, or find entities in bulk via the Parallel web research API. Parallel provides an OpenAI-compatible chat completions interface, structured web search, content extraction, long-running task runs, and FindAll for bulk entity discovery — all accessible through `orth api run parallel`."
---

# Parallel

Parallel is a web research API accessible via `orth api run parallel`. It offers five core capabilities: **Search** (web queries), **Extract** (pull content from URLs), **Chat API** (OpenAI-compatible completions with built-in web research), **Task Runs** (async long-running research jobs), and **FindAll** (bulk entity discovery matching specific criteria). Responses are OpenAI ChatCompletions-compatible, so existing OpenAI SDK code can use Parallel as a drop-in.

## Workflow

1. **Identify the research goal.** The agent determines whether the user needs a quick web search, content from known URLs, a conversational research answer, a long-running async task, or bulk entity discovery.
2. **Select the right capability:**
   - Single question or quick lookup → **Chat API** (`/chat/completions`)
   - Targeted web search with structured results → **Search** (`/v1beta/search`)
   - Extract text from one or more known URLs → **Extract** (`/v1beta/extract`)
   - Complex research requiring extended processing → **Create Task Run** (`/v1/tasks/runs`), then poll or retrieve results
   - Find many entities matching criteria (e.g. "all AI startups in SF") → **FindAll** (`/v1beta/findall/runs`)
3. **Build and send the request.** The agent constructs the `orth api run parallel` command with the appropriate endpoint and `--body` JSON payload.
4. **Handle async results (Task Runs and FindAll only).** If the request returns a queued run, the agent retrieves the `run_id` or `findall_id` from the response, then polls for status or fetches the result when ready.
5. **Return findings to the user.** The agent summarises the response, citing sources where available.

## Searching the Web

The Search endpoint performs web searches guided by natural language objectives or keyword queries. To access this endpoint, the agent passes the `parallel-beta` header with value `search-extract-2025-10-10`.

**Endpoint:** `POST /v1beta/search`

Parameters:
- mode (enum<string> | null) - Request to Search API.
- objective (string | null) - Natural-language description of what the web search is trying to find. May include guidance about preferred sources or freshness. At least one of objective or search_queries must be provided.
- search_queries (string[] | null) - Optional list of traditional keyword search queries to guide the search. May contain search operators. At least one of objective or search_queries must be provided.
- processor (enum<string> | null) - DEPRECATED: use mode instead.
- max_results (integer | null) - Upper bound on the number of results to return. May be limited by the processor. Defaults to 10 if not provided.
- max_chars_per_result (integer | null) - DEPRECATED: Use excerpts.max_chars_per_result instead.
- excerpts (object) - Optional settings to configure excerpt generation.
- source_policy (object) - Optional source policy governing domain and date preferences in search results.
- fetch_policy (object) - Fetch policy: determines when to return cached content from the index (faster) vs fetching live content (fresher). Default is to disable live fetch and return cached content from the index.

```bash
orth api run parallel /v1beta/search --body ‘{"objective": "AI agent frameworks comparison 2024"}’
```

## Extracting Content from URLs

The Extract endpoint pulls relevant content from specific web pages. To access this endpoint, the agent passes the `parallel-beta` header with value `search-extract-2025-10-10`.

**Endpoint:** `POST /v1beta/extract`

Parameters:
- urls* (string[]) - Extract request.
- objective (string) - If provided, focuses extracted content on the specified search objective.
- search_queries (string[]) - If provided, focuses extracted content on the specified keyword search queries.
- fetch_policy (object) - Fetch policy: determines when to return cached content from the index (faster) vs fetching live content (fresher). Default is to use a dynamic policy based on the search objective and url.
- excerpts (boolean) - Include excerpts from each URL relevant to the search objective and queries. Note that if neither objective nor search_queries is provided, excerpts are redundant with full content. default:true
- full_content (boolean) - Include full content from each URL. Note that if neither objective nor search_queries is provided, excerpts are redundant with full content. default:false

```bash
orth api run parallel /v1beta/extract --body ‘{"urls": ["https://example.com/article"]}’
```

## Chat API (OpenAI-Compatible Completions)

The Chat API provides web-research-augmented answers through an OpenAI ChatCompletions-compatible interface, supporting streaming text and structured JSON output.

**Endpoint:** `POST /chat/completions`

Parameters:
- model (string)
- messages (array)
- stream (boolean)
- response_format (object)

```bash
orth api run parallel /chat/completions --body ‘{
  "model": "parallel",
  "messages": [
    {"role": "user", "content": "What are the latest developments in quantum computing?"}
  ]
}’
```

## Running Async Task Runs

Task Runs handle complex, long-running research jobs asynchronously. The agent creates a run, receives a `run_id`, and then retrieves results when complete. Beta features can be enabled by setting the `parallel-beta` header.

### Create Task Run

**Endpoint:** `POST /v1/tasks/runs`

Parameters:
- processor* (string) - Task run input with additional beta fields.
- input* (string) - Input to the task, either text or a JSON object.
- metadata (object) - User-provided metadata stored with the run. Keys and values must be strings with a maximum length of 16 and 512 characters respectively.
- source_policy (object) - Optional source policy governing preferred and disallowed domains in web search results.
- task_spec (object) - Task specification. If unspecified, defaults to auto output schema.
- mcp_servers (object[]) - Optional list of MCP servers to use for the run. To enable this feature in requests, specify `mcp-server-2025-07-17` as one of the values in the `parallel-beta` header (for API calls) or `betas` param (for the SDKs).
- enable_events (boolean) - Controls tracking of task run execution progress. When set to true, progress events are recorded and can be accessed via the Task Run events endpoint. When false, no progress events are tracked. Note that progress tracking cannot be enabled after a run has been created. The flag is set to true by default for premium processors (pro and above). To enable this feature, specify `events-sse-2025-07-24` in the `parallel-beta` header.
- webhook (object) - Callback URL (webhook endpoint) that will receive an HTTP POST when the run completes. Not available via the Python SDK. To enable, specify `webhook-2025-08-12` in the `parallel-beta` header.

```bash
orth api run parallel /v1/tasks/runs --body ‘{
  "processor": "base",
  "input": "Research the competitive landscape of AI coding assistants"
}’
```

### Retrieve Task Run Status (free)

Retrieves run status by `run_id`. The run result is available from the `/result` endpoint.

```bash
orth api run parallel /v1/tasks/runs/{run_id}
```

### Retrieve Task Run Result (free)

Retrieves a run result by `run_id`, blocking until the run is completed.

Parameters:
- timeout (integer)

```bash
orth api run parallel /v1/tasks/runs/{run_id}/result
```

### Retrieve Task Run Input (free)

Retrieves the input of a run by `run_id`.

```bash
orth api run parallel /v1/tasks/runs/{run_id}/input
```

## Bulk Entity Discovery with FindAll

FindAll discovers many entities matching specific criteria (e.g. "all AI startups in San Francisco"). The agent creates a run, then polls or subscribes for results.

### Ingest FindAll Run

Transforms a natural language search objective into a structured FindAll spec. Access requires the `parallel-beta` header. The generated specification serves as a suggested starting point and can be further customized.

**Endpoint:** `POST /v1beta/findall/ingest`

Parameters:
- objective* (string) - Input model for FindAll ingest.

```bash
orth api run parallel /v1beta/findall/ingest --body ‘{"objective": "Find all AI startups in San Francisco"}’
```

### Create FindAll Run

Starts a FindAll run. Returns immediately with status `queued`. The agent can track progress by polling status, subscribing to real-time events via `/v1beta/findall/runs/{findall_id}/events`, or specifying a webhook during creation.

**Endpoint:** `POST /v1beta/findall/runs`

Parameters:
- objective* (string) - Input model for FindAll run.
- entity_type* (string) - Type of the entity for the FindAll run.
- match_conditions* (MatchCondition · object[]) - List of match conditions for the FindAll run.
- generator* (enum<string>) - Generator for the FindAll run. One of base, core, pro, preview.
- match_limit* (integer) - Maximum number of matches to find for this FindAll run. Must be between 5 and 1000 (inclusive).
- exclude_list (ExcludeCandidate · object[] | null) - List of entity names/IDs to exclude from results.
- metadata (Metadata · object) - Metadata for the FindAll run.
- webhook (Webhook · object) - Webhook for the FindAll run.

```bash
orth api run parallel /v1beta/findall/runs --body ‘{
  "objective": "Find all AI startups in San Francisco"
}’
```

### Retrieve FindAll Run Status (free)

```bash
orth api run parallel /v1beta/findall/runs/{findall_id}
```

### Retrieve FindAll Run Result (free)

Returns the FindAll run result snapshot at the time of the request.

```bash
orth api run parallel /v1beta/findall/runs/{findall_id}/result
```

### Cancel FindAll Run (free)

```bash
orth api run parallel /v1beta/findall/runs/{findall_id}/cancel
```

## Examples

### Example 1: Quick research question via Chat API

The user asks "What are the top open-source LLM frameworks?" The agent uses the Chat API for a conversational, sourced answer:

```bash
orth api run parallel /chat/completions --body ‘{
  "model": "parallel",
  "messages": [
    {"role": "user", "content": "What are the top open-source LLM frameworks in 2024? Compare features and community adoption."}
  ]
}’
```

The agent receives a ChatCompletions-compatible response with web-sourced information and presents the summary to the user.

### Example 2: Search then extract details from a result

The user wants detailed pricing info from a competitor’s website. The agent first searches, then extracts:

```bash
# Step 1: Search for the competitor’s pricing page
orth api run parallel /v1beta/search --body ‘{
  "objective": "Acme Corp SaaS pricing page",
  "max_results": 5
}’

# Step 2: Extract pricing details from a discovered URL
orth api run parallel /v1beta/extract --body ‘{
  "urls": ["https://acmecorp.com/pricing"],
  "objective": "pricing tiers and features"
}’
```

### Example 3: Async bulk entity discovery with FindAll

The user needs a list of all fintech companies in London with Series B funding. The agent uses FindAll for bulk discovery:

```bash
# Step 1: Create the FindAll run
orth api run parallel /v1beta/findall/runs --body ‘{
  "objective": "Find all fintech companies in London with Series B funding",
  "entity_type": "company",
  "match_conditions": [{"field": "location", "value": "London"}, {"field": "funding_stage", "value": "Series B"}],
  "generator": "core",
  "match_limit": 100
}’

# Step 2: Poll for status using the returned findall_id
orth api run parallel /v1beta/findall/runs/{findall_id}

# Step 3: Retrieve results when status is complete
orth api run parallel /v1beta/findall/runs/{findall_id}/result
```

## Discover More

For full endpoint details and parameters:

```bash
orth api show parallel              # List all endpoints
orth api show parallel /v1beta/findall   # Get endpoint details
```
