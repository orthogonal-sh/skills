---
name: tomba
description: Email finder and verifier - find emails from domains, LinkedIn, or company search
---

# Tomba - Email Finding & Verification

Find and verify email addresses from domains, LinkedIn profiles, or natural language search.

## Capabilities

- **Domain Search**: Find all emails for a domain ($0.01)
- **LinkedIn Lookup**: Find email from LinkedIn URL ($0.01)
- **Email Verification**: Verify deliverability ($0.01)
- **Company Search**: AI-powered company search ($0.01)
- **Email Count**: Get email counts by department ($0.01)
- **Company Info**: Get company details from domain ($0.01)

## Usage

### Domain Search ($0.01)
```bash
curl "https://api.orth.sh/v1/run/tomba/v1/domain-search?domain=stripe.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Find Email from LinkedIn ($0.01)
```bash
curl "https://api.orth.sh/v1/run/tomba/v1/linkedin?url=https://linkedin.com/in/johndoe" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Verify Email ($0.01)
```bash
curl "https://api.orth.sh/v1/run/tomba/v1/email-verifier?email=john@example.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### AI Company Search ($0.01)
```bash
curl -X POST "https://api.orth.sh/v1/run/tomba/v1/reveal/search" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"query": "AI startups in San Francisco with 50+ employees"}'
```

### Email Count by Department ($0.01)
```bash
curl "https://api.orth.sh/v1/run/tomba/v1/email-count?domain=openai.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Get Company Info ($0.01)
```bash
curl "https://api.orth.sh/v1/run/tomba/v1/companies/find?domain=anthropic.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Domain Suggestions ($0.01)
```bash
curl "https://api.orth.sh/v1/run/tomba/v1/domain-suggestions?company=Google" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

## CLI Usage

```bash
# Find all emails for a company
orth api run tomba /v1/domain-search --query 'domain=notion.so'

# Find email from LinkedIn profile
orth api run tomba /v1/linkedin --query 'url=https://linkedin.com/in/example'

# Verify an email
orth api run tomba /v1/email-verifier --query 'email=test@company.com'

# Search companies with AI
orth api run tomba /v1/reveal/search --body '{"query": "fintech companies in NYC"}'
```

## Use Cases

1. **Sales Prospecting**: Find contact emails at target companies
2. **Lead Generation**: Build email lists from LinkedIn
3. **Email Validation**: Clean email lists before campaigns
4. **Company Research**: Find companies matching criteria
5. **Outreach**: Verify emails before sending
