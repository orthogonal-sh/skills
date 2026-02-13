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
orth api run tomba /v1/domain-search --query 'domain=stripe.com'
```

### Find Email from LinkedIn ($0.01)
```bash
orth api run tomba /v1/linkedin --query 'url=https://linkedin.com/in/johndoe'
```

### Verify Email ($0.01)
```bash
orth api run tomba /v1/email-verifier --query 'email=john@example.com'
```

### AI Company Search ($0.01)
```bash
orth api run tomba /v1/reveal/search --body '{"query": "AI startups in San Francisco with 50+ employees"}'
```

### Email Count by Department ($0.01)
```bash
orth api run tomba /v1/email-count --query 'domain=openai.com'
```

### Get Company Info ($0.01)
```bash
orth api run tomba /v1/companies/find --query 'domain=anthropic.com'
```

### Domain Suggestions ($0.01)
```bash
orth api run tomba /v1/domain-suggestions --query 'company=Google'
```

## Use Cases

1. **Sales Prospecting**: Find contact emails at target companies
2. **Lead Generation**: Build email lists from LinkedIn
3. **Email Validation**: Clean email lists before campaigns
4. **Company Research**: Find companies matching criteria
5. **Outreach**: Verify emails before sending
