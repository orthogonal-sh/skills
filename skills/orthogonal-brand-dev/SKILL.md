---
name: brand-dev
description: Brand intelligence - logos, colors, fonts, styleguides, and company data from any domain
---

# Brand.dev - Brand Intelligence API

Extract comprehensive brand information from any domain - logos, colors, fonts, and more.

## Capabilities

- **Extract fonts from website**: Extract font information from a brand’s website including font families, usage statistics, fallbacks, and element/word counts ($0.03)
- **Identify brand from transaction data**: Endpoint specially designed for platforms that want to identify transaction data by the transaction title ($0.03)
- **Retrieve NAICS code for any brand**: Endpoint to classify any brand into a 2022 NAICS code ($0.03)
- **Retrieve brand data by email address**: Retrieve brand information using an email address while detecting disposable and free email addresses ($0.03)
- **Retrieve simplified brand data by domain**: Returns a simplified version of brand data containing only essential information: domain, title, colors, logos, and backdrops ($0.03)
- **Retrieve brand data by ISIN**: Retrieve brand information using an ISIN (International Securities Identification Number) ($0.03)
- **Extract products from a brand's website**: Beta feature: Extract product information from a brand’s website ($0.03)
- **Retrieve brand data by domain**: Retrieve logos, backdrops, colors, industry, description, and more from any domain ($0.03)
- **Retrieve brand data by company name**: Retrieve brand information using a company name ($0.03)
- **Retrieve brand data by stock ticker**: Retrieve brand information using a stock ticker symbol ($0.03)
- **Extract design system and styleguide from website**: Automatically extract comprehensive design system information from a brand’s website including colors, typography, spacing, shadows, and UI components ($0.03)
- **Take screenshot of website**: Capture a screenshot of a website ($0.03)
- **Query website data using AI**: Use AI to extract specific data points from a brand’s website ($0.03)

## Usage

### Extract fonts from website ($0.03)
Extract font information from a brand’s website including font families, usage statistics, fallbacks, and element/word counts.

Parameters:
- domain* (string) - Domain name to extract fonts from (e.g., 'example.com', 'google.com'). The domain will be automatically normalized and validated.
- timeoutMS (integer) - Optional timeout in milliseconds for the request. If the request takes longer than this value, it will be aborted with a 408 status code. Maximum allowed value is 300000ms (5 minutes).

```bash
orth api run brand-dev /v1/brand/fonts --query 'domain=vercel.com'
```

### Identify brand from transaction data ($0.03)
Endpoint specially designed for platforms that want to identify transaction data by the transaction title.

Parameters:
- transaction_info* (string) - Transaction information to identify the brand
- force_language (string) - Optional parameter to force the language of the retrieved brand data.
- maxSpeed (boolean) - Optional parameter to optimize the API call for maximum speed. When set to true, the API will skip time-consuming operations for faster response at the cost of less comprehensive data.
- country_gl (string) - Optional country code (GL parameter) to specify the country. This affects the geographic location used for search queries.
- city (string) - Optional city name to prioritize when searching for the brand.
- mcc (string) - Optional Merchant Category Code (MCC) to help identify the business category/industry.
- phone (number) - Optional phone number from the transaction to help verify brand match.
- timeoutMS (integer) - Optional timeout in milliseconds for the request. If the request takes longer than this value, it will be aborted with a 408 status code. Maximum allowed value is 300000ms (5 minutes).

```bash
orth api run brand-dev /v1/brand/transaction_identifier --query 'transaction_title=STRIPE%20PAYMENT'
```

### Retrieve NAICS code for any brand ($0.03)
Endpoint to classify any brand into a 2022 NAICS code.

Parameters:
- input* (string) - Brand domain or title to retrieve NAICS code for. If a valid domain is provided in input, it will be used for classification, otherwise, we will search for the brand using the provided title.
- timeoutMS (integer) - Optional timeout in milliseconds for the request. If the request takes longer than this value, it will be aborted with a 408 status code. Maximum allowed value is 300000ms (5 minutes).
- minResults (integer) - Minimum number of NAICS codes to return. Must be at least 1. Defaults to 1.
- maxResults (integer) - Maximum number of NAICS codes to return. Must be between 1 and 10. Defaults to 5.

```bash
orth api run brand-dev /v1/brand/naics --query 'input=openai.com'
```

### Retrieve brand data by email address ($0.03)
Retrieve brand information using an email address while detecting disposable and free email addresses. This endpoint extracts the domain from the email address and returns brand data for that domain. Disposable and free email addresses (like gmail.com, yahoo.com) will throw a 422 error.

