---
name: searchapi
description: Multi-platform search - YouTube, Amazon, eBay, Walmart, TikTok, Instagram, and more
---

# SearchAPI - Multi-Platform Search

Search across YouTube, Amazon, eBay, Walmart, TikTok, Instagram, Airbnb, and ad libraries.

## Capabilities

- **TripAdvisor Search**: Search TripAdvisor listings ($0.01)
- **YouTube Comments**: Get comments on a YouTube video ($0.01)
- **YouTube Channel**: Get YouTube channel info ($0.01)
- **Reddit Ad Library**: Search Reddit ads library ($0.01)
- **Meta Ad Library**: Search Meta/Facebook ads library ($0.01)
- **YouTube Transcripts**: Get video transcript/captions ($0.01)
- **Amazon Search**: Search Amazon products ($0.01)
- **eBay Search**: Search eBay listings ($0.01)
- **YouTube Video Details**: Get detailed info about a YouTube video ($0.01)
- **YouTube Channel Videos**: Get videos from a YouTube channel ($0.01)
- **Apple App Store Search**: Search Apple App Store apps ($0.01)
- **Airbnb Search**: Search Airbnb listings ($0.01)
- **TikTok Profile**: Get TikTok user profile info ($0.01)
- **Instagram Profile**: Get Instagram profile info ($0.01)
- **Walmart Search**: Search Walmart products ($0.01)
- **TikTok Ads Library**: Search TikTok ads library ($0.01)
- **LinkedIn Ad Library**: Search LinkedIn ads library ($0.01)
- **YouTube Search**: Search YouTube videos by query ($0.01)

## Usage

### TripAdvisor Search ($0.01)
Search TripAdvisor listings

Parameters:
- engine* (string)
- q* (string) - Search query
- tripadvisor_domain (string) - TripAdvisor domain
- category (string) - Category filter (all, hotels, restaurants, attractions)
- location (string) - Location filter
- lat (number) - Latitude for geo search
- lon (number) - Longitude for geo search
- page (integer) - Page number
- num (integer) - Number of results

```bash
orth api run searchapi /api/v1/search --query engine=tripadvisor q=best%20restaurants%20NYC
```

### YouTube Comments ($0.01)
Get comments on a YouTube video

Parameters:
- engine* (string)
- video_id* (string) - YouTube video ID
- gl (string) - Country code
- hl (string) - Language code
- next_page_token (string) - Pagination token

```bash
orth api run searchapi /api/v1/search --query engine=youtube_comments video_id=dQw4w9WgXcQ
```

### YouTube Channel ($0.01)
Get YouTube channel info

Parameters:
- engine* (string)
- channel_id* (string) - YouTube channel ID
- gl (string) - Country code
- hl (string) - Language code

```bash
orth api run searchapi /api/v1/search --query engine=youtube_channel channel_id=UC_x5XG1OV2P6uZZ5FSM9Ttw
```

### Reddit Ad Library ($0.01)
Search Reddit ads library

Parameters:
- engine* (string)
- q* (string) - Search query
- industry (string) - Industry filter
- objective_type (string) - Campaign objective
- budget_category (string) - Budget category
- placements (string) - Ad placements
- post_type (string) - Post type filter

```bash
orth api run searchapi /api/v1/search --query engine=reddit_ad_library q=software
```

### Meta Ad Library ($0.01)
Search Meta/Facebook ads library

Parameters:
- engine* (string)
- q (string) - Search query
- page_id (string) - Facebook page ID
- location_id (string) - Location ID
- country (string) - Country code
- content_languages (string) - Content language filter
- active_status (string) - Active status filter
- ad_type (string) - Ad type filter
- media_type (string) - Media type filter
- platforms (string) - Platform filter (facebook, instagram)
- sort_by (string) - Sort order
- start_date (string) - Start date filter
- end_date (string) - End date filter
- next_page_token (string) - Pagination token

```bash
orth api run searchapi /api/v1/search --query engine=meta_ad_library q=AI%20tools
```

### YouTube Transcripts ($0.01)
Get video transcript/captions

Parameters:
- engine* (string)
- video_id* (string) - YouTube video ID
- lang (string) - Transcript language code
- transcript_type (string) - Type of transcript
- transcript_name (string) - Name of specific transcript
- only_available (boolean) - Only return available transcripts

```bash
orth api run searchapi /api/v1/search --query engine=youtube_transcripts video_id=dQw4w9WgXcQ
```

### Amazon Search ($0.01)
Search Amazon products

Parameters:
- engine* (string)
- q* (string) - Search query
- amazon_domain (string) - Amazon domain (e.g. amazon.com, amazon.co.uk)
- language (string) - Language code
- delivery_country (string) - Delivery country code
- page (integer) - Page number
- sort_by (string) - Sort order
- price_min (number) - Minimum price filter
- price_max (number) - Maximum price filter
- rh (string) - Refinement filters

```bash
orth api run searchapi /api/v1/search --query engine=amazon_search q=wireless%20headphones
```

### eBay Search ($0.01)
Search eBay listings

