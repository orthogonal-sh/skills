---
name: investor-call-prep
description: Prepare for investor calls by pulling upcoming meetings from Google Calendar, deeply researching each investor and their firm (website scraping, portfolio analysis, thesis extraction), checking for competitor conflicts, and outputting an honest prep sheet with compatibility assessments. Use when asked to prep for investor meetings, fundraising calls, VC meetings, or demo day.
---

# Investor Call Prep

Pull investor meetings from Google Calendar, deep-research each firm (scrape their website, analyze portfolio, extract thesis), and output an honest prep sheet that says which investors are a real fit and which aren't.

**Read-only calendar access. Never creates, modifies, or deletes events.**

## Input

- **domain** (required) — user's company website (provided in the prompt, e.g. "prep my investor calls for orthogonal.com")
- **competitors** (optional) — auto-detected if not provided

Always export to Google Sheets at the end — it's free and takes seconds.

## Step 1: Pull Investor Meetings

```bash
orth run google-calendar /list-events --body '{
  "calendarId": "primary",
  "timeMin": "{today}T00:00:00Z",
  "timeMax": "{end_date}T23:59:59Z",
  "maxResults": 100,
  "singleEvents": true,
  "orderBy": "startTime"
}'
```

Filter events where title contains: `invest`, `vc`, `pitch`, `raise`, `fund`, `partner`, `capital`, `ventures`, `angel`, `seed`, `series`.