Parameters:
- email* (string<email>) - Email address to retrieve brand data for (e.g., 'contact@example.com'). The domain will be extracted from the email. Free email providers (gmail.com, yahoo.com, etc.) and disposable email addresses are not allowed.
- force_language (string) - Optional parameter to force the language of the retrieved brand data.
- maxSpeed (boolean) - Optional parameter to optimize the API call for maximum speed. When set to true, the API will skip time-consuming operations for faster response at the cost of less comprehensive data.
- timeoutMS (integer) - Optional timeout in milliseconds for the request. If the request takes longer than this value, it will be aborted with a 408 status code. Maximum allowed value is 300000ms (5 minutes).

```bash
orth api run brand-dev /v1/brand/retrieve-by-email --query 'email=john@stripe.com'
```

### Retrieve simplified brand data by domain ($0.03)
Returns a simplified version of brand data containing only essential information: domain, title, colors, logos, and backdrops. This endpoint is optimized for faster responses and reduced data transfer.

Parameters:
- domain* (string) - Domain name to retrieve simplified brand data for
- timeoutMS (integer) - Optional timeout in milliseconds for the request. If the request takes longer than this value, it will be aborted with a 408 status code. Maximum allowed value is 300000ms (5 minutes).

```bash
orth api run brand-dev /v1/brand/retrieve-simplified --query 'domain=notion.so'
```

### Retrieve brand data by ISIN ($0.03)
Retrieve brand information using an ISIN (International Securities Identification Number). This endpoint looks up the company associated with the ISIN and returns its brand data.

Parameters:
- isin* (string) - ISIN (International Securities Identification Number) to retrieve brand data for (e.g., 'AU000000IMD5', 'US0378331005'). Must be exactly 12 characters: 2 letters followed by 9 alphanumeric characters and ending with a digit.
- force_language (string) - Optional parameter to force the language of the retrieved brand data.
- maxSpeed (boolean) - Optional parameter to optimize the API call for maximum speed. When set to true, the API will skip time-consuming operations for faster response at the cost of less comprehensive data.
- timeoutMS (integer) - Optional timeout in milliseconds for the request. If the request takes longer than this value, it will be aborted with a 408 status code. Maximum allowed value is 300000ms (5 minutes).

```bash
orth api run brand-dev /v1/brand/retrieve-by-isin --query 'isin=US0378331005'
```

### Extract products from a brand's website ($0.03)
Beta feature: Extract product information from a brand’s website. Brand.dev will analyze the website and return a list of products with details such as name, description, image, pricing, features, and more.

Parameters:
- domain* (string) - The domain name to analyze
- maxProducts (integer) - Maximum number of products to extract.
- timeoutMS (integer) - Optional timeout in milliseconds for the request. If the request takes longer than this value, it will be aborted with a 408 status code. Maximum allowed value is 300000ms (5 minutes).

```bash
orth api run brand-dev /v1/brand/ai/products --body '{"domain": "stripe.com"}'
```

### Retrieve brand data by domain ($0.03)
Retrieve logos, backdrops, colors, industry, description, and more from any domain

Parameters:
- domain* (string) - Domain name to retrieve brand data for (e.g., 'example.com', 'google.com'). Cannot be used with name or ticker parameters.
- force_language (string) - Optional parameter to force the language of the retrieved brand data. Works with all three lookup methods.
- maxSpeed (boolean) - Optional parameter to optimize the API call for maximum speed. When set to true, the API will skip time-consuming operations for faster response at the cost of less comprehensive data. Works with all three lookup methods.
- timeoutMS (integer) - Optional timeout in milliseconds for the request. If the request takes longer than this value, it will be aborted with a 408 status code. Maximum allowed value is 300000ms (5 minutes).

```bash
orth api run brand-dev /v1/brand/retrieve --query 'domain=stripe.com'
```

### Retrieve brand data by company name ($0.03)
Retrieve brand information using a company name. This endpoint searches for the company by name and returns its brand data.

Parameters:
- name* (string) - Company name to retrieve brand data for (e.g., 'Apple Inc', 'Microsoft Corporation'). Must be 3-30 characters.
- force_language (string) - Optional parameter to force the language of the retrieved brand data.
- maxSpeed (boolean) - Optional parameter to optimize the API call for maximum speed. When set to true, the API will skip time-consuming operations for faster response at the cost of less comprehensive data.
- timeoutMS (integer) - Optional timeout in milliseconds for the request. If the request takes longer than this value, it will be aborted with a 408 status code. Maximum allowed value is 300000ms (5 minutes).

