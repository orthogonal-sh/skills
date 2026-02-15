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
orth run linkup /fetch --body '{"url": "https://api.example.com/health"}'
```

### Step 2: Test POST Endpoints
Test POST requests by fetching API docs:

```bash
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://api.example.com/docs",
  "user_prompt": "Extract all API endpoints, methods, parameters, and example responses"
}'
```

### Step 3: Get API Documentation
Fetch and parse API docs:

```bash
orth run scrapegraph /v1/markdownify --body '{"website_url": "https://api.example.com/docs"}'
```

### Step 4: Validate Response Schema
Check response structure:

```bash
orth run riveter /v1/run --body '{
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
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://stripe.com/docs/api",
  "user_prompt": "Extract API authentication methods and example curl commands"
}'

# Fetch API page
orth run linkup /fetch --body '{"url": "https://api.openai.com/v1/models"}'
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
