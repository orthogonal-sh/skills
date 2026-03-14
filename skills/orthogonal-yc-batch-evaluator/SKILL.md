---
name: yc-batch-evaluator
description: Evaluate YC batch companies for investment — scrapes the YC directory, researches each company and its founders (work history, LinkedIn, website), assesses founder-company fit, and exports to Google Sheets with priority rankings. Use when asked to evaluate YC companies, research a YC batch, screen startups, or do due diligence on YC companies.
---

# YC Batch Evaluator

Scrape a YC batch, research every company and founder, assess founder-company fit, and export a live-updating Google Sheet with priority rankings. Designed for investors evaluating YC companies.

## Input

- **batch** (optional) — defaults to "Spring 2026". Examples: "Winter 2026", "Summer 2025"
- **sectors** (optional) — filter to specific sectors (e.g. "AI", "fintech", "infrastructure")
- **thesis** (optional) — investor's focus areas for tailored scoring and ranking

## Step 1: Scrape the YC Batch Directory

```bash
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://www.ycombinator.com/companies?batch={batch_url_encoded}",
  "user_prompt": "Extract every company listed: company name, one-line description, sector/tags, location, and URL slug for each company page (e.g. /companies/orthogonal). Return as a structured list."
}'
```

Batch URL encoding: "Spring 2026" → `Spring%202026`, "Winter 2026" → `Winter%202026`.

If the investor specified sectors, filter the list. Otherwise process all companies.

## Step 2: Create Google Sheet and Share Link Immediately

Before any research, create the sheet and populate it with company names + descriptions. Share the link so the investor can watch results fill in live.

```bash
orth run google-sheets /create-spreadsheet --body '{"title": "YC {batch} Batch Evaluation"}'
```

Write header row + all company rows (research columns blank):

```bash
orth run google-sheets /update-values --body '{
  "spreadsheet_id": "{spreadsheet_id}",
  "sheet_name": "Sheet1",
  "first_cell_location": "A1",
  "valueInputOption": "USER_ENTERED",
  "values": [
    ["Company", "Description", "Sector", "Location", "Website", "Founders", "Founder LinkedIn(s)", "Founder Twitter/X", "Founder Background", "Founder-Company Fit", "Website Analysis", "Market/Competitors", "Overall Assessment", "Priority Rank"],
    ["{company_name}", "{description}", "{sectors}", "{location}", "", "", "", "", "", "", "", "", "", ""]
  ]
}'
```

**Share the sheet link with the user immediately** so they can watch it fill in.

## Step 3: Research Each Company — Row by Row

Process one company at a time. For each company, run all research calls in parallel, then compile the results and **update that company's row immediately** before moving to the next. This lets the user watch the sheet fill in live — much more impressive than batching everything.

### 3a. Scrape the YC company page (~$0.03)

YC company pages have rich data: founders with LinkedIn, Twitter/X, bios, team size, sectors, website.

```bash
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://www.ycombinator.com/companies/{company_slug}",
  "user_prompt": "Extract: full company description, all founders (full name, title, LinkedIn URL, Twitter/X URL, bio), company website URL, team size, location, sectors, founding year."
}'
```

**Important parsing notes:**
- Website field may be `website_url`, `company_website_url`, or `company_website` — check all.
- Sectors may be `sectors`, `sector_tags`, or `tags` — check all. Use the individual page data (richer) over the batch page data.
- **Filter out YC partners** from the founders list. If title contains "Primary Partner" or "Group Partner", exclude them — they're YC staff, not founders.
- Location from the individual page is often more specific than the batch page.

### 3b. Scrape the company's own website (~$0.03)

```bash
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://{company_website}",
  "user_prompt": "Extract: what the product does, target customer, pricing model, key features, traction signals (customer logos, metrics, testimonials), hiring signals, tech stack."
}'
```

Skip on error — some early-stage companies may not have a website yet.

### 3c. Apollo — founder work history (~$0.01 per founder)

Use the LinkedIn URL from the YC page to get full employment history.

```bash
orth run apollo /api/v1/people/match --body '{
  "linkedin_url": "{founder_linkedin_url}",
  "reveal_personal_emails": true
}'
```

Returns: employment history (companies, titles, dates), education, current role. This is the key input for founder-company fit.

