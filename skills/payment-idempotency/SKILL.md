---
name: payment-idempotency
description: Design and audit idempotent payment, checkout, refund, and webhook flows.
---

# Payment Idempotency

Use this skill when implementing or reviewing payment operations that must be safe across retries, timeouts, duplicated webhooks, or partial failures.

## Stub Notes

- Source: skills.sh hot list / vtex skills.
- Suggested coverage: idempotency keys, dedupe stores, transaction state machines, retry policy, webhook replay safety, and reconciliation.
- Suggested setup: document payment provider idempotency APIs and local test fixtures.
