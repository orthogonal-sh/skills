---
name: find-dentists
description: Find dentist contact information (phone, email, address) in a given city for sales prospecting and outreach. Use when asked to find dentists, build a prospect list of dental practices, get dentist phone numbers for outreach, or generate leads in a specific area.
---

# Find Dentists

Find dentist and dental practice contact information — phone numbers, email addresses, office addresses, and websites — for any city or area. Built for sales teams selling to dental practices (e.g., AI receptionist software, dental supplies, practice management tools) who need prospect lists with verified contact info for outreach.

## When to Use

- User wants to prospect dental practices in a city for sales outreach
- User needs dentist contact info (phone, email, address) to build a lead list
- User asks "find me dentists in [city]" or "get dentist contacts in [area]"
- User wants to target a specific specialty (orthodontist, pediatric dentist, oral surgeon, etc.)
- Sales teams selling to dentists — AI receptionist, practice management software, dental supplies, marketing services, etc.

## Workflow

### 1. Parse the Request

Extract from the user's query:
- **City/location** (required) — city name, zip code, neighborhood, or area (e.g., "San Francisco", "Austin TX", "90210")
- **Specialty** (optional) — general dentist, orthodontist, pediatric dentist, cosmetic dentist, oral surgeon, endodontist, periodontist, etc.
- **Max results** (optional, default 10) — scale up if user asks for more. If user says "all" or wants comprehensive coverage, see the Scaling Up section below
- **Other filters** (optional) — insurance accepted, language spoken, open weekends, etc.

### 2. Search for Dentists

Run 2-3 search strategies **in parallel** to maximize coverage:

**Strategy A — Scrapegraph searchscraper** (primary — search + extract in one call):

This is the highest-signal source. It searches the web and extracts structured data in a single API call.

```bash
# Core search — dentists with contact info
orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "dentists in {city} with phone number, email address, office address, and website URL",
  "num_results": 10
}'

# If specialty is specified
orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "{specialty} dentists in {city} with phone number, email address, office address, and website",
  "num_results": 10
}'
```

Returns structured data extracted directly from search results — practice names, phone numbers, addresses, websites, and sometimes emails.

**Strategy B — Tavily web search** (supplemental — catches Google Maps/Yelp/Healthgrades results):

```bash
orth run tavily /search --body '{
  "query": "best dentists in {city} phone number address",
  "max_results": 10,
  "include_answer": false
}'

# Second query targeting directories
orth run tavily /search --body '{
  "query": "{city} dentist office contact information email phone",
  "max_results": 10,
  "include_answer": false
}'
```

Returns search result URLs + snippets. Parse dentist names, phone numbers, and addresses from the snippets. Results typically come from Google Maps listings, Yelp, Healthgrades, Zocdoc, and dental practice websites.

**Strategy C — Exa search** (find directory/listing pages with multiple dentists):

```bash
orth run exa /search --body '{
  "query": "dentists in {city} phone number address",
  "numResults": 10,
  "contents": {"text": {"maxCharacters": 5000}}
}'

# Target directory sites
orth run exa /search --body '{
  "query": "top rated dental practices {city} contact information",
  "numResults": 10,
  "contents": {"text": {"maxCharacters": 5000}}
}'
```

Returns listing pages with multiple dentists per page. Use `contents.text` to extract names, phone numbers, addresses, and emails from the page text. Directory pages (Yelp, Healthgrades, local dental society listings) often contain 10-20 practices each.

#### Scaling Up — When the User Wants More Than ~15 Results

A single round of searches across all 3 strategies typically yields ~15-20 unique practices after dedup. To get more, **search by neighborhood/area** to multiply coverage:

```bash
# Break the city into neighborhoods and run separate searches for each
# Example for San Francisco:
orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "dentists in Mission District San Francisco with phone number, email, address, website",
  "num_results": 10
}'

orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "dentists in Sunset District San Francisco with phone number, email, address, website",
  "num_results": 10
}'

orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "dentists in Marina District San Francisco with phone number, email, address, website",
  "num_results": 10
}'

# ... repeat for Richmond, SOMA, Financial District, Noe Valley, etc.
```

**How to determine neighborhoods:** Use your knowledge of the city, or run a quick search:
```bash
orth run tavily /search --body '{
  "query": "{city} neighborhoods list",
  "max_results": 3,
  "include_answer": true
}'
```

**Scaling guidelines:**
- **10-20 results:** Default — single round of all 3 strategies
- **20-50 results:** Search by 3-5 major neighborhoods/areas with Scrapegraph searchscraper
- **50-100+ results:** Search every neighborhood + use Exa to find comprehensive directory pages (dental society listings, state dental board registries). Also search for "dentist directory {city}" and "dental society {city} member list"
- **"All dentists":** Search every neighborhood (5-10+ searches), target bulk directories like state dental board license lookups and local dental society member lists. Note: true 100% coverage is not possible via web search alone — there will always be some practices missed. Set expectations with the user

