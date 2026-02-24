---
name: find-twitter-influencers
description: Find Twitter/X influencers to promote a product or brand. Use when asked to find influencers, discover Twitter accounts for partnerships, identify creators in a niche, or build an influencer outreach list.
---

# Find Twitter Influencers

Discover, score, and enrich Twitter/X influencers relevant to a company, product, or niche. Returns a ranked list with engagement metrics, relevance reasoning, and contact info.

## Workflow

### 1. Parse the Request

Extract from the user's query:
- **Company name or domain** (required) — the brand seeking influencers
- **Niche/vertical** (optional) — e.g., "fintech Twitter", "AI/ML creators", "DTC beauty"
- **Size preference** (optional) — mid-tier (10K-100K), macro (100K+), or mixed (default: 10K+ minimum)
- **Max results** (optional, default 50)

### 2. Resolve the Company

Use Brand.dev to get domain, industry, description, target audience, and keywords. This context drives all subsequent searches.

```bash
orth run brand-dev /v1/brand/retrieve-by-name --query 'name=Acme Corp'
```

If a domain is provided directly:
```bash
orth run brand-dev /v1/brand/retrieve --query 'domain=acme.com'
```

From the result, build a **company context string**: company name, domain, industry, description, and target audience keywords. Example: `"Acme Corp acme.com developer tools API platform engineering teams"`. Use this in all search queries.

### 3. Discover Candidates

Run three strategies **in parallel** to maximize coverage:

**Strategy A — Exa search for curated influencer lists** (primary, highest signal):

IMPORTANT: x.com and twitter.com profiles are NOT in Exa's search index, so `includeDomains: ["x.com"]` will return zero Twitter results. Instead, search for curated list pages, blog posts, and articles about influencers in the niche. Use `contents.text` to get the page content so you can extract Twitter handles from it.

Run 5+ query variations to maximize coverage. Include the **core niche** AND **adjacent niches** — many influencers span related topics. Each query returns 10 results with text content:

```bash
# Query 1: Core niche — curated lists
orth run exa /search --body '{
  "query": "best {niche} Twitter accounts to follow",
  "numResults": 10,
  "contents": {"text": {"maxCharacters": 5000}}
}'

# Query 2: Core niche — different phrasing
orth run exa /search --body '{
  "query": "top {industry} influencers on X Twitter must follow",
  "numResults": 10,
  "contents": {"text": {"maxCharacters": 5000}}
}'

# Query 3: Core niche — thought leaders
orth run exa /search --body '{
  "query": "{niche} thought leaders creators Twitter handles",
  "numResults": 10,
  "contents": {"text": {"maxCharacters": 5000}}
}'

# Query 4: Adjacent niche 1 (e.g., if niche is "identity verification", try "fraud prevention")
orth run exa /search --body '{
  "query": "top {adjacent_niche_1} influencers Twitter accounts to follow",
  "numResults": 10,
  "contents": {"text": {"maxCharacters": 5000}}
}'

# Query 5: Adjacent niche 2 (e.g., "cybersecurity", "regtech", "biometrics")
orth run exa /search --body '{
  "query": "best {adjacent_niche_2} experts creators on X Twitter",
  "numResults": 10,
  "contents": {"text": {"maxCharacters": 5000}}
}'
```

**Choosing adjacent niches**: From the company context (Step 2), identify 2-3 related verticals. Examples:
- Identity verification → fraud prevention, cybersecurity, regtech, biometrics
- Fintech → banking, payments, DeFi, financial regulation
- AI/ML → data science, MLOps, developer tools
- DTC beauty → skincare, wellness, lifestyle, clean beauty

These queries return listicle pages (e.g., "Top 60 Fintech Influencers", "FinTwit Accounts to Follow") whose text content contains Twitter handles, bios, and follower counts. Parse these in Step 4.

**Strategy B — Exa findSimilar** (expand from strong listicle finds):

After Strategy A returns results, pick 1-2 of the best curated list URLs and find similar pages:

```bash
orth run exa /findSimilar --body '{
  "url": "https://example.com/top-fintech-twitter-influencers",
  "numResults": 5,
  "contents": {"text": {"maxCharacters": 5000}}
}'
```

This surfaces additional curated lists that keyword search may miss. Do NOT use Twitter/X profile URLs for findSimilar — they are not in Exa's index and will return empty results.

**Strategy C — Fiber natural-language-search** (catch LinkedIn-heavy professionals):

