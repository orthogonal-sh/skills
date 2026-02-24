---
name: find-dentists
description: Build a sales prospect list of dental practices in a city — finds practices, decision makers, contact info, and buying signals. Use when asked to find dentists for outreach, prospect dental practices, build a lead list of dentists, or generate dental practice leads in a specific area.
---

# Find Dentists — Sales Prospecting for Dental Practices

Build a prioritized prospect list of dental practices in any city. Goes beyond basic contact info — finds the decision maker (practice owner or office manager), their direct contact info, whether the practice already uses a virtual/AI receptionist, and intent signals like receptionist job postings that indicate they're ready to buy.

## When to Use

- User wants to prospect dental practices in a city for sales outreach
- User asks "find me dentists in [city]" or "get dental practice leads in [area]"
- User is selling a product/service to dental practices and needs a lead list
- User wants to identify high-priority prospects (hiring receptionists, new practices, no existing solution)

## Workflow

### 1. Parse the Request

Extract from the user's query:
- **City/location** (required) — city name, zip code, neighborhood, or area
- **Specialty** (optional) — general dentist, orthodontist, pediatric dentist, cosmetic dentist, oral surgeon, etc.
- **Max results** (optional, default 10) — scale up if user asks for more
- **What they're selling** (optional) — helps tailor the competitive intel and intent signals. If not stated, keep it generic

### 2. Find Dental Practices

Run 2-3 search strategies **in parallel**:

**Strategy A — Scrapegraph searchscraper** (primary — structured data in one call):

```bash
orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "dentists in {city} with practice name, phone number, email address, office address, and website URL",
  "num_results": 10
}'
```

**Strategy B — Tavily web search** (supplemental — Yelp/Healthgrades/Maps results):

```bash
orth run tavily /search --body '{
  "query": "dentists in {city} phone number address",
  "max_results": 10,
  "include_answer": false
}'
```

**Strategy C — Exa search** (directory pages with many practices per page):

```bash
orth run exa /search --body '{
  "query": "dentists in {city} phone number address",
  "numResults": 10,
  "contents": {"text": {"maxCharacters": 5000}}
}'
```

#### Scaling Up — Getting More Than ~15 Results

A single search round yields ~15-20 unique practices after dedup. To get more, **search by neighborhood**:

```bash
# Run in parallel — one search per neighborhood
orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "dentists in Mission District San Francisco with practice name, phone, email, address, website",
  "num_results": 10
}'

orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "dentists in Sunset District San Francisco with practice name, phone, email, address, website",
  "num_results": 10
}'

# ... repeat for each neighborhood
```

Guidelines: 10-20 results = default single round. 20-50 = search 3-5 neighborhoods. 50-100+ = search every neighborhood + dental society directories.

### 3. Extract & Deduplicate

From all results, extract per practice:
- **Practice name**
- **Phone number**
- **Address**
- **Website URL**
- **Email** (if found)
- **Dentist name(s)** (if listed)

Deduplicate by practice name + address, or by phone number.

### 4. Find the Decision Maker

This is the high-value step. For each practice, identify the **practice owner or office manager** — the person who actually buys software and services.

**Step 1 — Scrape the practice website's About/Team page:**

```bash
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://smithfamilydental.com/about",
  "user_prompt": "Extract the names and roles of all staff. Identify the practice owner, office manager, or managing dentist. Also extract any email addresses and phone numbers on this page."
}'
```

Run in parallel for all practices. Try `/about`, `/about-us`, `/our-team`, or `/team` paths. This is the best source for decision maker names — dental practice websites almost always have a team page.

**Step 2 — Fiber people search** (find staff by company name + job title):

```bash
orth run fiber /v1/people-search --body '{
  "searchParams": {
    "company_names": ["{practice name}"],
    "job_titles": ["Owner", "Office Manager", "Practice Manager", "Managing Partner", "DDS"],
    "locations": ["{city}"]
  }
}'
```

Returns LinkedIn profiles with names, titles, emails, and phone numbers. Best for larger group practices. Solo practices may not have LinkedIn-indexed staff.