Run neighborhood searches **in parallel** to keep latency low.

### 3. Extract & Deduplicate

From all search results across strategies A, B, and C, extract for each dentist/practice:
- **Practice name**
- **Dentist name(s)** — individual dentist names if available
- **Phone number**
- **Address** — full street address with city, state, zip
- **Website URL**
- **Email** — if found in snippets or page text
- **Specialty** — if mentioned (general, orthodontics, pediatric, etc.)

**Deduplication rules:**
- Match by practice name + address (same practice may appear on multiple listing sites)
- Match by phone number (same practice listed under slightly different names)
- Keep the most complete record when merging duplicates (prefer the one with more fields filled)
- Normalize phone numbers to a consistent format for comparison

### 4. Enrich — Especially Email Addresses

Email is the hardest contact field to find for dental practices. Most practices prefer phone calls and web forms over email, so emails are rarely on directory listings. You need to actively scrape for them.

**Step 1 — Scrape the contact/about page of EVERY practice website** (not just ones missing data):

Most dental websites have an email address somewhere — usually on the Contact page, footer, or About page — even if directories don't list it. Scrape all practice websites that have a URL, targeting the contact page specifically:

```bash
# Try /contact, /contact-us, or /about pages first — emails are almost always there
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://smithfamilydental.com/contact",
  "user_prompt": "Extract all email addresses, phone numbers, office address, hours of operation, dentist names, and specialties"
}'

# If contact page doesn't exist or returns nothing, scrape the homepage
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://smithfamilydental.com",
  "user_prompt": "Extract all email addresses, phone numbers, office address, hours of operation, dentist names, and specialties"
}'
```

Run these in parallel for ALL practices with websites. This is the single best way to find emails — dental practice websites almost always have an email somewhere on the site, even though directory listings don't show it.

