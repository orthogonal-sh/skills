---
name: find-dentists
description: Build a sales prospect list of dental practices in a city — finds practices, decision makers, contact info, and buying signals. Use when asked to find dentists for outreach, prospect dental practices, build a lead list of dentists, or generate dental practice leads in a specific area.
---

# Find Dentists — Sales Prospecting for Dental Practices

Build a prioritized prospect list of dental practices in any city. Goes beyond basic contact info — finds the decision maker (practice owner or office manager), whether the practice already uses a virtual/AI receptionist, and intent signals like receptionist job postings that indicate they're ready to buy.

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

This is the highest-signal source. In testing, it returned **57 practices** for San Francisco in a single call — far more than the requested 10. Returns structured JSON with practice names, phone numbers, addresses, websites, and sometimes emails.

**Strategy B — Tavily web search** (supplemental — Yelp/Healthgrades/Maps results):

```bash
orth run tavily /search --body '{
  "query": "dentists in {city} phone number address",
  "max_results": 10,
  "include_answer": false
}'
```

Returns search result URLs + snippets. Parse dentist names, phone numbers, and addresses from the snippets.

**Strategy C — Exa search** (directory pages with full text):

```bash
orth run exa /search --body '{
  "query": "dentists in {city} phone number address",
  "numResults": 10,
  "contents": {"text": {"maxCharacters": 5000}}
}'
```

Returns listing pages with full text content. Useful for parsing contact info from practice websites. Note: Exa sometimes returns irrelevant results — filter by relevance.

#### Scaling Up — Getting More Results

To get more than the initial batch, **search by neighborhood**:

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

**Primary method — Scrape the practice website's About/Team page:**

```bash
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://smithfamilydental.com/about",
  "user_prompt": "Extract the names and roles of all staff. Identify the practice owner, office manager, or managing dentist. Also extract any email addresses and phone numbers on this page."
}'
```

Run in parallel for all practices with websites. This is the **most reliable method** for dental practices — in testing, it successfully identified decision makers on 5/5 websites (owners, office managers, managing dentists).

**URL path handling:** Try the homepage URL first — most practice websites mention the owner/managing dentist on the homepage. If the homepage doesn't have staff info, try appending `/about`, `/about-us`, `/our-team`, or `/team`. Note: appending paths like `/about` to some websites returns a 422 error. If that happens, fall back to the base homepage URL which almost always works.

**Fallback — Fiber kitchen-sink** (if you found a LinkedIn URL for someone at the practice):

```bash
orth run fiber /v1/kitchen-sink/person --body '{
  "profileIdentifier": "https://linkedin.com/in/drmanali"
}'
```

Returns full profile data with email, phone, and work history.

**Important: Fiber people-search and job-search with searchParams filters are unreliable** — in testing, both returned 400 errors consistently even with documented parameter formats. Do NOT rely on these as primary methods. Use Scrapegraph smartscraper for decision maker discovery and Scrapegraph searchscraper for job posting signals instead.

### 5. Get Decision Maker Contact Info

For each decision maker identified in Step 4, find their direct email:

**Scrape the practice contact page** (most reliable for dental practices):
```bash
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://smithfamilydental.com/contact",
  "user_prompt": "Extract all email addresses and phone numbers from this page"
}'
```

In testing, this found practice emails (info@, office@) on most sites. For decision maker personal emails, try:

**Hunter email-finder** (predict email by name + domain):
```bash
orth run hunter /v2/email-finder --query 'domain=smithfamilydental.com&first_name=Sarah&last_name=Johnson'
```

Note: Hunter often returns null for small dental practice domains. It works better for larger group practices.

**Tomba LinkedIn-to-email** (if LinkedIn URL found):
```bash
orth run tomba /v1/linkedin --query 'url=https://linkedin.com/in/sarahjohnson'
```

**Exa LinkedIn discovery** (find LinkedIn URL for the decision maker):
```bash
orth run exa /search --body '{
  "query": "Dr. Manali Rathod dentist San Francisco",
  "numResults": 3,
  "includeDomains": ["linkedin.com"]
}'
```

Once you have a LinkedIn URL, use Fiber kitchen-sink or Tomba for email extraction.

