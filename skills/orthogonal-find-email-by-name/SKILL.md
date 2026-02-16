---
name: find-email-by-name
description: Find someone's email address given their name and company
---

# Find Email by Name

Find a person's email address when you know their name and company/domain. Essential for sales outreach, recruiting, and professional networking.

## When to Use

- User needs to contact someone at a company
- User asks "what's [person]'s email at [company]?"
- User wants to reach out to a specific person
- Sales prospecting or lead generation
- Recruiting outreach

## How It Works

Uses Hunter or Tomba APIs to find the most likely email address for a person based on their name and company domain.

## Usage

### Find Email with Hunter

```bash
orth run hunter /v2/email-finder --query 'domain=stripe.com&first_name=Patrick&last_name=Collison'
```

### Find Email with Tomba

```bash
orth run tomba /v1/email-finder --query 'domain=intercom.com&company=Intercom&first_name=Eoghan&last_name=McCabe'
```

### Find from LinkedIn Profile

```bash
orth run tomba /v1/linkedin --query 'url=https://linkedin.com/in/johndoe'
```

## Parameters

### Hunter
- **domain** (required) - Company domain (e.g., stripe.com)
- **first_name** (required) - Person's first name
- **last_name** (required) - Person's last name
- **company** (optional) - Company name (alternative to domain)

### Tomba
- **domain** (required) - Company domain
- **company** (required) - Company name (3-75 chars)
- **first_name** / **last_name** or **full_name** - Person's name
- **enrich_mobile** (optional) - Set to `true` to include phone number

## Response

### Hunter Response
Returns `data` object:
- **email** (string) - The found email address
- **score** (integer) - Confidence 0-100 (higher = more likely correct)
- **domain** (string) - Company domain searched
- **accept_all** (boolean) - Whether server accepts any address
- **company** (string) - Company name
- **position** (string|null) - Job title if known
- **twitter** (string|null) - Twitter handle if known
- **linkedin_url** (string|null) - LinkedIn profile URL if known
- **phone_number** (string|null) - Phone if known
- **sources** (array) - Web pages where this email appeared
- **verification** (object) - `date` and `status` (`valid`/`invalid`/`unknown`)

### Tomba Response
Returns `data.email` object with email address and confidence data. Also includes web sources where the email was found.

## Examples

**User:** "Find the email for Sarah Chen at Notion"
```bash
orth run hunter /v2/email-finder --query 'domain=notion.so&first_name=Sarah&last_name=Chen'
```

**User:** "I need to contact John Smith who works at Google"
```bash
orth run tomba /v1/email-finder --query 'domain=google.com&company=Google&first_name=John&last_name=Smith'
```

## Error Handling

- **400** - Missing required parameters (Hunter needs `domain` + `first_name` + `last_name`)
- **422** - Tomba validation error — ensure both `domain` and `company` are provided
- **429** - Rate limit exceeded — wait and retry
- Score of 0 means no match found — try alternate name spellings or a different API
- If Hunter returns `accept_all: true`, the email format may be correct but the specific mailbox can't be confirmed

## Tips

- Use the company's main domain (not subdomains)
- Try both Hunter and Tomba if one doesn't find results
- Check confidence scores - high confidence means the email is likely correct
- Always verify important emails before sending cold outreach
- For LinkedIn profiles, Tomba's LinkedIn finder is very effective
