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
- **Person Lookup**: Get person info from email ($0.01)
- **Company Lookup**: Get company info from domain ($0.01)
- **Combined Lookup**: Get person + company from email ($0.01)
- **Company Discovery**: Find companies matching criteria ($0.01)

## Usage

### Domain Search ($0.01)
```bash
curl "https://api.orth.sh/v1/run/hunter/v2/domain-search?domain=stripe.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Find Email ($0.01)
```bash
curl "https://api.orth.sh/v1/run/hunter/v2/email-finder?domain=openai.com&first_name=Sam&last_name=Altman" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Verify Email ($0.01)
```bash
curl "https://api.orth.sh/v1/run/hunter/v2/email-verifier?email=john@example.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Person Lookup ($0.01)
```bash
curl "https://api.orth.sh/v1/run/hunter/v2/people/find?email=john@company.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Company Lookup ($0.01)
```bash
curl "https://api.orth.sh/v1/run/hunter/v2/companies/find?domain=anthropic.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Combined Lookup ($0.01)
```bash
curl "https://api.orth.sh/v1/run/hunter/v2/combined/find?email=jane@company.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Discover Companies ($0.01)
```bash
curl -X POST "https://api.orth.sh/v1/run/hunter/v2/discover" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"query": "AI startups in San Francisco"}'
```

### Email Count ($0.01)
```bash
curl "https://api.orth.sh/v1/run/hunter/v2/email-count?domain=google.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

## CLI Usage

```bash
# Find all emails for a domain
orth api run hunter /v2/domain-search --query 'domain=notion.so'

# Find specific person's email
orth api run hunter /v2/email-finder --query 'domain=stripe.com&first_name=Patrick&last_name=Collison'

# Verify email deliverability
orth api run hunter /v2/email-verifier --query 'email=test@company.com'

# Discover companies
orth api run hunter /v2/discover --body '{"query": "fintech startups NYC"}'
```

## Use Cases

1. **Sales Outreach**: Find verified emails at target companies
2. **Lead Generation**: Build email lists by domain
3. **Email Validation**: Clean lists before campaigns
4. **Company Research**: Find companies matching criteria
5. **Contact Enrichment**: Get full profiles from emails
