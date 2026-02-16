---
name: send-text-message
description: Send SMS text messages to phone numbers. Use when the user asks to send a text, send an SMS, text someone, message a phone number, or send a notification via text message.
---

# Send Text Message

Send SMS messages via the Textbelt API on Orthogonal.

## Workflow

### Step 1: Gather Info

Ask the user for:
- **Phone number** (required) - US/Canada: 10-digit with area code. International: E.164 format (e.g., +44...)
- **Message** (required) - Max 800 characters. No URLs allowed.

### Step 2: Send the Message

```bash
orth run textbelt /text --body '{
  "phone": "<phone_number>",
  "message": "<message_text>"
}'
```

### Step 3: Confirm Delivery

The response includes a `textId`. Use it to check delivery status:

```bash
orth run textbelt /status/<textId>
```

This endpoint is free.

## Constraints

- Max 800 characters per message
- No URLs in message text
- Sender name is optional and not visible to the recipient in most countries

## Optional Parameters

When sending, you can also include:
- `sender` (string) - Business/org name for regulatory purposes
- `replyWebhookUrl` (string) - US only: URL to receive reply webhooks
- `webhookData` (string) - Extra data passed to webhook (max 100 chars)
