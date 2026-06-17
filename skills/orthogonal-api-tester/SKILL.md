---
name: api-tester
description: Test and document API endpoints - validate responses, check status, generate examples
---

# API Tester - Test Any API Endpoint

Test API endpoints, validate responses, and generate documentation examples.

## Workflow

### Step 1: Test GET Endpoints
Make GET requests to test endpoints:

```bash
orth api run linkup /fetch --body '{"url": "https://api.example.com/health"}'
```

### Step 2: Test POST Endpoints
Test POST requests by fetching API docs:

```bash
orth api run scrapegraph /api/extract --body '{
  "url": "https://api.example.com/docs",
  "prompt": "Extract all API endpoints, methods, parameters, and example responses"
}'
```

### Step 3: Get API Documentation
Fetch and parse API docs:

```bash
orth api run scrapegraph /api/scrape --body '{"url": "https://api.example.com/docs", "formats": [{"type": "markdown"}]}'
```

### Step 4: Validate Response Schema
Check response structure:

```bash
orth api run riveter /v1/run --body '{
  "url": "https://api.example.com/endpoint",
  "schema": {
    "id": "string",
    "name": "string",
    "created_at": "string"
  }
}'
```

## Example Usage

```bash
# Extract API spec from docs
orth api run scrapegraph /api/extract --body '{
  "url": "https://stripe.com/docs/api",
  "prompt": "Extract API authentication methods and example curl commands"
}'

# Fetch API page
orth api run linkup /fetch --body '{"url": "https://api.openai.com/v1/models"}'
```

## Tips

- Test both happy paths and error cases
- Verify response schemas match documentation
- Check rate limits and authentication
- Document any discrepancies found

## Discover More

List all endpoints, or add a path for parameter details:

```bash
orth api show linkup
orth api show riveter
orth api show scrapegraph
```

Example: `orth api show olostep /v1/scrapes` for endpoint parameters.
