---
name: contactout
description: Find emails, phone numbers, and enrich profiles using ContactOut. LinkedIn enrichment, people search, decision maker discovery, company search, and email verification.
---

# ContactOut

Sales and recruitment intelligence platform. Find anyone's email and phone number, enrich LinkedIn profiles, discover decision makers at companies, and verify email addresses.

## When to Use

- Find someone's email or phone from their LinkedIn profile
- Discover decision makers at a company
- Search for people by title, company, seniority, location
- Enrich a person from name + company or email
- Verify if an email address is valid
- Get company information from a domain
- Batch enrich multiple LinkedIn profiles

## Endpoints

### 1. LinkedIn Profile Enrichment

Get full profile details (email, phone, work history, education, skills) from a LinkedIn URL.

```bash
orth run contactout /v1/linkedin/enrich -q 'profile=https://www.linkedin.com/in/williamhgates'
```

<details>
<summary>curl equivalent</summary>

```bash
curl -X POST "https://api.orth.sh/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"api":"contactout","path":"/v1/linkedin/enrich","query":{"profile":"https://www.linkedin.com/in/williamhgates"}}'
```
</details>

**Parameters:**
- **profile** (required) - LinkedIn profile URL (must start with http and contain linkedin.com/in/)
- **profile_only** (optional, boolean) - If true, returns profile without contact info (cheaper)

**Returns:** Full profile with emails, phones, work history, education, skills, company info, seniority, job function.

**Cost:** 1 email credit if email found + 1 phone credit if phone found. 1 search credit if profile_only=true.

---

### 2. Contact Details from LinkedIn

Get just contact details (emails, phones) for a LinkedIn profile. Lighter than full enrichment.

```bash
orth run contactout /v1/people/linkedin -q 'profile=https://www.linkedin.com/in/williamhgates&include_phone=true'
```

<details>
<summary>curl equivalent</summary>

```bash
curl -X POST "https://api.orth.sh/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"api":"contactout","path":"/v1/people/linkedin","query":{"profile":"https://www.linkedin.com/in/williamhgates","include_phone":"true"}}'
```
</details>

**Parameters:**
- **profile** (required) - LinkedIn profile URL
- **include_phone** (optional, boolean, default: false) - Include phone numbers (costs phone credits)
- **email_type** (optional) - Filter emails: `personal`, `work`, `personal,work`, or `none`

---

### 3. Batch LinkedIn Enrichment (v1 - sync, up to 30)

```bash
orth run contactout /v1/people/linkedin/batch -d '{"profiles":["https://linkedin.com/in/person1","https://linkedin.com/in/person2"]}'
```

**Parameters:**
- **profiles** (required, array, max 30) - Array of LinkedIn profile URLs

---

### 4. Batch LinkedIn Enrichment (v2 - async, up to 1000)

For large batches. Returns a job ID, then poll for results.

```bash
# Start batch job
orth run contactout /v2/people/linkedin/batch -d '{"profiles":["https://linkedin.com/in/person1","https://linkedin.com/in/person2"],"include_phone":true}'

# Poll for results (replace JOB_UUID)
orth run contactout /v2/people/linkedin/batch/JOB_UUID
```

<details>
<summary>curl equivalent</summary>

```bash
# Start job
curl -X POST "https://api.orth.sh/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"api":"contactout","path":"/v2/people/linkedin/batch","body":{"profiles":["https://linkedin.com/in/person1"],"include_phone":true}}'

# Poll results
curl -X POST "https://api.orth.sh/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"api":"contactout","path":"/v2/people/linkedin/batch/JOB_UUID"}'
```
</details>

**Parameters:**
- **profiles** (required, array, max 1000) - LinkedIn profile URLs
- **include_phone** (optional, boolean) - Include phone numbers
- **callback_url** (optional) - URL to POST results when complete

---

### 5. Enrich from Email

Get profile details from an email address. Personal emails have higher match rates.

```bash
orth run contactout /v1/email/enrich -q 'email=john@example.com&include=work_email'
```