**Step 3 — Fiber natural language search** (catches people that structured search misses):

```bash
orth run fiber /v1/natural-language-search/profiles --body '{
  "query": "office manager or practice owner at dental practices in {city}",
  "pageSize": 20
}'
```

This can surface office managers across multiple practices in one call — efficient for building a broad list.

### 5. Get Decision Maker Contact Info

For each decision maker identified in Step 4, find their direct email and LinkedIn:

**Hunter email-finder** (email by name + practice domain):
```bash
orth run hunter /v2/email-finder --query 'domain=smithfamilydental.com&first_name=Sarah&last_name=Johnson'
```

**Tomba LinkedIn-to-email** (if LinkedIn URL found via Fiber):
```bash
orth run tomba /v1/linkedin --query 'url=https://linkedin.com/in/sarahjohnson'
```

**Fiber kitchen-sink** (full enrichment with LinkedIn URL):
```bash
orth run fiber /v1/kitchen-sink/person --body '{
  "profileIdentifier": "https://linkedin.com/in/sarahjohnson"
}'
```

Also check the practice website contact page for general email (`info@`, `office@`) as a fallback:
```bash
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://smithfamilydental.com/contact",
  "user_prompt": "Extract all email addresses and phone numbers from this page"
}'
```

### 6. Check for Existing Virtual/AI Receptionist (Competitive Intel)

Scrape each practice's website to detect whether they already use a virtual receptionist, AI phone answering, or automated scheduling service. This helps the sales team avoid wasting time on practices that already have a solution — or position a competitive switch.

```bash
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://smithfamilydental.com",
  "user_prompt": "Does this dental practice use any virtual receptionist, AI receptionist, AI phone answering, automated call handling, or after-hours answering service? Look for mentions of these services, integrations, or third-party tools in the page content, footer, or widgets. Also check if they have online scheduling or a chatbot."
}'
```

Run in parallel for all practices. Flag practices as:
- **No existing solution detected** — top priority prospect
- **Has online scheduling only** — may still need phone handling
- **Has virtual/AI receptionist** — lower priority, competitive switch opportunity
- **Unknown** — couldn't determine from website

### 7. Intent Signals — Identify Ready-to-Buy Prospects

These signals indicate a practice is actively looking for reception/phone help, making them high-priority targets.

**Signal A — Hiring receptionists** (strongest buying signal):

```bash
orth run fiber /v1/job-search --body '{
  "searchParams": {
    "job_titles": ["Receptionist", "Front Desk", "Patient Coordinator", "Scheduling Coordinator"],
    "keywords": ["dental", "dentist"],
    "locations": ["{city}"]
  }
}'
```

A dental practice posting a job for a receptionist is either struggling with staffing or growing — both make them ideal prospects for an AI/virtual receptionist product.

**Signal B — New practices** (recently opened, still building their operations):

```bash
orth run tavily /search --body '{
  "query": "new dental practice opening {city} 2025 2026",
  "max_results": 10,
  "topic": "news",
  "include_answer": false
}'
```

New practices are more open to adopting new technology from day one rather than switching from an established workflow.

**Signal C — Practice size and growth** (from Fiber or website):

Solo practices and small group practices (2-5 dentists) are typically the sweet spot — large enough to need help with call volume, small enough that they don't have a full reception team. Extract practice size from the team page scrape in Step 4.

### 8. Present Results

Output a prioritized prospect list:

```
## Dental Practice Prospects in {City}

Found {N} practices, ranked by sales readiness:

### High Priority (strong buying signals)
| # | Practice | Decision Maker | Title | Phone | Email | Signal |
|---|----------|---------------|-------|-------|-------|--------|
| 1 | Smith Dental | Sarah Johnson | Office Manager | (415) 555-1234 | sarah@smithdental.com | Hiring receptionist |
| 2 | ... | ... | ... | ... | ... | New practice |

### Medium Priority (no existing solution detected)
| # | Practice | Decision Maker | Title | Phone | Email | Notes |
|---|----------|---------------|-------|-------|-------|-------|
| 3 | ... | ... | ... | ... | ... | Solo practice, no AI receptionist |

### Lower Priority (existing solution detected)
| # | Practice | Decision Maker | Title | Phone | Email | Current Solution |
|---|----------|---------------|-------|-------|-------|-----------------|
| 8 | ... | ... | ... | ... | ... | Has virtual receptionist |

### Summary
- Total practices found: {N}
- Decision makers identified: {count}/{N}
- Practices hiring receptionists: {count} (high priority)
- Practices with no existing solution: {count}
- Practices with existing solution: {count}
```

