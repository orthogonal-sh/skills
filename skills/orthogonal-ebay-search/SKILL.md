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

Top-level keys: `search_metadata`, `search_parameters`, `search_information`, `categories`, `organic_results`, `related_searches`, `pagination`.

**`search_information`**: `total_results` (integer), `query_displayed`, `sorted_by`.

Each item in **`organic_results`** array:
- **position** (integer) - Result rank
- **item_id** (string) - eBay item ID
- **title** (string) - Listing title
- **link** (string) - Listing page URL
- **condition** (string) - "Brand New", "Pre-Owned", "Refurbished", etc.
- **price** (string) - Display price (e.g., "$199.99")
- **extracted_price** (number) - Numeric price for comparison
- **original_price** / **extracted_original_price** - Pre-discount price (if discounted)
- **shipping** (string) - Shipping cost text (e.g., "Free delivery")
- **extracted_shipping** (number) - Numeric shipping cost
- **buying_format** (string) - "Buy It Now", "or Best Offer", or bid info with time left
- **rating** (number) - Seller rating (if available)
- **reviews** (integer) - Review count (if available)
- **extensions** (array) - Tags like brand, material, location, "Free returns", "Last one"
- **thumbnail** (string) - Image URL
- **tag** (string) - Special badges like "NEW LOW PRICE" (if applicable)

**Pagination**: Use `page=2`, `page=3`, etc. for more results. Response includes `pagination.next` URL.

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

## Error Handling

- **400** - Invalid engine name or missing `q` parameter
- **401** - Invalid API key
- **429** - Rate limit — wait and retry
- Empty `organic_results` means no listings found — try broader terms
- Use separate `-q` flags if `&` in query string causes issues: `-q 'engine=ebay_search' -q 'q=vintage watch'`
