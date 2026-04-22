---
name: recent-funding-rounds
description: Find companies that raised funding recently (last week, last month, etc.) — search recent deals by date range, round type, size, industry, and location. Use when asked about recent funding rounds, new raises, latest deals, or weekly/monthly deal flow.
---

# Recent Funding Rounds

Find companies that recently raised funding using the Fundable API. Filter by date range, round type, deal size, industry, location, and more.

## When to Use

- User asks "what companies raised funding this week?"
- User wants to see recent seed rounds or Series A deals
- User asks "what fintech companies recently raised"
---

## Get Recent Funding Rounds

```bash
orth api run fundable /companies --body '{
  "latest_deal": {
    "date_start": "2026-03-13",
    "date_end": "2026-03-20"
  },
  "sort_by": "most_recent_raise",
  "page_size": 25
}'
```

> **Date calculation:** Set `date_start` to 7 days before today for "last week", 30 days for "last month". Use ISO 8601 format (YYYY-MM-DD).

### With Filters

```bash
orth api run fundable /companies --body '{
  "latest_deal": {
    "date_start": "2026-03-13",
    "date_end": "2026-03-20",
    "financing_types": [{"type": "SEED"}],
    "size_min": 1000000
  },
  "company": {
    "industries": ["artificial-intelligence"],
    "ipo_status": ["private"]
  },
  "sort_by": "most_recent_raise",
  "page_size": 25
}'
```

---

## Parameters

### Date Range (required for this use case)
- **`latest_deal.date_start`** — Start date (ISO 8601, e.g. `"2026-03-13"`)
- **`latest_deal.date_end`** — End date (ISO 8601, e.g. `"2026-03-20"`)

### Deal Filters (optional)
- **`latest_deal.financing_types`** — Array of objects: `{"type": "SEED"}`, `{"type": "SERIES_A"}`, etc. Supports: `SEED`, `SERIES_A` through `SERIES_M`, `SAFE`, `CONVERTIBLE_NOTE`, `EQUITY`, `PREFERRED`, `DEBT_FINANCING`, `GRANT`, `FUNDING_ROUND`, and more. Optional modifiers: `"pre": true` (e.g. Pre-Seed), `"extension": true`
- **`latest_deal.size_min`** — Minimum deal size in USD
- **`latest_deal.size_max`** — Maximum deal size in USD

### Company Filters (optional)
- **`company.industries`** — Industry permalinks (e.g. `["artificial-intelligence", "fintech-e067"]`)
- **`company.locations`** — Location permalinks (e.g. `["san-francisco-california", "new-york"]`)
- **`company.ipo_status`** — `["private"]` or `["public"]`
- **`company.employee_count`** — e.g. `["1-10", "11-50", "51-100"]`
- **`company.search_query`** — AI-powered semantic search (e.g. `"AI healthcare diagnostics"`)

### Pagination & Sorting
- **`page`** — Page number, 0-based (default: 0)
- **`page_size`** — Results per page, 1-100 (default: 10)
- **`sort_by`** — `most_recent_raise` (default), `largest_total_raise`, `most_funding_rounds`, `most_investors`, and others

---

## Response

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
          "type": "SEED",
          "size_native": 5000000,
          "date": "2026-03-18T00:00:00Z",
          "pre": false,
          "extension": false,
          "intermediate": "NONE",
          "description": {
            "short_description": "Acme Corp raised a $5M seed round...",
            "long_description": "Acme Corp secured $5 million in seed funding..."
          },
          "investors": ["investor-uuid-1", "investor-uuid-2"]
        }
      }
    ]
  },
  "meta": {
    "total_count": 147,
    "page": 0,
    "page_size": 25,
    "credits_used": 25
  }
}
```

---

## Usage Examples

| Use Case | Key Parameters |
|----------|---------------|
| All rounds this week | `date_start` = 7 days ago, `date_end` = today |
| Seed rounds this month | + `financing_types: [{"type": "SEED"}]` |
| Series A+ in fintech | + `financing_types: [{"type": "SERIES_A"}, {"type": "SERIES_B"}]`, `industries: ["fintech-e067"]` |
| Large rounds ($10M+) | + `size_min: 10000000` |
| AI startups in SF | + `search_query: "artificial intelligence"`, `locations: ["san-francisco-california"]` |

---

## Error Handling

- **401** — Invalid or missing API key. Check `$FUNDABLE_API_KEY`
- **402** — Insufficient credits. Visit https://tryfundable.ai/api-access
- **422** — Unknown parameter. Check field names match exactly
- **429** — Rate limit (200 req/min). Wait and retry
- Empty arrays are not allowed — omit the field instead of sending `[]`

## Tips

- Calculate dates dynamically: `date -v-7d +%Y-%m-%d` (macOS) or `date -d '7 days ago' +%Y-%m-%d` (Linux)
- Use `page_size: 100` to get more results per request (max 100)
- Paginate with `page: 0`, `page: 1`, etc. — check `meta.total_count` for total results
- `sort_by` is ignored when using `search_query` (results sort by relevance instead)
- Each API call costs credits based on `page_size` — use smaller pages if browsing
