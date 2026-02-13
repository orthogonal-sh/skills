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
orth api run brand-dev /v1/brand/retrieve --query 'domain=stripe.com'
```

### Get Simplified Brand ($0.03)
```bash
orth api run brand-dev /v1/brand/retrieve-simplified --query 'domain=notion.so'
```

### Extract Style Guide ($0.03)
```bash
orth api run brand-dev /v1/brand/styleguide --query 'domain=linear.app'
```

### Get Font Information ($0.03)
```bash
orth api run brand-dev /v1/brand/fonts --query 'domain=vercel.com'
```

### Capture Screenshot ($0.03)
```bash
orth api run brand-dev /v1/brand/screenshot --query 'domain=github.com'
```

### NAICS Classification ($0.03)
```bash
orth api run brand-dev /v1/brand/naics --query 'input=openai.com'
```

### AI Query ($0.03)
```bash
orth api run brand-dev /v1/brand/ai/query --body '{
  "domain": "anthropic.com",
  "data_to_extract": [{"name": "products", "description": "What products does this company offer?"}]
}'
```

### Find by Company Name ($0.03)
```bash
orth api run brand-dev /v1/brand/retrieve-by-name --query 'name=Stripe'
```

### Find by Email ($0.03)
```bash
orth api run brand-dev /v1/brand/retrieve-by-email --query 'email=john@stripe.com'
```

### Find by Stock Ticker ($0.03)
```bash
orth api run brand-dev /v1/brand/retrieve-by-ticker --query 'ticker=AAPL'
```

## Use Cases

1. **Design Systems**: Extract brand colors, fonts, and styles
2. **Competitive Analysis**: Understand competitor branding
3. **Lead Enrichment**: Get company info from domains or emails
4. **Transaction Identification**: Identify companies from transaction data
5. **Market Research**: Classify and categorize companies
