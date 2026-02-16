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

### Brand.dev Response
Returns screenshot URL:
- **status** (string) - `ok` on success
- **domain** (string) - Domain that was screenshotted
- **screenshot** (string) - Public URL to the screenshot image (PNG)
- **screenshotType** (string) - `viewport` (above-the-fold) or `full_page`
- **code** (integer) - HTTP status code

### Notte Response
Returns page content + session:
- **markdown** (string) - Page content as markdown text
- **images** (array|null) - Extracted images (if any)
- **structured** (object|null) - Structured data (if extraction was requested)
- **session.session_id** (string) - Session ID for follow-up actions
- **session.status** (string) - `active` while session is open
- **session.credit_usage** (integer) - Credits consumed

To take an explicit screenshot via Notte session:
```bash
orth run notte /sessions/{session_id}/page/screenshot
```

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

## Error Handling

- **400** - Missing required parameter (`domain` for Brand.dev, `url` for Notte)
- **404** - Domain not found or page doesn't exist
- **504** - Page took too long to load — retry or try simpler URL
- Brand.dev only screenshots the homepage (pass domain, not full URL)
- Notte sessions auto-expire after `idle_timeout_minutes` (default 3) — take screenshots promptly

## Tips

- Brand.dev is simpler for quick homepage screenshots
- Notte is more powerful for full page control
- For pages requiring login, use Notte sessions with authentication
- Screenshots are typically full-page or viewport-sized
- Some sites may block automated screenshots
