---
name: docs-generator
description: Generate documentation - API docs, READMEs, guides from code or specs
---

# Docs Generator - Automated Documentation

Generate high-quality documentation from code, APIs, and specifications.

## Workflow

### Step 1: Extract Code Structure
Fetch and analyze code:

```bash
curl -X POST "https://api.orth.sh/v1/run/linkup/fetch" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"url": "https://raw.githubusercontent.com/user/repo/main/src/api.py"}'
```

### Step 2: Generate API Documentation
Use AI to create comprehensive docs:

```bash
curl -X POST "https://api.orth.sh/v1/run/perplexity/chat/completions" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "sonar",
    "messages": [{
      "role": "user",
      "content": "Generate comprehensive API documentation for this Python code. Include: function signatures, parameters, return types, examples, and error handling:\n\n[paste code]"
    }]
  }'
```

### Step 3: Research Best Practices
Find documentation standards:

```bash
curl -X POST "https://api.orth.sh/v1/run/tavily/search" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "API documentation best practices examples OpenAPI Swagger 2024",
    "search_depth": "advanced",
    "include_answer": true
  }'
```

### Step 4: Find Similar Docs
Learn from good documentation:

```bash
curl -X POST "https://api.orth.sh/v1/run/exa/search" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "excellent API documentation examples developer-friendly",
    "num_results": 10,
    "contents": {"text": true}
  }'
```

### Step 5: Convert Existing Docs
Transform documentation format:

```bash
curl -X POST "https://api.orth.sh/v1/run/scrapegraph/v1/markdownify" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"website_url": "https://docs.example.com/api"}'
```

## Example Usage

```bash
# Generate README
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{"role": "user", "content": "Generate a comprehensive README.md for a Python web scraping library. Include: installation, quick start, features, API reference, examples, contributing guide"}]
}'

# Extract docs structure
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://docs.stripe.com/api",
  "user_prompt": "Extract the documentation structure - sections, endpoints, and organization pattern"
}'

# Generate from spec
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{"role": "user", "content": "Convert this OpenAPI spec to human-readable markdown documentation with examples: [spec]"}]
}'
```

## Tips

- Include code examples in every section
- Add error handling documentation
- Keep language simple and clear
- Include quick start guides
