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
orth run dome /polymarket/markets
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

### Markets include:
- Market question/title
- Current Yes/No prices (probabilities)
- Trading volume
- End date
- Market status

### Activity includes:
- Recent trades
- Volume changes
- Price movements

## Examples

**User:** "What are the odds on Polymarket right now?"
```bash
orth run dome /polymarket/markets
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

## Tips

- Check multiple markets for the same event
- Volume indicates market confidence
- Recent activity shows sentiment shifts
- Polymarket focuses on politics/world events, Kalshi on finance/weather
