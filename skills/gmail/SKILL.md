---
name: gmail
description: Send, read, and manage emails via Gmail. Use when asked to send an email, check inbox, read messages, draft emails, or manage Gmail.
---

# Gmail

Send, read, and manage emails through Gmail integration. Connect to your Gmail account to send emails, check your inbox, read messages, create drafts, and more.

## Requirements

- Install the `orth` CLI
- Connect your Gmail account at https://orthogonal.com/dashboard/integrations
- OAuth connection must be active (HTTP 428 response means not connected)

## Actions

### Send Email

Send an email with optional attachments and formatting.

```bash
orth run gmail /send-email --body '{
  "recipient_email": "user@example.com",
  "body": "Hello, this is a test email.",
  "subject": "Test Email"
}'
```

**Parameters:**
- `recipient_email` (required) - Primary recipient's email address
- `body` (required) - Email content/message
- `subject` - Email subject line
- `cc` - CC recipients (comma-separated emails)
- `bcc` - BCC recipients (comma-separated emails)  
- `is_html` - Send as HTML format (true/false)
- `attachment` - File attachment path
- `extra_recipients` - Additional recipients array
- `user_id` - Specific user ID to send as

### List Emails

Retrieve emails from your inbox or specific folders.

```bash
orth run gmail /list-emails --body '{
  "max_results": 10,
  "query": "is:unread"
}'
```

**Parameters:**
- `query` - Gmail search query (e.g., "is:unread", "from:user@example.com")
- `label_ids` - Specific Gmail label IDs to search
- `max_results` - Maximum number of emails to return
- `verbose` - Include detailed email data (true/false)
- `ids_only` - Return only message IDs (true/false)
- `include_payload` - Include full message content (true/false)
- `include_spam_trash` - Include spam and trash folders (true/false)
- `page_token` - Token for pagination
- `user_id` - Specific user ID to query

### Get Email

Retrieve a specific email by its message ID.

```bash
orth run gmail /get-email --body '{
  "message_id": "MESSAGE_ID_HERE"
}'
```

**Parameters:**
- `message_id` (required) - Gmail message ID to retrieve
- `format` - Response format (full, metadata, minimal)
- `user_id` - Specific user ID to query

### Create Draft

Create a draft email for later sending.

```bash
orth run gmail /create-draft --body '{
  "recipient_email": "user@example.com",
  "body": "Draft email content",
  "subject": "Draft Subject"
}'
```

**Parameters:**
- `recipient_email` (required) - Primary recipient's email address
- `body` (required) - Email content/message
- `subject` (required) - Email subject line
- `cc` - CC recipients (comma-separated emails)
- `bcc` - BCC recipients (comma-separated emails)
- `is_html` - Draft as HTML format (true/false)
- `thread_id` - Thread ID to reply within
- `attachment` - File attachment path
- `extra_recipients` - Additional recipients array
- `user_id` - Specific user ID to create draft as

## Usage Examples

**Send a quick email:**
```bash
orth run gmail /send-email -b '{"recipient_email":"colleague@company.com","body":"The report is ready for review.","subject":"Report Ready"}'
```

**Check unread emails:**
```bash
orth run gmail /list-emails -b '{"query":"is:unread","max_results":5}'
```

**Get a specific email:**
```bash
orth run gmail /get-email -b '{"message_id":"17a1b2c3d4e5f6g7"}'
```

**Create HTML draft:**
```bash
orth run gmail /create-draft -b '{"recipient_email":"team@company.com","subject":"Weekly Update","body":"<h1>Weekly Report</h1><p>All tasks completed.</p>","is_html":true}'
```

## Error Handling

- **HTTP 428** - Gmail integration not connected. Visit https://orthogonal.com/dashboard/integrations to connect your account
- **400 Bad Request** - Invalid email format or missing required parameters
- **403 Forbidden** - Insufficient permissions or quota exceeded
- **404 Not Found** - Message ID does not exist
- **429 Rate Limited** - Too many requests, wait before retrying

## Tips

- Use Gmail search syntax in `query` parameter (is:unread, from:email, has:attachment)
- Set `max_results` appropriately to avoid large responses
- Use `ids_only=true` for fast email counting
- HTML emails need `is_html=true` parameter
- Draft emails can be edited later in Gmail interface