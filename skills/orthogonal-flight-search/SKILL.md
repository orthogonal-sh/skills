---
name: flight-search
description: Search and compare flight prices across airlines using web search and scraping
---

# Flight Search - Find and Compare Flights

Search for flights and compare prices across airlines using Orthogonal APIs.

## Workflow

### Step 1: Search for Flights
Use Tavily or Andi to search for flight options:

```bash
orth api run tavily /search --body '{
  "query": "flights from SFO to NYC December 15 2024 round trip prices",
  "search_depth": "advanced",
  "include_answer": true
}'
```

### Step 2: Get Detailed Pricing
Use Olostep AI answers for comprehensive flight info:

```bash
orth api run olostep /v1/answers --body '{
  "task": "What are the cheapest flights from San Francisco to New York on December 15, 2024? Include airline names and prices."
}'
```

### Step 3: Extract from Travel Sites
Use ScrapeGraph to extract structured flight data:

```bash
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://www.google.com/travel/flights",
  "user_prompt": "Extract flight options with prices, airlines, departure times, and durations"
}'
```

## Example Usage

```bash
# Quick flight search
orth api run tavily /search --body '{
  "query": "best flight deals LAX to London January 2025",
  "include_answer": true
}'

# Get AI-powered flight comparison
orth api run olostep /v1/answers --body '{
  "task": "Compare Delta, United, and American flights from Chicago to Miami on Feb 1, 2025"
}'
```

## Tips

- Include specific dates for better results
- Search for "flexible dates" to find deals
- Compare one-way vs round-trip pricing
- Check for airline sales and promotions

## Discover More

List all endpoints, or add a path for parameter details:

```bash
orth api show olostep
orth api show scrapegraph
orth api show tavily 
```

Example: `orth api show olostep /v1/scrapes` for endpoint parameters.
