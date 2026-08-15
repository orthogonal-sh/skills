---
name: google-maps-grounding
description: Ground local search, routes, weather, and place decisions with Google Maps based MCP or API results.
---

# Google Maps Grounding

Use this skill when a local task needs place search, routing, distance, hours, nearby options, or location grounding.

## Workflow

1. Resolve the user location, destination, and constraints.
2. Query the configured Google Maps MCP server or API for places, routes, travel time, and relevant metadata.
3. Cross-check important facts such as hours, address, and availability when the action is time-sensitive.
4. Present options with tradeoffs and source timestamps.

## Safety

- Do not book, order, or message a venue without explicit confirmation.
- For travel timing, state the date and time used for routing.
