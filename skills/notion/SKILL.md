---
name: notion
description: Create pages, search content, and manage Notion workspaces. Use when asked to create Notion pages, search Notion, add content to pages, or fetch Notion data.
---

# Notion

Create pages, search content, fetch data, and add content to your Notion workspace. Connect your Notion account to manage pages, databases, and content programmatically.

## Requirements

- Install the `orth` CLI
- Connect your Notion workspace at https://orthogonal.com/dashboard/integrations
- OAuth connection must be active (HTTP 428 response means not connected)

## Actions

### Create Page

Create a new page in your Notion workspace.

```bash
orth run notion /create-page --body '{
  "title": "Meeting Notes",
  "parent_id": "parent-page-or-database-id"
}'
```

**Parameters:**
- `title` (required) - Page title
- `parent_id` (required) - Parent page or database ID where page will be created
- `icon` - Page icon (emoji or external URL)
- `cover` - Cover image URL for the page

### Search

Search for pages and databases in your Notion workspace.

```bash
orth run notion /search --body '{
  "query": "meeting notes",
  "filter_value": "page"
}'
```

**Parameters:**
- `query` - Search query text
- `filter_value` - Filter results by type (page, database)
- `direction` - Sort direction (ascending, descending)
- `timestamp` - Property to sort by timestamp
- `page_size` - Number of results per page
- `start_cursor` - Cursor for pagination
- `filter_property` - Property to filter by

### Fetch Data

Retrieve pages and databases from your Notion workspace.

```bash
orth run notion /fetch-data --body '{
  "get_pages": true,
  "page_size": 20
}'
```

**Parameters:**
- `query` - Optional search query
- `get_pages` - Retrieve pages (only one of get_pages, get_databases, get_all can be true)
- `get_databases` - Retrieve databases (only one of get_pages, get_databases, get_all can be true)
- `get_all` - Retrieve both pages and databases (only one of get_pages, get_databases, get_all can be true)
- `page_size` - Number of items per page

### Add Content

Add content blocks to an existing Notion page.

```bash
orth run notion /add-content --body '{
  "parent_block_id": "page-block-id",
  "content_blocks": [
    {"type": "paragraph", "text": "This is a paragraph with **markdown** support."},
    {"type": "heading_1", "text": "Main Heading"}
  ]
}'
```

**Parameters:**
- `parent_block_id` (required) - ID of the parent block/page to add content to
- `content_blocks` (required) - Array of content blocks to add (supports markdown)
- `after` - Insert content after specific block ID

## Usage Examples

**Create a new project page:**
```bash
orth run notion /create-page -b '{"title":"Q1 Project Plan","parent_id":"abc123-def456-ghi789","icon":"📋"}'
```

**Search for meeting notes:**
```bash
orth run notion /search -b '{"query":"team meeting","filter_value":"page","page_size":10}'
```

**Get all pages:**
```bash
orth run notion /fetch-data -b '{"get_pages":true,"page_size":50}'
```

**Get all databases:**
```bash
orth run notion /fetch-data -b '{"get_databases":true}'
```

**Add structured content:**
```bash
orth run notion /add-content -b '{"parent_block_id":"page123","content_blocks":[{"type":"heading_2","text":"Action Items"},{"type":"paragraph","text":"- Complete user testing\n- Update documentation\n- Schedule follow-up meeting"}]}'
```

**Add content with markdown:**
```bash
orth run notion /add-content -b '{"parent_block_id":"page456","content_blocks":[{"type":"paragraph","text":"This **important** note has [a link](https://example.com) and `inline code`."}]}'
```

## Content Block Types

When adding content, you can use these block types:
- `paragraph` - Regular text paragraph
- `heading_1` - Main heading (H1)
- `heading_2` - Section heading (H2)
- `heading_3` - Subsection heading (H3)
- `bulleted_list_item` - Bullet point
- `numbered_list_item` - Numbered list item
- `to_do` - Checkbox item
- `code` - Code block
- `quote` - Block quote

## Error Handling

- **HTTP 428** - Notion integration not connected. Visit https://orthogonal.com/dashboard/integrations to connect your workspace
- **400 Bad Request** - Invalid parameters or malformed content blocks
- **401 Unauthorized** - Invalid or expired Notion token
- **403 Forbidden** - Insufficient permissions for page or database
- **404 Not Found** - Page, database, or block does not exist
- **429 Rate Limited** - Notion API rate limit exceeded
- **validation_error** - Invalid block content or structure

## Tips

- Get parent_id from existing pages by using the search or fetch-data actions
- Page IDs can be found in the URL when viewing a page in Notion
- Content blocks support markdown formatting (bold, italic, links, code)
- Use only one of get_pages, get_databases, or get_all in fetch-data
- Icons can be emoji characters or external image URLs
- Search is case-insensitive and searches titles and content
- Pagination uses start_cursor from previous responses
- Block IDs are returned when creating pages or adding content