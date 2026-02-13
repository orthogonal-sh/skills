---
name: gift-finder
description: Find perfect gift ideas based on person, occasion, and budget
---

# Gift Finder - Discover Perfect Gifts

Find thoughtful gift ideas based on the recipient, occasion, and your budget.

## Workflow

### Step 1: Get Gift Ideas
Search for gift suggestions:

```bash
orth api run tavily /search --body '{
  "query": "best birthday gift ideas for 30 year old man who likes technology under $100",
  "search_depth": "advanced",
  "include_answer": true
}'
```

### Step 2: Get Personalized Recommendations
Use Perplexity for tailored suggestions:

```bash
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{
    "role": "user",
    "content": "Suggest 10 unique gift ideas for my mom who loves gardening and cooking. Budget $50-150. Include where to buy."
  }]
}'
```

### Step 3: Compare Products
Search for specific products and prices:

```bash
orth api run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "Find the best wireless earbuds under $100 with good reviews and compare prices across Amazon, Best Buy"
}'
```

### Step 4: Get Product Details
Extract detailed product information:

```bash
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://www.amazon.com/dp/B08XYZ",
  "user_prompt": "Extract product name, price, features, ratings, and top reviews"
}'
```

## Example Usage

```bash
# Anniversary gift ideas
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{"role": "user", "content": "Romantic 5th anniversary gift ideas for wife who loves travel"}]
}'

# Holiday gifts by category
orth api run tavily /search --body '{
  "query": "best Christmas gifts 2024 for teenagers trendy popular",
  "include_answer": true
}'

# Experience gifts
orth api run olostep /v1/answers --body '{
  "task": "Best experience gift ideas in San Francisco - cooking classes, spa, adventures"
}'
```

## Tips

- Consider recipient's hobbies and interests
- Think about experiences, not just physical items
- Check for gift cards if unsure
- Look for personalization options