**Parameters:**
- **email** (required) - Email address
- **include** (optional) - Set to `work_email` to include work email in response

---

### 6. People Enrich (multi-signal)

Enrich a person using multiple data points. Needs at least one primary identifier (linkedin_url, email, or phone) or name + company.

```bash
orth run contactout /v1/people/enrich -d '{
  "full_name": "Patrick Collison",
  "company": ["Stripe"],
  "company_domain": ["stripe.com"],
  "include": ["work_email", "personal_email", "phone"]
}'
```

**Parameters:**
- **linkedin_url** (optional) - LinkedIn profile URL
- **email** (optional) - Email address
- **phone** (optional) - Phone number
- **full_name** (optional) - Full name (or use first_name + last_name)
- **first_name** / **last_name** (optional) - Used together
- **company** (optional, array, max 10) - Company names
- **company_domain** (optional, array, max 10) - Company domains
- **job_title** (optional) - Job title
- **location** (optional) - Location
- **education** (optional, array, max 10) - Educational institutions
- **include** (optional, array) - Data to include: `work_email`, `personal_email`, `phone`

**Note:** Name-only searches need at least one secondary param (company, domain, education, location, or job_title).

---

### 7. People Search

Search for people matching criteria. Returns 25 profiles per page.

```bash
orth run contactout /v1/people/search -d '{
  "domain": ["stripe.com"],
  "seniority": ["VP", "CXO", "Director"],
  "page": 1,
  "reveal_info": true,
  "data_types": ["personal_email", "work_email", "phone"]
}'
```

<details>
<summary>curl equivalent</summary>

```bash
curl -X POST "https://api.orth.sh/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"api":"contactout","path":"/v1/people/search","body":{"domain":["stripe.com"],"seniority":["VP","CXO"],"page":1,"reveal_info":true}}'
```
</details>

**Parameters:**
- **name** (optional) - Name to search
- **job_title** (optional, array, max 50) - Job titles
- **company** (optional, array, max 50) - Company names
- **domain** (optional, array, max 50) - Company domains
- **location** (optional, array, max 50) - Locations
- **industry** (optional, array, max 50) - Industries (see accepted values below)
- **seniority** (optional, array, max 50) - Seniority levels (see accepted values below)
- **job_function** (optional, array, max 50) - Job functions (see accepted values below)
- **skills** (optional, array, max 50) - Skills
- **keyword** (optional) - Keyword match anywhere in profile
- **company_size** (optional, array) - Size ranges (see accepted values below)
- **education** (optional, array, max 50) - Schools/degrees
- **page** (optional, integer) - Page number (default 1)
- **reveal_info** (optional, boolean) - Include contact info (costs credits)
- **data_types** (optional, array) - Contact types: `personal_email`, `work_email`, `phone`
- **current_titles_only** (optional, boolean, default true) - Match current title only
- **match_experience** (optional) - `current`, `past`, or `both`

**Returns:** `metadata.total_results` (total matches), `metadata.page_size` (25), and `profiles` object keyed by LinkedIn URL.

---

### 8. Decision Makers

Find decision makers at a company by domain. Returns 25 per page.

```bash
orth run contactout /v1/people/decision-makers -q 'domain=stripe.com&reveal_info=true'
```

**Parameters:**
- **domain** (required) - Company domain
- **department** (optional) - Filter by department
- **seniority** (optional) - Filter by seniority level
- **reveal_info** (optional, boolean) - Include contact details
- **page** (optional, integer) - Page number
- **per_page** (optional, integer) - Results per page (max 25)

---

### 9. People Count (free)

Count matching profiles without returning data. Use to estimate results before searching.

```bash
orth run contactout /v1/people/count -d '{"domain":["stripe.com"],"seniority":["VP","CXO","Director"]}'
```

**Parameters:** Same search filters as People Search. Returns only `total_results`.

**Cost:** Free, no credits consumed.

---

### 10. Company Search

Search for companies by name.

```bash
orth run contactout /v1/company/search -d '{"name":["Stripe","Google"]}'
```

