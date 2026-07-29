---
name: goplaces
description: Query Google Places API through the goplaces CLI for place search, details, and reviews.
---

# Goplaces

Use this skill when a task needs Google Places data from the terminal.

## When To Use

- Search local businesses or venues.
- Resolve place IDs.
- Fetch place details, hours, ratings, photos, or reviews.
- Build local recommendation shortlists.

## Starter Commands

```bash
goplaces search "coffee near Hayes Valley" --json
goplaces details <place-id> --json
```

## Notes

- Use exact place IDs for follow-up calls.
- Include location, radius, and category constraints to reduce noisy results.
- Respect API quotas and pricing.
