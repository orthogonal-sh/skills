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
orth api run linkup /fetch --body '{"url": "https://yoursite.com"}'
```

### Step 2: Verify Page Content
Ensure page loads correctly:

```bash
orth api run scrapegraph /api/extract --body '{
  "url": "https://yoursite.com",
  "prompt": "Check if page loads and contains expected content. Report any error messages."
}'
```

### Step 3: Test API Health
Check API endpoints:

```bash
orth api run linkup /fetch --body '{"url": "https://api.yoursite.com/health"}'
```

### Step 4: Check Multiple Endpoints
Monitor critical paths:

```bash
orth api run olostep /v1/batches --body '{
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
orth api run scrapegraph /api/extract --body '{
  "url": "https://status.yoursite.com",
  "prompt": "Extract current service status, any incidents, and affected components"
}'
```

### Step 6: Send Alert (if down)
Use SMS for critical alerts:

```bash
orth api run textbelt /text --body '{
  "phone": "+1234567890",
  "message": "ALERT: yoursite.com is down! Check immediately."
}'
```

### Step 7: Schedule Recurring Monitoring (optional)
For continuous, hands-off monitoring, register a scheduled scrape that runs on a cron interval and notifies a webhook on each run:

```bash
orth api run scrapegraph /api/monitor --body '{
  "url": "https://yoursite.com",
  "name": "yoursite-uptime",
  "interval": "*/5 * * * *",
  "formats": [{"type": "markdown"}],
  "webhookUrl": "https://hooks.yoursite.com/uptime"
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
orth api run scrapegraph /api/extract --body '{
  "url": "https://status.github.com",
  "prompt": "What is the current status of GitHub services?"
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

## Discover More

List all endpoints, or add a path for parameter details:

```bash
orth api show linkup
orth api show olostep
orth api show scrapegraph
orth api show textbelt 
```

Example: `orth api show olostep /v1/scrapes` for endpoint parameters.