Some influencers are better indexed on LinkedIn but have active Twitter accounts. Fiber can surface these. Run 2-3 queries covering the core niche and adjacent topics:

```bash
# Core niche
orth run fiber /v1/natural-language-search/profiles --body '{
  "query": "{niche} thought leader content creator with Twitter presence at {industry} companies",
  "pageSize": 20
}'

# Adjacent niche — broader coverage
orth run fiber /v1/natural-language-search/profiles --body '{
  "query": "{adjacent_niche} influencer expert with large social media following",
  "pageSize": 20
}'
```

Cross-reference Fiber results with Twitter in Step 5 — only keep people with active Twitter accounts. Also extract LinkedIn URLs from Fiber results — these are critical for contact enrichment in Step 7.

### 4. Extract & Deduplicate Usernames

From the **text content** of Exa listicle pages, parse Twitter handles using multiple patterns:
- `@username` mentions in the article text
- URLs matching `x.com/username` or `twitter.com/username`
- Strip trailing URL paths (e.g., `/status/123`, `/followers`) — only keep base profile usernames
- Discard non-profile patterns (search pages, hashtag pages, `x.com/home`, `x.com/search`)
- Deduplicate by username (case-insensitive)
- Flag and remove obvious brand/company accounts (e.g., `@stripe`, `@shopify`) — focus on individual creators

From Fiber results, extract any Twitter/X URLs from social profiles. Add new handles to the candidate pool.

Also extract LinkedIn URLs mentioned alongside Twitter handles in listicle pages — save these for contact enrichment in Step 7.

Target: ~100-150 unique handles after dedup. Curated list pages typically mention 20-50 handles each, so 5+ good listicle results across core and adjacent niches yield a large candidate pool.

### 5. Get Twitter Profiles + Engagement

Use Scrape Creators to fetch structured Twitter data. This is a two-step process: fetch profiles for ALL candidates (cheap, 1 credit each), then fetch tweets only for the top ~25-30 after initial filtering.

**Step 1 — Fetch profiles for all candidates:**

```bash
orth run scrape-creators /v1/twitter/profile --query 'handle=examplehandle'
```

Returns structured JSON with: `screen_name`, `name`, `description` (bio), `followers_count`, `following_count`, `statuses_count`, `location`, `verified`, `created_at`, `profile_image_url`, and website URL. The profile URL is `https://x.com/{screen_name}`.

Run these in parallel for all candidates. Apply **hard filters** to narrow the pool:
- Fewer than 10,000 followers (default minimum — adjustable if user specifies a different threshold)
- Empty bio or bio completely unrelated to the niche
- Suspended or not-found accounts (API returns error)
- Bio indicates they've left X (e.g., "find me on Mastodon/Bluesky", "abandoned this site")

**Step 2 — Fetch tweets for top ~60-80 candidates** (after profile filtering):

```bash
orth run scrape-creators /v1/twitter/user-tweets --query 'handle=examplehandle'
```

Returns an array of tweet objects, each with: `full_text`, `favorite_count` (likes), `retweet_count`, `reply_count`, `views_count`, `created_at`, `url`, and media attachments. All engagement numbers are exact integers — no parsing needed.

From the tweet data, calculate:
- **Average likes** per tweet
- **Average retweets** per tweet
- **Average replies** per tweet
- **Engagement rate**: (avg likes + avg retweets + avg replies) / followers * 100
- **Post frequency**: inferred from `created_at` dates
- **Content themes**: what topics they tweet about most (from `full_text`)

**Additional hard filters** (applied after tweet fetch):
- No tweets in the last 30 days (inactive)
- Protected/private accounts

Skip reply-only accounts (>80% of tweets are replies to others with minimal engagement).

### 6. Score & Rank

Apply a composite scoring model:

| Factor | Weight | Signal |
|--------|--------|--------|
| **Relevance** | 40% | Bio keywords, content themes, audience overlap with target company |
| **Engagement rate** | 25% | Higher is better; micro-influencers often outperform macro here |
| **Follower count** | 15% | Log-scaled — diminishing returns above 100K |
| **Content quality** | 10% | Original content vs retweets, thread depth, media usage |
| **Audience alignment** | 10% | Do their followers match the company's target audience? Inferred from bio + content themes |

**Scoring guidelines:**
- Relevance: Compare bio and recent tweet topics against the company context string from Step 2. Exact niche match = high score. Adjacent niche = medium. Generic/unrelated = low.
- Engagement rate benchmarks: >3% excellent, 1-3% good, <1% below average (varies by follower tier)
- Content quality: Penalize accounts that are >50% retweets. Reward original threads, insights, and media-rich posts.

