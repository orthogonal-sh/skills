---
name: company-funding-search
description: Find company funding history, investors, and investment details
---

# Company Funding Search

Get funding history, investors, and investment details for companies. Two APIs available:
- **Nyne**: Look up specific company's funding history
- **Fiber**: Search companies by funding stage/criteria

## When to Use

- User asks "how much funding has [company] raised?" → Nyne
- User wants to know who invested in a company → Nyne
- User wants to find companies by funding stage → Fiber
- User asks "find Series B AI companies" → Fiber
- Targeting companies by funding criteria → Fiber

---

## Option 1: Nyne (Specific Company Lookup)

Best for: Looking up a known company's funding history and investors.

### Get Company Funding History

**Step 1: Start the lookup (POST)**
```bash
orth run -X POST nyne /company/funding -d '{"company_name":"Anthropic"}'
```

Returns a `request_id`. Then poll:

**Step 2: Poll for results (GET)**
```bash
orth run nyne /company/funding -q request_id=YOUR_REQUEST_ID
```

<details>
<summary>curl equivalent</summary>

```bash
# Step 1: Start lookup
curl -X POST https://api.orth.sh/v1/run/nyne/company/funding \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"company_name":"Anthropic"}'

# Step 2: Poll for results
curl "https://api.orth.sh/v1/run/nyne/company/funding?request_id=YOUR_REQUEST_ID" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```
</details>

### Get Company Investors/Funders

```bash
orth run -X POST nyne /company/funders -d '{"company_domain":"stripe.com"}'
```

<details>
<summary>curl equivalent</summary>

```bash
curl -X POST https://api.orth.sh/v1/run/nyne/company/funders \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"company_domain":"stripe.com"}'
```
</details>

### Nyne Parameters
- **company_name** - Company name (e.g., "Anthropic") - works better
- **company_domain** - Company domain (e.g., "anthropic.com")

---

## Option 2: Fiber (Search Companies by Funding)

Best for: Finding companies by funding stage, industry, location, etc.

### Natural Language Company Search

```bash
orth run -X POST fiber /v1/natural-language-search/companies -d '{"query":"AI companies that raised Series B in 2024","limit":10}'
```

<details>
<summary>curl equivalent</summary>

```bash
curl -X POST https://api.orth.sh/v1/run/fiber/v1/natural-language-search/companies \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"query":"AI companies that raised Series B in 2024","limit":10}'
```
</details>

### Investor Search

Search for investors/VCs (filter-based, not natural language):

```bash
orth run -X POST fiber /v1/investor-search -d '{"searchParams":{},"limit":10}'
```

<details>
<summary>curl equivalent</summary>

```bash
curl -X POST https://api.orth.sh/v1/run/fiber/v1/investor-search \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"searchParams":{},"limit":10}'
```
</details>

Returns top investors with:
- Total investments, lead rate
- Investment breakdown by stage
- Recent investments
- LinkedIn, logo, social links

### Fiber Response Includes
- Company name, domain, LinkedIn
- Funding rounds with dates and amounts
- Investors per round (lead vs participating)
- Employee count, location, industry
- Total funding, latest funding stage
- Similar companies

---

## When to Use Which

| Use Case | API | Endpoint |
|----------|-----|----------|
| "How much has Anthropic raised?" | Nyne | /company/funding |
| "Who invested in Stripe?" | Nyne | /company/funders |
| "Find Series A AI startups" | Fiber | /v1/natural-language-search/companies |
| "Find top VCs" | Fiber | /v1/investor-search |
| "Companies that raised $10M+ in 2024" | Fiber | /v1/natural-language-search/companies |

## Tips

- **Nyne is async**: Start with POST, poll with GET using request_id (5-20 seconds)
- **Fiber is sync**: Returns results immediately
- **company_name > company_domain** for Nyne lookups
- Fiber's natural language search is very flexible - just describe what you want
- Fiber returns rich company data including similar companies
