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
orth api run hunter /v2/domain-search --query 'domain=stripe.com'
```

### Step 2: Find Specific Person's Email
Find email for specific contacts:

```bash
orth api run hunter /v2/email-finder --query domain=stripe.com first_name=John last_name=Doe
```

### Step 3: Verify Emails
Check deliverability before sending:

```bash
orth api run hunter /v2/email-verifier --query 'email=john@stripe.com'
```

### Step 4: Batch Verification with Fiber
Validate multiple emails:

```bash
orth api run fiber /v1/validate-email/single --body '{"email": "john@stripe.com"}'
```

### Step 5: Enrich for Personalization
Get info for personalized outreach:

```bash
orth api run sixtyfour /enrich-lead --body '{
  "lead_info": {
    "first_name": "John",
    "last_name": "Doe",
    "company": "Stripe"
  },
  "struct": {"email": "Work email", "phone": "Phone number"}
}'
```

### Step 6: Get Company Context
Research company for personalization:

```bash
orth api run brand-dev /v1/brand/retrieve --query 'domain=stripe.com'
```

## Campaign Building Pipeline

```bash
# 1. Find target companies
orth api run fiber /v1/company-search --body '{
  "searchParams": {
    "industries": ["SaaS"],
    "employee_count_min": 50,
    "employee_count_max": 500
  }
}'

# 2. Get emails for each company
orth api run hunter /v2/domain-search --query 'domain=company.com'

# 3. Verify each email
orth api run hunter /v2/email-verifier --query 'email=person@company.com'

# 4. Enrich for personalization
orth api run sixtyfour /enrich-lead --body '{"lead_info": {"first_name": "John", "last_name": "Doe", "company": "Company"}, "struct": {"email": "Work email"}}'
```

## Tips

- Always verify emails before sending
- Personalize using enrichment data
- Segment by role, industry, or company size
- Track bounces and clean your list

## Discover More

List all endpoints, or add a path for parameter details:

```bash
orth api show brand-dev
orth api show fiber
orth api show hunter
orth api show sixtyfour 
```

Example: `orth api show olostep /v1/scrapes` for endpoint parameters.
