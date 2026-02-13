---
name: tomba
description: Email finder and verifier - find emails from domains, LinkedIn, or company search
---

# Tomba - Email Finding & Verification

Find and verify email addresses from domains, LinkedIn profiles, or natural language search.

## Capabilities

- **Validate Phone**: Validate a phone number and get carrier information ($0.01)
- **Domain Status**: Check the status and availability of a domain ($0.01)
- **Email Format**: Get the email format patterns used by a domain (e ($0.01)
- **Find Person**: Get person information from an email address ($0.01)
- **Combined Enrichment**: Get combined person and company information from an email ($0.01)
- **Domain Suggestions**: Get domain suggestions for a company name ($0.01)
- **Email Count**: Get the count of email addresses for a domain, broken down by department and seniority ($0.01)
- **Author Finder**: Find the email address of a blog post author from the article URL ($0.01)
- **LinkedIn Finder**: Find the email address from a LinkedIn profile URL ($0.01)
- **Technology Stack**: Discover technologies used by a website ($0.01)
- **Verify Email**: Verify the deliverability of an email address ($0.01)
- **Find Company**: Get company information from a domain ($0.01)
- **Location**: Get employee location distribution for a domain ($0.01)
- **Domain Search**: Search emails based on a website domain ($0.01)
- **Email Enrichment**: Enrich an email address with person and company data (name, location, social handles) ($0.01)
- **Find Phone**: Find phone numbers associated with an email, domain, or LinkedIn profile ($0.01)
- **Similar Domains**: Find domains similar to a given domain ($0.01)
- **Email Finder**: Find the most likely email address from a domain name, first name, and last name ($0.01)
- **Email Sources**: Find the sources where an email was found on the web ($0.01)
- **Search Companies**: Search for companies using natural language queries or structured filters ($0.01)

## Usage

### Validate Phone ($0.01)
Validate a phone number and get carrier information.

Parameters:
- phone* (string) - Phone number to validate
- country_code (string) - Country code (e.g., US)

```bash
orth api run tomba /v1/phone-validator --query 'phone=+14155552671'
```

### Domain Status ($0.01)
Check the status and availability of a domain.

Parameters:
- domain* (string) - Domain to check

```bash
orth api run tomba /v1/domain-status --query 'domain=stripe.com'
```

### Email Format ($0.01)
Get the email format patterns used by a domain (e.g. first.last, firstlast).

Parameters:
- domain* (string) - Domain name, e.g. stripe.com

```bash
orth api run tomba /v1/email-format --query 'domain=stripe.com'
```

### Find Person ($0.01)
Get person information from an email address.

Parameters:
- email* (string) - Email address to look up

```bash
orth api run tomba /v1/people/find --query 'email=john@stripe.com'
```

### Combined Enrichment ($0.01)
Get combined person and company information from an email.

Parameters:
- email* (string) - Email address to enrich

```bash
orth api run tomba /v1/combined/find --query 'email=john@stripe.com'
```

### Domain Suggestions ($0.01)
Get domain suggestions for a company name

Parameters:
- query* (string) - The domain or company name to find suggestions for

```bash
orth api run tomba /v1/domain-suggestions --query 'query=Google'
```

### Email Count ($0.01)
Get the count of email addresses for a domain, broken down by department and seniority.

Parameters:
- domain* (string) - Domain name, e.g. stripe.com

```bash
orth api run tomba /v1/email-count --query 'domain=openai.com'
```

### Author Finder ($0.01)
Find the email address of a blog post author from the article URL.

Parameters:
- url* (string) - URL of the blog post/article

```bash
orth api run tomba /v1/author-finder --query 'url=https://example.com/blog/post'
```

### LinkedIn Finder ($0.01)
Find the email address from a LinkedIn profile URL.

Parameters:
- url* (string) - LinkedIn profile URL
- enrich_mobile (string) - Set to true to get phone number

```bash
orth api run tomba /v1/linkedin --query 'url=https://linkedin.com/in/johndoe'
```

### Technology Stack ($0.01)
Discover technologies used by a website.

Parameters:
- domain* (string) - Domain to analyze

```bash
orth api run tomba /v1/technology --query 'domain=stripe.com'
```

### Verify Email ($0.01)
Verify the deliverability of an email address.

Parameters:
- email* (string) - The email address to verify

```bash
orth api run tomba /v1/email-verifier --query 'email=john@example.com'
```

### Find Company ($0.01)
Get company information from a domain.

Parameters:
- domain* (string) - Domain name (e.g., stripe.com)

```bash
orth api run tomba /v1/companies/find --query 'domain=anthropic.com'
```

### Location ($0.01)
Get employee location distribution for a domain.

Parameters:
- domain* (string) - Domain name, e.g. stripe.com

```bash
orth api run tomba /v1/location --query 'ip=8.8.8.8'
```

### Domain Search ($0.01)
Search emails based on a website domain. Returns all email addresses found on the internet for a given domain, with organization info and employee details.

Parameters:
- domain* (string) - Domain name to search, e.g. stripe.com
- company* (string) - Company name (3-75 chars)
- page (string) - Page number (default 1)
- limit (string) - Results per page: 10, 20, or 50 (default 10)
- country (string) - Two-letter country code filter
- department (string) - Department filter: engineering, sales, finance, hr, it, marketing, operations, management, executive, legal, support, communication, software, security, pr, warehouse, diversity, administrative, facilities, accounting

```bash
orth api run tomba /v1/domain-search --query 'domain=stripe.com'
```

### Email Enrichment ($0.01)
Enrich an email address with person and company data (name, location, social handles).

Parameters:
- email* (string) - Email address to enrich
- enrich_mobile (string) - Set to true to get phone number

```bash
orth api run tomba /v1/enrich --query 'email=john@stripe.com'
```

### Find Phone ($0.01)
Find phone numbers associated with an email, domain, or LinkedIn profile.

Parameters:
- email (string) - Email address to find phone for
- domain (string) - Domain to find phone numbers for
- linkedin (string) - LinkedIn profile URL
- full (boolean) - Set to true to get all phone numbers

```bash
orth api run tomba /v1/phone-finder --query domain=stripe.com first_name=John last_name=Doe
```

### Similar Domains ($0.01)
Find domains similar to a given domain.

Parameters:
- domain* (string) - Domain to find similar domains for

```bash
orth api run tomba /v1/similar --query 'domain=stripe.com'
```

### Email Finder ($0.01)
Find the most likely email address from a domain name, first name, and last name.

Parameters:
- domain* (string) - Domain name, e.g. stripe.com
- company* (string) - Company name (3-75 chars)
- full_name (string) - Full name of the person
- first_name (string) - First name of the person
- last_name (string) - Last name of the person
- enrich_mobile (string) - Set to true to get phone number

```bash
orth api run tomba /v1/email-finder --query domain=stripe.com first_name=John last_name=Doe
```

### Email Sources ($0.01)
Find the sources where an email was found on the web.

Parameters:
- email* (string) - Email address to find sources for

```bash
orth api run tomba /v1/email-sources --query 'email=john@stripe.com'
```

### Search Companies ($0.01)
Search for companies using natural language queries or structured filters. AI assistant generates appropriate filters from your query.

Parameters:
- query (string) - Natural language query (8-100 chars). AI generates filters from this. Use only on first request, then use filters for pagination.
- filters (object) - Structured filters: company, location_country, location_city, location_state, industry, size, type, keywords, founded, technologies, similar, revenue, sic, naics. Each has include/exclude arrays.
- page (integer) - Page number for pagination (1-1000, default: 1)

```bash
orth api run tomba /v1/reveal/search --body '{"query": "AI startups in San Francisco with 50+ employees"}'
```

## Use Cases

1. **Sales Prospecting**: Find contact emails at target companies
2. **Lead Generation**: Build email lists from LinkedIn
3. **Email Validation**: Clean email lists before campaigns
4. **Company Research**: Find companies matching criteria
5. **Outreach**: Verify emails before sending

## Discover More

For full endpoint details and parameters:

```bash
orth api show tomba              # List all endpoints
orth api show tomba /v1/phone-validator   # Get endpoint details
```
