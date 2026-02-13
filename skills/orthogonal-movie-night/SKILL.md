---
name: movie-night
description: Find movies, check showtimes, and plan your movie night
---

# Movie Night - Find Movies and Showtimes

Discover movies, check local showtimes, and plan your perfect movie night.

## Workflow

### Step 1: Find Movies
Search for movies based on genre, ratings, or what's playing:

```bash
orth api run tavily /search --body '{
  "query": "best movies in theaters now February 2024 ratings reviews",
  "search_depth": "advanced",
  "include_answer": true
}'
```

### Step 2: Get Movie Recommendations
Use Perplexity for personalized suggestions:

```bash
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{
    "role": "user",
    "content": "Recommend 5 sci-fi movies from 2023-2024 with good reviews for someone who liked Dune and Interstellar"
  }]
}'
```

### Step 3: Check Showtimes
Search for local showtimes:

```bash
orth api run olostep /v1/answers --body '{
  "question": "What are the showtimes for Dune Part 2 at AMC theaters in San Francisco this weekend?"
}'
```

### Step 4: Get Movie Details
Extract comprehensive movie information:

```bash
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://www.imdb.com/title/tt123456",
  "user_prompt": "Extract movie title, rating, runtime, cast, director, plot summary, and user reviews"
}'
```

## Example Usage

```bash
# Find family-friendly movies
orth api run tavily /search --body '{
  "query": "best family movies in theaters now PG rated",
  "include_answer": true
}'

# Get streaming recommendations
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{"role": "user", "content": "Best horror movies on Netflix right now 2024"}]
}'
```

## Tips

- Specify genre preferences
- Include rating preferences (PG, R, etc.)
- Check multiple theaters for best times
- Look for IMAX or Dolby showings for big releases
