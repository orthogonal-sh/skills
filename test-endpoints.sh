#!/bin/bash
# Test all unique CLI endpoint paths from SKILL.md files
# Success = 2xx or 400 (endpoint exists, bad params is fine)
# Failure = 404, 405, or connection error (wrong path)

PASS=0
FAIL=0
ERRORS=""

test_endpoint() {
  local desc="$1"
  shift
  local output
  output=$(orth api run "$@" --raw 2>&1)
  local exit_code=$?

  if echo "$output" | grep -q "status 404"; then
    FAIL=$((FAIL + 1))
    ERRORS="${ERRORS}\nFAIL (404): $desc"
    echo "FAIL (404): $desc"
  elif echo "$output" | grep -q "status 405"; then
    FAIL=$((FAIL + 1))
    ERRORS="${ERRORS}\nFAIL (405): $desc"
    echo "FAIL (405): $desc"
  elif echo "$output" | grep -q "Could not resolve"; then
    FAIL=$((FAIL + 1))
    ERRORS="${ERRORS}\nFAIL (DNS): $desc"
    echo "FAIL (DNS): $desc"
  else
    PASS=$((PASS + 1))
    # Extract status for logging
    if echo "$output" | grep -q "Error:"; then
      local status=$(echo "$output" | grep "Error:" | head -1 | sed 's/.*status //' | cut -d' ' -f1)
      echo "OK ($status): $desc"
    else
      echo "OK (200): $desc"
    fi
  fi
}

echo "=== Testing all SKILL.md CLI endpoints ==="
echo ""

# andi
test_endpoint "andi /v1/search" andi /v1/search --query q=test

# brand-dev (GET endpoints)
test_endpoint "brand-dev /v1/brand/retrieve" brand-dev /v1/brand/retrieve --query domain=stripe.com
test_endpoint "brand-dev /v1/brand/retrieve-simplified" brand-dev /v1/brand/retrieve-simplified --query domain=stripe.com
test_endpoint "brand-dev /v1/brand/styleguide" brand-dev /v1/brand/styleguide --query domain=stripe.com
test_endpoint "brand-dev /v1/brand/fonts" brand-dev /v1/brand/fonts --query domain=stripe.com
test_endpoint "brand-dev /v1/brand/screenshot" brand-dev /v1/brand/screenshot --query domain=stripe.com
test_endpoint "brand-dev /v1/brand/naics" brand-dev /v1/brand/naics --query input=stripe.com
test_endpoint "brand-dev /v1/brand/ai/query" brand-dev /v1/brand/ai/query --body '{"domain":"stripe.com","data_to_extract":[{"name":"description","description":"Company description"}]}'
test_endpoint "brand-dev /v1/brand/retrieve-by-name" brand-dev /v1/brand/retrieve-by-name --query name=Stripe
test_endpoint "brand-dev /v1/brand/retrieve-by-email" brand-dev /v1/brand/retrieve-by-email --query email=test@stripe.com
test_endpoint "brand-dev /v1/brand/retrieve-by-ticker" brand-dev /v1/brand/retrieve-by-ticker --query ticker=AAPL

# didit
test_endpoint "didit /v3/phone/send" didit /v3/phone/send --body '{"phone_number":"+0000000000"}'
test_endpoint "didit /v3/phone/check" didit /v3/phone/check --body '{"phone_number":"+0000000000","code":"000000"}'
test_endpoint "didit /v3/email/send" didit /v3/email/send --body '{"email":"test@test.com"}'
test_endpoint "didit /v3/email/check" didit /v3/email/check --body '{"email":"test@test.com","code":"000000"}'
test_endpoint "didit /v3/database-validation" didit /v3/database-validation --body '{"issuing_state":"ESP","validation_type":"one_by_one","identification_number":"12345678A"}'
test_endpoint "didit /v3/aml" didit /v3/aml --body '{"full_name":"Test","entity_type":"person"}'

