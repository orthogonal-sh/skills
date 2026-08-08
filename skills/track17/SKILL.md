---
name: track17
description: Track parcels through 17TRACK, persist shipment state, poll updates, and handle webhooks.
---

# 17TRACK Package Tracking

Use this skill when tracking shipments through 17TRACK or normalizing logistics events.

## Workflow

1. Collect tracking number, carrier hint, title, and notification preference.
2. Register or query the shipment through 17TRACK.
3. Store normalized checkpoints with status, location, timestamp, and carrier.
4. Poll or process webhook updates for delivery changes.
5. Flag exceptions, stale shipments, and delivery-complete events.

## Guardrails

Keep tracking numbers and delivery metadata private unless the user asks to share them.
