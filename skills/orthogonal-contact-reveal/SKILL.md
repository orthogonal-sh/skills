---
name: contact-reveal
description: Reveal work emails, personal emails, and phone numbers from a LinkedIn profile URL
---

# Contact Reveal - Emails & Phone Numbers from LinkedIn

Given a LinkedIn URL, reveal work emails, personal emails, and phone numbers. Three tiers available depending on speed, cost, and coverage needs. Batch mode for lists up to 2000 people.

## When to Use

- User has a LinkedIn profile URL and needs contact info
- Sales outreach — need verified work email for a prospect
- Recruiting — need personal email or phone for a candidate
- Bulk enrichment — have a list of LinkedIn URLs to enrich

## Choosing a Tier

| Tier | Speed | Cost | Coverage | Best For |
|------|-------|------|----------|----------|
| Standard | ~30s | 5 credits | Good | Default choice, balanced |
| Turbo | ~10s | 7 credits | Good | Time-sensitive, real-time flows |
| Exhaustive | ~60s (async) | 12 credits | Maximum | Critical contacts, need every possible email/phone |

*Costs above are for all contact types. Requesting fewer types costs less (e.g., work email only = 2 credits on standard).*

## Workflow

### Option A: Single Person (Standard)

Best default choice — good coverage at lowest cost:

```bash
orth api run fiber /v1/contact-details/single --body '{
  "linkedinUrl": "https://www.linkedin.com/in/johndoe",
  "enrichmentType": {"getWorkEmails": true, "getPersonalEmails": true, "getPhoneNumbers": true},
  "validateEmails": true
}'
```

### Option B: Single Person (Turbo — Fastest)

When you need results in seconds (e.g., real-time enrichment during a call):

```bash
orth api run fiber /v1/contact-details/turbo/sync --body '{
  "linkedinUrl": "https://www.linkedin.com/in/johndoe",
  "enrichmentType": {"getWorkEmails": true, "getPersonalEmails": true, "getPhoneNumbers": true}
}'
```

### Option C: Single Person (Exhaustive — Maximum Coverage)

When the contact is high-value and you need every possible email/phone:

```bash
# Step 1: Start the exhaustive search
orth api run fiber /v1/contact-details/exhaustive/start --body '{
  "linkedinUrl": "https://www.linkedin.com/in/johndoe",
  "enrichmentType": {"getWorkEmails": true, "getPersonalEmails": true, "getPhoneNumbers": true}
}'

# Step 2: Poll for results (repeat until complete)
orth api run fiber /v1/contact-details/exhaustive/poll --body '{"taskId": "TASK_ID_FROM_STEP_1"}'
```

### Option D: Batch (Up to 2000 People)

For enriching a list of prospects:

```bash
# Step 1: Start batch job
orth api run fiber /v1/contact-details/batch/start --body '{
  "personDetails": [
    {"linkedinUrl": {"value": "https://www.linkedin.com/in/johndoe"}},
    {"linkedinUrl": {"value": "https://www.linkedin.com/in/janedoe"}},
    {"linkedinUrl": {"value": "https://www.linkedin.com/in/bobsmith"}}
  ],
  "enrichmentTypes": {"getWorkEmails": true, "getPersonalEmails": true, "getPhoneNumbers": true}
}'

# Step 2: Poll for results (repeat until done=true)
orth api run fiber /v1/contact-details/batch/poll --body '{"taskId": "TASK_ID_FROM_STEP_1", "take": 100}'
```

Use `cursor` from the response to paginate through large result sets.

## Example Usage

```bash
# Just work email (cheapest — 2 credits)
orth api run fiber /v1/contact-details/single --body '{
  "linkedinUrl": "https://www.linkedin.com/in/johndoe",
  "enrichmentType": {"getWorkEmails": true, "getPersonalEmails": false, "getPhoneNumbers": false}
}'

# Just phone number (3 credits)
orth api run fiber /v1/contact-details/single --body '{
  "linkedinUrl": "https://www.linkedin.com/in/johndoe",
  "enrichmentType": {"getWorkEmails": false, "getPersonalEmails": false, "getPhoneNumbers": true}
}'

# All contact info, fastest possible
orth api run fiber /v1/contact-details/turbo/sync --body '{
  "linkedinUrl": "https://www.linkedin.com/in/johndoe",
  "enrichmentType": {"getWorkEmails": true, "getPersonalEmails": true, "getPhoneNumbers": true}
}'
```

## Tips

- **Start with standard** — use turbo only when speed is critical, exhaustive only for high-value targets
- **Request only what you need** — fewer contact types = lower cost (work email only is 2 credits vs 5 for everything)
- **Batch requires full URLs** — use `https://www.linkedin.com/in/slug`, NOT bare slugs. Single/turbo/exhaustive accept bare slugs.
- **Only person profiles** — only `/in/`, `/sales/lead/`, or `/talent/profile/` URLs work. Company URLs (`/company/`) will error.
- **Check email status** — turbo and exhaustive return a `status` field per email (`valid`, `risky`, `unknown`, `invalid`). Standard does not include `status`. Filter before outreach when available.
- **Check phone type** — each phone includes a `type` field: `mobile`, `other`, or `unknown`
- **Duplicates are deduped** — batch charges are calculated after deduplication
- **Undelivered = refunded** — if no contact info is found for a person, credits are refunded

## Discover More

List all endpoints, or add a path for parameter details:

```bash
orth api show fiber
orth api show fiber /v1/contact-details/single
```

Example: `orth api show fiber /v1/contact-details/single` for endpoint parameters.