# dome
test_endpoint "dome /polymarket/markets" dome /polymarket/markets --query search=test status=open
test_endpoint "dome /kalshi/markets" dome /kalshi/markets --query search=test
test_endpoint "dome /matching-markets/sports" dome /matching-markets/sports
test_endpoint "dome /crypto-prices/binance" dome /crypto-prices/binance --query currency=btcusdt
test_endpoint "dome /polymarket/orders" dome /polymarket/orders --query market=test

# shofo
test_endpoint "shofo /x/user-profile" shofo /x/user-profile --query username=openai
test_endpoint "shofo /x/user-posts" shofo /x/user-posts --query username=openai count=3
test_endpoint "shofo /linkedin/user-profile" shofo /linkedin/user-profile --query username=satyanadella
test_endpoint "shofo /instagram/user-posts" shofo /instagram/user-posts --query username=openai count=3
test_endpoint "shofo /tiktok/profile" shofo /tiktok/profile --query username=openai count=3

# notte
test_endpoint "notte /scrape" notte /scrape --body '{"url":"https://example.com"}'

# searchapi
test_endpoint "searchapi /api/v1/search (amazon)" searchapi /api/v1/search --query engine=amazon_search q=test
test_endpoint "searchapi /api/v1/search (ebay)" searchapi /api/v1/search --query engine=ebay_search q=test

# nyne
test_endpoint "nyne /person/search" nyne /person/search --body '{"query":"test"}'

# exa
test_endpoint "exa /search" exa /search --body '{"query":"test","num_results":1}'
test_endpoint "exa /findSimilar" exa /findSimilar --body '{"url":"https://example.com","num_results":1}'
test_endpoint "exa /contents" exa /contents --body '{"ids":["https://example.com"],"text":true}'
test_endpoint "exa /answer" exa /answer --body '{"query":"test"}'
test_endpoint "exa /research/v1" exa /research/v1 --body '{"query":"test"}'

# fiber
test_endpoint "fiber /v1/natural-language-search/profiles" fiber /v1/natural-language-search/profiles --body '{"query":"test"}'
test_endpoint "fiber /v1/natural-language-search/companies" fiber /v1/natural-language-search/companies --body '{"query":"test"}'
test_endpoint "fiber /v1/people-search" fiber /v1/people-search --body '{"searchParams":{"job_titles":["CEO"]}}'
test_endpoint "fiber /v1/company-search" fiber /v1/company-search --body '{"searchParams":{"industries":["Software"]}}'
test_endpoint "fiber /v1/investor-search" fiber /v1/investor-search --body '{"searchParams":{"investment_stages":["Seed"]}}'
test_endpoint "fiber /v1/job-search" fiber /v1/job-search --body '{"searchParams":{"job_titles":["Engineer"]}}'
test_endpoint "fiber /v1/validate-email/single" fiber /v1/validate-email/single --body '{"email":"test@test.com"}'
test_endpoint "fiber /v1/linkedin-live-fetch/profile/single" fiber /v1/linkedin-live-fetch/profile/single --body '{"identifier":"https://linkedin.com/in/test"}'
test_endpoint "fiber /v1/email-to-person/single" fiber /v1/email-to-person/single --body '{"email":"test@test.com"}'

# hunter
test_endpoint "hunter /v2/domain-search" hunter /v2/domain-search --query domain=stripe.com
test_endpoint "hunter /v2/email-finder" hunter /v2/email-finder --query domain=stripe.com first_name=Test last_name=Test
test_endpoint "hunter /v2/email-verifier" hunter /v2/email-verifier --query email=test@stripe.com
test_endpoint "hunter /v2/people/find" hunter /v2/people/find --query email=test@stripe.com
test_endpoint "hunter /v2/companies/find" hunter /v2/companies/find --query domain=stripe.com
test_endpoint "hunter /v2/combined/find" hunter /v2/combined/find --query email=test@stripe.com
test_endpoint "hunter /v2/discover" hunter /v2/discover --body '{"query":"test"}'
test_endpoint "hunter /v2/email-count" hunter /v2/email-count --query domain=stripe.com

