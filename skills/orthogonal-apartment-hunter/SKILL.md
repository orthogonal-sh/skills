---
name: apartment-hunter
description: Find apartments and rentals matching your criteria - location, price, amenities
---

# Apartment Hunter - Find Your Next Home

Search for apartments matching your location, budget, and amenity requirements.

## Workflow

### Step 1: Search for Listings
Use Tavily to search for apartments:

```bash
curl -X POST "https://api.orth.sh/v1/run/tavily/search" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "apartments for rent in San Francisco Mission District under $3000 1 bedroom pet friendly",
    "search_depth": "advanced",
    "include_answer": true
  }'
```

### Step 2: Get Neighborhood Info
Research the neighborhood:

```bash
curl -X POST "https://api.orth.sh/v1/run/perplexity/chat/completions" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "sonar",
    "messages": [{
      "role": "user",
      "content": "Tell me about the Mission District in San Francisco - safety, walkability, restaurants, public transit, vibe"
    }]
  }'
```

### Step 3: Extract Listing Details
Use ScrapeGraph to get structured listing data:

```bash
curl -X POST "https://api.orth.sh/v1/run/scrapegraph/v1/smartscraper" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "website_url": "https://www.apartments.com/san-francisco-ca/",
    "user_prompt": "Extract apartment listings with price, bedrooms, square footage, amenities, and contact info"
  }'
```

### Step 4: Check Commute
Research commute times:

```bash
curl -X POST "https://api.orth.sh/v1/run/olostep/v1/answers" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "question": "How long is the commute from Mission District SF to Financial District by BART and by car during rush hour?"
  }'
```

## Example Usage

```bash
# Find luxury apartments
orth api run tavily /search --body '{
  "query": "luxury apartments downtown Seattle 2 bedroom gym pool rooftop",
  "include_answer": true
}'

# Compare neighborhoods
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{"role": "user", "content": "Compare Brooklyn Heights vs Park Slope for young professionals - rent prices, vibe, safety"}]
}'
```

## Tips

- Search multiple listing sites (Zillow, Apartments.com, Craigslist)
- Check crime stats for the neighborhood
- Factor in commute time and transit access
- Ask about utilities included vs separate
