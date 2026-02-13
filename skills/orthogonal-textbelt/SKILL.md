---
name: textbelt
description: Send SMS messages programmatically - simple HTTP API for text messaging
---

# Textbelt - SMS API

Send SMS messages via simple HTTP API.

## Capabilities

- **Status**: Checking SMS delivery status (free)
- **Send an SMS**: Send an SMS using HTTP POST ($0.025)

## Usage

### Status (free)
Checking SMS delivery status

```bash
orth api run textbelt /status/{message_id}
```

### Send an SMS ($0.025)
Send an SMS using HTTP POST.
Note: No Urls in text message.
Max 800 characters

Parameters:
- phone* (string) - A phone number.  If you're in the U.S. or Canada, you can just send a normal 10-digit phone number with area code.  Outside the U.S., it is best to send the phone number in E.164 format with your country code.
- message* (string) - The content of your SMS.
- sender (string) - Optionally, the name of the business/organization you represent.  This field is for regulatory purposes and is not visible to the end user in most countries. If not set, sender will default to your account-wide sender name.
- replyWebhookUrl (string) - U.S. phone numbers only: Textbelt lets you receive replies to SMS you've sent. Replies are sent by webhook, meaning you will have to set up an HTTP or HTTPS route on your website that will process inbound SMS.This will send an SMS.  If the recipient responds, Textbelt will send an HTTP POST request to the specified endpoint (in this case, https://my.site/api/handleSmsReply).  The webhook payload is application/json encoded.  Your server must interpret it like any other HTTP POST request with a JSON payload.  The JSON payload contains the following:  textId: The ID of the original text that began the conversation.  fromNumber:  The phone number of the user that sent the reply (you can use this, for example, to send them a response depending on their reply).  text: The content of their reply. Here's an example payload:  {   "textId": "123456",   "fromNumber": "+1555123456",   "text": "Here is my reply" }
- webhookData (string) - Endpoint supports a webhookData field.  This data is passed as data in the webhook request. There is a maximum length of 100 characters in the webhookData field.

```bash
orth api run textbelt /text --body '{
  "phone": "+1234567890",
  "message": "Hello from Orthogonal!"
}'
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

## Discover More

For full endpoint details and parameters:

```bash
orth api show textbelt              # List all endpoints
orth api show textbelt <endpoint>   # Get endpoint parameters
```
