---
name: sixtyfour
description: AI-powered lead enrichment - find emails, phones, and enrich company/lead data
---

# Sixtyfour - AI Lead Enrichment

Find contact information and enrich lead data using AI-powered discovery.

## Capabilities

- **Find Phone**: Discover phone numbers for leads ($0.30)
- **Find Email**: Find email addresses for leads ($0.05)
- **Enrich Company**: Get comprehensive company data ($0.10)
- **Enrich Lead**: Get complete lead profile with contact info ($0.10)

## Usage

### Find Email ($0.05)
```bash
curl -X POST "https://api.orth.sh/v1/run/sixtyfour/find-email" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "first_name": "John",
    "last_name": "Doe",
    "company": "Acme Inc",
    "domain": "acme.com"
  }'
```

### Find Phone ($0.30)
```bash
curl -X POST "https://api.orth.sh/v1/run/sixtyfour/find-phone" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "first_name": "John",
    "last_name": "Doe",
    "company": "Acme Inc"
  }'
```

### Enrich Company ($0.10)
```bash
curl -X POST "https://api.orth.sh/v1/run/sixtyfour/enrich-company" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"domain": "acme.com"}'
```

### Enrich Lead ($0.10)
```bash
curl -X POST "https://api.orth.sh/v1/run/sixtyfour/enrich-lead" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "first_name": "John",
    "last_name": "Doe",
    "company": "Acme Inc",
    "linkedin_url": "https://linkedin.com/in/johndoe"
  }'
```

## CLI Usage

```bash
# Find email for a lead
orth api run sixtyfour /find-email --body '{"first_name": "John", "last_name": "Doe", "domain": "acme.com"}'

# Enrich company data
orth api run sixtyfour /enrich-company --body '{"domain": "stripe.com"}'

# Full lead enrichment
orth api run sixtyfour /enrich-lead --body '{"first_name": "Jane", "last_name": "Smith", "company": "OpenAI"}'
```

## Use Cases

1. **Sales Prospecting**: Find contact info for potential customers
2. **Lead Enrichment**: Complete partial lead data with emails/phones
3. **CRM Data Quality**: Fill in missing fields in your CRM
4. **Account Research**: Get comprehensive company information
