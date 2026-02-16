---
name: weather-forecast
description: Get weather forecasts - temperature, precipitation, wind, and conditions
---

# Weather Forecast

Get weather forecasts including temperature, precipitation, wind, and humidity for any location.

## When to Use

- User asks about weather
- User wants to know if it will rain
- User asks "what's the weather in [location]?"
- Planning outdoor activities
- Travel weather checks

## How It Works

Uses the Precip API to get weather data from meteorological sources.

## Usage

### Get Daily Forecast

```bash
orth run precip /api/v1/daily -q 'latitude=37.7749&longitude=-122.4194&start=2026-02-14&end=2026-02-21'
```

<details>
<summary>curl equivalent</summary>

```bash
curl -X POST "https://api.orth.sh/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"api":"precip","path":"/api/v1/daily","query":{"latitude":"37.7749","longitude":"-122.4194","start":"2026-02-14","end":"2026-02-21"}}'
```
</details>

### Get Hourly Forecast

```bash
orth run precip /api/v1/hourly -q 'latitude=37.7749&longitude=-122.4194&start=2026-02-14&end=2026-02-15'
```

### Get Temperature by Hour

```bash
orth run precip /api/v1/temperature-hourly -q 'latitude=37.7749&longitude=-122.4194&start=2026-02-14&end=2026-02-15'
```

### Get Recent Rain Data

```bash
orth run precip /api/v1/recent-rain -q 'latitude=37.7749&longitude=-122.4194'
```

### Get Last 48 Hours

```bash
orth run precip /api/v1/last-48 -q 'latitude=37.7749&longitude=-122.4194'
```

## Parameters

- **latitude** (required) - Latitude (e.g., 37.7749)
- **longitude** (required) - Longitude (e.g., -122.4194)
- **start** (required for forecasts) - Start date (YYYY-MM-DD format)
- **end** (required for forecasts) - End date (YYYY-MM-DD format)

## Common Coordinates

- San Francisco: latitude=37.7749, longitude=-122.4194
- New York: latitude=40.7128, longitude=-74.0060
- Los Angeles: latitude=34.0522, longitude=-118.2437
- London: latitude=51.5074, longitude=-0.1278
- Tokyo: latitude=35.6762, longitude=139.6503

## Response

### Daily forecast includes:
- High/low temperatures
- Precipitation amounts
- Weather conditions

### Hourly forecast includes:
- Temperature
- Precipitation
- Cloud cover
- Wind speed

## Examples

**User:** "What's the weather in San Francisco this week?"
```bash
orth run precip /api/v1/daily -q 'latitude=37.7749&longitude=-122.4194&start=2026-02-14&end=2026-02-21'
```

**User:** "Will it rain in NYC tomorrow?"
```bash
orth run precip /api/v1/hourly -q 'latitude=40.7128&longitude=-74.0060&start=2026-02-15&end=2026-02-16'
```

**User:** "How much rain fell in Seattle recently?"
```bash
orth run precip /api/v1/recent-rain -q 'latitude=47.6062&longitude=-122.3321'
```

## Tips

- Convert city names to coordinates before calling
- Use current date for start, add days for end
- Date format must be YYYY-MM-DD
- recent-rain and last-48 don't need date parameters