Extract: title, date/time, attendee emails (non-company = investor contacts), description (often has investor names/emails even when attendee list doesn't).

**Present filtered list to user for confirmation before proceeding.**

## Step 2: Research the User's Company

Run in parallel:

```bash
# Company context + ideal investor profile
orth run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{"role": "user", "content": "What does {company_name} ({domain}) do? Product, target market, business model, stage. What kind of investor is an ideal fit — what thesis, stage focus, sector expertise?"}]
}'

# Auto-detect competitors (skip if user provided)
orth run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{"role": "user", "content": "Top 5-10 competitors of {company_name} ({domain})? {description}. Company names and domains only."}]
}'
```

Save this company profile — use it to assess every investor's fit.

## Step 3: Research Each Investor

Run ALL of these in parallel per investor. Every source adds unique data.

### 3a. Apollo — investor profile from email

```bash
orth run apollo /api/v1/people/match --body '{
  "email": "{investor_email}",
  "reveal_personal_emails": true
}'
```

**No attendee email? Don't stop.** Parse firm name from event title, then:

```bash
# Firm enrichment
orth run apollo /api/v1/organizations/enrich --query 'domain={firm_domain}'

# Find key people
orth run apollo /api/v1/mixed_people/search --body '{
  "q_organization_domains": "{firm_domain}",
  "person_titles": ["Partner", "Principal", "Managing Director", "GP", "General Partner", "Investor"],
  "page": 1,
  "per_page": 10
}'
```

### 3b. Scrape the firm's website (most reliable source)

VC websites are the ground truth. Perplexity and Apollo often have gaps for smaller firms.

```bash
# Main page — thesis, overview, portfolio
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://{firm_website}",
  "user_prompt": "Extract ALL information: investment thesis, fund size, check size, stage focus, sector focus, geographic focus, every portfolio company listed, team members with titles and LinkedIn URLs, contact info."
}'

# Portfolio page (try /portfolio, /companies, /investments — skip on 404)
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://{firm_website}/portfolio",
  "user_prompt": "Extract every portfolio company: name, sector, funding stage, description, website URL."
}'

# Team page (try /team, /people, /about — skip on 404)
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://{firm_website}/team",
  "user_prompt": "Extract every team member: full name, title, LinkedIn URL, bio summary, background."
}'
```

### 3c. Perplexity — thesis, portfolio, competitor check

**Critical: use context-rich prompts.** Include location, GP names, aliases. "Tell me about e2vc" gets nothing. "Tell me about e2vc, formerly 500 Emerging Europe, based in Turkey" gets rich results.

```bash
orth run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{"role": "user", "content": "Tell me about {firm_name}, a venture capital firm{location_context}{gp_context}{alias_context}. I am raising for {company_name}, {company_description}. Answer:\n1. Investment thesis and typical check size?\n2. Notable portfolio companies in {company_sectors}?\n3. Have they invested in any of these competitors: {competitor_list}?\n4. What stage?\n5. Recent investments or news?\n6. Key partners and backgrounds?\n7. Would {company_name} be a good fit for them? Why or why not?"}]
}'
```

### 3d. Fiber — structured portfolio data

```bash
orth run fiber /v1/natural-language-search/companies --body '{
  "query": "companies invested in by {firm_name}",
  "pageSize": 10
}'
```

Cross-reference returned companies against competitor list.

## Step 4: Compile Prep Sheet

Cross-reference all sources. When they conflict, prefer: **website > Apollo > Perplexity > Fiber**.

### Output format per meeting:

```
## {Firm Name} — {Date/Time}

**Investor:** {Name}, {Title}
**LinkedIn:** {linkedin_url}
**Firm:** {firm_name} | {firm_linkedin_url} | {firm_website}

**Thesis:** {specific, not generic}
**Stage:** {seed, Series A, etc.} | **Check Size:** {range} | **Fund Size:** {if known}
**Geographic Focus:** {regions}

**Portfolio ({count}):** {most relevant to user's space}
**Competitor Conflicts:** {names} or None found

**Compatibility: {verdict}**
{honest, company-specific assessment}

**Talking Points:**
1. {angle from portfolio overlap}
2. {angle from partner's background}
3. {angle from thesis alignment}
```

### Compatibility — Be Honest and Specific

Every rating must reference the user's specific company, product, and sector. Generic assessments are useless.

**Strong Fit** — Thesis covers user's sector AND stage. Adjacent portfolio companies (not competitors). Partner has relevant domain expertise.
> "Strong fit — Revo invests in B2B SaaS + AI from Turkey/CEE at seed-Series A ($500K-$5M). Their marketplace portfolio companies are adjacent. Melis's M&A background means she gets platform economics."

**Moderate Fit** — Partial overlap. Be specific about what's missing.
> "Moderate fit — right stage but portfolio leans fintech/industrial tech, no developer tools. You'll need to educate them on the API marketplace space."

**Weak Fit** — Wrong thesis, stage, geography, or has funded a competitor. Don't sugarcoat.
> "Weak fit — consumer apps focus, Series B+ checks. No dev tools portfolio. May not be worth your limited pre-demo-day time."

**Competitor Conflict** — Flag prominently.
> "They backed Composio — a direct competitor. Ask early whether this creates a conflict."

## Step 5: Google Sheets Export (optional)

```bash
orth run google-sheets /create-spreadsheet --body '{"title": "Investor Call Prep — {date_range}"}'
```

```bash
orth run google-sheets /update-values --body '{
  "spreadsheet_id": "{spreadsheet_id}",
  "sheet_name": "Sheet1",
  "first_cell_location": "A1",
  "valueInputOption": "USER_ENTERED",
  "values": [
    ["Date/Time", "Firm", "Investor", "Title", "LinkedIn", "Firm LinkedIn", "Website", "Thesis", "Stage", "Check Size", "Portfolio", "Conflicts", "Compatibility", "Why", "Talking Points"],
    ["{...}"]
  ]
}'
```

## Tips

- **Parallelize everything**: Apollo, Scrapegraph, Perplexity, Fiber are independent — run all in parallel per investor, and process investors simultaneously.
- **Website > all other sources**: Firm websites are ground truth. Always scrape.
- **No email? Parse the firm name** from the event title → derive domain → Apollo org enrich + people search + website scrape.
- **Context in Perplexity prompts**: Include location, GP names, "formerly known as" — massively improves results for smaller firms.
- **Be brutal on fit**: User has limited time. Say which meetings to prioritize and which to skip.
- **Firm domain from email**: `investor@somefirm.com` → domain is `somefirm.com`.
- **Multiple attendees**: Run Apollo on each. Most senior person = decision-maker.
