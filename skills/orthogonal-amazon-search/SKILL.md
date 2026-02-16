---
name: amazon-search
description: Search Amazon products - find items, compare prices, read reviews
---

# Amazon Product Search

Search for products on Amazon. Find items by keyword, category, or criteria.

## When to Use

- User wants to find a product on Amazon
- User asks "find me a [product] on Amazon"
- User wants to compare prices
- User needs product recommendations

## How It Works

Uses the SearchAPI Amazon Search engine to query Amazon's catalog.

## Usage

### Basic Product Search

```bash
orth run searchapi /api/v1/search -q 'engine=amazon_search&q=wireless earbuds'
```

<details>
<summary>curl equivalent</summary>

```bash
curl -X POST "https://api.orth.sh/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"api":"searchapi","path":"/api/v1/search","query":{"engine":"amazon_search","q":"wireless earbuds"}}'
```
</details>

### Search with Category

```bash
orth run searchapi /api/v1/search -q 'engine=amazon_search&q=laptop&category_id=electronics'
```

## Parameters

- **engine** (required) - Must be `amazon_search`
- **q** (required) - Search query
- **category_id** - Amazon category (electronics, books, etc.)
- **page** - Page number for pagination

## Response

Returns product results with:
- Product title
- Price (current and original)
- Rating and review count
- Prime eligibility
- Product URL
- Thumbnail image

## Examples

**User:** "Find wireless earbuds on Amazon"
```bash
orth run searchapi /api/v1/search -q 'engine=amazon_search&q=wireless earbuds'
```

**User:** "Search for laptops under $500"
```bash
orth run searchapi /api/v1/search -q 'engine=amazon_search&q=laptop under 500'
```

**User:** "Find highly rated coffee makers"
```bash
orth run searchapi /api/v1/search -q 'engine=amazon_search&q=coffee maker best rated'
```
