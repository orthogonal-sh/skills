---
name: webhook-gen
description: Generate webhook handlers with signature verification, retries, idempotency, and observability.
---

# Webhook Generator

Use this skill when implementing webhook receivers or reviewing webhook integration code.

## When To Use

- Add Stripe, GitHub, Linear, Slack, or custom webhook endpoints.
- Validate request signatures.
- Design retry and idempotency behavior.
- Normalize provider events into internal jobs.

## Checklist

- Raw body access for signature checks
- Timestamp tolerance
- Idempotency key or event ID storage
- Fast 2xx response after durable enqueue
- Dead-letter path
- Structured logging
- Replay tooling for local tests

## Output

Provide handler code, environment variables, test fixtures, and a short operations note.
