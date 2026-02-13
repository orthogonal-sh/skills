---
name: shofo
description: Social media scraping - Instagram, TikTok, LinkedIn, and X/Twitter profiles, posts, and comments
---

# Shofo - Social Media Scraping API

Scrape profiles, posts, and comments from Instagram, TikTok, LinkedIn, and X/Twitter.

## Capabilities

- **Instagram Hashtag**: Get posts for an Instagram hashtag ($0.01)
- **X/Twitter Tweet Comments**: Get comments/replies from an X tweet ($0.01)
- **LinkedIn Company Posts**: Get recent posts from a LinkedIn company page ($0.01)
- **TikTok Hashtag Videos**: Get videos for a specific hashtag ($0.01)
- **X/Twitter User Profile**: Get X/Twitter profile data including bio, follower counts, and profile info ($0.01)
- **TikTok Feed Videos**: Get videos from TikTok's recommendation feed ($0.01)
- **Instagram User Profile**: Get Instagram profile data with optional followers and following lists ($0.01)
- **TikTok User Profile Videos**: Get videos from a specific TikTok user's profile ($0.01)
- **TikTok Video Comments**: Get comments from a TikTok video ($0.01)
- **Linkedin User Profile**: Get comprehensive LinkedIn profile data including work experience, education, skills, and contact info ($0.01)
- **Linkedin User Posts**: Get recent posts and activity from a LinkedIn user ($0.01)
- **Linkedin Company Profile**: Get company information including size, industry, locations, and specialties ($0.01)
- **Linkedin Search Employees**: Search LinkedIn people by company or school ($0.01)
- **Instagram User Posts**: Get posts or reels from an Instagram user's profile ($0.01)
- **Instagram Individual Post**: Get detailed data for a specific Instagram post by shortcode or URL ($0.01)
- **Instagram Post Comments**: Get comments from an Instagram post ($0.01)
- **X/Twitter User Posts**: Get tweets from a user's profile ($0.01)
- **X/Twitter Individual Post**: Get detailed data for a specific tweet by ID or URL ($0.01)

## Usage

### Instagram Hashtag ($0.01)
Get posts for an Instagram hashtag.

