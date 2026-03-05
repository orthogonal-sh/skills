---
name: screenshot-website
description: Take screenshots of any website using Notte browser automation. Use when asked to screenshot, capture, or snap a webpage.
---

# Website Screenshot

Take screenshots of any website URL and save them as image files.

## Requirements

- Orthogonal CLI: `npm install -g @orth/cli`

## Workflow

Take a screenshot of a URL in 4 steps:

### Step 1: Start a browser session

```bash
orth api run notte /sessions/start --body '{"headless": true}'
```

Save the `session_id` from the response.

### Step 2: Navigate to the URL

```bash
orth api run notte /sessions/{session_id}/page/execute --body '{"type": "goto", "url": "https://example.com"}'
```

### Step 3: Take the screenshot

```bash
orth api run notte /sessions/{session_id}/page/screenshot --body '{}' -o screenshot.jpg
```

For a full-page screenshot:

```bash
orth api run notte /sessions/{session_id}/page/screenshot --body '{"full_page": true}' -o screenshot.jpg
```

### Step 4: Stop the session

```bash
orth api run notte /sessions/{session_id}/stop
```

## Full Example

```bash
# 1. Start session
SESSION=$(orth api run notte /sessions/start --body '{"headless": true}' --raw | python3 -c "import sys,json; print(json.load(sys.stdin)['session_id'])")

# 2. Navigate
orth api run notte /sessions/$SESSION/page/execute --body '{"type": "goto", "url": "https://example.com"}'

# 3. Screenshot
orth api run notte /sessions/$SESSION/page/screenshot --body '{}' -o screenshot.jpg

# 4. Cleanup
orth api run notte /sessions/$SESSION/stop
```

## Options

| Parameter | Description |
|-----------|-------------|
| `full_page` | Set to `true` to capture the entire scrollable page |
| `headless` | Set to `false` to see the browser window (default: true) |
| `viewport_width` | Custom viewport width in pixels |
| `viewport_height` | Custom viewport height in pixels |

## Tips

- Always stop the session when done to free resources
- Sessions auto-expire after 3 minutes of idle time
- Use `-o` flag to save the screenshot to a file (required for binary data)
- The output file must not already exist (use a unique name or delete first)
