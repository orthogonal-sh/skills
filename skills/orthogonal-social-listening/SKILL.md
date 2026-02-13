---
name: social-listening
description: Monitor brand mentions, competitor activity, and industry conversations
---

# Social Listening - Monitor Online Conversations

Track brand mentions, competitor activity, and industry conversations across the web.

## Workflow

### Step 1: Search for Brand Mentions
Find mentions of your brand:

```bash
orth api run tavily /search --body '{
  "query": "\"YourBrand\" OR \"@yourbrand\" mentions reviews discussions",
  "search_depth": "advanced",
  "include_answer": true
}'
```

### Step 2: Monitor Competitors
Track competitor mentions:

```bash
orth api run exa /search --body '{
  "query": "Notion reviews opinions user feedback",
  "num_results": 30,
  "contents": {"text": true}
}'
```

### Step 3: Track Industry Trends
Monitor industry conversations:

```bash
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{
    "role": "user",
    "content": "What are people saying about productivity software trends on Twitter, Reddit, and HackerNews this week?"
  }]
}'
```

### Step 4: Find User Feedback
Search for product feedback:

```bash
orth api run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "Find user reviews and feedback about Notion on G2, Capterra, and ProductHunt"
}'
```

### Step 5: Monitor Forum Discussions
Track community discussions:

```bash
orth api run tavily /search --body '{
  "query": "site:reddit.com OR site:news.ycombinator.com productivity software recommendations",
  "search_depth": "advanced"
}'
```

## Example Usage

```bash
# Monitor brand sentiment
orth api run tavily /search --body '{
  "query": "\"Slack\" complaints OR problems OR issues users",
  "include_answer": true
}'

# Track competitor launches
orth api run exa /search --body '{
  "query": "Notion new features announcement launch 2024",
  "num_results": 20
}'

# Find influencer mentions
orth api run tavily /search --body '{
  "query": "tech influencers reviewing project management tools YouTube",
  "include_answer": true
}'
```

## Tips

- Set up regular monitoring schedules
- Track both positive and negative sentiment
- Respond quickly to negative mentions
- Use insights for product development
