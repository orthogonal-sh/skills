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
orth run tomba /email-finder --query 'domain=intercom.com&first_name=Eoghan&last_name=McCabe'
```

### Find from LinkedIn Profile

```bash
orth run tomba /linkedin --query 'url=https://linkedin.com/in/johndoe'
```

## Parameters

- **domain** (required) - Company domain (e.g., stripe.com)
- **first_name** (required) - Person's first name
- **last_name** (required) - Person's last name
- **company** (optional) - Company name (alternative to domain)

## Response

Returns:
- **email** - The found/predicted email address
- **confidence** - Confidence score (high/medium/low or percentage)
- **sources** - Where the email was found
- **verification** - Whether the email has been verified as deliverable
- **format** - The email pattern used by the company

## Examples

**User:** "Find the email for Sarah Chen at Notion"
```bash
orth run hunter /v2/email-finder --query 'domain=notion.so&first_name=Sarah&last_name=Chen'
```

**User:** "I need to contact John Smith who works at Google"
```bash
orth run tomba /email-finder --query 'domain=google.com&first_name=John&last_name=Smith'
```

## Tips

- Use the company's main domain (not subdomains)
- Try both Hunter and Tomba if one doesn't find results
- Check confidence scores - high confidence means the email is likely correct
- Always verify important emails before sending cold outreach
- For LinkedIn profiles, Tomba's LinkedIn finder is very effective
