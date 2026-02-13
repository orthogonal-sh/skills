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
orth api run linkup /fetch --body '{"url": "https://raw.githubusercontent.com/user/repo/main/src/api.py"}'
```

### Step 2: Generate API Documentation
Use AI to create comprehensive docs:

```bash
orth api run perplexity /chat/completions --body '{
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
orth api run tavily /search --body '{
  "query": "API documentation best practices examples OpenAPI Swagger 2024",
  "search_depth": "advanced",
  "include_answer": true
}'
```

### Step 4: Find Similar Docs
Learn from good documentation:

```bash
orth api run exa /search --body '{
  "query": "excellent API documentation examples developer-friendly",
  "num_results": 10,
  "contents": {"text": true}
}'
```

### Step 5: Convert Existing Docs
Transform documentation format:

```bash
orth api run scrapegraph /v1/markdownify --body '{"website_url": "https://docs.example.com/api"}'
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

## Discover More

List all endpoints, or add a path for parameter details:

```bash
orth api show exa
orth api show linkup
orth api show perplexity
orth api show scrapegraph
orth api show tavily 
```

Example: `orth api show olostep /v1/scrapes` for endpoint parameters.
