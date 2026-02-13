---
name: notte
description: Browser automation - control browser sessions, scrape pages, and run AI agents
---

# Notte - Browser Automation API

Control browser sessions, scrape web pages, and run autonomous AI agents.

## Capabilities

- **Take Screenshot**: Take a screenshot of the current page ($0.001)
- **Get Session**: Get session status and details (free)
- **Stop Session**: Stop and clean up a browser session (free)
- **Get Session Cookies**: Get all cookies from the browser session (free)
- **Get Network Logs**: Get network request/response logs from the session (free)
- **Get Agent Status**: Get agent execution status and results (free)
- **Observe Page**: Observe the current page state and get available actions ($0.005)
- **Stop Agent**: Stop a running agent (free)
- **Scrape Webpage**: Scrape content from a URL without managing sessions ($0.01)
- **Execute Page Action**: Execute an action on the page (click, type, navigate, etc ($0.002)
- **Set Session Cookies**: Set cookies in the browser session ($0.001)
- **Start Session**: Start a new browser session ($0.015)
- **Scrape from HTML**: Extract structured content from raw HTML without using a browser ($0.002)
- **Start Agent**: Start an AI agent to autonomously complete a browser task ($0.07)
- **Scrape Page**: Scrape content from the current page in the session ($0.003)

## Usage

### Take Screenshot ($0.001)
Take a screenshot of the current page.

Parameters:
- full_page (boolean) - Capture full page
- session_id* (string)

```bash
orth api run notte /sessions/{session_id}/page/screenshot --body '{}'
```

### Get Session (free)
Get session status and details.

Parameters:
- session_id* (string)

```bash
orth api run notte /sessions/{session_id}
```

### Stop Session (free)
Stop and clean up a browser session.

Parameters:
- session_id* (string) - Session ID

```bash
orth api run notte /sessions/{session_id}/stop
```

### Get Session Cookies (free)
Get all cookies from the browser session.

Parameters:
- session_id* (string)

```bash
orth api run notte /sessions/{session_id}/cookies
```

### Get Network Logs (free)
Get network request/response logs from the session.

Parameters:
- session_id* (string)

```bash
orth api run notte /sessions/{session_id}/network/logs --query session_id=example
```

### Get Agent Status (free)
Get agent execution status and results.

Parameters:
- agent_id* (string)

```bash
orth api run notte /agents/{agent_id}
```

### Observe Page ($0.005)
Observe the current page state and get available actions.

Parameters:
- max_nb_actions (number) - Maximum actions to return (default: 100)
- min_nb_actions (number) - Minimum actions to return
- instruction (string) - Optional instruction to filter actions
- session_id* (string)

```bash
orth api run notte /sessions/{session_id}/page/observe --body '{"instruction": "Find the search box"}'
```

### Stop Agent (free)
Stop a running agent.

Parameters:
- session_id* (string) - Session ID the agent is running on

```bash
orth api run notte /agents/{agent_id}/stop
```

### Scrape Webpage ($0.01)
Scrape content from a URL without managing sessions.

Parameters:
- url* (string) - URL to scrape
- schema (object) - Structured extraction schema

```bash
orth api run notte /scrape --body '{"url": "https://example.com"}'
```

### Execute Page Action ($0.002)
Execute an action on the page (click, type, navigate, etc.).

Parameters:
- type* (string) - Action type: goto, click, type, scroll, select, hover, wait, screenshot
- url (string) - URL for goto action
- ref (string) - Element reference for click/type/select actions
- text (string) - Text for type action
- value (string) - Value for select action
- direction (string) - Scroll direction: up/down
- amount (number) - Scroll amount in pixels
- timeout (number) - Wait timeout in ms
- session_id* (string)

```bash
orth api run notte /sessions/{session_id}/page/execute --body '{"instruction": "Click the search button"}'
```

### Set Session Cookies ($0.001)
Set cookies in the browser session.

Parameters:
- cookies* (array) - Array of cookie objects
- session_id* (string)

```bash
orth api run notte /sessions/{session_id}/cookies
```

### Start Session ($0.015)
Start a new browser session. Configure browser type, proxies, viewport, and session timeout.

Parameters:
- headless (boolean) - Run in headless mode (default: true)
- browser_type (string) - Browser type: chromium, chrome, firefox
- proxies (boolean) - Enable proxy rotation
- solve_captchas (boolean) - Auto-solve CAPTCHAs
- idle_timeout_minutes (integer) - Idle timeout (default: 3)
- max_duration_minutes (integer) - Max duration (default: 15)
- viewport_width (integer)
- viewport_height (integer)
- user_agent (string)

```bash
orth api run notte /sessions/start --body '{
  "url": "https://example.com",
  "timeout_minutes": 5
}'
```

### Scrape from HTML ($0.002)
Extract structured content from raw HTML without using a browser

Parameters:
- frames* (array) - Array of HTML frames to parse

```bash
orth api run notte /scrape_from_html --body '{"html": "<html><body>Hello</body></html>"}'
```

### Start Agent ($0.07)
Start an AI agent to autonomously complete a browser task.

Parameters:
- task* (string) - Task for the AI agent to perform
- session_id* (string) - Session ID to run the agent on
- url (string) - Starting URL
- max_steps (number) - Max steps (1-50, default: 20)
- use_vision (boolean) - Use vision model (default: true)

```bash
orth api run notte /agents/start --body '{
  "task": "Search for AI news on Google and summarize the top results",
  "url": "https://google.com"
}'
```

### Scrape Page ($0.003)
Scrape content from the current page in the session.

Parameters:
- selector (string) - Playwright selector to scope the scrape
- scrape_links (boolean) - Scrape links (default: true)
- scrape_images (boolean) - Scrape images (default: false)
- only_main_content (boolean) - Only main content, exclude nav/footer (default: true)
- response_format (object) - Pydantic model or JSON Schema for structured extraction
- instructions (string) - Additional extraction instructions
- session_id* (string)

```bash
orth api run notte /sessions/{session_id}/page/scrape --body '{}'
```

## Use Cases

1. **Web Scraping**: Extract structured data from any webpage
2. **Browser Automation**: Automate complex browser workflows
3. **Testing**: Run automated browser tests
4. **AI Agents**: Deploy autonomous agents for web tasks
5. **Monitoring**: Track website changes and content
