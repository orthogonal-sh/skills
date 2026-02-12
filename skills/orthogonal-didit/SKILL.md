---
name: didit
description: Identity verification via phone/email OTP and AML screening using Didit API
---

# Didit - Identity Verification API

Verify user identities through phone/email OTP codes and screen against AML databases.

## Capabilities

- **Phone Verification**: Send and verify OTP codes via SMS
- **Email Verification**: Send and verify OTP codes via email
- **Database Validation**: Validate identity data against authoritative sources
- **AML Screening**: Screen individuals/companies against global watchlists

## Usage

### Send Phone OTP ($0.30)
```bash
curl -X POST "https://api.orth.sh/v1/run/didit/v3/phone/send/" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"phone_number": "+1234567890"}'
```

### Verify Phone OTP (free)
```bash
curl -X POST "https://api.orth.sh/v1/run/didit/v3/phone/check/" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"phone_number": "+1234567890", "code": "123456"}'
```

### Send Email OTP ($0.04)
```bash
curl -X POST "https://api.orth.sh/v1/run/didit/v3/email/send/" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"email": "user@example.com"}'
```

### Verify Email OTP (free)
```bash
curl -X POST "https://api.orth.sh/v1/run/didit/v3/email/check/" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"email": "user@example.com", "code": "123456"}'
```

### Database Validation ($0.31)
```bash
curl -X POST "https://api.orth.sh/v1/run/didit/v3/database-validation/" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"first_name": "John", "last_name": "Doe", "date_of_birth": "1990-01-15"}'
```

### AML Screening ($0.36)
```bash
curl -X POST "https://api.orth.sh/v1/run/didit/v3/aml/" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"name": "John Doe", "type": "individual"}'
```

## CLI Usage

```bash
# Send phone OTP
orth api run didit /v3/phone/send/ --body '{"phone_number": "+1234567890"}'

# Verify phone OTP
orth api run didit /v3/phone/check/ --body '{"phone_number": "+1234567890", "code": "123456"}'

# AML screening
orth api run didit /v3/aml/ --body '{"name": "John Doe", "type": "individual"}'
```

## Use Cases

1. **User Registration**: Verify phone/email during signup
2. **Two-Factor Authentication**: Add OTP verification to login flows
3. **KYC Compliance**: Validate identity data for financial services
4. **AML Compliance**: Screen customers against sanctions and watchlists
