---
name: website-screenshot
description: Take screenshots of websites and web pages
---

# Website Screenshot

Capture screenshots of any website or web page. Useful for documentation, monitoring, and visual records.

## When to Use

- User asks for a screenshot of a website
- User wants to see what a site looks like
- Documenting web pages
- Monitoring website changes
- Creating visual records

## How It Works

Uses Notte or Brand.dev APIs to capture website screenshots.

## Usage

### Screenshot with Notte

```bash
# First start a session, then screenshot
orth run notte /sessions/start -d '{"url":"https://stripe.com"}'
# Then take screenshot with the session_id
orth run notte /sessions/{session_id}/page/screenshot
```

### Screenshot with Brand.dev (simpler)

```bash
orth run brand-dev /v1/brand/screenshot --query 'domain=stripe.com'
```

### Scrape and Screenshot with Notte

```bash
orth run notte /scrape -d '{"url":"https://example.com"}'
```

## Parameters

### Notte Session
- **url** (required) - Full URL to navigate to

### Brand.dev
- **domain** (required) - Website domain

## Response

### Screenshot returns:
- Image data (base64 or URL)
- Page dimensions
- Screenshot timestamp

### With Notte scrape:
- Screenshot
- Page content (markdown)
- Page title
- Metadata

## Examples

**User:** "Take a screenshot of Notion's homepage"
```bash
orth run brand-dev /v1/brand/screenshot --query 'domain=notion.so'
```

**User:** "Capture what vercel.com looks like"
```bash
orth run brand-dev /v1/brand/screenshot --query 'domain=vercel.com'
```

**User:** "Screenshot and scrape the content from this article"
```bash
orth run notte /scrape -d '{"url":"https://example.com/article"}'
```

## Tips

- Brand.dev is simpler for quick homepage screenshots
- Notte is more powerful for full page control
- For pages requiring login, use Notte sessions with authentication
- Screenshots are typically full-page or viewport-sized
- Some sites may block automated screenshots
