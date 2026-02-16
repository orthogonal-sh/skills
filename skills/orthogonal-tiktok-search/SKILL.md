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

Uses the SearchAPI TikTok engines to query TikTok data.

## Usage

### Get TikTok Profile

```bash
orth run searchapi /api/v1/search -q 'engine=tiktok_profile&username=charlidamelio'
```

<details>
<summary>curl equivalent</summary>

```bash
curl -X POST "https://api.orth.sh/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"api":"searchapi","path":"/api/v1/search","query":{"engine":"tiktok_profile","username":"charlidamelio"}}'
```
</details>

### Search TikTok Videos

```bash
orth run searchapi /api/v1/search -q 'engine=tiktok&q=AI tutorials'
```

### Search Hashtag

```bash
orth run searchapi /api/v1/search -q 'engine=tiktok_hashtag&hashtag=tech'
```

## Parameters

### Profile Lookup
- **engine** - `tiktok_profile`
- **username** (required) - TikTok username (without @)

### Video Search
- **engine** - `tiktok`
- **q** (required) - Search query

### Hashtag Search
- **engine** - `tiktok_hashtag`
- **hashtag** (required) - Hashtag to search (without #)

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
orth run searchapi /api/v1/search -q 'engine=tiktok_profile&username=charlidamelio'
```

**User:** "Find AI tutorial videos on TikTok"
```bash
orth run searchapi /api/v1/search -q 'engine=tiktok&q=AI tutorial'
```

**User:** "What's trending with #tech on TikTok?"
```bash
orth run searchapi /api/v1/search -q 'engine=tiktok_hashtag&hashtag=tech'
```

## Tips

- Remove @ from usernames
- Remove # from hashtags
- Private accounts cannot be accessed
