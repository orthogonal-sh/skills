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

Uses the Shofo API to scrape TikTok data including profiles, hashtags, and trending content.

## Usage

### Get TikTok Profile Videos

```bash
orth run shofo /tiktok/profile -q 'username=charlidamelio&count=10'
```

<details>
<summary>curl equivalent</summary>

```bash
curl -X POST "https://api.orth.sh/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"api":"shofo","path":"/tiktok/profile","query":{"username":"charlidamelio","count":"10"}}'
```
</details>

### Search Hashtag Videos

```bash
orth run shofo /tiktok/hashtag -q 'hashtag=tech&count=10'
```

### Get Trending Feed

```bash
orth run shofo /tiktok/feed -q 'count=10'
```

## Parameters

### Profile Videos
- **username** (required) - TikTok username (without @)
- **count** (required) - Number of videos to retrieve

### Hashtag Videos
- **hashtag** (required) - Hashtag to search (without #)
- **count** (required) - Number of videos to retrieve

### Trending Feed
- **count** (required) - Number of videos to retrieve (1-100)

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
orth run shofo /tiktok/profile -q 'username=charlidamelio&count=10'
```

**User:** "What's trending on TikTok?"
```bash
orth run shofo /tiktok/feed -q 'count=10'
```

**User:** "What's trending with #tech on TikTok?"
```bash
orth run shofo /tiktok/hashtag -q 'hashtag=tech&count=10'
```

## Tips

- Remove @ from usernames
- Remove # from hashtags
- Private accounts cannot be accessed
