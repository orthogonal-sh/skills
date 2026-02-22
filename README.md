# Orthogonal Skills

Agent skills for [Cursor](https://cursor.sh), [Claude Code](https://claude.ai), [Windsurf](https://codeium.com/windsurf), [GitHub Copilot](https://github.com/features/copilot), [Codex](https://openai.com/codex), [Gemini CLI](https://github.com/google-gemini/gemini-cli), [OpenClaw](https://openclaw.ai), and any agent that reads `SKILL.md` files.

## Install

```bash
# Install the CLI
npm install -g @orth/cli

# Search for skills
orth skills search "web scraping"

# Install a skill (installs to .agent/skills/ + all global agent dirs)
orth skills add orthogonal/scrape

# Install for a specific agent only
orth skills add orthogonal/scrape --agent cursor
```

Or copy any `SKILL.md` directly into your agent's skills directory.

## How Skills Work

A skill is a `SKILL.md` file that tells an AI agent how to do something. When you install a skill, it gets placed in directories your agent already reads:

| Agent | Directory |
|-------|-----------|
| **Project** | `.agent/skills/` |
| Cursor | `~/.cursor/skills/` |
| Claude Code | `~/.claude/skills/` |
| GitHub Copilot | `~/.github/skills/` |
| Windsurf | `~/.codeium/windsurf/skills/` |
| Codex | `~/.agents/skills/` |
| Gemini CLI | `~/.gemini/skills/` |
| OpenClaw | `~/.openclaw/skills/` |

## Available Skills

### 🔍 Search & Research

| Skill | Description |
|-------|-------------|
| [search](skills/orthogonal-search) | Search the web, YouTube, Amazon, eBay, news, and more |
| [andi](skills/orthogonal-andi) | Fast web search with intelligent ranking and instant answers |
| [exa](skills/orthogonal-exa) | Neural web search, find similar content, deep research |
| [jina-s](skills/orthogonal-jina-s) | Fast web search returning SERP results |
| [linkup](skills/orthogonal-linkup) | Web search and content extraction from URLs |
| [parallel](skills/orthogonal-parallel) | Web research API with async tasks |
| [perplexity](skills/orthogonal-perplexity) | AI search and chat with real-time web data |
| [tavily](skills/orthogonal-tavily) | AI-powered web search, crawling, and deep research |
| [valyu](skills/orthogonal-valyu) | Web search, AI answers, and async deep research |
| [searchapi](skills/orthogonal-searchapi) | Multi-platform search: YouTube, Amazon, eBay, TikTok, and more |
| [prediction-market-odds](skills/orthogonal-prediction-market-odds) | Polymarket and Kalshi odds and prices |
| [dome](skills/orthogonal-dome) | Prediction markets data, positions, and trades |

### 🌐 Web Scraping & Automation

| Skill | Description |
|-------|-------------|
| [scrape](skills/orthogonal-scrape) | Scrape websites, extract structured data, automate browsers |
| [notte](skills/orthogonal-notte) | AI-powered browser automation, no selectors needed |
| [olostep](skills/orthogonal-olostep) | Web scraping, crawling, and AI answer extraction at scale |
| [scrapegraph](skills/orthogonal-scrapegraph) | Extract data using natural language prompts |
| [riveter](skills/orthogonal-riveter) | Structured data extraction with custom schemas |
| [extract-webpage-data](skills/orthogonal-extract-webpage-data) | Extract structured data from web pages using AI |
| [website-screenshot](skills/orthogonal-website-screenshot) | Take screenshots of websites |

### 👤 People & Contact Data

| Skill | Description |
|-------|-------------|
| [enrich](skills/orthogonal-enrich) | Enrich any person or company from any identifier |
| [lead-enrichment](skills/orthogonal-lead-enrichment) | Enrich leads with email, phone, and company data |
| [person-lookup](skills/orthogonal-person-lookup) | Work history, social profiles, contact info |
| [find-email-by-name](skills/orthogonal-find-email-by-name) | Find email addresses from name and company |
| [hunter](skills/orthogonal-hunter) | Email finder and verifier |
| [tomba](skills/orthogonal-tomba) | Email finder from domains, LinkedIn, or company search |
| [verify-email](skills/orthogonal-verify-email) | Verify email deliverability |
| [sixtyfour](skills/orthogonal-sixtyfour) | AI-powered lead enrichment |
| [fiber](skills/orthogonal-fiber) | People, company, investor, and job search with LinkedIn data |
| [nyne](skills/orthogonal-nyne) | Person and company intelligence, social profiles, events, funding |

### 🏢 Company Intelligence

| Skill | Description |
|-------|-------------|
| [company-intel](skills/orthogonal-company-intel) | Full company reports: team, funding, products, news |
| [company-funding-search](skills/orthogonal-company-funding-search) | Funding history, investors, investment details |
| [competitor-research](skills/orthogonal-competitor-research) | Products, pricing, team, funding, and strategy |
| [market-research](skills/orthogonal-market-research) | Market trends, size, competitors, growth |
| [investor-research](skills/orthogonal-investor-research) | VC and angel investor portfolios, thesis, contact info |
| [get-brand-assets](skills/orthogonal-get-brand-assets) | Logos, brand colors, fonts, and style guides |
| [brand-dev](skills/orthogonal-brand-dev) | Brand intelligence from any domain |
| [logo](skills/orthogonal-logo) | Search for company domains by brand name |

### 📱 Social Media

| Skill | Description |
|-------|-------------|
| [shofo](skills/orthogonal-shofo) | Instagram, TikTok, LinkedIn, and X/Twitter scraping |
| [instagram-scraper](skills/orthogonal-instagram-scraper) | Profiles, posts, reels, and comments |
| [linkedin-scraper](skills/orthogonal-linkedin-scraper) | Profiles, company pages, posts, employee data |
| [twitter-profile-lookup](skills/orthogonal-twitter-profile-lookup) | Bios, followers, tweets, engagement |
| [tiktok-search](skills/orthogonal-tiktok-search) | Profiles, videos, hashtags, trending content |
| [social-listening](skills/orthogonal-social-listening) | Monitor brand mentions and competitor activity |

### 📧 Outreach & Sales

| Skill | Description |
|-------|-------------|
| [sales-prospecting](skills/orthogonal-sales-prospecting) | Build targeted prospect lists with verified contacts |
| [email-campaign](skills/orthogonal-email-campaign) | Find emails, verify them, prepare outreach |
| [send-text-message](skills/orthogonal-send-text-message) | Send SMS text messages |
| [textbelt](skills/orthogonal-textbelt) | SMS via HTTP API |
| [job-search](skills/orthogonal-job-search) | Search jobs by skills, experience, preferences |

### 🌤️ Weather

| Skill | Description |
|-------|-------------|
| [weather](skills/orthogonal-weather) | Current weather and forecasts (no API key required) |
| [weather-forecast](skills/orthogonal-weather-forecast) | Temperature, precipitation, wind, conditions |
| [precip](skills/orthogonal-precip) | Hyperlocal weather: precipitation, soil moisture, and more |

### 🛒 Shopping

| Skill | Description |
|-------|-------------|
| [amazon-search](skills/orthogonal-amazon-search) | Search Amazon products, compare prices, read reviews |
| [ebay-search](skills/orthogonal-ebay-search) | Search eBay listings, auctions, deals |
| [restaurant-booking](skills/orthogonal-restaurant-booking) | Book reservations on OpenTable, Resy, and more |

### 🔧 Utilities

| Skill | Description |
|-------|-------------|
| [pdf-processor](skills/orthogonal-pdf-processor) | Extract text, tables, and structured data from PDFs |
| [image-analyzer](skills/orthogonal-image-analyzer) | Extract text, describe content, detect objects |
| [api-tester](skills/orthogonal-api-tester) | Test and document API endpoints |
| [seo-analyzer](skills/orthogonal-seo-analyzer) | Analyze website SEO and keyword opportunities |
| [uptime-monitor](skills/orthogonal-uptime-monitor) | Monitor website availability and response times |
| [didit](skills/orthogonal-didit) | Identity verification via phone/email OTP |
| [phone-verification](skills/orthogonal-phone-verification) | Verify phone numbers via SMS codes |

### 🎬 Media & Creative

| Skill | Description |
|-------|-------------|
| [remotion-best-practices](skills/orthogonal-remotion) | Video creation in React with Remotion |
| [tavus](skills/orthogonal-tavus) | AI video conversations with real-time personas |
| [vhs-terminal-recordings](skills/orthogonal-vhs-terminal-recordings) | Create polished terminal GIF recordings |

### 💻 Development & Design

| Skill | Description |
|-------|-------------|
| [react-best-practices](skills/react-best-practices) | React and Next.js performance optimization, component patterns, anti-patterns |
| [frontend-design](skills/frontend-design) | Creating distinctive, production-grade frontend interfaces |
| [web-design-guidelines](skills/web-design-guidelines) | Web accessibility (WCAG), responsive design, semantic HTML, performance |
| [ui-ux-design](skills/ui-ux-design) | UI/UX design principles, user research, interaction design, usability heuristics |
| [brainstorming](skills/brainstorming) | Structured brainstorming and ideation techniques |
| [supabase-postgres](skills/supabase-postgres) | Supabase and PostgreSQL best practices, schema design, RLS, edge functions |
| [test-driven-development](skills/test-driven-development) | TDD workflow, test strategies, mocking, testing best practices |
| [code-review](skills/code-review) | Code review best practices, feedback, anti-patterns, security checks |

### 🤖 Meta

| Skill | Description |
|-------|-------------|
| [find-skill](skills/orthogonal-find-skill) | Search and install skills from the Orthogonal library |
| [skill-creator](skills/orthogonal-skill-creator) | Create and package new skills |

## Create Your Own Skill

```bash
# Scaffold a new skill
orth skills init my-skill

# Edit SKILL.md with your instructions
# Then submit to the platform
orth skills submit ./my-skill

# Request verification
orth skills request-verification my-skill
```

See the [skill-creator](skills/orthogonal-skill-creator) skill for detailed guidance.

## Links

- **Browse skills:** [orthogonal.com/skills](https://orthogonal.com/skills)
- **CLI docs:** [@orth/cli](https://www.npmjs.com/package/@orth/cli)
- **Platform:** [orthogonal.com](https://orthogonal.com)