Rank all candidates by composite score. Select the top N (default 50) for the final list.

### 7. Enrich Contacts

For the final list, find email addresses and LinkedIn profiles. The key insight: **discover LinkedIn URLs first** — they dramatically improve match rates for all enrichment APIs.

**Step 1 — Collect what you already have**: From previous steps, gather:
- Emails visible in Twitter bios (many influencers list them directly)
- LinkedIn URLs extracted from Exa listicle page text (Step 4)
- LinkedIn URLs from Fiber NL search results (Step 3, Strategy C)
- Website URLs from Twitter profile data (Step 5)
- "DM for collabs" or "Open DMs" notes from bios

**Step 2 — Discover LinkedIn URLs** for candidates missing them:
```bash
# Exa search to find LinkedIn profiles by name
orth run exa /search --body '{
  "query": "Jane Smith site:linkedin.com/in",
  "numResults": 3,
  "includeDomains": ["linkedin.com"]
}'
```

Run these in parallel for all candidates without LinkedIn URLs. Match by name + job title/company from their Twitter bio. LinkedIn URLs are indexed by Exa, unlike Twitter profiles.

**Step 3 — Fiber kitchen-sink** (best coverage for professionals):
```bash
# With LinkedIn URL (best match rate — ALWAYS prefer this):
orth run fiber /v1/kitchen-sink/person --body '{
  "profileIdentifier": "https://linkedin.com/in/janesmith"
}'
```

Note: Fiber kitchen-sink does NOT accept a Twitter URL parameter. Use `profileIdentifier` (LinkedIn URL) for best results. The name+company fallback has low match rates for influencers — invest in finding LinkedIn URLs in Step 2 instead.

**Step 4 — Hunter email-finder** (if you have their name + domain from their website/LinkedIn):
```bash
orth run hunter /v2/email-finder --query 'domain=janesmithcreative.com' --query 'first_name=Jane' --query 'last_name=Smith'
```

**Step 5 — Tomba LinkedIn-to-email** (if LinkedIn URL was discovered):
```bash
orth run tomba /v1/linkedin --query 'url=https://linkedin.com/in/janesmith'
```

Also extract from enrichment results:
- LinkedIn URL (for outreach or further research)
- Personal website or newsletter link
- Other social profiles

### 8. Present Results

Output a ranked markdown table with the final influencer list:

```
## Twitter Influencers for {Company} — {Niche}

Found {N} influencers ranked by relevance and engagement:

| # | Name | Handle | Followers | Eng. Rate | Why They Fit | Email | LinkedIn |
|---|------|--------|-----------|-----------|--------------|-------|----------|
| 1 | Jane Smith | [@janesmith](https://x.com/janesmith) | 45.2K | 3.8% | {1-line reason} | jane@... | [Profile](https://linkedin.com/in/...) |
| 2 | ... | ... | ... | ... | ... | ... | ... |

### Size Distribution
- Mid-tier (10K-100K): {count}
- Macro (100K+): {count}

### Notes
- Engagement rates above 3% are excellent for partnership ROI
- Influencers marked with "DM preferred" indicated in their bio they prefer DMs over email
- {Any caveats about the search — e.g., niche is small so fewer results}
```

Include a brief summary of search coverage: how many candidates were found, how many passed filtering, and any gaps (e.g., "Few macro influencers found in this niche — consider broadening to adjacent topics").

### 9. Optional Deep Dive

Only if the user requests more detail on specific influencers:

**Full tweet analysis** (recent content, top tweets, audience reactions):
```bash
orth run scrape-creators /v1/twitter/profile --query 'handle=TARGET'
orth run scrape-creators /v1/twitter/user-tweets --query 'handle=TARGET'
```

If deeper tweet history is needed, Nyne can fetch recent newsfeed data asynchronously:
```bash
# Step 1: POST to start async retrieval
orth run -X POST nyne /person/newsfeed -d '{"social_media_url": "https://x.com/TARGET"}'
# Step 2: Poll with GET using request_id
orth run nyne /person/newsfeed --query 'request_id=REQUEST_ID'
```

**LinkedIn profile** (full work history, credentials, other ventures):
```bash
orth run fiber /v1/linkedin-live-fetch/profile/single --body '{"identifier": "https://linkedin.com/in/TARGET"}'
```

