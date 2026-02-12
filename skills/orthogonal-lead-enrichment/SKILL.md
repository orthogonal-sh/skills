---
name: lead-enrichment
description: Enrich leads with email, phone, company data using multiple data sources
---

# Lead Enrichment - Complete Contact Data

Enrich partial lead data with emails, phone numbers, and company information using multiple APIs.

## Workflow

### Step 1: Find Email Address
Use Hunter to find email:

```bash
curl "https://api.orth.sh/v1/run/hunter/v2/email-finder?domain=stripe.com&first_name=John&last_name=Doe" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Step 2: Verify Email
Verify the email is deliverable:

```bash
curl "https://api.orth.sh/v1/run/hunter/v2/email-verifier?email=john@stripe.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Step 3: Get More Contact Info
Use Sixtyfour for additional enrichment:

```bash
curl -X POST "https://api.orth.sh/v1/run/sixtyfour/enrich-lead" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "first_name": "John",
    "last_name": "Doe",
    "company": "Stripe",
    "linkedin_url": "https://linkedin.com/in/johndoe"
  }'
```

### Step 4: Find Phone Number
Use Sixtyfour to find phone:

```bash
curl -X POST "https://api.orth.sh/v1/run/sixtyfour/find-phone" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "first_name": "John",
    "last_name": "Doe",
    "company": "Stripe"
  }'
```

### Step 5: Enrich Company Data
Get detailed company information:

```bash
curl "https://api.orth.sh/v1/run/hunter/v2/companies/find?domain=stripe.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Step 6: Get LinkedIn Data
Fetch real-time LinkedIn profile:

```bash
curl -X POST "https://api.orth.sh/v1/run/fiber/v1/linkedin-live-fetch/profile/single" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"linkedin_url": "https://linkedin.com/in/johndoe"}'
```

## Full Enrichment Pipeline

```bash
# 1. Start with name + company
export NAME="John Doe"
export COMPANY="Stripe"
export DOMAIN="stripe.com"

# 2. Find email (Hunter)
orth api run hunter /v2/email-finder --query "domain=$DOMAIN&first_name=John&last_name=Doe"

# 3. Verify email
orth api run hunter /v2/email-verifier --query "email=john@stripe.com"

# 4. Get full lead profile (Sixtyfour)
orth api run sixtyfour /enrich-lead --body '{"first_name": "John", "last_name": "Doe", "company": "Stripe"}'

# 5. Find phone
orth api run sixtyfour /find-phone --body '{"first_name": "John", "last_name": "Doe", "company": "Stripe"}'

# 6. Get company details
orth api run hunter /v2/companies/find --query "domain=stripe.com"
```

## Tips

- Always verify emails before outreach
- Use multiple sources for better coverage
- LinkedIn URLs dramatically improve match rates
- Cache results to avoid duplicate lookups
