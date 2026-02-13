---
name: recipe-finder
description: Find recipes based on ingredients you have, dietary restrictions, or cuisine type
---

# Recipe Finder - Discover Recipes

Find recipes based on available ingredients, dietary needs, or cuisine preferences.

## Workflow

### Step 1: Search for Recipes
Use Tavily to find recipes matching your criteria:

```bash
orth api run tavily /search --body '{
  "query": "easy chicken recipes with rice and vegetables under 30 minutes",
  "search_depth": "advanced",
  "include_answer": true
}'
```

### Step 2: Get Recipe Suggestions
Use Perplexity for personalized recipe ideas:

```bash
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{
    "role": "user",
    "content": "I have chicken breast, garlic, lemon, and olive oil. What are 5 recipes I can make? Include cooking times."
  }]
}'
```

### Step 3: Extract Full Recipe
Use ScrapeGraph to get complete recipe details:

```bash
orth api run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://www.allrecipes.com/recipe/example",
  "user_prompt": "Extract the full recipe including ingredients list, step-by-step instructions, cooking time, and servings"
}'
```

## Example Usage

```bash
# Find recipes by ingredient
orth api run tavily /search --body '{
  "query": "what can I make with eggs, cheese, and spinach",
  "include_answer": true
}'

# Get dietary-specific recipes
orth api run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{"role": "user", "content": "Give me 5 keto dinner recipes under 500 calories"}]
}'

# Find cuisine-specific dishes
orth api run olostep /v1/answers --body '{
  "task": "Best authentic Thai curry recipes for beginners"
}'
```

## Tips

- Specify dietary restrictions (vegan, gluten-free, keto)
- Include cooking time constraints
- Mention skill level (beginner, intermediate)
- List ingredients you want to use or avoid
