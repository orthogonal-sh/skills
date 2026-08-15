---
name: subscription-cancel-assistant
description: Find likely recurring subscriptions, calculate waste, and prepare safe cancellation steps for user approval.
---

# Subscription Cancel Assistant

Use this skill when the user wants to find unwanted subscriptions, understand recurring charges, or prepare cancellation workflows.

## Workflow

1. Gather transaction data from a user-provided export or connected finance tool.
2. Detect recurring merchants, interval, estimated annualized cost, and last charge.
3. Rank by likely waste, ambiguity, and cancellation friction.
4. Find official cancellation pages or support paths.
5. Draft a cancellation plan for user approval before taking any external action.

## Safety

- Do not log into accounts, cancel services, or contact vendors without explicit confirmation.
- Treat financial exports as private.
- Prefer official merchant URLs over search-result snippets.