## APIs Used

1. **Scrapegraph** `/v1/searchscraper` — find dental practices via web search
2. **Scrapegraph** `/v1/smartscraper` — scrape practice websites for team info, emails, competitive intel
3. **Tavily** `/search` — supplemental web search, new practice detection
4. **Exa** `/search` — find directory pages with many practices
5. **Fiber** `/v1/people-search` — find decision makers by company + job title
6. **Fiber** `/v1/natural-language-search/profiles` — broad decision maker discovery
7. **Fiber** `/v1/kitchen-sink/person` — full person enrichment
8. **Fiber** `/v1/job-search` — find practices hiring receptionists (intent signal)
9. **Hunter** `/v2/email-finder` — find decision maker email by name + domain
10. **Tomba** `/v1/linkedin` — LinkedIn-to-email lookup

## Examples

**User:** "Find dentists in San Francisco for our sales team"
- Run Steps 2-8: find ~15 practices, identify office managers, check for existing solutions, flag any hiring receptionists

**User:** "Build a prospect list of 50 dental practices in Austin TX"
- Scale up with neighborhood searches (Step 2 scaling), then enrich all 50 with decision makers and signals

**User:** "Find orthodontists in Miami that don't already have a virtual receptionist"
- Filter by specialty in search queries, run competitive intel (Step 6) on all results, only present practices with no existing solution

**User:** "Which dental practices in Denver are hiring receptionists right now?"
- Skip straight to Step 7 Signal A (Fiber job search), then enrich those specific practices with contact info

## Error Handling

- **Fiber people-search returns empty for a practice** — Small/solo practices often aren't indexed. Fall back to the website team page scrape from Step 4
- **Website has no team/about page** — Try scraping the homepage. Many solo practices list the dentist's name on the homepage even without a dedicated team page
- **Job search returns no results** — Not every city will have dental practices actively hiring receptionists. This just means fewer high-priority signals, not that the prospects are bad
- **Hunter returns no email for decision maker** — Try the practice's general email (info@, office@) as fallback. Note it as a general inbox in the results

## Tips

- **Decision maker > practice contact** — The practice phone number gets you the front desk. The office manager's direct email or LinkedIn gets you the buyer. Always invest in Step 4
- **Scrape the About/Team page first** — This is the single best source for decision maker names at dental practices. Almost every practice website has one, and it tells you exactly who runs the office
- **Fiber people-search works best for group practices** — Solo practices (one dentist, no listed staff) rarely appear in Fiber. For these, the website team page is your only source
- **Job postings are the strongest intent signal** — A practice hiring a receptionist is actively spending money to solve the exact problem your user's product addresses
- **Practice size is a useful filter** — Solo practices and small groups (2-5 dentists) are the sweet spot for most dental SaaS products. Very large dental chains usually have enterprise procurement processes
- **Competitive intel from websites is imperfect** — Not all practices advertise their receptionist solution on their website. "No solution detected" means nothing was visible — not that they definitely don't have one. Note this caveat in results
- **Search by neighborhood to scale up** — A single search round caps at ~15-20 practices. Break the city into neighborhoods and search each one in parallel for 50-100+ results
- **Phone numbers have ~100% coverage** — Every dental practice has a public phone number. Email coverage for decision makers is lower (~40-60%). LinkedIn coverage depends on practice size
- **General practice emails are fallback only** — `info@practice.com` goes to the front desk. A decision maker's direct email is far more valuable for sales outreach. Always try to find the personal email first
- **Specialty filtering happens at search time** — Include the specialty in search queries ("orthodontists in Austin" not "dentists in Austin") for more targeted results
