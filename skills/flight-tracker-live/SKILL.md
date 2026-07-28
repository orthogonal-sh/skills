---
name: flight-tracker-live
description: Track live flights, delays, gates, routes, and aircraft position
---

# Flight Tracker Live

Use this skill when the user asks about a flight number, airline route, airport arrivals/departures, delays, gates, baggage claims, or live aircraft position.

## Workflow

1. Parse flight number, date, airline, airport, or route from the request.
2. Fetch the latest flight status from the configured flight data source.
3. Check scheduled, estimated, and actual departure/arrival times.
4. Include gate, terminal, delay reason, aircraft, and live position when available.
5. Use absolute local times with airport time zones.

## Notes

- Flight status changes frequently. Always fetch current data.
- If multiple flights match, ask for the date, airline, or airport before acting.
