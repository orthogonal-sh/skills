---
name: precip
description: Hyperlocal weather data - precipitation, temperature, wind, soil moisture and more
---

# Precip - Hyperlocal Weather Data API

Access hyperlocal weather data including precipitation, temperature, wind, soil conditions, and more.

## Capabilities

- **Last 48 Hours Precipitation Data**: Total precipitation in the last 48 hours for the given location(s) ($0.01)
- **Air Temperature**: Hourly near-surface air temperature in Celsius (°C) ($0.01)
- **Hourly Soil Moisture**: Hourly soil moisture percentage relative to holding capacity at 0-10cm depth ($0.01)
- **Wind Direction**: Hourly wind direction in compass degrees (0-360) ($0.01)
- **Daily Precipitation Data**: Returns comprehensive daily precipitation data for the given time range and location(s) ($0.01)
- **Wind Gusts**: Hourly wind gust speed in meters per second (m/s) ($0.01)
- **Recent Rain Event**: Returns detailed information about the most recent precipitation event for the given location(s), including total amounts, precipitation type (rain/snow), timing, and how long ago it occurred ($0.01)
- **Map Layer Tiles**: Map tiles compatible with most web mapping or GIS tools ($0.01)
- **Wind Speed**: Hourly near-surface wind speed in meters per second (m/s) ($0.01)
- **Cloud Cover**: Hourly cloud cover fraction (0-1, where 0 is clear and 1 is overcast) ($0.01)
- **Soil Temperature**: Hourly soil temperature data at 0-10cm depth in Celsius (°C) ($0.01)
- **Specific Humidity**: Hourly specific humidity (kg/kg) ($0.01)
- **Hourly Precipitation Data**: Returns comprehensive hourly precipitation data for the given time range and location(s) ($0.01)
- **Daily Soil Moisture**: Daily soil moisture percentage relative to holding capacity at 0-10cm depth ($0.01)
- **Embeddable HTML UI**: Returns a complete, HTML page displaying comprehensive weather data for a specific location ($0.10)
- **Solar Radiation**: Hourly downward short-wave radiation flux in watts per square meter (W/m²) ($0.01)
- **Relative Humidity**: Hourly relative humidity as a percentage (0-100%) ($0.01)

## Usage

### Last 48 Hours Precipitation Data ($0.01)
Total precipitation in the last 48 hours for the given location(s).

Parameters:
- longitude* (string)
- latitude* (string)
- timeZoneId (string)
- format (string)

```bash
orth api run precip /api/v1/last-48 --query latitude=37.7749 longitude=-122.4194
```

### Air Temperature ($0.01)
Hourly near-surface air temperature in Celsius (°C)

Parameters:
- start* (string)
- end* (string)
- longitude* (string) - Comma-separated list of longitude coordinates (WGS84)
- latitude* (string) - Comma-separated list of latitude coordinates (WGS84)
- timeZoneId (string) - IANA timezone identifier for localizing timestamps
- format (string) - Output format: `geojson`, `json` or `csv`

```bash
orth api run precip /api/v1/temperature-hourly --query latitude=37.7749 longitude=-122.4194 start=2024-01-01 end=2024-01-02
```

### Hourly Soil Moisture ($0.01)
Hourly soil moisture percentage relative to holding capacity at 0-10cm depth

Parameters:
- start* (string)
- end* (string)
- longitude* (string)
- latitude* (string)
- timeZoneId (string)
- format (string)

```bash
orth api run precip /api/v1/soil-moisture-hourly --query latitude=37.7749 longitude=-122.4194 start=2024-01-01 end=2024-01-02
```

### Wind Direction ($0.01)
Hourly wind direction in compass degrees (0-360)

Parameters:
- start* (string)
- end* (string)
- longitude* (string) - Comma-separated list of longitude coordinates (WGS84)
- latitude* (string) - Comma-separated list of latitude coordinates (WGS84)
- timeZoneId (string) - IANA timezone identifier for localizing timestamps
- format (string) - Output format: `geojson`, `json` or `csv`

