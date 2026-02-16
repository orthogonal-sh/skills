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
orth run shofo /instagram/user-posts -q 'username=openai'
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
orth run shofo /instagram/hashtag -q 'hashtag=artificialintelligence'
```

### Get Post Comments

```bash
orth run shofo /instagram/comments -q 'post_url=https://instagram.com/p/ABC123'
```

## Parameters

### User Posts
- **username** (required) - Instagram username (without @)

### Hashtag Posts
- **hashtag** (required) - Hashtag to search (without #)

### Post Comments
- **post_url** (required) - Full Instagram post URL

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
orth run shofo /instagram/user-posts -q 'username=openai'
```

**User:** "Show me posts with #AI hashtag"
```bash
orth run shofo /instagram/hashtag -q 'hashtag=AI'
```

**User:** "Get comments on this Instagram post"
```bash
orth run shofo /instagram/comments -q 'post_url=https://instagram.com/p/ABC123'
```

## Tips

- Private accounts cannot be accessed
- Remove @ from usernames and # from hashtags
- API may return errors for rate limiting - retry after a few seconds
