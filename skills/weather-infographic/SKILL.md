---
name: weather-infographic
description: Produce a compact visual weather briefing with current conditions, forecast, and location-specific context.
---

# Weather Infographic

Use this skill when the user asks for a visual weather forecast, printable weather card, or TV-style weather summary.

## Workflow

1. Fetch current weather and forecast from the configured weather source.
2. Summarize temperature, precipitation, wind, air quality when available, and notable timing.
3. Pick a layout suitable for the destination surface: mobile, Slack, canvas, or image.
4. Generate a concise visual with location, date, icons, and forecast bands.

## Safety

- Use official alerts when severe weather is involved.
- Include timestamps and location so stale forecasts are obvious.