**No LinkedIn URL on YC page?** Fallback — search by name + company:

```bash
orth run apollo /api/v1/mixed_people/search --body '{
  "q_person_name": "{founder_name}",
  "q_organization_names": ["{company_name}"],
  "page": 1,
  "per_page": 1
}'
```

This usually returns their LinkedIn and work history even when the YC page doesn't list it.

### 3d. Perplexity — market context (~$0.005)

```bash
orth run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{"role": "user", "content": "{company_name} ({website}) is a YC {batch} startup: {description}. Founders: {founder_names_and_bios}. Answer concisely:\n1. Market size and opportunity?\n2. Top 3 competitors?\n3. What makes the founders uniquely qualified?\n4. Any traction, press, or notable mentions?\n5. Red flags or concerns?"}]
}'
```

## Step 4: Update Each Row Immediately After Research

After all research for a company completes, immediately update that row in the sheet before moving to the next company. This creates the live-filling effect.

### Links — use HYPERLINK formulas

All URLs should be clickable. Use `=HYPERLINK()` formulas:

- **Website**: `=HYPERLINK("https://example.com","example.com")`
- **Founder LinkedIn**: One `=HYPERLINK()` per founder, each on its own line within the cell: `=HYPERLINK("https://linkedin.com/in/slug","Founder Name")`
- **Founder Twitter/X**: Same format as LinkedIn.

If there are multiple founders, put each HYPERLINK on a separate line within the same cell using `\n`.

### Founder-Company Fit (Strong / Moderate / Weak)

Assess whether the founders' backgrounds make them uniquely suited to build THIS specific company.

**Strong** — Direct domain expertise in the problem they're solving.
> "Strong — CEO spent 5 years at Stripe building payment APIs, now building payment infrastructure. Deep domain match."

**Moderate** — Strong technical background but limited domain experience.
> "Moderate — both founders are strong engineers (Google, Amazon) but no direct healthcare experience for a healthcare product."

**Weak** — No relevant background for the space.
> "Weak — first-time founders with no background in manufacturing or supply chain."

### Overall Assessment (High Priority / Interesting / Pass)

Consider: founder-company fit, market size, competitive landscape, team completeness, product clarity.

If the investor provided a thesis, weight the assessment heavily toward their focus areas.

### Priority Rank

Rank all companies 1 to N. #1 is the strongest overall. If the investor has a thesis, rank according to thesis fit. If no thesis provided, rank on general investment quality (founder-company fit × market size × team strength).

```bash
orth run google-sheets /update-values --body '{
  "spreadsheet_id": "{spreadsheet_id}",
  "sheet_name": "Sheet1",
  "first_cell_location": "E{row_number}",
  "valueInputOption": "USER_ENTERED",
  "values": [["=HYPERLINK(\"https://{website}\",\"{domain}\")", "{founders}", "=HYPERLINK(\"...\",\"Name\")", "=HYPERLINK(\"...\",\"Name\")", "{background}", "{fit_rating}", "{website_analysis}", "{market}", "{overall}", "{rank}"]]
}'
```

## Step 5: Final Summary

After all companies are researched and ranked, output a summary table:

```
Top 5 Priority Companies:
1. {Company} — {one-line why}
2. ...

Companies to Skip:
- {Company} — {one-line why}
```

## Tips

- **Row by row, not batch**: Research one company → update its row → move to next. The live-fill effect is the demo.
- **Parallelize within each company**: All 4 research calls (YC page, website, Apollo, Perplexity) for a single company run in parallel.
- **Filter out YC partners**: Tom Blomfield, Harj Taggar, etc. appear as "Primary Partner" on company pages — they're YC staff, not founders.
- **Check multiple field names**: Scrapegraph returns different field names depending on the page. Always check `website_url`, `company_website_url`, `company_website` for websites; `sectors`, `sector_tags`, `tags` for sectors.
- **Apollo fallback for missing LinkedIn**: If a founder has no LinkedIn on the YC page, use Apollo's `mixed_people/search` with name + company name. This usually finds them.
- **HYPERLINK formulas for all URLs**: Makes the sheet immediately usable. `=HYPERLINK("url","display text")`.
- **Be honest**: If founders have no relevant experience, say so. If the market is tiny, say so. Investors value honest assessments over hype.
