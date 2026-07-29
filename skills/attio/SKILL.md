---
name: attio
description: Manage Attio CRM companies, people, deals, notes, tasks, and custom objects through the API.
---

# Attio

Use this skill when a task involves Attio CRM records or workflows.

## When To Use

- Search or update companies, people, deals, or lists.
- Add notes after customer calls or research.
- Create tasks for sales or success follow-up.
- Enrich CRM records from trusted sources.

## Starter API Shape

```bash
curl -s "https://api.attio.com/v2/objects/companies/records/query" \
  -H "Authorization: Bearer $ATTIO_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"limit": 10}'
```

## Best Practices

- Use record IDs for updates.
- Preserve existing field values unless explicitly changing them.
- Add source URLs or notes for enrichment provenance.

## Safety

Confirm before bulk updates, deletes, or outbound CRM workflow triggers.
