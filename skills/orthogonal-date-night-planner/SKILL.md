---
name: date-night-planner
description: Plan the perfect date night - restaurants, activities, and entertainment
---

# Date Night Planner - Create Memorable Evenings

Plan complete date nights with restaurant reservations, activities, and entertainment.

## Workflow

### Step 1: Find Restaurant Options
Search for romantic dining options:

```bash
curl -X POST "https://api.orth.sh/v1/run/tavily/search" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "best romantic restaurants San Francisco intimate atmosphere good reviews reservations",
    "search_depth": "advanced",
    "include_answer": true
  }'
```

### Step 2: Get Personalized Recommendations
Use Perplexity for curated suggestions:

```bash
curl -X POST "https://api.orth.sh/v1/run/perplexity/chat/completions" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "sonar",
    "messages": [{
      "role": "user",
      "content": "Plan a special anniversary date night in San Francisco. Include a nice restaurant, pre-dinner activity, and after-dinner entertainment. Budget around $300."
    }]
  }'
```

### Step 3: Find Activities
Search for pre or post-dinner activities:

```bash
curl -X POST "https://api.orth.sh/v1/run/olostep/v1/answers" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "question": "What are unique date night activities in San Francisco this weekend? Comedy shows, jazz clubs, rooftop bars, or experiences."
  }'
```

### Step 4: Check Events
Find special events or shows:

```bash
curl -X POST "https://api.orth.sh/v1/run/tavily/search" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "live music events San Francisco this Saturday night jazz blues",
    "include_answer": true
  }'
```

### Step 5: Get Weather
Check weather for outdoor activities:

```bash
curl "https://api.orth.sh/v1/run/precip/api/v1/hourly?lat=37.7749&lon=-122.4194&start=2024-02-14&end=2024-02-15" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

## Example Usage

```bash
# Budget date ideas
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{"role": "user", "content": "Creative date ideas under $50 in NYC - fun, unique, memorable"}]
}'

# Find speakeasy bars
orth api run tavily /search --body '{
  "query": "secret speakeasy bars Los Angeles hidden entrance cocktails",
  "include_answer": true
}'

# Outdoor date ideas
orth api run olostep /v1/answers --body '{
  "question": "Best sunset spots and romantic outdoor activities in San Diego"
}'
```

## Tips

- Make reservations in advance for popular spots
- Plan the logistics (parking, Uber, walking distance)
- Have a backup plan for weather
- Mix familiar favorites with new experiences
