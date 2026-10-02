---
name: stripe
description: Inspect and troubleshoot Stripe customers, subscriptions, invoices, payments, webhooks, and billing flows.
---

# Stripe

Use this skill when a task involves Stripe billing, customers, subscriptions, checkout, invoices, disputes, webhooks, or payment debugging.

## Workflow

- Identify the Stripe account, mode, customer, subscription, invoice, payment intent, or webhook event involved.
- Inspect objects and timelines before changing billing state, and distinguish test-mode from live-mode data.
- Treat refunds, cancellations, retries, and customer-visible billing changes as high-impact operations.
- Verify the final state through Stripe objects, webhook delivery, and the application database if relevant.