Parameters:
- keyword* (string) - Hashtag keyword (without #)
- count* (string) - Number of posts to retrieve
- feed_type (string) - Feed type: "top", "recent", or "reels"

```bash
orth api run shofo /instagram/hashtag --query 'hashtag=artificialintelligence'
```

### X/Twitter Tweet Comments ($0.01)
Get comments/replies from an X tweet.

Parameters:
- tweet_id* (string) - X/Twitter tweet ID
- count (string) - Number of comments (min: 10)
- cursor (string) - Pagination cursor from previous response

```bash
orth api run shofo /x/comments --query 'tweet_url=https://x.com/OpenAI/status/123456'
```

### LinkedIn Company Posts ($0.01)
Get recent posts from a LinkedIn company page.

Parameters:
- company (string) - Company name/slug (e.g., "orthogonal")
- company_id (string) - LinkedIn company ID (if known)
- count* (integer) - Number of posts to retrieve
- sort_by (string) - "top" for popular, "recent" for newest (default: top)

```bash
orth api run shofo /linkedin/company-posts --query 'url=https://linkedin.com/company/openai'
```

### TikTok Hashtag Videos ($0.01)
Get videos for a specific hashtag. Great for campaign tracking and trend monitoring.

Parameters:
- hashtag (string) - Hashtag to search (without #)
- challenge_id (string) - Challenge ID (alternative to hashtag)
- count* (integer) - Number of videos to retrieve
- cursor (string) - Pagination cursor from previous response

```bash
orth api run shofo /tiktok/hashtag --query 'hashtag=ai'
```

### X/Twitter User Profile ($0.01)
Get X/Twitter profile data including bio, follower counts, and profile info.

Parameters:
- username* (string) - X/Twitter username (without @)

```bash
orth api run shofo /x/user-profile --query 'username=OpenAI'
```

### TikTok Feed Videos ($0.01)
Get videos from TikTok's recommendation feed. Perfect for trend analysis and content discovery.

Parameters:
- count* (integer) - Number of videos to retrieve (1-100)

```bash
orth api run shofo /tiktok/feed --query 'keyword=artificial%20intelligence'
```

### Instagram User Profile ($0.01)
Get Instagram profile data with optional followers and following lists.

Parameters:
- username* (string) - Instagram username (without @)
- max_followers (integer) - Number of followers to fetch (0 = skip)
- max_following (integer) - Number of following to fetch (0 = skip)

```bash
orth api run shofo /instagram/user-profile --query 'username=openai'
```

### TikTok User Profile Videos ($0.01)
Get videos from a specific TikTok user's profile.

Parameters:
- username (string) - TikTok username (without @)
- sec_uid (string) - User's sec_uid (alternative to username)
- count* (integer) - Number of videos to retrieve
- cursor (string) - Pagination cursor from previous response

```bash
orth api run shofo /tiktok/profile --query 'username=openai'
```

### TikTok Video Comments ($0.01)
Get comments from a TikTok video.

Parameters:
- video_id* (string) - TikTok video ID (aweme_id)
- count (integer) - Number of comments (min: 10)
- cursor (integer) - Pagination cursor from previous response

```bash
orth api run shofo /tiktok/comments --query 'video_url=https://tiktok.com/@user/video/123'
```

### Linkedin User Profile ($0.01)
Get comprehensive LinkedIn profile data including work experience, education, skills, and contact info.

Parameters:
- username* (string) - LinkedIn username (from URL: linkedin.com/in/username). Provide either profile_url or username.

```bash
orth api run shofo /linkedin/user-profile --query 'url=https://linkedin.com/in/johndoe'
```

### Linkedin User Posts ($0.01)
Get recent posts and activity from a LinkedIn user.

Parameters:
- username* (string) - LinkedIn username (from URL: linkedin.com/in/username)
- count* (integer) - Number of posts to retrieve

```bash
orth api run shofo /linkedin/user-posts --query 'url=https://linkedin.com/in/johndoe'
```

### Linkedin Company Profile ($0.01)
Get company information including size, industry, locations, and specialties.

Parameters:
- company (string) - Company name/slug (e.g., "orthogonal")
- company_id (string) - LinkedIn company ID (if known)
- employee_count (string) - Number of employees to fetch (default: 0)

```bash
orth api run shofo /linkedin/company-profile --query 'url=https://linkedin.com/company/openai'
```

### Linkedin Search Employees ($0.01)
Search LinkedIn people by company or school.

Parameters:
- company (string) - Company name to search
- school (string) - School name to search
- current_company (string) - Current company ID filter
- count* (integer) - Number of people to retrieve

```bash
orth api run shofo /linkedin/search-employees --query 'company_url=https://linkedin.com/company/openai'
```

### Instagram User Posts ($0.01)
Get posts or reels from an Instagram user's profile.

Parameters:
- username* (string) - Instagram username
- count* (integer) - Number of posts to retrieve
- reels_only (boolean) - Fetch only reels instead of all posts

```bash
orth api run shofo /instagram/user-posts --query 'username=openai'
```

### Instagram Individual Post ($0.01)
Get detailed data for a specific Instagram post by shortcode or URL.

Parameters:
- code_or_url* (string) - Post shortcode (e.g., DRhvwVLAHAG) or full Instagram URL. Accepted Input Formats The code_or_url parameter accepts either a shortcode or a full URL:  • Shortcode: CxYz123ABC • Post URL: https://www.instagram.com/p/CxYz123ABC/ • Reel URL: https://www.instagram.com/reel/CxYz123ABC/

```bash
orth api run shofo /instagram/post --query 'url=https://instagram.com/p/abc123'
```

### Instagram Post Comments ($0.01)
Get comments from an Instagram post.

Parameters:
- media_id* (string) - Instagram post/media ID
- count (integer) - Number of comments (min: 10)
- sort_order (string) - Sort order: "popular" or "recent"
- cursor (string) - Pagination cursor (next_min_id)

```bash
orth api run shofo /instagram/comments --query 'post_url=https://instagram.com/p/abc123'
```

### X/Twitter User Posts ($0.01)
Get tweets from a user's profile.

Parameters:
- username* (string) - X/Twitter username
- count* (integer) - Number of tweets to retrieve

```bash
orth api run shofo /x/user-posts --query 'username=OpenAI'
```

### X/Twitter Individual Post ($0.01)
Get detailed data for a specific tweet by ID or URL.

Parameters:
- tweet_id_or_url* (string) - Tweet ID or full URL (twitter.com or x.com). Accepted Input Formats: The tweet_id_or_url parameter accepts either a tweet ID or a full URL:  • Tweet ID: 1808168603721650364 • twitter.com URL: https://twitter.com/user/status/1808168603721650364 • x.com URL: https://x.com/user/status/1808168603721650364

```bash
orth api run shofo /x/post --query 'url=https://x.com/OpenAI/status/123456'
```

## Use Cases

1. **Social Listening**: Monitor brand mentions across platforms
2. **Influencer Research**: Analyze influencer profiles and engagement
3. **Competitive Analysis**: Track competitor social media activity
4. **Content Research**: Discover trending content and hashtags
5. **Lead Generation**: Find prospects through social profiles
