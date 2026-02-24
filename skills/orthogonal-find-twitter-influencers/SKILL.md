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
- **Size preference** (optional) — micro (1K-10K), mid-tier (10K-100K), macro (100K+), or mixed
- **Max results** (optional, default 15)

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

Run 2-3 query variations, each returning 10 results with text content:

```bash
# Query 1: Curated lists of influencers in the niche
orth run exa /search --body '{
  "query": "best {niche} Twitter accounts to follow",
  "numResults": 10,
  "contents": {"text": {"maxCharacters": 5000}}
}'

# Query 2: Influencer roundup with different phrasing
orth run exa /search --body '{
  "query": "top {industry} influencers on X Twitter must follow",
  "numResults": 10,
  "contents": {"text": {"maxCharacters": 5000}}
}'

# Query 3: Niche-specific creator lists
orth run exa /search --body '{
  "query": "{niche} thought leaders creators Twitter handles",
  "numResults": 10,
  "contents": {"text": {"maxCharacters": 5000}}
}'
```

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

Some influencers are better indexed on LinkedIn but have active Twitter accounts. Fiber can surface these:

```bash
orth run fiber /v1/natural-language-search/profiles --body '{
  "query": "{niche} thought leader content creator with Twitter presence at {industry} companies",
  "pageSize": 20
}'
```

Cross-reference Fiber results with Twitter in Step 5 — only keep people with active Twitter accounts.

### 4. Extract & Deduplicate Usernames

From the **text content** of Exa listicle pages, parse Twitter handles using multiple patterns:
- `@username` mentions in the article text
- URLs matching `x.com/username` or `twitter.com/username`
- Strip trailing URL paths (e.g., `/status/123`, `/followers`) — only keep base profile usernames
- Discard non-profile patterns (search pages, hashtag pages, `x.com/home`, `x.com/search`)
- Deduplicate by username (case-insensitive)
- Flag and remove obvious brand/company accounts (e.g., `@stripe`, `@shopify`) — focus on individual creators

From Fiber results, extract any Twitter/X URLs from social profiles. Add new handles to the candidate pool.

Target: ~40-60 unique handles after dedup. Curated list pages typically mention 20-50 handles each, so 3-5 good listicle results yield plenty of candidates.

### 5. Get Twitter Profiles

Fetch profiles for ALL candidates using Shofo. This is cheap (~200 tokens each) and provides the data needed for filtering.

```bash
orth run shofo /x/user-profile --query 'username=examplehandle'
```

Run these in parallel for all candidates. From each profile, extract:
- Display name, bio, location
- Follower count, following count
- Verified status
- Profile URL, website link
- Last tweet date (for activity check)

**Hard filters — discard profiles that meet any of these:**
- Fewer than 1,000 followers
- No tweets in the last 30 days (inactive)
- Empty bio or bio completely unrelated to the niche
- Protected/private accounts
- Suspended or not-found accounts

### 6. Get Engagement Metrics

For the top 25-30 candidates (by follower count + bio relevance after Step 5 filtering), fetch recent tweets:

```bash
orth run shofo /x/user-posts --query 'username=examplehandle' --query 'count=20'
```

The `count` parameter is required — use 20 for a good balance of data vs context size. Run these in parallel. From each user's recent posts, calculate:
- **Average likes** per tweet
- **Average retweets** per tweet
- **Average replies** per tweet
- **Engagement rate**: (avg likes + avg retweets + avg replies) / followers * 100
- **Post frequency**: tweets per week
- **Content themes**: what topics they tweet about most

Skip reply-only accounts (>80% of tweets are replies to others with minimal engagement).

### 7. Score & Rank

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

Rank all candidates by composite score. Select the top N (default 15) for the final list.

### 8. Enrich Contacts

For the final list, run a contact enrichment waterfall to find email addresses. Try sources in order — stop per person once a verified email is found.

**Step 1 — Check Twitter bio**: Many influencers list their email or a link to a contact page directly in their bio. Extract any email addresses or "DM for collabs" notes.

**Step 2 — Fiber kitchen-sink** (best coverage for professionals):
```bash
# With LinkedIn URL (best match rate):
orth run fiber /v1/kitchen-sink/person --body '{
  "profileIdentifier": "https://linkedin.com/in/janesmith"
}'

# Without LinkedIn — use name + company:
orth run fiber /v1/kitchen-sink/person --body '{
  "personName": {"fullName": "Jane Smith"},
  "companyName": {"name": "Jane Smith Creative"}
}'
```

