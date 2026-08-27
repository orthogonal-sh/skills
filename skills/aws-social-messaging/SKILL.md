---
name: aws-social-messaging
description: Build AWS social messaging workflows with Pinpoint, SNS, SES, opt-in, templates, and compliance checks
---

# AWS Social Messaging

Use this skill when implementing messaging workflows on AWS.

## Workflow

1. Identify channels, regions, sender identities, audience sources, and consent model.
2. Configure templates, personalization, opt-in, opt-out, suppression, and rate limits.
3. Validate IAM, secrets, webhook handling, retries, and idempotency.
4. Test delivery, bounces, complaints, unsubscribes, and analytics events.
5. Document compliance constraints and approval requirements.

## Checks

- Ask before sending real external messages unless explicitly instructed.
- Never expose credentials, tokens, or recipient lists.
- Keep transactional and marketing traffic separated.
- Include sandbox and production differences in setup docs.
