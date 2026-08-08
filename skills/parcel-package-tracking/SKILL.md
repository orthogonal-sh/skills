---
name: parcel-package-tracking
description: Track shipments, carriers, delivery events, and package status across parcel APIs.
---

# Parcel Package Tracking

Use this skill when tracking package deliveries or building shipment notifications.

## Workflow

1. Collect tracking number, carrier if known, destination region, and desired notification rules.
2. Query the configured tracking provider or carrier API.
3. Normalize events into status, location, timestamp, carrier, and estimated delivery.
4. Highlight exceptions, failed delivery attempts, customs holds, and stale scans.
5. Suggest next action when a delivery needs attention.

## Guardrails

Do not expose full delivery addresses unless necessary.
