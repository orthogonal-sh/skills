---
name: textbelt
description: Send SMS messages programmatically - simple HTTP API for text messaging
---

# Textbelt - SMS API

Send SMS messages via simple HTTP API.

## Capabilities

- **Send SMS**: Send text messages ($0.03)
- **Check Status**: Check delivery status (free)

## Usage

### Send SMS ($0.03)
```bash
orth api run textbelt /text --body '{
  "phone": "+1234567890",
  "message": "Hello from Orthogonal!"
}'
```

### Check Delivery Status (free)
```bash
orth api run textbelt /status/{message_id}
```

## Limitations

- Maximum 800 characters per message
- No URLs allowed in message text
- US phone numbers supported

## Use Cases

1. **Notifications**: Send alerts and notifications
2. **Verification**: Send OTP codes
3. **Reminders**: Appointment and event reminders
4. **Updates**: Order and delivery updates
5. **Marketing**: Promotional messages (with consent)
