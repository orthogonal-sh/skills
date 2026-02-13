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
orth api run precip /api/v1/hourly --query lat=37.7749 lon=-122.4194 start=2024-01-01 end=2024-01-07
```

### Daily Precipitation ($0.01)
```bash
orth api run precip /api/v1/daily --query lat=37.7749 lon=-122.4194 start=2024-01-01 end=2024-01-31
```

### Last 48 Hours ($0.01)
```bash
orth api run precip /api/v1/last-48 --query lat=37.7749 lon=-122.4194
```

### Temperature Hourly ($0.01)
```bash
orth api run precip /api/v1/temperature-hourly --query lat=37.7749 lon=-122.4194 start=2024-01-01 end=2024-01-02
```

### Wind Speed ($0.01)
```bash
orth api run precip /api/v1/wind-speed-hourly --query lat=37.7749 lon=-122.4194 start=2024-01-01 end=2024-01-02
```

### Soil Moisture ($0.01)
```bash
orth api run precip /api/v1/soil-moisture-hourly --query lat=37.7749 lon=-122.4194 start=2024-01-01 end=2024-01-02
```

### Recent Rain Event ($0.01)
```bash
orth api run precip /api/v1/recent-rain --query lat=37.7749 lon=-122.4194
```

### Weather Embed ($0.10)
```bash
orth api run precip /embed/location --query lat=37.7749 lon=-122.4194
```

## Use Cases

1. **Agriculture**: Monitor soil moisture and plan irrigation
2. **Construction**: Track weather conditions for project planning
3. **Event Planning**: Check precipitation forecasts for outdoor events
4. **Research**: Access historical weather data for analysis
5. **IoT/Smart Home**: Integrate weather data into automation
