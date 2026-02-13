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
orth api run hunter /v2/email-finder --query domain=stripe.com first_name=John last_name=Doe
```

### Step 2: Verify Email
Verify the email is deliverable:

```bash
orth api run hunter /v2/email-verifier --query 'email=john@stripe.com'
```

### Step 3: Get More Contact Info
Use Sixtyfour for additional enrichment:

```bash
orth api run sixtyfour /enrich-lead --body '{
  "lead_info": {
    "first_name": "John",
    "last_name": "Doe",
    "company": "Stripe",
    "linkedin_url": "https://linkedin.com/in/johndoe"
  },
  "struct": {"email": "Work email", "phone": "Phone number"}
}'
```

### Step 4: Find Phone Number
Use Sixtyfour to find phone:

```bash
orth api run sixtyfour /find-phone --body '{
  "lead": {
    "first_name": "John",
    "last_name": "Doe",
    "company": "Stripe"
  }
}'
```

### Step 5: Enrich Company Data
Get detailed company information:

```bash
orth api run hunter /v2/companies/find --query 'domain=stripe.com'
```

### Step 6: Get LinkedIn Data
Fetch real-time LinkedIn profile:

```bash
orth api run fiber /v1/linkedin-live-fetch/profile/single --body '{"identifier": "https://linkedin.com/in/johndoe"}'
```

## Full Enrichment Pipeline

```bash
# 1. Start with name + company
export NAME="John Doe"
export COMPANY="Stripe"
export DOMAIN="stripe.com"

# 2. Find email (Hunter)
orth api run hunter /v2/email-finder --query domain=$DOMAIN first_name=John last_name=Doe

# 3. Verify email
orth api run hunter /v2/email-verifier --query "email=john@stripe.com"

# 4. Get full lead profile (Sixtyfour)
orth api run sixtyfour /enrich-lead --body '{"lead_info": {"first_name": "John", "last_name": "Doe", "company": "Stripe"}, "struct": {"email": "Work email"}}'

# 5. Find phone
orth api run sixtyfour /find-phone --body '{"lead": {"first_name": "John", "last_name": "Doe", "company": "Stripe"}}'

# 6. Get company details
orth api run hunter /v2/companies/find --query "domain=stripe.com"
```

## Tips

- Always verify emails before outreach
- Use multiple sources for better coverage
- LinkedIn URLs dramatically improve match rates
- Cache results to avoid duplicate lookups

## Discover More

List all endpoints, or add a path for parameter details:

```bash
orth api show fiber
orth api show hunter
orth api show sixtyfour 
```

Example: `orth api show olostep /v1/scrapes` for endpoint parameters.
