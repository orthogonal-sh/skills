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
curl "https://api.orth.sh/v1/run/linkup/fetch" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"url": "https://api.example.com/health"}'
```

### Step 2: Test POST Endpoints
Test POST requests by fetching API docs:

```bash
curl -X POST "https://api.orth.sh/v1/run/scrapegraph/v1/smartscraper" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "website_url": "https://api.example.com/docs",
    "user_prompt": "Extract all API endpoints, methods, parameters, and example responses"
  }'
```

### Step 3: Get API Documentation
Fetch and parse API docs:

```bash
curl -X POST "https://api.orth.sh/v1/run/scrapegraph/v1/markdownify" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"website_url": "https://api.example.com/docs"}'
```

### Step 4: Generate Test Cases
Use AI to create test scenarios:

```bash
curl -X POST "https://api.orth.sh/v1/run/perplexity/chat/completions" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "sonar",
    "messages": [{
      "role": "user",
      "content": "Generate comprehensive test cases for a REST API user endpoint that supports GET, POST, PUT, DELETE. Include edge cases and error scenarios."
    }]
  }'
```

### Step 5: Validate Response Schema
Check response structure:

```bash
curl -X POST "https://api.orth.sh/v1/run/riveter/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
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
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://stripe.com/docs/api",
  "user_prompt": "Extract API authentication methods and example curl commands"
}'

# Generate API test plan
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{"role": "user", "content": "Create a test plan for testing a payment processing API"}]
}'

# Fetch API page
orth api run linkup /fetch --body '{"url": "https://api.openai.com/v1/models"}'
```

## Tips

- Test both happy paths and error cases
- Verify response schemas match documentation
- Check rate limits and authentication
- Document any discrepancies found