# jina-s
test_endpoint "jina-s /" jina-s / --query q=test

# linkup
test_endpoint "linkup /search" linkup /search --body '{"q":"test","depth":"standard","outputType":"sourcedAnswer"}'
test_endpoint "linkup /fetch" linkup /fetch --body '{"url":"https://example.com"}'

# logo
test_endpoint "logo /search" logo /search --query q=Stripe

# olostep
test_endpoint "olostep /v1/scrapes" olostep /v1/scrapes --body '{"url_to_scrape":"https://example.com"}'
test_endpoint "olostep /v1/crawls" olostep /v1/crawls --body '{"start_url":"https://example.com","max_pages":1}'
test_endpoint "olostep /v1/batches" olostep /v1/batches --body '{"items":[{"url_to_scrape":"https://example.com"}]}'
test_endpoint "olostep /v1/answers" olostep /v1/answers --body '{"task":"test"}'
test_endpoint "olostep /v1/maps" olostep /v1/maps --body '{"url":"https://example.com"}'

# parallel
test_endpoint "parallel /chat/completions" parallel /chat/completions --body '{"model":"parallel","messages":[{"role":"user","content":"test"}]}'
test_endpoint "parallel /v1/tasks/runs" parallel /v1/tasks/runs --body '{"processor":"base","input":"test"}'
test_endpoint "parallel /v1beta/search" parallel /v1beta/search --body '{"objective":"test"}'

# perplexity
test_endpoint "perplexity /search" perplexity /search --body '{"query":"test"}'
test_endpoint "perplexity /chat/completions" perplexity /chat/completions --body '{"model":"sonar","messages":[{"role":"user","content":"test"}]}'

# precip
test_endpoint "precip /api/v1/hourly" precip /api/v1/hourly --query latitude=37.7749 longitude=-122.4194 start=2024-01-01 end=2024-01-02
test_endpoint "precip /api/v1/daily" precip /api/v1/daily --query latitude=37.7749 longitude=-122.4194 start=2024-01-01 end=2024-01-02
test_endpoint "precip /api/v1/last-48" precip /api/v1/last-48 --query latitude=37.7749 longitude=-122.4194
test_endpoint "precip /api/v1/temperature-hourly" precip /api/v1/temperature-hourly --query latitude=37.7749 longitude=-122.4194 start=2024-01-01 end=2024-01-02
test_endpoint "precip /api/v1/wind-speed-hourly" precip /api/v1/wind-speed-hourly --query latitude=37.7749 longitude=-122.4194 start=2024-01-01 end=2024-01-02
test_endpoint "precip /api/v1/soil-moisture-hourly" precip /api/v1/soil-moisture-hourly --query latitude=37.7749 longitude=-122.4194 start=2024-01-01 end=2024-01-02
test_endpoint "precip /api/v1/recent-rain" precip /api/v1/recent-rain --query latitude=37.7749 longitude=-122.4194
test_endpoint "precip /embed/location" precip /embed/location --query lat=37.7749 lon=-122.4194

# riveter
test_endpoint "riveter /v1/scrape" riveter /v1/scrape --body '{"url":"https://example.com"}'
test_endpoint "riveter /v1/run" riveter /v1/run --body '{"input":{"urls":["https://example.com"]},"output":{"title":{"prompt":"Extract the page title","contexts":["urls"]}}}'
test_endpoint "riveter /v1/run_status" riveter /v1/run_status --query run_key=test
test_endpoint "riveter /v1/run_data" riveter /v1/run_data --query run_key=test
test_endpoint "riveter /v1/stop_run" riveter /v1/stop_run --query run_key=test