**Realistic expectations:** Decision maker personal emails are hard to find for dental practices. Most contact info you'll get is practice-level (info@, office@). This is still valuable — the key insight is knowing WHO to ask for when you call or email.

### 6. Check for Existing Virtual/AI Receptionist (Competitive Intel)

Scrape each practice's website to detect whether they already use a virtual receptionist, AI phone answering, or automated scheduling service.

```bash
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://smithfamilydental.com",
  "user_prompt": "Does this dental practice use any virtual receptionist, AI receptionist, AI phone answering, automated call handling, or after-hours answering service? Look for mentions of these services, integrations, or third-party tools in the page content, footer, or widgets. Also check if they have online scheduling or a chatbot."
}'
```

Run in parallel for all practices. In testing, this correctly detected online scheduling and no AI receptionist. Flag practices as:
- **No existing solution detected** — top priority prospect
- **Has online scheduling only** — may still need phone handling
- **Has virtual/AI receptionist** — lower priority, competitive switch opportunity
- **Unknown** — couldn't determine from website

### 7. Intent Signals — Identify Ready-to-Buy Prospects

These signals indicate a practice is actively looking for reception/phone help, making them high-priority targets.

**Signal A — Hiring receptionists** (strongest buying signal):

Use Scrapegraph searchscraper to find dental practices with open receptionist positions:

```bash
orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "dental practices hiring receptionist or front desk in {city}, list the practice name, job title, and salary",
  "num_results": 10
}'
```

In testing, this returned **11 SF practices** actively hiring front desk staff in a single call, with practice names and salary ranges. This is the most efficient way to find this signal.

For more comprehensive job listing coverage, also scrape job board listing pages:

```bash
orth run tavily /search --body '{
  "query": "dental receptionist job opening {city}",
  "max_results": 5,
  "include_answer": false
}'

# Then scrape the top job listing page for specific practice names
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://www.glassdoor.com/Job/{city}-dental-receptionist-jobs-SRCH_...",
  "user_prompt": "Extract all dental practice names that are hiring receptionists, along with the job title, salary if listed, and location"
}'
```

In testing, scraping Glassdoor returned **29 practices** hiring in the SF Bay Area with salary data. Cross-reference these with your practice list from Step 2 — matches are your highest-priority prospects.

**Signal B — New practices** (recently opened, still building their operations):

```bash
orth run tavily /search --body '{
  "query": "new dental practice opening {city} 2025 2026",
  "max_results": 10,
  "topic": "news",
  "include_answer": false
}'
```

**Signal C — Practice size** (from the team page scrape in Step 4):

Solo practices and small group practices (2-5 dentists) are typically the sweet spot — large enough to need help with call volume, small enough that they don't have a full reception team.

### 8. Present Results

Output a prioritized prospect list:

```
## Dental Practice Prospects in {City}

Found {N} practices, ranked by sales readiness:

### High Priority (strong buying signals)
| # | Practice | Decision Maker | Title | Phone | Email | Signal |
|---|----------|---------------|-------|-------|-------|--------|
| 1 | Smith Dental | Sarah Johnson | Office Manager | (415) 555-1234 | info@smithdental.com | Hiring receptionist |
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

1. **Scrapegraph** `/v1/searchscraper` — find dental practices via web search AND find practices hiring receptionists (primary for both)
2. **Scrapegraph** `/v1/smartscraper` — scrape practice websites for decision maker names, emails, competitive intel
3. **Tavily** `/search` — supplemental web search, job board discovery, new practice detection
4. **Exa** `/search` — find directory pages, LinkedIn URL discovery for decision makers
5. **Fiber** `/v1/kitchen-sink/person` — enrich decision maker with LinkedIn URL (when available)
6. **Hunter** `/v2/email-finder` — find decision maker email by name + domain
7. **Tomba** `/v1/linkedin` — LinkedIn-to-email lookup

## Examples

**User:** "Find dentists in San Francisco for our sales team"
```bash
# Step 2: Find practices (run in parallel)
orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "dentists in San Francisco with practice name, phone number, email address, office address, and website URL",
  "num_results": 10
}'

orth run tavily /search --body '{
  "query": "dentists in San Francisco phone number address",
  "max_results": 10,
  "include_answer": false
}'

