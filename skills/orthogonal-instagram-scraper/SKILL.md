---
name: instagram-scraper
description: Get Instagram profiles, posts, reels, and comments
---

# Instagram Scraper

Scrape public Instagram data including posts, hashtags, and comments.

## When to Use

- User asks about Instagram content
- User wants to see posts from an account
- User asks about hashtag content
- Social media research

## How It Works

Uses the Shofo API to scrape Instagram data.

## Usage

### Get User Posts

```bash
orth run shofo /instagram/user-posts -q 'username=openai&count=10'
```

<details>
<summary>curl equivalent</summary>

```bash
curl -X POST "https://api.orth.sh/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"api":"shofo","path":"/instagram/user-posts","query":{"username":"openai"}}'
```
</details>

### Get Hashtag Posts

```bash
orth run shofo /instagram/hashtag -q 'keyword=artificialintelligence&count=10'
```

### Get Post Comments

```bash
orth run shofo /instagram/comments -q 'media_id=ABC123'
```

## Parameters

### User Posts
- **username** (required) - Instagram username (without @)
- **count** (required) - Number of posts to retrieve

### Hashtag Posts
- **keyword** (required) - Hashtag to search (without #)
- **count** (required) - Number of posts to retrieve

### Post Comments
- **media_id** (required) - Instagram post/media ID

## Response

### Posts include:
- Post caption
- Image/video URLs
- Like count
- Comment count
- Timestamp
- Post URL

### Comments include:
- Comment text
- Username
- Timestamp
- Like count

## Examples

**User:** "What's OpenAI posting on Instagram?"
```bash
orth run shofo /instagram/user-posts -q 'username=openai&count=10'
```

**User:** "Show me posts with #AI hashtag"
```bash
orth run shofo /instagram/hashtag -q 'keyword=AI&count=10'
```

**User:** "Get comments on this Instagram post"
```bash
orth run shofo /instagram/comments -q 'media_id=ABC123'
```

## Error Handling

- **success: false** — Shofo may temporarily fail; retry after a few seconds
- Private accounts cannot be accessed — no workaround
- Rate limiting may cause failures on rapid requests — add delays between calls
- Missing `count` parameter may return default or error — always include it

## Tips

- Private accounts cannot be accessed
- Remove @ from usernames and # from hashtags
- API may return errors for rate limiting - retry after a few seconds
