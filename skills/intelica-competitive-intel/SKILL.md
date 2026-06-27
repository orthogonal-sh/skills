---
name: intelica-competitive-intel
description: Competitive intelligence for autonomous AI agents. Analyze any company or URL and get moat scoring (IMI 0.0-1.0), competitor mapping, decision recommendation (enter/avoid/monitor/acquire/partner), executable action plan with steps and deadlines, source verification, and OTel trace metadata. Pay $0.05 USDC per call via x402 on Base or Solana — no accounts needed.
---

# Intelica — Competitive Intelligence API

Analyze any company or URL and receive structured competitive intelligence. Returns moat score, competitor mapping, decision recommendation, and an executable action plan.

**Price:** $0.05 USDC standard / $1.00 USDC elite via x402 on Base or Solana. Free trial: `GET https://api.intelica.dev/api-keys/trial`

## Capabilities

- **Moat Scoring**: Intelica Moat Index (IMI 0.0–1.0) benchmarked against 3,744+ companies
- **Decision Support**: enter / avoid / monitor / acquire / partner + confidence + rationale
- **Action Plan (SOP)**: Executable steps with owner, deadline_days, and tool hints
- **Source Verification**: Semantic match between claims and source text
- **Audit Trail**: SHA256 — EU AI Act Art.13 compliant
- **OTel Metadata**: trace_id + span_metadata for enterprise observability

## Usage

### Analyze a company
```bash
orth api run intelica-competitive-intel /intel --body '{"text": "Stripe payment API for developers", "mode": "competitive"}'
```

### Elite modes ($1.00 USDC)
```bash
orth api run intelica-competitive-intel /intel --body '{"text": "OpenAI", "mode": "venture_screening"}'
orth api run intelica-competitive-intel /intel --body '{"url": "https://competitor.com", "mode": "defend_position"}'
```

### Free trial (5 calls, no wallet)
```bash
curl https://api.intelica.dev/api-keys/trial
```

Parameters:
- text* (string) — Company name or description to analyze
- url (string) — URL of company or product (optional)
- mode (string) — Analysis mode (competitive, market_entry, fundraising, partnership, acquisition, crypto_protocol, defend_position, venture_screening, regulatory_compliance, risk_assessment, sales_enablement, market_entry_execution)
- client_context (string) — Optional analyst persona or decision frame

## Response

```json
{
  "trace_id": "uuid-v4",
  "intelica_moat_index": 0.72,
  "decision_recommendation": {
    "action": "monitor",
    "confidence_score": 0.85,
    "rationale": "IMI 0.72 — moat beatable but requires 18+ months"
  },
  "action_plan": {
    "objective": "Monitor Stripe for IMI shift before entering",
    "steps": [
      {"step": 1, "action": "Subscribe to Pulse alerts", "owner": "agent", "deadline_days": 1},
      {"step": 2, "action": "Re-analyze if IMI drops below 0.65", "deadline_days": 30}
    ]
  },
  "source_verification_status": {"overall": "verified", "total_citations": 3},
  "audit_trail": {"hash": "sha256...", "compliance": ["EU AI Act Art.13"]}
}
```

## Use Cases

1. **Market Entry**: Go/no-go decision with rationale and action plan
2. **Competitor Monitoring**: Track IMI shifts — subscribe to Pulse for autonomous alerts
3. **VC Screening**: venture_screening mode for investment thesis and deal-breakers
4. **Incumbent Defense**: defend_position to counter competitive threats
5. **M&A Research**: acquisition mode for moat strength and integration risk

- API: https://api.intelica.dev
- Docs: https://api.intelica.dev/llms-full.txt
- Trial: https://api.intelica.dev/api-keys/trial
