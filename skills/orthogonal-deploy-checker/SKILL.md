---
name: deploy-checker
description: Check deployment status - verify endpoints, test health checks, validate responses
---

# Deploy Checker - Verify Deployments

Check deployment status by verifying endpoints, testing health checks, and validating responses.

## Workflow

### Step 1: Check Health Endpoint
Verify the health check endpoint:

```bash
orth api run linkup /fetch --body '{"url": "https://api.yourapp.com/health"}'
```

### Step 2: Validate Homepage
Check if main page loads:

```bash
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://yourapp.com",
  "user_prompt": "Check if page loads correctly. Extract: page title, any error messages, main content presence"
}'
```

### Step 3: Test API Endpoints
Verify critical API endpoints:

```bash
orth api run linkup /fetch --body '{"url": "https://api.yourapp.com/v1/status"}'
```

### Step 4: Compare with Previous Version
Check for breaking changes:

```bash
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://yourapp.com/changelog",
  "user_prompt": "Extract the latest release version and changes"
}'
```

### Step 5: Capture Screenshot
Get visual confirmation:

```bash
orth api run brand-dev /v1/brand/screenshot --query 'domain=yourapp.com'
```

## Deployment Checklist

```bash
DOMAIN="yourapp.com"
API="api.yourapp.com"

# 1. Check health
orth api run linkup /fetch --body "{\"url\": \"https://$API/health\"}"

# 2. Verify homepage
orth api run scrapegraph /v1/smartscraper --body "{
  \"website_url\": \"https://$DOMAIN\",
  \"user_prompt\": \"Check page loads and has no error messages\"
}"

# 3. Test API
orth api run linkup /fetch --body "{\"url\": \"https://$API/v1/users\"}"

# 4. Get screenshot
orth api run brand-dev /v1/brand/screenshot --query "domain=$DOMAIN"
```

## Example Usage

```bash
# Quick health check
orth api run linkup /fetch --body '{"url": "https://api.example.com/health"}'

# Full page validation
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://app.example.com",
  "user_prompt": "Verify page loads, check for JavaScript errors, confirm login button exists"
}'

# Compare environments
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{"role": "user", "content": "What should I check when verifying a production deployment?"}]
}'
```

## Tips

- Test all critical user paths
- Check error handling endpoints
- Verify SSL certificates
- Test from multiple regions if possible
