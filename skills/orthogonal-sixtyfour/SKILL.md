---
name: sixtyfour
description: AI-powered lead enrichment - find emails, phones, and enrich company/lead data
---

# Sixtyfour - AI Lead Enrichment

Find contact information and enrich lead data using AI-powered discovery.

## Capabilities

- **Find email**: Find email address for a lead
- **Enrich lead**: Enrich lead information with additional details such as contact information, social profiles, and company details
- **Find Phone API**: The Find Phone API uses Sixtyfour AI to discover phone numbers for leads
- **Enrich company**: Enrich company data with additional information and find associated people

## Usage

### Find email
Find email address for a lead.

Parameters:
- lead* (object) - Lead information to find email for
- mode (string) - Email discovery mode. Allowed values: `"PROFESSIONAL"` (default) for company emails, `"PERSONAL"` for personal emails.

```bash
orth api run sixtyfour /find-email --body '{
  "lead": {
    "first_name": "John",
    "last_name": "Doe",
    "company": "Acme Inc",
    "domain": "acme.com"
  }
}'
```

### Enrich lead
Enrich lead information with additional details such as contact information, social profiles, and company details.

Parameters:
- lead_info* (object) - Initial lead information as key-value pairs
- struct* (object) - Fields to collect about the lead
- research_plan (string) - Optional research plan to guide enrichment

```bash
orth api run sixtyfour /enrich-lead --body '{
  "lead_info": {
    "first_name": "John",
    "last_name": "Doe",
    "company": "Acme Inc",
    "linkedin_url": "https://linkedin.com/in/johndoe"
  },
  "struct": {"email": "Work email", "phone": "Phone number"}
}'
```

### Find Phone API
The Find Phone API uses Sixtyfour AI to discover phone numbers for leads. It extracts contact information from lead data and returns enriched results with phone numbers.

Parameters:
- lead* (object) - Lead information object
- name (string) - Full name of the person
- company (string) - Company name
- linkedin_url (string) - LinkedIn profile URL
- domain (string) - Company website domain
- email (string) - Email address

```bash
orth api run sixtyfour /find-phone --body '{
  "lead": {
    "first_name": "John",
    "last_name": "Doe",
    "company": "Acme Inc"
  }
}'
```

### Enrich company
Enrich company data with additional information and find associated people.

Parameters:
- target_company* (object) - Company data to enrich
- struct* (object) - Fields to collect
- lead_struct (object) - Custom schema to define the structure of returned lead data.
- find_people (boolean) - Whether to find people associated with the company
- research_plan (string) - Optional strategy describing how the agent should search for information
- people_focus_prompt (string) - Description of people to find, typically includes the roles or responsibilities of the people you’re looking for

```bash
orth api run sixtyfour /enrich-company --body '{
  "target_company": {"domain": "acme.com"},
  "struct": {"description": "Company description", "industry": "Industry"}
}'
```

## Use Cases

1. **Sales Prospecting**: Find contact info for potential customers
2. **Lead Enrichment**: Complete partial lead data with emails/phones
3. **CRM Data Quality**: Fill in missing fields in your CRM
4. **Account Research**: Get comprehensive company information

## Discover More

For full endpoint details and parameters:

```bash
orth api show sixtyfour              # List all endpoints
orth api show sixtyfour /find-email   # Get endpoint details
```
