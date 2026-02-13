---
name: travel-planner
description: Plan complete trips with flights, hotels, activities, and itineraries
---

# Travel Planner - Plan Your Perfect Trip

Create comprehensive travel plans including flights, hotels, activities, and day-by-day itineraries.

## Workflow

### Step 1: Research Destination
Get an overview of your destination:

```bash
orth api run tavily /research --body '{
  "query": "Complete travel guide to Tokyo Japan - best time to visit, neighborhoods, attractions, food, culture tips"
}'
```

### Step 2: Find Flights
Search for flight options:

```bash
orth api run olostep /v1/answers --body '{
  "question": "What are the best flights from Los Angeles to Tokyo in March 2025? Compare prices and airlines."
}'
```

### Step 3: Find Accommodations
Search for hotels by neighborhood:

```bash
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{
    "role": "user",
    "content": "Best hotels in Shibuya Tokyo for tourists. Include price ranges and what each area is best for."
  }]
}'
```

### Step 4: Plan Activities
Get activity and attraction recommendations:

```bash
orth api run tavily /search --body '{
  "query": "best things to do in Tokyo 5 days itinerary must-see attractions hidden gems",
  "search_depth": "advanced",
  "include_answer": true
}'
```

### Step 5: Create Itinerary
Generate a day-by-day plan:

```bash
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{
    "role": "user",
    "content": "Create a detailed 5-day Tokyo itinerary. Day 1: Shibuya/Harajuku, Day 2: Historic sites, etc. Include specific attractions, restaurants, and time estimates."
  }]
}'
```

### Step 6: Get Weather Info
Check weather for packing:

```bash
orth api run precip /api/v1/daily --query lat=35.6762 lon=139.6503 start=2025-03-01 end=2025-03-07
```

## Example Usage

```bash
# Quick destination research
orth api run tavily /research --body '{
  "query": "Barcelona Spain travel guide best neighborhoods beaches food nightlife"
}'

# Budget trip planning
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{"role": "user", "content": "Plan a budget 7-day trip to Portugal for under $2000 including flights from NYC"}]
}'
```

## Tips

- Book flights 6-8 weeks in advance for best prices
- Stay in central neighborhoods to save on transport
- Mix popular attractions with local experiences
- Leave buffer time for spontaneous discoveries
