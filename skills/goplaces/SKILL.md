---
name: goplaces
description: Query Google Places with an agent-friendly CLI
---

# Goplaces

Use Goplaces when the user needs place search, details, reviews, or location grounding through Google Places API.

## Capabilities

- Text search for businesses, restaurants, venues, and landmarks
- Fetch place details, ratings, hours, reviews, and coordinates
- Return structured JSON for scripts or concise recommendations for humans

## Workflow

1. Clarify location, category, constraints, and time sensitivity.
2. Search with Goplaces and inspect top candidates.
3. Compare relevant details such as hours, rating, distance, and reviews.
4. Present the best matches with links and practical caveats.

## Notes

- Check current hours when the user might visit soon.
- Do not assume place data is stable.
