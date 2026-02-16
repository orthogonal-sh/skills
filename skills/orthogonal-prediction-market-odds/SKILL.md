---
name: prediction-market-odds
description: Get prediction market odds and prices from Polymarket and Kalshi
---

# Prediction Market Odds

Get current odds, prices, and market data from prediction markets like Polymarket and Kalshi.

## When to Use

- User asks about prediction market odds
- User wants to know probability of an event
- User asks "what are the odds of [event]?"
- Research on market sentiment
- Election or event probability checks

## How It Works

Uses the Dome API to aggregate prediction market data from Polymarket and Kalshi.

## Usage

### Get Polymarket Markets

```bash
orth run dome /polymarket/markets -q 'status=open'
```

<details>
<summary>curl equivalent</summary>

```bash
curl -X POST "https://api.orth.sh/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"api":"dome","path":"/polymarket/markets"}'
```
</details>

### Search Markets

```bash
orth run dome /polymarket/markets -q 'search=election' -q 'status=open'
```

### Get Kalshi Markets

```bash
orth run dome /kalshi/markets
```

### Get Polymarket Activity

```bash
orth run dome /polymarket/activity
```

### Get Market Orders

```bash
orth run dome /polymarket/orders
```

### Get Sports Markets

```bash
orth run dome /matching-markets/sports
```

### Get Specific Sport Markets

```bash
orth run dome /matching-markets/sports/nba
```

## Supported Sports

- nba
- nfl
- mlb
- nhl
- soccer
- tennis

## Response

### Markets Response (`/polymarket/markets`, `/kalshi/markets`)
Returns `markets` array:
- **title** (string) - Market question (e.g., "Will Trump nationalize elections?")
- **market_slug** (string) - URL-friendly identifier
- **condition_id** (string) - Blockchain condition ID
- **start_time** / **end_time** (integer) - Unix timestamps
- **completed_time** (integer|null) - Null if still open
- **tags** (array) - Category tags (e.g., `["politics", "us election"]`)
- **volume_1_week** / **volume_1_month** / **volume_1_year** / **volume_total** (number) - Trading volume in USD
- **side_a** / **side_b** (object) - `id` and `label` (typically "Yes"/"No")
- **winning_side** (object|null) - Null if unresolved
- **image** (string) - Market thumbnail URL

### Activity Response (`/polymarket/activity`)
Returns `activities` array:
- **title** (string) - Market title
- **market_slug** (string) - Market identifier
- **side** (string) - Trade side: `BUY`, `SELL`, or `MERGE`
- **shares** (integer) - Raw share amount
- **shares_normalized** (number) - Human-readable share amount
- **price** (number) - Trade price (0-1, represents probability)
- **timestamp** (integer) - Unix timestamp of the trade
- **user** (string) - Wallet address of the trader
- **tx_hash** (string) - Blockchain transaction hash

## Examples

**User:** "What are the odds on Polymarket right now?"
```bash
orth run dome /polymarket/markets -q 'status=open'
```

**User:** "Show me Kalshi prediction markets"
```bash
orth run dome /kalshi/markets
```

**User:** "What's happening in prediction markets?"
```bash
orth run dome /polymarket/activity
```

**User:** "Any sports betting markets?"
```bash
orth run dome /matching-markets/sports
```

## Understanding Odds

- Prices are shown as decimals (0.65 = 65% probability)
- "Yes" price = probability market thinks event will happen
- Higher volume = more confidence/liquidity
- Prices change based on trading activity

## Error Handling

- **400** - `search` requires `status` parameter (`open` or `closed`) — always include both
- **401** - Invalid API key
- **429** - Rate limit — wait and retry
- Empty `markets` array means no markets match the search term
- Activity endpoint returns recent trades globally — no filters required

## Tips

- Check multiple markets for the same event
- Volume indicates market confidence
- Recent activity shows sentiment shifts
- Polymarket focuses on politics/world events, Kalshi on finance/weather
