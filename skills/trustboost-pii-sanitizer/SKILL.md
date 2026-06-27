---
name: trustboost-pii-sanitizer
description: PII sanitization for AI agent pipelines. Detects and redacts names, emails, phones, tax IDs (RFC, CPF, CUIT), and other personal data before text reaches LLMs. Returns sanitized text, safety score 0.0-1.0, and risk category. GDPR, LGPD, HIPAA, CCPA compliant. Pay per call via x402 on Solana.
---

# TrustBoost — PII Sanitization API

Privacy firewall for autonomous AI agent pipelines. Sanitizes personal data before it reaches LLMs. Supports 5 languages with LATAM-specific PII patterns.

**Price:** $0.0149 USDC per call via x402 on Solana. Free: `tx_hash=TRIAL` for 50 sanitizations.

## Capabilities

- **PII Detection**: Names, emails, phones, addresses, national IDs, tax numbers
- **LATAM Support**: RFC (Mexico), CPF/CNPJ (Brazil), CUIT (Argentina), RUT (Chile)
- **5 Languages**: English, Spanish, Portuguese, German, Japanese
- **Safety Score**: 0.0–1.0 risk score per sanitization
- **Risk Categories**: CRITICAL / PRIVATE / SENSITIVE
- **Compliance**: GDPR, LGPD, HIPAA, CCPA, EU AI Act

## Usage

### Sanitize text (free trial)
```bash
orth api run trustboost-pii-sanitizer /sanitize --body '{
  "text": "Contact John Smith at john@acme.com or +1-555-0123",
  "tx_hash": "TRIAL"
}'
```

Parameters:
- text* (string) — Text to sanitize
- tx_hash* (string) — x402 transaction hash or "TRIAL" for free tier

## Response

```json
{
  "sanitized_text": "Contact [NAME] at [EMAIL] or [PHONE]",
  "safety_score": 0.85,
  "risk_category": "PRIVATE",
  "entities": [
    {"type": "NAME", "value": "John Smith", "score": 0.20},
    {"type": "EMAIL", "value": "john@acme.com", "score": 0.20}
  ]
}
```

## Use Cases

1. **LLM Privacy**: Sanitize user input before sending to any LLM
2. **Agent Pipelines**: Preprocessing step in agentic workflows
3. **LATAM Compliance**: RFC, CPF, CUIT tax IDs — unique vs US-only tools
4. **EU AI Act**: Mandatory PII protection before AI processing

- API: https://api.trustboost.dev
- Docs: https://api.trustboost.dev/llms.txt
