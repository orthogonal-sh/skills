---
name: logo
description: Logo.dev - search for company domains by brand name
---

# Logo.dev - Company Domain Search

Find company domains by searching brand names.

## Capabilities

- **Search**: Find company domains from brand names ($0.01)

## Usage

### Search for Domain ($0.01)
```bash
curl "https://api.orth.sh/v1/run/logo/search?query=Stripe" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Search Multiple
```bash
curl "https://api.orth.sh/v1/run/logo/search?query=OpenAI" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

## CLI Usage

```bash
# Find domain for a company
orth api run logo /search --query 'query=Anthropic'

# Search for brand
orth api run logo /search --query 'query=Notion'
```

## Use Cases

1. **Domain Discovery**: Find official domains for companies
2. **Brand Research**: Identify company websites
3. **Lead Enrichment**: Get domains from company names
4. **Data Cleaning**: Standardize company domains in datasets
