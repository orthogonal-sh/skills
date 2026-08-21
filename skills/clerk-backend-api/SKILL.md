---
name: clerk-backend-api
description: Use Clerk backend APIs for users, organizations, sessions, invitations, and webhooks.
---

# Clerk Backend API

Use this skill when server code needs to query or mutate Clerk resources.

## Stub Workflow

1. Confirm which Clerk resource is needed: user, organization, membership, session, or invitation.
2. Use server-side SDKs or REST APIs with scoped credentials.
3. Handle pagination, idempotency, validation, and permission checks.
4. Add tests around auth failure, missing resources, and role boundaries.

## Source

Discovered from skills.sh trending, `clerk/skills`.
