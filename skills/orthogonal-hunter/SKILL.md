---
name: hunter
description: Email finder and verifier - find emails, verify deliverability, discover companies
---

# Hunter - Email Intelligence

Find email addresses, verify deliverability, and discover companies.

## Capabilities

- **Domain Search**: Find all emails for a domain ($0.01)
- **Email Finder**: Find email for a person at company ($0.01)
- **Email Verifier**: Check if email is deliverable ($0.01)
- **Company Lookup**: Get company info from domain ($0.01)
- **Company Discovery**: Find companies matching criteria ($0.01)

## Usage

### Domain Search ($0.01)
```bash
orth api run hunter /v2/domain-search --query 'domain=stripe.com'
```

### Find Email ($0.01)
```bash
orth api run hunter /v2/email-finder --query domain=openai.com first_name=Sam last_name=Altman
```

### Verify Email ($0.01)
```bash
orth api run hunter /v2/email-verifier --query 'email=john@example.com'
```

### Company Lookup ($0.01)
```bash
orth api run hunter /v2/companies/find --query 'domain=anthropic.com'
```

### Discover Companies ($0.01)
```bash
orth api run hunter /v2/discover --body '{"query": "AI startups in San Francisco"}'
```

### Email Count ($0.01)
```bash
orth api run hunter /v2/email-count --query 'domain=google.com'
```

## Use Cases

1. **Sales Outreach**: Find verified emails at target companies
2. **Lead Generation**: Build email lists by domain
3. **Email Validation**: Clean lists before campaigns
4. **Company Research**: Find companies matching criteria
5. **Contact Enrichment**: Get full profiles from emails
