---
name: twitter-profile-lookup
description: Look up Twitter/X profiles - get bio, followers, tweets, and engagement
---

# Twitter/X Profile Lookup

Get profile information, tweets, and engagement data for any Twitter/X account.

## When to Use

- User asks about a Twitter/X account
- User wants to see someone's tweets
- User asks "who is @username on Twitter?"
- Research on a public figure or company
- Social media due diligence

## How It Works

Uses the Shofo API to scrape Twitter/X profile data and tweets.

## Usage

### Get User Profile

```bash
orth run shofo /x/user-profile -q 'username=openai'
```

### Get User's Posts

```bash
orth run shofo /x/user-posts -q 'username=openai&count=10'
```

<details>
<summary>curl equivalent</summary>

```bash
curl -X POST "https://api.orth.sh/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"api":"shofo","path":"/x/user-posts","query":{"username":"openai"}}'
```
</details>

## Parameters

### Profile
- **username** (required) - Twitter handle (without @)

### Posts
- **username** (required) - Twitter handle (without @)
- **count** (required) - Number of posts to retrieve

## Response

### Profile Response
- User display name and handle
- Bio/description
- Follower and following counts
- Tweet count
- Profile and banner image URLs
- Verified status
- Account creation date
- Location and website (if set)

### Posts Response
- Tweet text content
- Like, retweet, reply counts
- Media attachments (images, videos)
- Timestamp
- Engagement metrics

## Examples

**User:** "What has OpenAI been posting on X?"
```bash
orth run shofo /x/user-posts -q 'username=openai&count=10'
```

**User:** "Show me Sam Altman's recent tweets"
```bash
orth run shofo /x/user-posts -q 'username=sama&count=10'
```

**User:** "What's Anthropic sharing on Twitter?"
```bash
orth run shofo /x/user-posts -q 'username=AnthropicAI&count=10'
```

## Error Handling

- **success: false** with `error: "Request failed. Please try again."` — Shofo may be temporarily unable to access the profile; retry after a few seconds
- Protected/private accounts return errors — no workaround
- Rate limiting may cause failures on rapid sequential requests — add short delays between calls

## Tips

- Remove @ from usernames
- Protected/private accounts cannot be accessed
- Returns recent posts (not full history)
- Rate limiting may apply for very frequent requests
