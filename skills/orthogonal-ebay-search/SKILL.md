---
name: ebay-search
description: Search eBay listings - find items, auctions, deals, and compare prices
---

# eBay Search

Search eBay for products, auctions, and deals.

## When to Use

- User wants to find items on eBay
- User asks about auctions
- User wants to compare prices on eBay
- User looking for used or vintage items

## How It Works

Uses the SearchAPI eBay Search engine to query eBay listings.

## Usage

### Basic Search

```bash
orth run searchapi /api/v1/search -q 'engine=ebay_search&q=vintage watch'
```

<details>
<summary>curl equivalent</summary>

```bash
curl -X POST "https://api.orth.sh/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"api":"searchapi","path":"/api/v1/search","query":{"engine":"ebay_search","q":"vintage watch"}}'
```
</details>

## Parameters

- **engine** (required) - Must be `ebay_search`
- **q** (required) - Search query
- **page** - Page number for pagination

## Response

Returns listing results with:
- Item title
- Current price or bid
- Auction end time (if applicable)
- Condition (new, used, etc.)
- Seller info
- Item URL
- Thumbnail image

## Examples

**User:** "Find vintage watches on eBay"
```bash
orth run searchapi /api/v1/search -q 'engine=ebay_search&q=vintage watch'
```

**User:** "Search eBay for retro gaming consoles"
```bash
orth run searchapi /api/v1/search -q 'engine=ebay_search&q=retro gaming console'
```

**User:** "Find rare vinyl records"
```bash
orth run searchapi /api/v1/search -q 'engine=ebay_search&q=rare vinyl records'
```
