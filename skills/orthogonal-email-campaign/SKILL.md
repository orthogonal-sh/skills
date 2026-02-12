---
name: email-campaign
description: Build email campaigns - find emails, verify them, and prepare outreach
---

# Email Campaign - Build Verified Email Lists

Build targeted email campaigns with verified email addresses and personalized outreach.

## Workflow

### Step 1: Find Emails by Domain
Get all emails for target companies:

```bash
curl "https://api.orth.sh/v1/run/hunter/v2/domain-search?domain=stripe.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Step 2: Find Specific Person's Email
Find email for specific contacts:

```bash
curl "https://api.orth.sh/v1/run/hunter/v2/email-finder?domain=stripe.com&first_name=John&last_name=Doe" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Step 3: Verify Emails
Check deliverability before sending:

```bash
curl "https://api.orth.sh/v1/run/hunter/v2/email-verifier?email=john@stripe.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Step 4: Batch Verification with Fiber
Validate multiple emails:

```bash
curl -X POST "https://api.orth.sh/v1/run/fiber/v1/validate-email/single" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"email": "john@stripe.com"}'
```

### Step 5: Enrich for Personalization
Get info for personalized outreach:

```bash
curl -X POST "https://api.orth.sh/v1/run/sixtyfour/enrich-lead" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "first_name": "John",
    "last_name": "Doe",
    "company": "Stripe"
  }'
```

### Step 6: Get Company Context
Research company for personalization:

```bash
curl "https://api.orth.sh/v1/run/brand-dev/v1/brand/retrieve?domain=stripe.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

## Campaign Building Pipeline

```bash
# 1. Find target companies
orth api run fiber /v1/company-search --body '{
  "industries": ["SaaS"],
  "employee_count_min": 50,
  "employee_count_max": 500
}'

# 2. Get emails for each company
orth api run hunter /v2/domain-search --query 'domain=company.com'

# 3. Verify each email
orth api run hunter /v2/email-verifier --query 'email=person@company.com'

# 4. Enrich for personalization
orth api run sixtyfour /enrich-lead --body '{"first_name": "John", "last_name": "Doe", "company": "Company"}'
```

## Tips

- Always verify emails before sending
- Personalize using enrichment data
- Segment by role, industry, or company size
- Track bounces and clean your list
