---
name: stock-info-explorer
description: Explore stock quotes, charts, fundamentals, and company market data.
---

# Stock Info Explorer

Use this skill when the user asks for stock quotes, market charts, fundamentals, moving averages, or company financial snapshots.

## Workflow

1. Confirm the ticker, exchange, and date range.
2. Fetch current quote and historical data from an authoritative provider.
3. Compute or display requested indicators only after validating data coverage.
4. Summarize price action, fundamentals, and caveats separately.
5. Cite data freshness for volatile values.

## Guardrails

- Do not give investment advice.
- Use current finance data for live prices.
- Be explicit when data is delayed or unavailable.
