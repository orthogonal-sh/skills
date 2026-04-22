---
name: investor-recent-investments
description: Find an investment firm's most recent investments — look up a VC firm by domain/name and get the companies they recently invested in with full company details. Use when asked about a firm's recent deals, portfolio activity, latest investments, or "what has [firm] invested in recently?"
---

# Investor Recent Investments

Find an investment firm's most recent investments with full company details. Two-step workflow:
1. Search for the investor to get their ID(s)
2. Use those IDs to find companies where the investor participated in the latest round

## When to Use

- User wants to know what companies a specific investor backed recently
- User asks "what has Benchmark invested in recently?"

---

## Step 1: Search for the Investor

Look up the investor by domain or name to get their UUID(s). A single domain like `benchmark.com` may return multiple entities.

### By Domain

```bash
orth api run fundable /investor/search --query 'domain=benchmark.com'
```

### By Name

```bash
orth api run fundable /investor/search --query 'name=benchmark'
```

**Response:**
```json
{
  "success": true,
  "data": {
    "investors": [
      {
        "id": "abc123-...",
        "guru_permalink": "benchmark",
        "name": "Benchmark",
        "description": "Benchmark is an early-stage venture capital firm...",
        "image": "https://images.crunchbase.com/image/upload/...",
        "relevance_score": 99,
        "domain": "benchmark.com",
        "website": "https://www.benchmark.com/",
        "linkedin": "https://linkedin.com/company/benchmark",
        "crunchbase": "https://crunchbase.com/organization/benchmark"
      },
      {
        "id": "def456-...",
        "guru_permalink": "benchmark-capital-partners",
        "name": "Benchmark Capital Partners",
        "description": "Benchmark Capital Partners...",
        "image": null,
        "relevance_score": 95,
        "domain": "benchmark.com",
        "website": "https://www.benchmark.com/",
        "linkedin": null,
        "crunchbase": null
      }
    ]
  }
}
```

Collect **all** `id` values from the response.

---

## Step 2: Get Their Recent Investments

Pass the investor IDs into `POST /companies` using `latest_deal.investor_ids` to find companies where the investor participated in the **most recent round**.

```bash
orth api run fundable /companies --body '{
  "latest_deal": {
    "investor_ids": ["abc123-...", "def456-..."]
  },
  "sort_by": "most_recent_raise",
  "page_size": 25
}'
```

### With Optional Filters

```bash
orth api run fundable /companies --body '{
  "latest_deal": {
    "investor_ids": ["abc123-...", "def456-..."],
    "financing_types": [{"type": "SERIES_A"}, {"type": "SERIES_B"}],
    "date_start": "2025-01-01"
  },
  "company": {
    "industries": ["artificial-intelligence"]
  },
  "sort_by": "most_recent_raise",
  "page_size": 25
}'
```

---

## Parameters

### Step 1: Investor Search
- **`domain`** — Investor domain (e.g. `benchmark.com`)
- **`name`** — Investor name, fuzzy search (e.g. `benchmark`)
- **`linkedin`** — Full LinkedIn URL (e.g. `https://linkedin.com/company/benchmark`)
- **`crunchbase`** — Full Crunchbase URL

Only one parameter at a time.

### Step 2: Companies Lookup
- **`latest_deal.investor_ids`** — Array of investor UUIDs from Step 1 (required)
- **`latest_deal.financing_types`** — Filter by round type (e.g. `[{"type": "SEED"}]`)
- **`latest_deal.date_start`** — Only deals after this date (ISO 8601)
- **`latest_deal.date_end`** — Only deals before this date (ISO 8601)
- **`latest_deal.size_min`** / **`size_max`** — Deal size range in USD
- **`company.industries`** — Filter by industry (e.g. `["artificial-intelligence"]`)
- **`company.locations`** — Filter by location (e.g. `["san-francisco-california"]`)
- **`company.ipo_status`** — `["private"]` or `["public"]`
- **`sort_by`** — `most_recent_raise` (default), `largest_total_raise`, `most_funding_rounds`, etc.
- **`page`** / **`page_size`** — Pagination (0-based, max 100 per page)

---

## Response (Step 2)

```json
{
  "success": true,
  "data": {
    "companies": [
      {
        "id": "uuid",
        "name": "Acme Corp",
        "domain": "acme.com",
        "short_description": "AI-powered solutions...",
        "linkedin": "https://linkedin.com/company/acme",
        "num_employees": "11-50",
        "ipo_status": "private",
        "total_raised": 15000000,
        "num_funding_rounds": 2,
        "num_investors": 5,
        "industries": [{"name": "Artificial Intelligence", "permalink": "artificial-intelligence"}],
        "location": {
          "region": {"name": "North America", "permalink": "north-america"},
          "country": {"name": "United States", "permalink": "united-states"},
          "state": {"name": "California", "permalink": "california"},
          "city": {"name": "San Francisco", "permalink": "san-francisco-california"}
        },
        "latest_deal": {
          "id": "deal-uuid",
          "type": "SERIES_A",
          "size_native": 12000000,
          "date": "2026-02-10T00:00:00Z",
          "pre": false,
          "extension": false,
          "intermediate": "NONE",
          "description": {
            "short_description": "Acme Corp raised a $12M Series A round...",
            "long_description": "Acme Corp secured $12 million in Series A funding..."
          },
          "investors": ["abc123-...", "other-investor-uuid"]
        }
      }
    ]
  },
  "meta": {
    "total_count": 42,
    "page": 0,
    "page_size": 25,
    "credits_used": 25
  }
}
```

---

## Usage Examples

| Use Case | Step 2 Key Parameters |
|----------|----------------------|
| All recent investments | `investor_ids` only, `sort_by: "most_recent_raise"` |
| Investments this year | + `date_start: "2026-01-01"` |
| Only Seed deals | + `financing_types: [{"type": "SEED"}]` |
| AI companies only | + `company.industries: ["artificial-intelligence"]` |
| Large rounds ($10M+) | + `size_min: 10000000` |

---

## Error Handling

- **401** — Invalid or missing API key
- **402** — Insufficient credits
- **404** — Investor not found (Step 1) — try a different domain or name
- **422** — Unknown parameter
- **429** — Rate limit (200 req/min)
- Empty arrays are not allowed — omit the field instead of sending `[]`

## Tips

- An investor can have multiple entities (e.g. `a16z.com` maps to a16z, a16z Speedrun, a16z Bio, etc.) — always collect **all** IDs from Step 1
- `latest_deal.investor_ids` finds companies where the investor was in the **latest round only** — use `investors.investor_ids` instead if you want all-time portfolio companies
- The investor search endpoint (`/investor/search`) costs 0 credits
- Use `name` search if you don't know the firm's exact domain
- Paginate with `page: 0`, `page: 1`, etc. — check `meta.total_count` for total results
