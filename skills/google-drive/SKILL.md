---
name: google-drive
description: Find, create, and manage files and folders in Google Drive. Use when asked to search Drive, create files, upload documents, organize folders, or access Drive content.
---

# Google Drive

Find, create, and manage files and folders in Google Drive. Connect your Google account to search for files, create documents, organize folders, and manage your Drive storage.

## Requirements

- Install the `orth` CLI
- Connect your Google Drive at https://orthogonal.com/dashboard/integrations
- OAuth connection must be active (HTTP 428 response means not connected)

## Actions

### Find File

Search for files and folders in your Google Drive.

```bash
orth run google-drive /find-file --body '{
  "q": "name contains \"project\" and mimeType = \"application/pdf\"",
  "orderBy": "modifiedTime desc"
}'
```

**Parameters:**
- `q` - Google Drive query using search syntax
- `fields` - Specific fields to return (id, name, mimeType, etc.)
- `spaces` - Search in specific spaces (drive, appDataFolder, photos)
- `corpora` - Search scope (user, domain, drive, allDrives)
- `driveId` - Shared drive ID to search in
- `orderBy` - Sort results (name, folder, createdTime, modifiedTime, quotaBytesUsed, recency, starred)
- `pageSize` - Number of files to return (max 1000)
- `pageToken` - Token for pagination
- `supportsAllDrives` - Include shared drives (true/false)
- `includeItemsFromAllDrives` - Include items from all drives (true/false)

### Create File

Create a new text file in Google Drive.

```bash
orth run google-drive /create-file --body '{
  "file_name": "project-notes.txt",
  "text_content": "This is my project documentation.\n\nSection 1: Overview\nSection 2: Details"
}'
```

**Parameters:**
- `file_name` (required) - Name for the new file
- `text_content` (required) - Text content to write to the file
- `mime_type` - MIME type for the file (defaults to text/plain)
- `parent_id` - Parent folder ID to create file in

### Get File

Download or retrieve information about a specific file.

```bash
orth run google-drive /get-file --body '{
  "fileId": "1abc2def3ghi4jkl5mno6pqr7stu8vwx9yz"
}'
```

**Parameters:**
- `fileId` (required) - Google Drive file ID
- `includeLabels` - Include file labels in response (true/false)
- `acknowledgeAbuse` - Acknowledge risk when downloading flagged files (true/false)
- `supportsAllDrives` - Support shared drives (true/false)
- `includePermissionsForView` - Include permissions info (true/false)

### Create Folder

Create a new folder in Google Drive.

```bash
orth run google-drive /create-folder --body '{
  "folder_name": "Project Documents",
  "parent_id": "parent-folder-id"
}'
```

**Parameters:**
- `folder_name` (required) - Name for the new folder
- `parent_id` - Parent folder ID to create folder in (defaults to root)

## Usage Examples

**Search for PDF files:**
```bash
orth run google-drive /find-file -b '{"q":"mimeType=\"application/pdf\"","orderBy":"modifiedTime desc","pageSize":20}'
```

**Find files by name:**
```bash
orth run google-drive /find-file -b '{"q":"name contains \"meeting notes\"","fields":"files(id,name,modifiedTime)"}'
```

**Search in specific folder:**
```bash
orth run google-drive /find-file -b '{"q":"\"folder123\" in parents and name contains \"report\""}'
```

**Create project document:**
```bash
orth run google-drive /create-file -b '{"file_name":"Project Plan.md","text_content":"# Project Plan\n\n## Overview\nThis document outlines our project plan.\n\n## Timeline\n- Phase 1: Research\n- Phase 2: Development"}'
```

**Create file in specific folder:**
```bash
orth run google-drive /create-file -b '{"file_name":"notes.txt","text_content":"Important notes here","parent_id":"folder456"}'
```

**Download file content:**
```bash
orth run google-drive /get-file -b '{"fileId":"1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms"}'
```

**Create project folder:**
```bash
orth run google-drive /create-folder -b '{"folder_name":"Q1 2024 Projects"}'
```

**Create subfolder:**
```bash
orth run google-drive /create-folder -b '{"folder_name":"Documents","parent_id":"parent_folder_id"}'
```

## Google Drive Query Syntax

Use these operators in the `q` parameter for find-file:

**File properties:**
- `name = "filename"` - Exact name match
- `name contains "text"` - Name contains text
- `mimeType = "application/pdf"` - Specific file type
- `parents in "folder_id"` - Files in specific folder

**File types:**
- `mimeType = "application/pdf"` - PDF files
- `mimeType = "image/jpeg"` - JPEG images
- `mimeType = "application/vnd.google-apps.document"` - Google Docs
- `mimeType = "application/vnd.google-apps.spreadsheet"` - Google Sheets
- `mimeType = "application/vnd.google-apps.folder"` - Folders

**Time filters:**
- `modifiedTime > "2024-01-01T00:00:00"` - Modified after date
- `createdTime < "2024-12-31T23:59:59"` - Created before date

**Other filters:**
- `starred = true` - Starred files only
- `trashed = false` - Exclude trashed files
- `"user@example.com" in owners` - Files owned by specific user

## Error Handling

- **HTTP 428** - Google Drive integration not connected. Visit https://orthogonal.com/dashboard/integrations to connect your account
- **400 Bad Request** - Invalid query syntax or parameters
- **403 Forbidden** - Insufficient permissions to access file/folder
- **404 Not Found** - File or folder does not exist
- **413 Payload Too Large** - File content too large for upload
- **429 Rate Limited** - Google Drive API quota exceeded

## Tips

- File IDs can be found in Google Drive URLs or from find-file results
- Use specific MIME types to filter by file type
- Combine multiple conditions with "and" in queries
- Use quotes around folder IDs and exact names in queries
- Parent folder ID defaults to root if not specified
- Created files are owned by the authenticated user
- Text files support Unicode content and line breaks
- Use pageToken for large result sets with many files