```bash
orth api run precip /api/v1/wind-direction-hourly --query latitude=37.7749 longitude=-122.4194 start=2024-01-01 end=2024-01-02
```

### Daily Precipitation Data ($0.01)
Returns comprehensive daily precipitation data for the given time range and location(s). Each day includes precipitation amount, type (rain/snow/mixed), probability (for forecasts), and data source. Seamlessly combines historical observations with forecast data depending on the requested time range.

Parameters:
- start* (string)
- end* (string)
- longitude* (string)
- latitude* (string)
- timeZoneId (string)
- format (string)

```bash
orth api run precip /api/v1/daily --query latitude=37.7749 longitude=-122.4194 start=2024-01-01 end=2024-01-31
```

### Wind Gusts ($0.01)
Hourly wind gust speed in meters per second (m/s)

Parameters:
- start* (string)
- end* (string)
- longitude* (string) - Comma-separated list of longitude coordinates (WGS84)
- latitude* (string) - Comma-separated list of latitude coordinates (WGS84)
- timeZoneId (string) - IANA timezone identifier for localizing timestamps
- format (string) - Output format: `geojson`, `json` or `csv`

```bash
orth api run precip /api/v1/wind-speed-gust-hourly --query latitude=37.7749 longitude=-122.4194 start=2024-01-01 end=2024-01-02
```

### Recent Rain Event ($0.01)
Returns detailed information about the most recent precipitation event for the given location(s), including total amounts, precipitation type (rain/snow), timing, and how long ago it occurred.

Parameters:
- longitude* (string)
- latitude* (string)
- timeZoneId (string)
- format (string)

```bash
orth api run precip /api/v1/recent-rain --query latitude=37.7749 longitude=-122.4194
```

### Map Layer Tiles ($0.01)
Map tiles compatible with most web mapping or GIS tools. Software such as Mapbox, Google Maps, ArcGIS, Leaflet, OpenLayers or QGIS will require an `x/y/z` url eg `https://api.precip.ai/api/v1/map/last-48/ImageServer/tile/{z}/{y}/{x}`. See the examples for more details.

Parameters:
- time (string)

```bash
orth api run precip /api/v1/map/precipitation/ImageServer/tile/5/12/10
```

### Wind Speed ($0.01)
Hourly near-surface wind speed in meters per second (m/s)

Parameters:
- start* (string)
- end* (string)
- longitude* (string) - Comma-separated list of longitude coordinates (WGS84)
- latitude* (string) - Comma-separated list of latitude coordinates (WGS84)
- timeZoneId (string) - IANA timezone identifier for localizing timestamps
- format (string) - Output format: `geojson`, `json` or `csv`

```bash
orth api run precip /api/v1/wind-speed-hourly --query latitude=37.7749 longitude=-122.4194 start=2024-01-01 end=2024-01-02
```

### Cloud Cover ($0.01)
Hourly cloud cover fraction (0-1, where 0 is clear and 1 is overcast)

Parameters:
- start* (string)
- end* (string)
- longitude* (string) - Comma-separated list of longitude coordinates (WGS84)
- latitude* (string) - Comma-separated list of latitude coordinates (WGS84)
- timeZoneId (string) - IANA timezone identifier for localizing timestamps
- format (string) - Output format: `geojson`, `json` or `csv`

```bash
orth api run precip /api/v1/cloud-cover-hourly --query latitude=37.7749 longitude=-122.4194 start=2024-01-01 end=2024-01-02
```

### Soil Temperature ($0.01)
Hourly soil temperature data at 0-10cm depth in Celsius (°C)

Parameters:
- start* (string)
- end* (string)
- longitude* (string) - Comma-separated list of longitude coordinates (WGS84)
- latitude* (string) - Comma-separated list of latitude coordinates (WGS84)
- timeZoneId (string) - IANA timezone identifier for localizing timestamps
- format (string) - Output format: `geojson`, `json` or `csv`

```bash
orth api run precip /api/v1/temp-0-10cm-hourly --query latitude=37.7749 longitude=-122.4194 start=2024-01-01 end=2024-01-02
```

### Specific Humidity ($0.01)
Hourly specific humidity (kg/kg)

