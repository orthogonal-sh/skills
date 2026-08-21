---
name: clerk-webhooks
description: Implement and verify Clerk webhook handlers for user, organization, and membership events.
---

# Clerk Webhooks

Use this skill when building Clerk webhook consumers.

## Stub Workflow

1. List required events and downstream side effects.
2. Verify signatures before parsing trusted payloads.
3. Make handlers idempotent and resilient to retries.
4. Test event fixtures for create, update, delete, and out-of-order delivery.

## Source

Discovered from skills.sh trending, `clerk/skills`.
