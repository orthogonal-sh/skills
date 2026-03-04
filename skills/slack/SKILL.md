---
name: slack
description: Send messages and manage Slack channels. Use when asked to send Slack messages, post to channels, list channels, or fetch message history.
---

# Slack

Send messages, list channels, and fetch message history in Slack workspaces. Connect your Slack workspace to post messages, check channels, and retrieve conversation data.

## Requirements

- Install the `orth` CLI
- Connect your Slack workspace at https://orthogonal.com/dashboard/integrations
- OAuth connection must be active (HTTP 428 response means not connected)

## Actions

### Send Message

Post a message to a Slack channel or direct message.

```bash
orth run slack /send-message --body '{
  "channel": "#general",
  "markdown_text": "Hello **team**! Check out this [link](https://example.com)."
}'
```

**Parameters:**
- `channel` (required) - Channel name (#general) or user ID for DM
- `markdown_text` (preferred) - Message content with markdown formatting
- `text` (deprecated) - Raw text message content
- `blocks` (deprecated) - Slack Block Kit formatted message
- `mrkdwn` - Enable markdown formatting (true/false)
- `as_user` - Send as authenticated user (true/false)
- `username` - Custom username for message
- `icon_url` - Custom icon URL for message
- `icon_emoji` - Custom emoji icon (e.g., ":ghost:")
- `thread_ts` - Reply to specific message thread timestamp
- `link_names` - Find and link channel/user names (true/false)
- `attachments` - Legacy message attachments
- `unfurl_links` - Automatically expand links (true/false)
- `unfurl_media` - Automatically expand media (true/false)
- `reply_broadcast` - Broadcast thread reply to channel (true/false)
- `parse` - Parse mode for text content

### List Channels

Get a list of channels in your Slack workspace.

```bash
orth run slack /list-channels --body '{
  "limit": 20,
  "types": "public_channel,private_channel"
}'
```

**Parameters:**
- `limit` - Maximum number of channels to return
- `types` - Channel types to include (public_channel, private_channel, mpim, im)
- `cursor` - Pagination cursor
- `channel_name` - Filter by specific channel name
- `exclude_archived` - Exclude archived channels (true/false)

### Fetch History

Retrieve message history from a Slack channel.

```bash
orth run slack /fetch-history --body '{
  "channel": "#general",
  "limit": 50
}'
```

**Parameters:**
- `channel` (required) - Channel name or ID to fetch from
- `limit` - Maximum number of messages to return
- `cursor` - Pagination cursor
- `latest` - Latest message timestamp to include
- `oldest` - Oldest message timestamp to include
- `inclusive` - Include messages at latest/oldest timestamps (true/false)

## Usage Examples

**Send formatted message:**
```bash
orth run slack /send-message -b '{"channel":"#team-updates","markdown_text":"**Daily Standup Reminder**\n\nPlease share your updates in this thread!"}'
```

**Send direct message:**
```bash
orth run slack /send-message -b '{"channel":"@username","text":"Hi! Can we schedule a quick call?"}'
```

**Reply to thread:**
```bash
orth run slack /send-message -b '{"channel":"#general","text":"Thanks for the update!","thread_ts":"1234567890.123456"}'
```

**List public channels:**
```bash
orth run slack /list-channels -b '{"types":"public_channel","limit":50}'
```

**Get recent messages:**
```bash
orth run slack /fetch-history -b '{"channel":"#general","limit":10}'
```

**Fetch messages from specific time range:**
```bash
orth run slack /fetch-history -b '{"channel":"#announcements","oldest":"1640995200.000000","latest":"1641081600.000000"}'
```

## Error Handling

- **HTTP 428** - Slack integration not connected. Visit https://orthogonal.com/dashboard/integrations to connect your workspace
- **400 Bad Request** - Invalid channel name or missing required parameters
- **403 Forbidden** - Insufficient permissions for channel or action
- **404 Not Found** - Channel does not exist or is not accessible
- **429 Rate Limited** - Too many requests, wait before retrying
- **channel_not_found** - Specified channel does not exist
- **not_in_channel** - Bot is not a member of the specified channel

## Tips

- Use `markdown_text` instead of `text` for formatted messages
- Channel names can be #channel-name or channel ID (C1234567890)
- For DMs, use @username or user ID (U1234567890)
- Thread timestamps are required for replying to specific messages
- Use cursor-based pagination for large channel lists
- Message timestamps are in Unix format with microsecond precision
- Bot must be invited to private channels before posting
- Some channels may require specific permissions to post or read history