**Step 2 — Hunter domain search** (find emails by domain for practices where scraping didn't find one):

```bash
orth run hunter /v2/domain-search --query 'domain=smithfamilydental.com'
```

Returns email addresses associated with the practice domain. Works better for larger practices with multiple staff. Small single-dentist practices often return empty.

**Step 3 — Hunter email-finder** (guess email by dentist name + practice domain):

If you know the dentist's name and the practice domain, Hunter can predict the email:

```bash
orth run hunter /v2/email-finder --query 'domain=smithfamilydental.com&first_name=John&last_name=Smith'
```

**Step 4 — Common email pattern guessing**: Many dental practices use predictable patterns. If all else fails, note likely email patterns in the results:
- `info@{domain}`, `office@{domain}`, `frontdesk@{domain}`
- `dr{lastname}@{domain}`, `{firstname}@{domain}`

Only include guessed emails if marked as unverified.

### 5. Verify Phone Numbers (Optional)

Only run this step if the user specifically requests verified/validated data:

```bash
orth run tomba /v1/phone-validator --query 'phone=+14155551234'
```

Skip this step by default — phone numbers from Google Maps, Yelp, and dental practice websites are generally accurate. Only validate if data quality is critical.

### 6. Present Results

Output a markdown table with the final dentist list:

```
## Dentists in {City}

Found {N} dental practices with contact information:

| # | Practice Name | Dentist(s) | Phone | Email | Address | Website | Specialty |
|---|---------------|------------|-------|-------|---------|---------|-----------|
| 1 | Smith Family Dental | Dr. John Smith | (415) 555-1234 | info@smithdental.com | 123 Main St, San Francisco, CA 94102 | [Website](https://smithdental.com) | General |
| 2 | ... | ... | ... | ... | ... | ... | ... |

### Data Completeness
- Phone numbers found: {count}/{total}
- Email addresses found: {count}/{total}
- Full addresses found: {count}/{total}

### Notes
- {Any caveats — e.g., "Some practices only list a main office number", "Emails were not publicly listed for 3 practices"}
- {If specialty was filtered: "Showing only {specialty} practices"}
```

## Parameters

### Scrapegraph searchscraper
- **user_prompt** (required) — Natural language query describing what to search and extract
- **num_results** (optional) — Number of search results to process

### Scrapegraph smartscraper
- **website_url** (required) — URL of the website to scrape
- **user_prompt** (required) — What to extract from the page

### Tavily
- **query** (required) — Search query string
- **max_results** (optional) — Number of results (default 5)
- **include_answer** (optional) — Whether to include AI-generated answer

### Exa
- **query** (required) — Search query
- **numResults** (optional) — Number of results
- **contents** (optional) — Request page text with `{"text": {"maxCharacters": 5000}}`

### Hunter
- **domain** (required) — Domain to search for email addresses

### Tomba
- **phone** (required) — Phone number to validate (E.164 format)

## Examples

**User:** "Find dentists in San Francisco"
```bash
# Run in parallel
orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "dentists in San Francisco with phone number, email address, office address, and website URL",
  "num_results": 10
}'

orth run tavily /search --body '{
  "query": "best dentists in San Francisco phone number address",
  "max_results": 10,
  "include_answer": false
}'

orth run exa /search --body '{
  "query": "dentists in San Francisco phone number address",
  "numResults": 10,
  "contents": {"text": {"maxCharacters": 5000}}
}'
```

**User:** "Find orthodontists in Austin TX, I need at least 20"
```bash
orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "orthodontists in Austin Texas with phone number, email, address, and website",
  "num_results": 15
}'

orth run tavily /search --body '{
  "query": "orthodontist Austin TX contact information phone email",
  "max_results": 15,
  "include_answer": false
}'

orth run exa /search --body '{
  "query": "orthodontists in Austin Texas contact phone address",
  "numResults": 15,
  "contents": {"text": {"maxCharacters": 5000}}
}'
```

**User:** "Find pediatric dentists in Brooklyn that accept Medicaid"
```bash
orth run scrapegraph /v1/searchscraper --body '{
  "user_prompt": "pediatric dentists in Brooklyn New York that accept Medicaid with phone number, email, address",
  "num_results": 10
}'

orth run tavily /search --body '{
  "query": "pediatric dentist Brooklyn Medicaid accepted phone number address",
  "max_results": 10,
  "include_answer": false
}'
```

**Enrichment example** — scraping a clinic website for missing info:
```bash
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://brooklynpediatricdentistry.com",
  "user_prompt": "Extract phone number, email address, office address, hours of operation, dentist names, specialties, and insurance plans accepted"
}'

orth run hunter /v2/domain-search --query 'domain=brooklynpediatricdentistry.com'
```

## Error Handling

- **No results for a city** — Try broader search terms (e.g., county name instead of small town), or try neighboring cities
- **Scrapegraph returns empty** — Fall back to Tavily + Exa results. Some queries may not match searchscraper's index well
- **Website scraping fails** — Some dental sites block scrapers or use heavy JavaScript. Skip enrichment for those practices and note in the results
- **Hunter returns no emails** — Many small dental practices don't have discoverable emails. Note "no public email found" in the table
- **Rate limits (429)** — Wait and retry. Stagger enrichment calls if hitting limits

## Tips

- **Scrapegraph searchscraper is the primary source** — it combines search + structured extraction in one call, giving the cleanest data. Tavily and Exa provide supplemental coverage
- **Request text content from Exa** — Always use `contents: { text: { maxCharacters: 5000 } }` so you can parse names, phones, and addresses from directory pages
- **Default to 10 results** — Keeps costs low (~$0.50-1.00 per run). Scale up if the user asks for more. For "all dentists" requests, search by neighborhood to multiply coverage
- **Always scrape practice websites for emails** — Directory listings almost never include email addresses, but the practice's own website usually has one on the Contact or About page. Scrape every practice website, not just ones with missing data. Target `/contact` or `/contact-us` pages specifically — that's where emails live
- **Email is the hardest field** — Expect ~30-40% email coverage from search results alone. Scraping individual websites can push this to 60-80%. The remaining practices genuinely don't publish email and prefer phone/form contact
- **Phone numbers are the most reliable** — Nearly every dental practice lists a phone number publicly. Addresses are almost always available. Email requires the most effort to find
- **Directory pages are gold mines** — A single Yelp or Healthgrades listing page often contains 10-20 practices with phone and address. Exa is best for finding these
- **Normalize phone formats** — Dental practices list phones in various formats: (415) 555-1234, 415-555-1234, 415.555.1234. Normalize for dedup and presentation
- **Specialty matters for search quality** — "orthodontist in Austin" returns much more targeted results than "dentist in Austin" when the user wants a specific specialty
- **Insurance filters are search-query-level** — There's no API filter for insurance. Include it in the search query (e.g., "dentists in Brooklyn that accept Medicaid") and let search engines match relevant results
- **Small towns may have few results** — If a city returns fewer than the requested count, note this in the results and suggest expanding to nearby areas
- **Search by neighborhood to scale up** — A single search round caps out at ~15-20 unique practices. To get 50+, break the city into neighborhoods and run separate searches for each. Run these in parallel. For a city like San Francisco, 8-10 neighborhood searches can yield 80-100+ unique practices
- **Verify addresses make sense** — Occasionally search results return outdated addresses. Cross-reference with the practice website when available
