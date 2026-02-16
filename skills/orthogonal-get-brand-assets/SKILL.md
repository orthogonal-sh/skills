---
name: get-brand-assets
description: Get company logos, brand colors, fonts, and style guides
---

# Get Brand Assets

Extract logos, colors, fonts, and design assets from any company's brand. Useful for partnerships, design work, and brand research.

## When to Use

- User needs a company's logo
- User asks "what are [company]'s brand colors?"
- User is designing something that needs brand assets
- User wants to match a company's visual style
- Creating pitch decks or partnership materials

## How It Works

Uses Brand.dev API to extract brand information directly from company websites.

## Usage

### Get Full Brand Data

```bash
orth run brand-dev /v1/brand/retrieve --query 'domain=stripe.com'
```

### Get Simplified Brand Data (logo + colors)

```bash
orth run brand-dev /v1/brand/retrieve-simplified --query 'domain=notion.so'
```

### Get Brand Fonts

```bash
orth run brand-dev /v1/brand/fonts --query 'domain=linear.app'
```

### Get Design System/Styleguide

```bash
orth run brand-dev /v1/brand/styleguide --query 'domain=vercel.com'
```

### Take Brand Screenshot

```bash
orth run brand-dev /v1/brand/screenshot --query 'domain=figma.com'
```

## Parameters

- **domain** (required) - Company website domain (e.g., stripe.com)

## Response

### Full brand data includes:
- **Logos** - Various formats and sizes
- **Colors** - Primary, secondary, accent colors with hex codes
- **Fonts** - Font families used on the site
- **Industry** - Company industry/category
- **Description** - Company description
- **Social links** - Twitter, LinkedIn, etc.

### Simplified data includes:
- Domain
- Company title
- Primary colors
- Logo URLs
- Backdrop images

### Fonts include:
- Font family names
- Usage (headings, body, etc.)
- Fallback fonts
- Element counts

### Styleguide includes:
- Color palette
- Typography scale
- Spacing values
- UI component styles
- Shadow definitions

## Examples

**User:** "Get Notion's logo and brand colors"
```bash
orth run brand-dev /v1/brand/retrieve-simplified --query 'domain=notion.so'
```

**User:** "What fonts does Linear use?"
```bash
orth run brand-dev /v1/brand/fonts --query 'domain=linear.app'
```

**User:** "I need the full design system for Vercel"
```bash
orth run brand-dev /v1/brand/styleguide --query 'domain=vercel.com'
```

## Tips

- Use the main company domain for best results
- Simplified endpoint is faster if you just need logo + colors
- Logo URLs are direct links you can download
- Colors are provided in hex format
- Styleguide extraction is comprehensive but takes longer
