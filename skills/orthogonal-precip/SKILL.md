---
name: precip
description: Hyperlocal weather data - precipitation, temperature, wind, soil moisture and more
---

# Precip - Hyperlocal Weather Data API

Access hyperlocal weather data including precipitation, temperature, wind, soil conditions, and more.

## Capabilities

- **Precipitation**: Hourly and daily rainfall data ($0.01)
- **Temperature**: Air and soil temperature readings ($0.01)
- **Wind**: Speed, direction, and gusts ($0.01)
- **Humidity**: Relative and specific humidity ($0.01)
- **Soil**: Moisture and temperature at depth ($0.01)
- **Solar**: Radiation flux data ($0.01)
- **Embeds**: Full weather widget for any location ($0.10)

## Usage

### Hourly Precipitation ($0.01)
```bash
curl "https://api.orth.sh/v1/run/precip/api/v1/hourly?lat=37.7749&lon=-122.4194&start=2024-01-01&end=2024-01-07" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Daily Precipitation ($0.01)
```bash
curl "https://api.orth.sh/v1/run/precip/api/v1/daily?lat=37.7749&lon=-122.4194&start=2024-01-01&end=2024-01-31" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Last 48 Hours ($0.01)
```bash
curl "https://api.orth.sh/v1/run/precip/api/v1/last-48?lat=37.7749&lon=-122.4194" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Temperature Hourly ($0.01)
```bash
curl "https://api.orth.sh/v1/run/precip/api/v1/temperature-hourly?lat=37.7749&lon=-122.4194&start=2024-01-01&end=2024-01-02" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Wind Speed ($0.01)
```bash
curl "https://api.orth.sh/v1/run/precip/api/v1/wind-speed-hourly?lat=37.7749&lon=-122.4194&start=2024-01-01&end=2024-01-02" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Soil Moisture ($0.01)
```bash
curl "https://api.orth.sh/v1/run/precip/api/v1/soil-moisture-hourly?lat=37.7749&lon=-122.4194&start=2024-01-01&end=2024-01-02" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Recent Rain Event ($0.01)
```bash
curl "https://api.orth.sh/v1/run/precip/api/v1/recent-rain?lat=37.7749&lon=-122.4194" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Weather Embed ($0.10)
```bash
curl "https://api.orth.sh/v1/run/precip/embed/location?lat=37.7749&lon=-122.4194" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

## CLI Usage

```bash
# Get hourly precipitation data
orth api run precip /api/v1/hourly --query 'lat=40.7128&lon=-74.0060&start=2024-01-01&end=2024-01-07'

# Check last 48 hours of rain
orth api run precip /api/v1/last-48 --query 'lat=34.0522&lon=-118.2437'

# Get soil moisture for agriculture
orth api run precip /api/v1/soil-moisture-daily --query 'lat=38.5816&lon=-121.4944&start=2024-01-01&end=2024-01-31'
```

## Use Cases

1. **Agriculture**: Monitor soil moisture and plan irrigation
2. **Construction**: Track weather conditions for project planning
3. **Event Planning**: Check precipitation forecasts for outdoor events
4. **Research**: Access historical weather data for analysis
5. **IoT/Smart Home**: Integrate weather data into automation
