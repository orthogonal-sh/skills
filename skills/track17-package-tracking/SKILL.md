---
name: track17-package-tracking
description: Track parcels across carriers with 17TRACK status, history, and delivery alerts
---

# 17TRACK Package Tracking

Use this skill when the user provides a tracking number or asks about parcel status, delivery ETA, carrier handoff, exceptions, or shipment history.

## Workflow

1. Normalize the tracking number and carrier if provided.
2. Query 17TRACK or the configured tracking provider.
3. Report current status, last scan location, timestamp, carrier, and ETA.
4. Explain exceptions such as customs hold, attempted delivery, or label created.
5. Offer to monitor changes only when scheduling or notification tools are available.

## Notes

- Tracking data may lag carrier scans.
- Use absolute times and include the carrier's local time zone when available.
