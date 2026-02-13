---
name: hotel-finder
description: Find and compare hotels by location, price, and amenities
---

# Hotel Finder - Search and Compare Hotels

Find hotels matching your criteria using web search and AI extraction.

## Workflow

### Step 1: Search for Hotels
Use Tavily to search for hotel options:

```bash
orth api run tavily /search --body '{
  "query": "best hotels in Tokyo Shibuya under $200 per night December 2024",
  "search_depth": "advanced",
  "include_answer": true
}'
```

### Step 2: Get AI Recommendations
Use Perplexity for personalized recommendations:

```bash
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{
    "role": "user",
    "content": "Recommend 5 boutique hotels in Paris near the Eiffel Tower with good reviews and breakfast included. Include prices."
  }]
}'
```

### Step 3: Extract Hotel Details
Use ScrapeGraph to get structured hotel data:

```bash
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://www.booking.com/searchresults.html?dest=Tokyo",
  "user_prompt": "Extract hotel names, prices, ratings, and key amenities"
}'
```

## Example Usage

```bash
# Find hotels with specific amenities
orth api run tavily /search --body '{
  "query": "hotels with pool and spa in Bali under $150/night",
  "include_answer": true
}'

# Get local recommendations
orth api run olostep /v1/answers --body '{
  "task": "What are the best family-friendly hotels near Disneyland with shuttle service?"
}'
```

## Tips

- Specify neighborhood for better location results
- Include amenity requirements (pool, gym, breakfast)
- Check cancellation policies
- Compare booking sites for best rates

## Discover More

List all endpoints, or add a path for parameter details:

```bash
orth api show olostep
orth api show perplexity
orth api show scrapegraph
orth api show tavily 
```

Example: `orth api show olostep /v1/scrapes` for endpoint parameters.
