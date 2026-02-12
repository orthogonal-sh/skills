# Email Finder

Find emails for any company domain.

## Tools

### find_emails
```yaml
endpoint: https://api.orth.sh/v1/run
method: POST
headers:
  Authorization: Bearer $ORTHOGONAL_API_KEY
  Content-Type: application/json
body:
  api: hunter
  path: /v2/domain-search
  query:
    domain: "{{domain}}"
```