```bash
orth api run brand-dev /v1/brand/retrieve-by-name --query 'name=Stripe'
```

### Retrieve brand data by stock ticker ($0.03)
Retrieve brand information using a stock ticker symbol. This endpoint looks up the company associated with the ticker and returns its brand data.

Parameters:
- ticker* (string) - Stock ticker symbol to retrieve brand data for (e.g., 'AAPL', 'GOOGL', 'BRK.A'). Must be 1-15 characters, letters/numbers/dots only.
- ticker_exchange (string) - Optional stock exchange for the ticker. Defaults to NASDAQ if not specified.
- force_language (string) - Optional parameter to force the language of the retrieved brand data.
- maxSpeed (boolean) - Optional parameter to optimize the API call for maximum speed. When set to true, the API will skip time-consuming operations for faster response at the cost of less comprehensive data.
- timeoutMS (integer) - Optional timeout in milliseconds for the request. If the request takes longer than this value, it will be aborted with a 408 status code. Maximum allowed value is 300000ms (5 minutes).

```bash
orth api run brand-dev /v1/brand/retrieve-by-ticker --query 'ticker=AAPL'
```

### Extract design system and styleguide from website ($0.03)
Automatically extract comprehensive design system information from a brand’s website including colors, typography, spacing, shadows, and UI components.

Parameters:
- domain* (string) - Domain name to extract styleguide from (e.g., 'example.com', 'google.com'). The domain will be automatically normalized and validated.
- timeoutMS (integer) - Optional timeout in milliseconds for the request. If the request takes longer than this value, it will be aborted with a 408 status code. Maximum allowed value is 300000ms (5 minutes).
- prioritize (string) - Optional parameter to prioritize screenshot capture for styleguide extraction. If 'speed', optimizes for faster capture with basic quality. If 'quality', optimizes for higher quality with longer wait times. Defaults to 'quality' if not provided.

```bash
orth api run brand-dev /v1/brand/styleguide --query 'domain=linear.app'
```

### Take screenshot of website ($0.03)
Capture a screenshot of a website. Supports both viewport (standard browser view) and full-page screenshots. Can also screenshot specific page types (login, pricing, etc.) by using heuristics to find the appropriate URL. Returns a URL to the uploaded screenshot image hosted on our CDN.

Parameters:
- domain* (string) - Domain name to take screenshot of (e.g., 'example.com', 'google.com'). The domain will be automatically normalized and validated.
- fullScreenshot (string) - Optional parameter to determine screenshot type. If 'true', takes a full page screenshot capturing all content. If 'false' or not provided, takes a viewport screenshot (standard browser view).
- page (string) - Optional parameter to specify which page type to screenshot. If provided, the system will scrape the domain's links and use heuristics to find the most appropriate URL for the specified page type (30 supported languages). If not provided, screenshots the main domain landing page.
- prioritize (string) - Optional parameter to prioritize screenshot capture. If 'speed', optimizes for faster capture with basic quality. If 'quality', optimizes for higher quality with longer wait times. Defaults to 'quality' if not provided.

```bash
orth api run brand-dev /v1/brand/screenshot --query 'domain=github.com'
```

### Query website data using AI ($0.03)
Use AI to extract specific data points from a brand’s website. The AI will crawl the website and extract the requested information based on the provided data points.

Parameters:
- domain* (string) - The domain name to analyze
- data_to_extract* (object[]) - Array of data points to extract from the website
- timeoutMS (integer) - Optional timeout in milliseconds for the request. If the request takes longer than this value, it will be aborted with a 408 status code. Maximum allowed value is 300000ms (5 minutes).
- specific_pages (object) - Optional object specifying which pages to analyze

```bash
orth api run brand-dev /v1/brand/ai/query --body '{
  "domain": "anthropic.com",
  "data_to_extract": [{"name": "products", "description": "What products does this company offer?"}]
}'
```

## Use Cases

1. **Design Systems**: Extract brand colors, fonts, and styles
2. **Competitive Analysis**: Understand competitor branding
3. **Lead Enrichment**: Get company info from domains or emails
4. **Transaction Identification**: Identify companies from transaction data
5. **Market Research**: Classify and categorize companies

## Discover More

For full endpoint details and parameters:

```bash
orth api show brand-dev              # List all endpoints
orth api show brand-dev /v1/brand/fonts   # Get endpoint details
```
