---
name: server-side-conversion-tracking
description: Implement server-side conversion tracking with event schemas, consent, dedupe, and validation.
---

# Server Side Conversion Tracking

Use this skill when adding or debugging backend conversion tracking for ads, analytics, attribution, or lifecycle events.

## Workflow

- Define the conversion events, required properties, user identifiers, and consent requirements.
- Keep client and server event IDs aligned for deduplication.
- Avoid logging secrets or unnecessary personal data.
- Add retry, observability, and validation for delivery failures.
- Test with provider debug tools and local automated checks.
