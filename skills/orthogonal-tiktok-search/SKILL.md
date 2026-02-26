---
name: tiktok-search
description: Search TikTok - find profiles, videos, hashtags, and trending content
---

# TikTok Search

Search TikTok for profiles, videos, and hashtag content.

## When to Use

- User asks about a TikTok account
- User wants to find TikTok videos
- User asks about trending TikTok content
- Social media research

## How It Works

Uses the Scrape Creators API via Orthogonal to scrape TikTok data including profiles, hashtags, and trending content.

## Usage

### Get TikTok Profile

```bash
orth run scrapecreators /v1/tiktok/profile -q 'handle=charlidamelio'
```

<details>
<summary>curl equivalent</summary>

```bash
curl -X POST "https://api.orth.sh/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"api":"scrapecreators","path":"/v1/tiktok/profile","query":{"handle":"charlidamelio"}}'
```
</details>

### Search Hashtag Videos

```bash
orth run scrapecreators /v1/tiktok/search/hashtag -q 'hashtag=tech'
```

### Get Trending Feed

```bash
orth run scrapecreators /v1/tiktok/get-trending-feed -q 'region=US'
```

## Parameters

### Profile
- **handle** (required) - TikTok handle (without @)

### Hashtag Search
- **hashtag** (required) - Hashtag to search (without #)
- **region** (optional) - Region for the proxy
- **cursor** (optional) - Cursor for pagination
- **trim** (optional) - Set to "true" for a trimmed response

### Trending Feed
- **region** (required) - Region for the proxy (e.g., "US")
- **trim** (optional) - Set to true for a trimmed response

## Response

### Profile includes:
- Username and display name
- Bio/description
- Follower and following counts
- Total likes
- Verified status
- Profile image

### Videos include:
- Video title/description
- View count
- Like count
- Comment count
- Video URL

## Examples

**User:** "Look up charlidamelio on TikTok"
```bash
orth run scrapecreators /v1/tiktok/profile -q 'handle=charlidamelio'
```

**User:** "What's trending on TikTok?"
```bash
orth run scrapecreators /v1/tiktok/get-trending-feed -q 'region=US'
```

**User:** "What's trending with #tech on TikTok?"
```bash
orth run scrapecreators /v1/tiktok/search/hashtag -q 'hashtag=tech'
```

## Error Handling

- **success: false** — the API may temporarily fail; retry after a few seconds
- Private accounts cannot be accessed
- Rate limiting may apply on rapid sequential requests

### No Longer Available

The following was previously available via Shofo but has no direct equivalent in Scrape Creators:
- **TikTok Video Comments** — no direct equivalent endpoint

## Tips

- Remove @ from handles
- Remove # from hashtags
- Private accounts cannot be accessed