Parameters:
- engine* (string)
- q* (string) - Search query
- ebay_domain (string) - eBay domain (e.g. ebay.com)
- country (string) - Country code
- delivery_country (string) - Delivery country
- page (integer) - Page number
- num (integer) - Number of results
- layout (string) - Results layout
- sort_by (string) - Sort order
- price_min (number) - Minimum price
- price_max (number) - Maximum price
- condition (string) - Item condition filter
- buying_format (string) - Buying format filter
- category_id (string) - Category ID
- postal_code (string) - Postal code for local
- distance_radius (integer) - Distance radius in miles

```bash
orth api run searchapi /api/v1/search --query engine=ebay_search q=vintage%20watch
```

### YouTube Video Details ($0.01)
Get detailed info about a YouTube video

Parameters:
- engine* (string)
- video_id* (string) - YouTube video ID
- gl (string) - Country code
- hl (string) - Language code

```bash
orth api run searchapi /api/v1/search --query engine=youtube_video video_id=dQw4w9WgXcQ
```

### YouTube Channel Videos ($0.01)
Get videos from a YouTube channel

Parameters:
- engine* (string)
- channel_id* (string) - YouTube channel ID
- gl (string) - Country code
- hl (string) - Language code

```bash
orth api run searchapi /api/v1/search --query engine=youtube_channel_videos channel_id=UC_x5XG1OV2P6uZZ5FSM9Ttw
```

### Apple App Store Search ($0.01)
Search Apple App Store apps

Parameters:
- engine* (string)
- term* (string) - Search term
- country (string) - Country code (e.g. us, gb)
- lang (string) - Language code
- page (integer) - Page number
- num (integer) - Number of results
- device (string) - Device filter (iphone, ipad)
- property (string) - Property filter
- include_explicit (boolean) - Include explicit content

```bash
orth api run searchapi /api/v1/search --query engine=apple_app_store term=productivity
```

### Airbnb Search ($0.01)
Search Airbnb listings

Parameters:
- engine* (string)
- q* (string) - Location query
- airbnb_domain (string) - Airbnb domain
- currency (string) - Currency code (e.g. USD, EUR)
- check_in_date (string) - Check-in date (YYYY-MM-DD)
- check_out_date (string) - Check-out date (YYYY-MM-DD)
- time_period (string) - Flexible time period
- adults (integer) - Number of adults
- children (integer) - Number of children
- infants (integer) - Number of infants
- pets (integer) - Number of pets
- price_min (number) - Minimum price
- price_max (number) - Maximum price
- bedrooms (integer) - Number of bedrooms
- beds (integer) - Number of beds
- bathrooms (integer) - Number of bathrooms
- property_types (string) - Property type filter
- type_of_place (string) - Entire place/private room/shared
- amenities (string) - Amenities filter

```bash
orth api run searchapi /api/v1/search --query engine=airbnb q=Paris
```

### TikTok Profile ($0.01)
Get TikTok user profile info

Parameters:
- engine* (string)
- username* (string) - TikTok username

```bash
orth api run searchapi /api/v1/search --query engine=tiktok_profile username=openai
```

### Instagram Profile ($0.01)
Get Instagram profile info

Parameters:
- engine* (string)
- username* (string) - Instagram username

```bash
orth api run searchapi /api/v1/search --query engine=instagram_profile username=openai
```

### Walmart Search ($0.01)
Search Walmart products

Parameters:
- engine* (string)
- q* (string) - Search query
- page (integer) - Page number
- sort_by (string) - Sort order
- price_min (number) - Minimum price
- price_max (number) - Maximum price
- category_id (string) - Category ID
- store_id (string) - Store ID for local inventory
- filters (string) - Additional filters

```bash
orth api run searchapi /api/v1/search --query engine=walmart_search q=laptop
```

### TikTok Ads Library ($0.01)
Search TikTok ads library

Parameters:
- engine* (string)
- q (string) - Search query
- advertiser_id (string) - Advertiser ID
- country (string) - Country code
- time_period (string) - Time period filter
- sort_by (string) - Sort order
- next_page_token (string) - Pagination token

```bash
orth api run searchapi /api/v1/search --query engine=tiktok_ads_library q=AI
```

### LinkedIn Ad Library ($0.01)
Search LinkedIn ads library

Parameters:
- engine* (string)
- q (string) - Search query
- advertiser (string) - Advertiser name
- country (string) - Country code
- time_period (string) - Time period filter
- next_page_token (string) - Pagination token

```bash
orth api run searchapi /api/v1/search --query engine=linkedin_ad_library q=hiring
```

### YouTube Search ($0.01)
Search YouTube videos by query

Parameters:
- engine* (string)
- q* (string) - Search query
- sp (string) - Search filter parameter
- gl (string) - Country code (e.g. us, uk, de)
- hl (string) - Language code (e.g. en, de, fr)

```bash
orth api run searchapi /api/v1/search --query engine=youtube q=AI%20agents
```

## Use Cases

1. **Product Research**: Compare products across Amazon, eBay, Walmart
2. **Video Intelligence**: Search YouTube videos, channels, and transcripts
3. **Ad Research**: Monitor ads on Meta, TikTok, Reddit, LinkedIn
4. **Social Media**: Get TikTok and Instagram profiles
5. **Travel**: Search Airbnb listings and TripAdvisor reviews

## Discover More

For full endpoint details and parameters:

```bash
orth api show searchapi              # List all endpoints
```
