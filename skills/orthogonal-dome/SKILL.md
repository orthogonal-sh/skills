---
name: dome
description: Prediction markets data - Polymarket, Kalshi markets, prices, positions, and trades
---

# Dome - Prediction Markets API

Access data from Polymarket and Kalshi prediction markets.

## Capabilities

- **Market Search**: Find markets on Polymarket and Kalshi ($0.01)
- **Price Data**: Current and historical prices ($0.01)
- **Order Books**: Historical orderbook snapshots ($0.01)
- **Trades**: Historical trade data ($0.01)
- **Positions**: Wallet positions and P&L ($0.01)
- **Crypto Prices**: Binance and Chainlink price feeds ($0.01)
- **Sports Markets**: Cross-platform sports betting markets ($0.01)

## Usage

### Search Polymarket Markets ($0.01)
```bash
curl "https://api.orth.sh/v1/run/dome/polymarket/markets?search=election" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Search Kalshi Markets ($0.01)
```bash
curl "https://api.orth.sh/v1/run/dome/kalshi/markets?search=fed%20rate" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Get Market Price ($0.01)
```bash
curl "https://api.orth.sh/v1/run/dome/polymarket/market-price/{token_id}" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Get Kalshi Price ($0.01)
```bash
curl "https://api.orth.sh/v1/run/dome/kalshi/market-price/{market_ticker}" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Historical Candlesticks ($0.01)
```bash
curl "https://api.orth.sh/v1/run/dome/polymarket/candlesticks/{condition_id}?interval=1h" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Order History ($0.01)
```bash
curl "https://api.orth.sh/v1/run/dome/polymarket/orders?market={market_id}" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Wallet Positions ($0.01)
```bash
curl "https://api.orth.sh/v1/run/dome/polymarket/positions/wallet/{wallet_address}" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Wallet P&L ($0.01)
```bash
curl "https://api.orth.sh/v1/run/dome/polymarket/wallet/pnl/{wallet_address}" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Sports Markets ($0.01)
```bash
curl "https://api.orth.sh/v1/run/dome/matching-markets/sports" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

### Crypto Prices from Binance ($0.01)
```bash
curl "https://api.orth.sh/v1/run/dome/crypto-prices/binance?symbol=BTCUSDT" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY"
```

## CLI Usage

```bash
# Find election markets
orth api run dome /polymarket/markets --query 'search=2024%20election'

# Get market price history
orth api run dome /polymarket/candlesticks/{condition_id} --query 'interval=1d'

# Check wallet positions
orth api run dome /polymarket/positions/wallet/{address}
```

## Use Cases

1. **Market Research**: Track prediction market sentiment
2. **Trading Analysis**: Analyze historical prices and orderbooks
3. **Portfolio Tracking**: Monitor positions and P&L
4. **Arbitrage**: Find price differences across platforms
5. **Forecasting**: Use market prices as probability estimates