# scrapegraph
test_endpoint "scrapegraph /v1/smartscraper" scrapegraph /v1/smartscraper --body '{"website_url":"https://example.com","user_prompt":"test"}'
test_endpoint "scrapegraph /v1/searchscraper" scrapegraph /v1/searchscraper --body '{"user_prompt":"test"}'
test_endpoint "scrapegraph /v1/crawl" scrapegraph /v1/crawl --body '{"url":"https://example.com","prompt":"test"}'
test_endpoint "scrapegraph /v1/markdownify" scrapegraph /v1/markdownify --body '{"website_url":"https://example.com"}'
test_endpoint "scrapegraph /v1/sitemap" scrapegraph /v1/sitemap --body '{"website_url":"https://example.com"}'
test_endpoint "scrapegraph /v1/scrape" scrapegraph /v1/scrape --body '{"website_url":"https://example.com"}'

# sixtyfour
test_endpoint "sixtyfour /find-email" sixtyfour /find-email --body '{"lead":{"first_name":"Test","last_name":"Test","domain":"test.com"}}'
test_endpoint "sixtyfour /find-phone" sixtyfour /find-phone --body '{"lead":{"first_name":"Test","last_name":"Test","company":"Test"}}'
test_endpoint "sixtyfour /enrich-company" sixtyfour /enrich-company --body '{"target_company":{"domain":"stripe.com"},"struct":{"description":"Company description"}}'
test_endpoint "sixtyfour /enrich-lead" sixtyfour /enrich-lead --body '{"lead_info":{"first_name":"Test","last_name":"Test","company":"Test"},"struct":{"email":"Email address"}}'

# tavily
test_endpoint "tavily /search" tavily /search --body '{"query":"test"}'
test_endpoint "tavily /research" tavily /research --body '{"input":"test"}'
test_endpoint "tavily /extract" tavily /extract --body '{"urls":["https://example.com"]}'
test_endpoint "tavily /crawl" tavily /crawl --body '{"url":"https://example.com"}'
test_endpoint "tavily /map" tavily /map --body '{"url":"https://example.com"}'

# tavus
test_endpoint "tavus /v2/personas" tavus /v2/personas
test_endpoint "tavus /v2/conversations" tavus /v2/conversations --body '{"persona_id":"test"}'

# textbelt
test_endpoint "textbelt /text" textbelt /text --body '{"phone":"+0000000000","message":"test"}'

# tomba
test_endpoint "tomba /v1/domain-search" tomba /v1/domain-search --query domain=stripe.com
test_endpoint "tomba /v1/linkedin" tomba /v1/linkedin --query url=https://linkedin.com/in/test
test_endpoint "tomba /v1/email-verifier" tomba /v1/email-verifier --query email=test@test.com
test_endpoint "tomba /v1/reveal/search" tomba /v1/reveal/search --body '{"query":"test"}'
test_endpoint "tomba /v1/email-count" tomba /v1/email-count --query domain=stripe.com
test_endpoint "tomba /v1/companies/find" tomba /v1/companies/find --query domain=stripe.com
test_endpoint "tomba /v1/domain-suggestions" tomba /v1/domain-suggestions --query query=Google

# valyu
test_endpoint "valyu /v1/search" valyu /v1/search --body '{"query":"test"}'
test_endpoint "valyu /v1/answer" valyu /v1/answer --body '{"query":"test"}'
test_endpoint "valyu /v1/contents" valyu /v1/contents --body '{"urls":["https://example.com"]}'
test_endpoint "valyu /v1/deepresearch/tasks" valyu /v1/deepresearch/tasks --body '{"query":"test"}'
test_endpoint "valyu /v1/deepresearch/batches" valyu /v1/deepresearch/batches --body '{"name":"test"}'

echo ""
echo "=== Results ==="
echo "PASS: $PASS"
echo "FAIL: $FAIL"
if [ -n "$ERRORS" ]; then
  echo ""
  echo "Failed endpoints:"
  echo -e "$ERRORS"
fi