# Step 4: Find decision makers (run in parallel for each practice)
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://www.thedentalpracticesf.com",
  "user_prompt": "Extract the names and roles of all staff. Identify the practice owner, office manager, or managing dentist. Also extract any email addresses and phone numbers."
}'

# Step 6: Competitive intel (run in parallel)
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://www.thedentalpracticesf.com",
  "user_prompt": "Does this dental practice use any virtual receptionist, AI receptionist, AI phone answering, automated call handling, or after-hours answering service? Look for mentions in the page content, footer, or widgets. Also check for online scheduling or chatbot."
}'

# Step 7: Intent signals — who is hiring?
orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "dental practices hiring receptionist or front desk in San Francisco, list the practice name, job title, and salary",
  "num_results": 10
}'
```

**User:** "Which dental practices in Denver are hiring receptionists?"
```bash
# Go straight to intent signals
orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "dental practices hiring receptionist or front desk in Denver Colorado, list the practice name, job title, and salary",
  "num_results": 10
}'

# Then enrich those specific practices
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://denverdental.com",
  "user_prompt": "Extract the names and roles of all staff. Identify the practice owner or office manager. Extract email addresses and phone numbers."
}'
```

**User:** "Build a prospect list of 50 dental practices in Austin TX"
```bash
# Scale up with neighborhood searches (run all in parallel)
orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "dentists in Downtown Austin Texas with practice name, phone, email, address, website",
  "num_results": 10
}'

orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "dentists in South Austin Texas with practice name, phone, email, address, website",
  "num_results": 10
}'

orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "dentists in North Austin Texas with practice name, phone, email, address, website",
  "num_results": 10
}'

# ... continue for Round Rock, Cedar Park, East Austin, West Austin, etc.
```

## Error Handling

- **Smartscraper 422 on /about path** — Some websites return 422 when you append paths like `/about`. Fall back to scraping the homepage URL (no path) which almost always works
- **Website has no team/about page** — Scrape the homepage. Many solo practices list the dentist's name on the homepage
- **Hunter returns null for decision maker** — Expected for small practice domains. Use the practice's general email (info@, office@) as fallback and note the decision maker's name so the sales rep can ask for them by name
- **Fiber people-search returns 400** — Known issue. Do not rely on Fiber people-search or job-search with filter params. Use Scrapegraph smartscraper for decision makers and Scrapegraph searchscraper for job posting signals instead
- **No hiring signal found** — Not every city will have dental practices actively posting receptionist jobs. This just means fewer high-priority signals, not that the prospects are bad

## Tips

- **Website team pages are the #1 source for decision makers** — In testing, scraping the About/Team page found the owner or office manager on 5/5 practice websites. This is far more reliable than LinkedIn-based people search for small dental practices
- **Scrapegraph searchscraper is the workhorse** — Use it for finding practices AND for finding which practices are hiring receptionists. In testing it returned 57 practices and 11 hiring signals in separate single calls
- **Combine decision maker name + practice phone** — Even if you can't find a personal email, knowing the decision maker's name + calling the practice phone is a strong outreach combo. "Hi, can I speak with Rosie Franco, your office manager?" beats a cold call to the front desk
- **Job postings are the strongest intent signal** — A practice hiring a receptionist is actively spending money to solve the exact problem. Cross-reference hiring practices with your prospect list for instant high-priority leads
- **Competitive intel from websites is imperfect** — "No solution detected" means nothing was visible on the website — not that they definitely don't have one. Note this caveat in results
- **Practice size matters** — Solo practices and small groups (2-5 dentists) are the sweet spot. Very large dental chains (Western Dental, Pacific Dental Services) have enterprise procurement. Filter these out
- **Scrape the homepage, not subpages** — When extracting decision maker info, scraping the homepage works more reliably than trying specific paths (/about, /team) which sometimes 422. The homepage usually mentions the lead dentist(s)
- **Phone numbers have ~100% coverage** — Every practice has a phone. Decision maker personal emails are rare (~20-30%). Practice general emails (info@, office@) are findable ~50-60% of the time
- **Search by neighborhood to scale up** — Break the city into neighborhoods and run parallel searches. For San Francisco, 8-10 neighborhoods can yield 100+ unique practices
- **Filter out clinics and dental schools** — Scrapegraph sometimes returns community health centers, university dental clinics, and public health dentists. Filter these out — they're not buying commercial software