**Deep enrichment** (AI-powered research — slow, ~30-60s):
```bash
orth run sixtyfour /enrich-lead --body '{
  "lead_info": {"first_name": "Jane", "last_name": "Smith", "linkedin_url": "https://linkedin.com/in/janesmith"},
  "struct": {"work_email": "Work email", "personal_email": "Personal email", "phone": "Phone number", "audience_size": "Total audience across platforms", "collab_history": "Known brand collaborations", "content_style": "Content style and themes"}
}'
```

## Tips

- **Exa cannot search Twitter directly** — x.com/twitter.com profiles are NOT in Exa's search index. `includeDomains: ["x.com"]` returns zero Twitter results. Instead, search for curated list pages and listicles about influencers, then extract handles from the page text
- **Request text content from Exa** — Always use `contents: { text: { maxCharacters: 5000 } }` when searching for influencer lists. The page text contains @handles, profile URLs, and bios that you need to parse
- **Query variation is key** — Vary phrasing across queries: "best fintech Twitter accounts to follow", "top finance creators on X", "FinTwit must-follow" all surface different listicle pages
- **findSimilar works on listicle pages, not Twitter URLs** — Use findSimilar on the best curated list URLs from Strategy A to find more lists. Do NOT pass x.com URLs — they return empty results
- **Mid-tier influencers often outperform** — accounts with 10K-100K followers frequently have 2-3x the engagement rate of 500K+ accounts. Include a healthy mix of mid-tier and macro
- **Brand accounts vs personal** — Filter out corporate accounts (@stripe, @shopify). Look for individual creators even if they work at companies (e.g., @pmarca not @a16z)
- **Engagement rate varies by tier** — >5% is elite for any size. 2-3% is strong for 50K+ followers. <0.5% is a red flag regardless of follower count
- **Content themes matter more than follower count** — An account with 8K followers tweeting daily about the exact niche beats a 200K account that occasionally mentions it
- **Scrape Creators returns structured JSON** — No text parsing needed. Profile endpoint returns exact `followers_count`, `description`, `screen_name`, etc. Tweet endpoint returns `favorite_count`, `retweet_count`, `reply_count`, `views_count` as integers
- **Two-step profile + tweets** — Fetch profiles first for all candidates (1 credit each), apply hard filters (followers, bio relevance), then fetch tweets only for the top ~25-30. This saves credits compared to fetching tweets for everyone
- **Each tweet includes a direct URL** — The `url` field on each tweet object gives you `https://x.com/{handle}/status/{id}`. The profile URL is `https://x.com/{screen_name}`
- **Check for newsletters/Substacks** — Many Twitter influencers run newsletters. These are high-signal for partnership potential and often listed in the bio
- **Fiber catches LinkedIn-heavy people** — Some professionals (B2B especially) are more discoverable via LinkedIn but still have active Twitter accounts. Don't skip Strategy C for B2B niches
- **Fiber kitchen-sink has no Twitter URL param** — Use `profileIdentifier` (LinkedIn URL) for best match rate. The name+company fallback has very low match rates for influencers
- **LinkedIn URL discovery is critical** — Fiber kitchen-sink with name+company often returns "could not find anyone". Invest in finding LinkedIn URLs first via Exa (`site:linkedin.com/in "Jane Smith"`) or from listicle page text. LinkedIn URLs in `profileIdentifier` have dramatically better match rates
- **Contact enrichment is a waterfall** — Check Twitter bio first (free), then Fiber with LinkedIn URL (best coverage), then Hunter/Tomba only if needed
- **DM culture** — Many influencers prefer Twitter DMs for collaboration inquiries. Note "DM for collabs" or "Open DMs" from bios as a contact method
- **Adjacent niches expand the pool** — Narrow B2B niches (identity verification, regtech, etc.) may only have 10-20 active influencers on X. Always search 2-3 adjacent verticals to hit the target count. For example: identity verification → fraud prevention, cybersecurity, biometrics, regtech
- **X migration is real** — Many B2B/security influencers have migrated to Mastodon, Bluesky, or Threads since 2022. Filter out accounts whose bio says "find me on [other platform]" or that haven't tweeted in 30+ days. Note migration trends in the results summary so the user can consider multi-platform outreach
- **Scrape Creators returns tweets sorted by popularity** — The `user-tweets` endpoint returns top tweets, not chronologically sorted. To check if an account is truly active, look at the `created_at` dates across all returned tweets — if the newest tweet is months old, the account may be inactive even though it has high historical engagement
