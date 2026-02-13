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
orth api run dome /polymarket/markets --query 'search=election'
```

### Search Kalshi Markets ($0.01)
```bash
orth api run dome /kalshi/markets --query 'search=fed%20rate'
```

### Get Market Price ($0.01)
```bash
orth api run dome /polymarket/market-price/{token_id}
```

### Get Kalshi Price ($0.01)
```bash
orth api run dome /kalshi/market-price/{market_ticker}
```

### Historical Candlesticks ($0.01)
```bash
orth api run dome /polymarket/candlesticks/{condition_id} --query 'interval=1h'
```

### Order History ($0.01)
```bash
orth api run dome /polymarket/orders --query 'market={market_id}'
```

### Wallet Positions ($0.01)
```bash
orth api run dome /polymarket/positions/wallet/{wallet_address}
```

### Wallet P&L ($0.01)
```bash
orth api run dome /polymarket/wallet/pnl/{wallet_address}
```

### Sports Markets ($0.01)
```bash
orth api run dome /matching-markets/sports
```

### Crypto Prices from Binance ($0.01)
```bash
orth api run dome /crypto-prices/binance --query 'currency=btcusdt'
```

## Use Cases

1. **Market Research**: Track prediction market sentiment
2. **Trading Analysis**: Analyze historical prices and orderbooks
3. **Portfolio Tracking**: Monitor positions and P&L
4. **Arbitrage**: Find price differences across platforms
5. **Forecasting**: Use market prices as probability estimates
