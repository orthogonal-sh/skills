---
name: verify-email
description: Verify if an email address is valid and deliverable
---

# Email Verification

Check if an email address is valid, exists, and can receive mail. Prevent bounces before sending.

## When to Use

- User wants to verify an email before sending
- User asks "is this email address real?"
- Cleaning an email list
- Before cold outreach to avoid bounces
- Validating user-provided email addresses

## How It Works

Uses Hunter or Tomba APIs to verify email deliverability through multiple checks including syntax, domain, and mailbox verification.

## Usage

### Verify with Hunter

```bash
orth run hunter /v2/email-verifier --query 'email=john@example.com'
```

### Verify with Tomba

```bash
orth run tomba /email-verifier --query 'email=jane@company.com'
```

## Parameters

- **email** (required) - The email address to verify

## Response

Returns verification details:
- **result** - valid, invalid, risky, unknown
- **score** - Confidence score (0-100)
- **status** - Detailed status explanation
- **checks performed**:
  - Syntax validation
  - Domain exists and has MX records
  - Mailbox exists (SMTP check)
  - Catch-all detection
  - Disposable email detection
  - Role-based email detection (info@, support@, etc.)

## Result Types

| Result | Meaning | Action |
|--------|---------|--------|
| **valid** | Email exists and accepts mail | Safe to send |
| **invalid** | Email doesn't exist or bounces | Don't send |
| **risky** | May exist but has issues | Send with caution |
| **unknown** | Couldn't verify definitively | Verify manually |

## Examples

**User:** "Check if hello@acme.com is a real email"
```bash
orth run hunter /v2/email-verifier --query 'email=hello@acme.com'
```

**User:** "Verify sarah.jones@startup.io before I send my pitch"
```bash
orth run tomba /email-verifier --query 'email=sarah.jones@startup.io'
```

## Tips

- Always verify emails before bulk sending to protect sender reputation
- "Valid" doesn't guarantee delivery - content still matters
- Role-based emails (info@, sales@) may be valid but less effective for outreach
- Disposable emails (tempmail, etc.) are detected and flagged
- Some corporate domains block verification - "unknown" doesn't mean invalid
