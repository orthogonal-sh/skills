---
name: yc-batch-evaluator
description: Evaluate YC batch companies for investment — scrapes the YC directory, researches each company and its founders (work history, LinkedIn, website), assesses founder-company fit, and exports to Google Sheets. Use when asked to evaluate YC companies, research a YC batch, screen startups, or do due diligence on YC companies.
---

# YC Batch Evaluator

Scrape a YC batch, research every company and founder, assess founder-company fit, and export a live-updating Google Sheet. Designed for investors evaluating YC companies.

## Input

- **batch** (optional) — defaults to "Spring 2026". Examples: "Winter 2026", "Summer 2025"
- **sectors** (optional) — filter to specific sectors (e.g. "AI", "fintech", "infrastructure")
- **thesis** (optional) — investor's focus areas for tailored scoring

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
    ["Company", "Description", "Sector", "Location", "Website", "Founders", "Founder LinkedIn(s)", "Founder Twitter/X", "Founder Background", "Founder-Company Fit", "Website Analysis", "Market/Competitors", "Overall Assessment"],
    ["{company_name}", "{description}", "{sectors}", "{location}", "", "", "", "", "", "", "", "", ""]
  ]
}'
```

**Share the sheet link with the user immediately.**

## Step 3: Research Each Company

Run ALL of these in parallel per company. Process multiple companies simultaneously.

### 3a. Scrape the YC company page (~$0.03)

YC company pages are rich: founders with LinkedIn, Twitter/X, bios, team size, sectors.

```bash
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://www.ycombinator.com/companies/{company_slug}",
  "user_prompt": "Extract: full company description, all founders (full name, title, LinkedIn URL, Twitter/X URL, bio), company website URL, team size, location, sectors, founding year."
}'
```

### 3b. Scrape the company's own website (~$0.03)

```bash
orth run scrapegraph /v1/smartscraper --body '{
  "website_url": "https://{company_website}",
  "user_prompt": "Extract: what the product does, target customer, pricing model, key features, traction signals (customer logos, metrics, testimonials), hiring signals, tech stack."
}'
```

Skip on error (some early-stage companies may not have a website yet).

### 3c. Apollo — founder work history (~$0.01 per founder)

Use the LinkedIn slug from the YC page to get full employment history.

```bash
orth run apollo /api/v1/people/match --body '{
  "linkedin_url": "https://linkedin.com/in/{founder_linkedin_slug}",
  "reveal_personal_emails": true
}'
```

Returns: employment history (companies, titles, dates), education, current role. This is the key input for founder-company fit.

**No LinkedIn slug?** Try matching by name + company:

```bash
orth run apollo /api/v1/mixed_people/search --body '{
  "q_person_name": "{founder_name}",
  "q_organization_names": ["{company_name}"],
  "page": 1,
  "per_page": 1
}'
```

### 3d. Perplexity — market context (~$0.005)

```bash
orth run perplexity /chat/completions --body '{
  "model": "sonar",
  "messages": [{"role": "user", "content": "{company_name} ({website}) is a YC {batch} startup: {description}. Founders: {founder_names_and_bios}. Answer concisely:\n1. Market size and opportunity?\n2. Top 3 competitors?\n3. What makes the founders uniquely qualified?\n4. Any traction, press, or notable mentions?\n5. Red flags or concerns?"}]
}'
```

## Step 4: Evaluate and Update Sheet Row-by-Row

As each company's research completes, immediately update its row. Don't wait for all companies.

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

If the investor provided a thesis, weight the assessment toward their focus areas.

```bash
orth run google-sheets /update-values --body '{
  "spreadsheet_id": "{spreadsheet_id}",
  "sheet_name": "Sheet1",
  "first_cell_location": "E{row_number}",
  "valueInputOption": "USER_ENTERED",
  "values": [["{website}", "{founders}", "{linkedin_urls}", "{twitter_urls}", "{background}", "{fit_rating}", "{website_analysis}", "{market}", "{overall}"]]
}'
```

## Tips

- **Parallelize aggressively**: All 4 research calls per company are independent. Process multiple companies at once.
- **Update the sheet as you go**: Each row update takes <1 second. Don't batch — the investor wants to see it fill in live.
- **Skip gracefully**: If a company website 404s or Apollo returns nothing, still fill what you have. Partial data > empty row.
- **Founder LinkedIn is the most valuable signal**: Employment history directly feeds the founder-company fit assessment.
- **Be honest**: If founders have no relevant experience, say so. If the market is tiny, say so. Investors value honesty over hype.
