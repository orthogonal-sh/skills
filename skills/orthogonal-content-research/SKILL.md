---
name: content-research
description: Research topics for content creation - articles, blog posts, social media
---

# Content Research - Research for Content Creation

Research topics thoroughly for creating high-quality articles, blog posts, and social media content.

## Workflow

### Step 1: Topic Research
Get comprehensive information on your topic:

```bash
orth api run tavily /research --body '{
  "query": "Complete guide to AI agents in 2024 - how they work, use cases, frameworks, best practices"
}'
```

### Step 2: Find Related Content
See what's already published:

```bash
orth api run exa /search --body '{
  "query": "best articles about AI agents and autonomous systems",
  "num_results": 20,
  "contents": {"text": true}
}'
```

### Step 3: Get Expert Opinions
Find quotes and expert takes:

```bash
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{
    "role": "user",
    "content": "What do AI researchers and industry experts say about the future of AI agents? Include specific quotes and sources."
  }]
}'
```

### Step 4: Find Statistics
Get data and stats to support your content:

```bash
orth api run tavily /search --body '{
  "query": "AI agents market size statistics growth projections 2024 2025",
  "search_depth": "advanced",
  "include_answer": true
}'
```

### Step 5: Generate Outline
Get help structuring your content:

```bash
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{
    "role": "user",
    "content": "Create a detailed outline for a comprehensive blog post about AI agents. Include sections, key points, and suggested word counts."
  }]
}'
```

## Example Usage

```bash
# Research for social media content
orth api run tavily /search --body '{
  "query": "viral social media trends 2024 what content performs best",
  "include_answer": true
}'

# Find content gaps
orth api run exa /search --body '{
  "query": "underexplored topics in AI that would make great blog posts",
  "num_results": 15
}'
```

## Tips

- Research competing content first
- Gather multiple sources for credibility
- Look for unique angles not covered elsewhere
- Include data and statistics when possible
