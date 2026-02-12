---
name: uptime-monitor
description: Monitor website uptime - check availability, response times, and status
---

# Uptime Monitor - Website Availability Monitoring

Monitor website uptime, check response times, and verify service availability.

## Workflow

### Step 1: Check Website Status
Verify site is accessible:

```bash
curl -X POST "https://api.orth.sh/v1/run/linkup/fetch" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"url": "https://yoursite.com"}'
```

### Step 2: Verify Page Content
Ensure page loads correctly:

```bash
curl -X POST "https://api.orth.sh/v1/run/scrapegraph/v1/smartscraper" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "website_url": "https://yoursite.com",
    "user_prompt": "Check if page loads and contains expected content. Report any error messages."
  }'
```

### Step 3: Test API Health
Check API endpoints:

```bash
curl -X POST "https://api.orth.sh/v1/run/linkup/fetch" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"url": "https://api.yoursite.com/health"}'
```

### Step 4: Check Multiple Endpoints
Monitor critical paths:

```bash
curl -X POST "https://api.orth.sh/v1/run/olostep/v1/batches" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "urls": [
      "https://yoursite.com",
      "https://yoursite.com/login",
      "https://api.yoursite.com/health",
      "https://yoursite.com/dashboard"
    ]
  }'
```

### Step 5: Research Status Page
Check official status:

```bash
curl -X POST "https://api.orth.sh/v1/run/scrapegraph/v1/smartscraper" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "website_url": "https://status.yoursite.com",
    "user_prompt": "Extract current service status, any incidents, and affected components"
  }'
```

### Step 6: Send Alert (if down)
Use SMS for critical alerts:

```bash
curl -X POST "https://api.orth.sh/v1/run/textbelt/text" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "phone": "+1234567890",
    "message": "ALERT: yoursite.com is down! Check immediately."
  }'
```

## Monitoring Script

```bash
SITES=("https://example.com" "https://api.example.com/health")

for site in "${SITES[@]}"; do
  echo "Checking: $site"
  orth api run linkup /fetch --body "{\"url\": \"$site\"}"
done
```

## Example Usage

```bash
# Quick status check
orth api run linkup /fetch --body '{"url": "https://stripe.com"}'

# Check status page
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://status.github.com",
  "user_prompt": "What is the current status of GitHub services?"
}'

# Monitor competitor uptime
orth api run linkup /fetch --body '{"url": "https://competitor.com"}'
```

## What to Monitor

1. **Homepage**: Main website accessible
2. **API Health**: Health check endpoints
3. **Login/Auth**: Authentication working
4. **Critical Features**: Core functionality
5. **Status Page**: Official service status
