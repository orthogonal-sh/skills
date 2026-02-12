---
name: brand-dev
description: Brand intelligence - logos, colors, fonts, styleguides, and company data from any domain
---

# Brand.dev - Brand Intelligence API

Extract comprehensive brand information from any domain - logos, colors, fonts, and more.

## Capabilities

- **Retrieve Brand**: Get logos, colors, industry, description ($0.03)
- **Style Guide**: Extract design system information ($0.03)
- **Fonts**: Get font information from websites ($0.03)
- **Products**: Extract product information ($0.03)
- **Screenshots**: Capture website screenshots ($0.03)
- **NAICS Classification**: Classify into NAICS codes ($0.03)
- **AI Query**: Extract custom data points ($0.03)
- **Lookups**: Find by name, ticker, email, or ISIN ($0.03)

## Usage

### Get Brand Info ($0.03)
```bash
curl "https://api.orth.sh/v1/run/brand-dev/v1/brand/retrieve?domain=stripe.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Get Simplified Brand ($0.03)
```bash
curl "https://api.orth.sh/v1/run/brand-dev/v1/brand/retrieve-simplified?domain=notion.so" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Extract Style Guide ($0.03)
```bash
curl "https://api.orth.sh/v1/run/brand-dev/v1/brand/styleguide?domain=linear.app" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Get Font Information ($0.03)
```bash
curl "https://api.orth.sh/v1/run/brand-dev/v1/brand/fonts?domain=vercel.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Capture Screenshot ($0.03)
```bash
curl "https://api.orth.sh/v1/run/brand-dev/v1/brand/screenshot?domain=github.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### NAICS Classification ($0.03)
```bash
curl "https://api.orth.sh/v1/run/brand-dev/v1/brand/naics?domain=openai.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### AI Query ($0.03)
```bash
curl -X POST "https://api.orth.sh/v1/run/brand-dev/v1/brand/ai/query" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "domain": "anthropic.com",
    "query": "What products does this company offer?"
  }'
```

### Find by Company Name ($0.03)
```bash
curl "https://api.orth.sh/v1/run/brand-dev/v1/brand/retrieve-by-name?name=Stripe" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Find by Email ($0.03)
```bash
curl "https://api.orth.sh/v1/run/brand-dev/v1/brand/retrieve-by-email?email=john@stripe.com" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Find by Stock Ticker ($0.03)
```bash
curl "https://api.orth.sh/v1/run/brand-dev/v1/brand/retrieve-by-ticker?ticker=AAPL" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

## CLI Usage

```bash
# Get comprehensive brand data
orth api run brand-dev /v1/brand/retrieve --query 'domain=figma.com'

# Extract style guide
orth api run brand-dev /v1/brand/styleguide --query 'domain=tailwindcss.com'

# Custom AI extraction
orth api run brand-dev /v1/brand/ai/query --body '{"domain": "shopify.com", "query": "What is their pricing?"}'
```

## Use Cases

1. **Design Systems**: Extract brand colors, fonts, and styles
2. **Competitive Analysis**: Understand competitor branding
3. **Lead Enrichment**: Get company info from domains or emails
4. **Transaction Identification**: Identify companies from transaction data
5. **Market Research**: Classify and categorize companies