Parameters:
- start* (string)
- end* (string)
- longitude* (string) - Comma-separated list of longitude coordinates (WGS84)
- latitude* (string) - Comma-separated list of latitude coordinates (WGS84)
- timeZoneId (string) - IANA timezone identifier for localizing timestamps
- format (string)

```bash
orth api run precip /api/v1/specific-humidity-hourly --query latitude=37.7749 longitude=-122.4194 start=2024-01-01 end=2024-01-02
```

### Hourly Precipitation Data ($0.01)
Returns comprehensive hourly precipitation data for the given time range and location(s). Each hour includes precipitation amount, type (rain/snow/mixed), probability (for forecasts), and data source.

Parameters:
- start* (string)
- end* (string)
- longitude* (string)
- latitude* (string)
- timeZoneId (string)
- format (string)

```bash
orth api run precip /api/v1/hourly --query latitude=37.7749 longitude=-122.4194 start=2024-01-01 end=2024-01-07
```

### Daily Soil Moisture ($0.01)
Daily soil moisture percentage relative to holding capacity at 0-10cm depth

Parameters:
- start* (string)
- end* (string)
- longitude* (string)
- latitude* (string)
- timeZoneId (string)
- format (string)

```bash
orth api run precip /api/v1/soil-moisture-daily --query latitude=37.7749 longitude=-122.4194 start=2024-01-01 end=2024-01-31
```

### Embeddable HTML UI ($0.10)
Returns a complete, HTML page displaying comprehensive weather data for a specific location. See the examples page for more details. 

 Authorization headers set automatically from query parameters on this endpoint.

Parameters:
- lat* (number) - Latitude coordinate (-90 to 90) for the location center of the precipitation widget
- lon* (number) - Longitude coordinate (-180 to 180) for the location center of the precipitation widget
- apiKey* (string) - Your API key for authentication. Gets automatically applied as header.
- units (string) - Unit system for displaying precipitation amounts and temperatures. 'metric' shows mm and °C, 'imperial' shows inches and °F.
- widgets (string) - Comma-separated list of widget keys to display.

Available options:
`current`, `event`, `calendar`, `cumulative`, `total`, `precip`, `table`, `wind`, `temp`, `soiltemp`, `soilmoisture`, `snow`

When not provided, shows all widgets.

```bash
orth api run precip /embed/location --query lat=37.7749 lon=-122.4194
```

### Solar Radiation ($0.01)
Hourly downward short-wave radiation flux in watts per square meter (W/m²)

Parameters:
- start* (string)
- end* (string)
- longitude* (string) - Comma-separated list of longitude coordinates (WGS84)
- latitude* (string) - Comma-separated list of latitude coordinates (WGS84)
- timeZoneId (string) - IANA timezone identifier for localizing timestamps
- format (string) - Output format: `geojson`, `json` or `csv`

```bash
orth api run precip /api/v1/solar-radiation-hourly --query latitude=37.7749 longitude=-122.4194 start=2024-01-01 end=2024-01-02
```

### Relative Humidity ($0.01)
Hourly relative humidity as a percentage (0-100%)

Parameters:
- start* (string)
- end* (string)
- longitude* (string) - Comma-separated list of longitude coordinates (WGS84)
- latitude* (string) - Comma-separated list of latitude coordinates (WGS84)
- timeZoneId (string) - IANA timezone identifier for localizing timestamps
- format (string) - Output format: `geojson`, `json` or `csv`

```bash
orth api run precip /api/v1/relative-humidity-hourly --query latitude=37.7749 longitude=-122.4194 start=2024-01-01 end=2024-01-02
```

## Use Cases

1. **Agriculture**: Monitor soil moisture and plan irrigation
2. **Construction**: Track weather conditions for project planning
3. **Event Planning**: Check precipitation forecasts for outdoor events
4. **Research**: Access historical weather data for analysis
5. **IoT/Smart Home**: Integrate weather data into automation

## Discover More

For full endpoint details and parameters:

```bash
orth api show precip              # List all endpoints
orth api show precip <endpoint>   # Get endpoint parameters
```
