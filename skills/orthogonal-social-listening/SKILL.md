---
name: social-listening
description: Monitor brand mentions, competitor activity, and industry conversations
---

# Social Listening - Monitor Online Conversations

Track brand mentions, competitor activity, and industry conversations across the web.

## Workflow

### Step 1: Monitor Competitors
Track competitor mentions:

```bash
orth run exa /search --body '{
  "query": "Notion reviews opinions user feedback",
  "num_results": 30,
  "contents": {"text": true}
}'
```

## Example Usage

```bash
# Track competitor launches
orth run exa /search --body '{
  "query": "Notion new features announcement launch 2024",
  "num_results": 20
}'
```

## Tips

- Set up regular monitoring schedules
- Track both positive and negative sentiment
- Respond quickly to negative mentions
- Use insights for product development

## Discover More

List all endpoints, or add a path for parameter details:

```bash
orth api show exa
```

Example: `orth api show olostep /v1/scrapes` for endpoint parameters.