Note: Fiber kitchen-sink does NOT accept a Twitter URL parameter. Use `profileIdentifier` (LinkedIn URL) for best results, or fall back to `personName` + `companyName`/`companyDomain`.

**Step 3 — Hunter email-finder** (if you have their name + domain from their website/LinkedIn):
```bash
orth run hunter /v2/email-finder --query 'domain=janesmithcreative.com' --query 'first_name=Jane' --query 'last_name=Smith'
```

**Step 4 — Tomba LinkedIn-to-email** (if LinkedIn URL was discovered):
```bash
orth run tomba /v1/linkedin --query 'url=https://linkedin.com/in/janesmith'
```

Also extract from enrichment results:
- LinkedIn URL (for outreach or further research)
- Personal website or newsletter link
- Other social profiles

### 9. Present Results

Output a ranked markdown table with the final influencer list:

```
## Twitter Influencers for {Company} — {Niche}

Found {N} influencers ranked by relevance and engagement:

| # | Name | Handle | Followers | Eng. Rate | Why They Fit | Email | LinkedIn |
|---|------|--------|-----------|-----------|--------------|-------|----------|
| 1 | Jane Smith | [@janesmith](https://x.com/janesmith) | 45.2K | 3.8% | {1-line reason} | jane@... | [Profile](https://linkedin.com/in/...) |
| 2 | ... | ... | ... | ... | ... | ... | ... |

### Size Distribution
- Micro (1K-10K): {count}
- Mid-tier (10K-100K): {count}
- Macro (100K+): {count}

### Notes
- Engagement rates above 3% are excellent for partnership ROI
- Influencers marked with "DM preferred" indicated in their bio they prefer DMs over email
- {Any caveats about the search — e.g., niche is small so fewer results}
```

Include a brief summary of search coverage: how many candidates were found, how many passed filtering, and any gaps (e.g., "Few macro influencers found in this niche — consider broadening to adjacent topics").

### 10. Optional Deep Dive

Only if the user requests more detail on specific influencers:

**Full tweet analysis** (recent content, top tweets, audience reactions):
```bash
orth run shofo /x/user-posts --query 'username=TARGET' --query 'count=50'
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
- **Micro-influencers often outperform** — accounts with 5K-50K followers frequently have 3-5x the engagement rate of 500K+ accounts. Recommend a mix unless the user specifies otherwise
- **Brand accounts vs personal** — Filter out corporate accounts (@stripe, @shopify). Look for individual creators even if they work at companies (e.g., @pmarca not @a16z)
- **Engagement rate varies by tier** — >5% is elite for any size. 2-3% is strong for 50K+ followers. <0.5% is a red flag regardless of follower count
- **Content themes matter more than follower count** — An account with 8K followers tweeting daily about the exact niche beats a 200K account that occasionally mentions it
- **Shofo profiles are cheap** — ~200 tokens each. Fetch all candidates. Only fetch tweets (`/x/user-posts`) for the top 25-30 to manage context
- **Shofo `/x/user-posts` requires `count`** — Always include `--query 'count=20'` (or desired number). Omitting it will cause an error
- **Shofo may be temporarily unavailable** — If Shofo returns `"success": false"`, retry after a few seconds. This indicates a temporary service issue, not a syntax error
- **Check for newsletters/Substacks** — Many Twitter influencers run newsletters. These are high-signal for partnership potential and often listed in the bio
- **Fiber catches LinkedIn-heavy people** — Some professionals (B2B especially) are more discoverable via LinkedIn but still have active Twitter accounts. Don't skip Strategy C for B2B niches
- **Fiber kitchen-sink has no Twitter URL param** — Use `profileIdentifier` (LinkedIn URL) for best match rate. Fall back to `personName` + `companyName` if no LinkedIn URL is available
- **Contact enrichment is a waterfall** — Don't blast all four sources for every person. Check Twitter bio first (free), then Fiber (most coverage), then Hunter/Tomba only if needed
- **DM culture** — Many influencers prefer Twitter DMs for collaboration inquiries. Note "DM for collabs" or "Open DMs" from bios as a contact method