**Parameters:**
- **name** (required, array) - Company names to search

---

### 11. Domain Enrichment

Get company information from domain names.

```bash
orth run contactout /v1/domain/enrich -d '{"domains":["stripe.com","google.com"]}'
```

**Parameters:**
- **domains** (required, array, max 30) - Domain names

**Returns:** Company details including name, industry, size, revenue, funding, headquarters, LinkedIn URL, specialties.

---

### 12. Email Verification

Verify if an email address is valid and deliverable.

```bash
orth run contactout /v1/email/verify -q 'email=test@stripe.com'
```

**Parameters:**
- **email** (required) - Email address to verify

---

### 13. Batch Email Verification (async)

```bash
# Start verification
orth run contactout /v1/email/verify/batch -d '{"emails":["test@stripe.com","test@google.com"]}'

# Poll results
orth run contactout /v1/email/verify/batch/JOB_UUID
```

## Accepted Values

### Seniority Levels
`Owner / Founder`, `CXO`, `Partner`, `VP`, `Head`, `Director`, `Manager`, `Senior`, `Entry`, `Intern`

### Job Functions
`Operations`, `Business Development`, `Sales`, `Education`, `Engineering`, `Healthcare Services`, `Information Technology`, `Administrative`, `Arts and Design`, `Customer Success and Support`, `Finance`, `Community and Social Services`, `Media and Communication`, `Accounting`, `Marketing`, `Human Resources`, `Research`, `Program and Project Management`, `Legal`, `Military and Protective Services`, `Consulting`, `Entrepreneurship`, `Real Estate`, `Quality Assurance`, `Purchasing`, `Product Management`, `Leadership`

### Company Size
`1_10`, `11_50`, `51_200`, `201_500`, `501_1000`, `1001_5000`, `5001_10000`, `10001`

### Industries
`Computer Software`, `Internet`, `Financial Services`, `Hospital & Health Care`, `Marketing and Advertising`, `Information Technology and Services`, `Telecommunications`, `Management Consulting`, `Real Estate`, `Retail`, and many more. Full list: https://docs.google.com/spreadsheets/d/14drLUuDLgxPflIsPNgV_w05N6guY4GtCCCd36zT4vg0

## Examples

**"Find the VP of Engineering at Stripe"**
```bash
orth run contactout /v1/people/search -d '{"domain":["stripe.com"],"job_title":["VP of Engineering"],"seniority":["VP"],"reveal_info":true}'
```

**"Who are the decision makers at Google?"**
```bash
orth run contactout /v1/people/decision-makers -q 'domain=google.com&reveal_info=true'
```

**"Get Bill Gates' email"**
```bash
orth run contactout /v1/linkedin/enrich -q 'profile=https://www.linkedin.com/in/williamhgates'
```

**"Verify this email is real"**
```bash
orth run contactout /v1/email/verify -q 'email=john@company.com'
```

**"How many CTOs are there at fintech companies in San Francisco?"**
```bash
orth run contactout /v1/people/count -d '{"job_title":["CTO"],"industry":["Financial Services"],"location":["San Francisco"]}'
```

**"Find me sales directors at SaaS companies with 50-200 employees"**
```bash
orth run contactout /v1/people/search -d '{"job_title":["Sales Director"],"seniority":["Director"],"industry":["Computer Software"],"company_size":["51_200"],"reveal_info":true}'
```

## Error Handling

- **400** - Invalid parameter values. Check accepted values lists above (especially seniority and industry).
- **404** - Person/company not found. Try different identifiers or broader search.
- **429** - Rate limited. People Search: 60/min, Email Verify: 150/min, Others: 1000/min.

## Tips

- Use `/v1/people/count` first (free) to estimate results before running a paid search
- Personal emails have higher match rates than work emails for email enrichment
- `reveal_info: true` on search/decision-makers costs extra credits but returns actual contact info
- For large batch operations, use v2 async batch (up to 1000 profiles) instead of v1 sync (30 max)
- The `match_experience` param is powerful: set to `past` to find people who previously worked at a company
