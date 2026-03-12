---
name: tako
description: Search and visualize the world's data - get charts, insights, and embeddable knowledge cards for finance, economics, demographics, sports, and more
---

# Tako Knowledge Search & Visualization

Search for data with natural language and get interactive charts, AI-generated insights, and embeddable knowledge cards. Covers finance, economics, demographics, sports, politics, climate, and health from sources like S&P Global, World Bank, and more.

## When to Use

- User asks a data question ("What's NVIDIA's revenue?", "US GDP growth?")
- User wants to compare metrics ("Tesla vs Ford market cap")
- User needs a chart or visualization for a report
- User wants to turn their own data into a chart
- User asks for insights or analysis on a data trend

## How It Works

Uses the Tako API to search curated data sources, generate knowledge cards with interactive charts, and extract AI-powered insights.

## Usage

### Search for Data (Knowledge Search)

Ask any data question in natural language. Returns knowledge cards with charts, images, and source attribution.

```bash
orth run tako /v1/knowledge_search -b '{"inputs": {"text": "NVIDIA vs AMD revenue since 2018"}}'
```

<details>
<summary>curl equivalent</summary>

```bash
curl -X POST "https://api.orth.sh/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"api":"tako","path":"/v1/knowledge_search","body":{"inputs":{"text":"NVIDIA vs AMD revenue since 2018"}}}'
```
</details>

#### With search effort and source options

```bash
orth run tako /v1/knowledge_search -b '{"inputs": {"text": "US inflation rate 2020-2025", "search_effort": "deep"}, "source_indexes": ["tako", "web"]}'
```

#### With dark mode images

```bash
orth run tako /v1/knowledge_search -b '{"inputs": {"text": "Bitcoin price history"}, "output_settings": {"knowledge_card_settings": {"image_dark_mode": true}}}'
```

### Get Chart Insights

Analyze any knowledge card and get AI-generated observations about trends, growth rates, and anomalies.

```bash
orth run tako /v1/beta/chart_insights -q 'card_id=sXQPVnixcDUf2Iw35Via'
```

<details>
<summary>curl equivalent</summary>

```bash
curl -X POST "https://api.orth.sh/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"api":"tako","path":"/v1/beta/chart_insights","query":{"card_id":"sXQPVnixcDUf2Iw35Via"}}'
```
</details>

### Visualize Your Own Data

Turn your datasets into charts. Provide data and a natural language description, and Tako picks the best visualization.

```bash
orth run tako /v1/beta/visualize -b '{"inputs": {"text": "Show quarterly revenue as a bar chart", "datasets": [{"name": "Revenue", "data": [{"quarter": "Q1 2024", "revenue_millions": 100}, {"quarter": "Q2 2024", "revenue_millions": 150}, {"quarter": "Q3 2024", "revenue_millions": 220}, {"quarter": "Q4 2024", "revenue_millions": 310}]}]}}'
```

<details>
<summary>curl equivalent</summary>

```bash
curl -X POST "https://api.orth.sh/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"api":"tako","path":"/v1/beta/visualize","body":{"inputs":{"text":"Show quarterly revenue as a bar chart","datasets":[{"name":"Revenue","data":[{"quarter":"Q1 2024","revenue_millions":100},{"quarter":"Q2 2024","revenue_millions":150},{"quarter":"Q3 2024","revenue_millions":220},{"quarter":"Q4 2024","revenue_millions":310}]}]}}}'
```
</details>

### Create a Custom Chart (Thin-Viz)

Build charts from scratch by specifying components directly. Full control over chart type and layout.

```bash
orth run tako /v1/thin_viz/create/ -b '{"components": [{"component_type": "header", "config": {"title": "Sales by Region"}}, {"component_type": "categorical_bar", "config": {"datasets": [{"label": "Revenue (M)", "data": [{"x": "US", "y": 500}, {"x": "EU", "y": 300}, {"x": "Asia", "y": 250}]}]}}], "title": "Sales by Region", "source": "Internal Data"}'
```

<details>
<summary>curl equivalent</summary>

```bash
curl -X POST "https://api.orth.sh/v1/run" \
  -H "Authorization: Bearer $ORTHOGONAL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"api":"tako","path":"/v1/thin_viz/create/","body":{"components":[{"component_type":"header","config":{"title":"Sales by Region"}},{"component_type":"categorical_bar","config":{"datasets":[{"label":"Revenue (M)","data":[{"x":"US","y":500},{"x":"EU","y":300},{"x":"Asia","y":250}]}]}}],"title":"Sales by Region","source":"Internal Data"}}'
```
</details>

### List Available Chart Types

See all available visualization templates before creating a custom chart.

```bash
orth run tako /v1/thin_viz/default_schema/
```

### Get Tako Tool Descriptions

Discover what data topics and metrics Tako can search across.

```bash
orth run tako /v1/tako_tools_description
```

## Parameters

### Knowledge Search (POST /v1/knowledge_search)

Body parameters:
- **inputs** (object, required) - Contains:
  - **text** (string, required) - Natural language query (e.g. "US GDP growth 2020-2024", "Tesla vs Ford market cap")
  - **search_effort** (string, optional) - "fast" for quick results, "medium" for balanced, "deep" for thorough research, "auto" to let Tako decide
- **source_indexes** (array, optional) - Source priority order: "tako" (curated S&P Global, World Bank data), "web" (web sources), "tako_deep_v2" (deeper research). Default: ["tako"]
- **country_code** (string, optional) - ISO 3166-1 alpha-2 code (e.g. "US", "GB"). Default: "US"
- **locale** (string, optional) - Locale string (e.g. "en-US", "de-DE"). Default: "en-US"
- **output_settings** (object, optional) - Set `{"knowledge_card_settings": {"image_dark_mode": true}}` for dark mode chart images

### Chart Insights (GET /v1/beta/chart_insights)

- **card_id** (string, required) - Knowledge card ID from a Knowledge Search or Create Card response

### Visualize Datasets (POST /v1/beta/visualize)

Body parameters:
- **inputs** (object, required) - Contains:
  - **text** (string, required) - Natural language instruction for visualization (e.g. "Show revenue by quarter as a bar chart")
  - **datasets** (array, required) - Array of dataset objects, each with "name" (string) and "data" (array of row objects with consistent keys)

### Create Card / Thin-Viz (POST /v1/thin_viz/create/)

Body parameters:
- **components** (array, required) - Array of component configs. Each needs:
  - **component_type** (string) - One of: header, generic_timeseries, categorical_bar, pie, scatter, table, choropleth, heatmap, histogram, boxplot, treemap, waterfall, bubble, financial_boxes, data_table_chart
  - **config** (object) - Type-specific configuration (use List Default Schemas to see required fields)
- **title** (string, optional) - Card title
- **description** (string, optional) - Card description
- **source** (string, optional) - Data source attribution for the footer

### List Default Schemas (GET /v1/thin_viz/default_schema/)

No parameters. Returns available chart templates: stock_card, timeseries_card, bar_chart, grouped_bar_chart, pie_chart, scatter_chart, bubble_chart, choropleth, heatmap, histogram, boxplot, treemap, waterfall, table, and more.

### Tool Descriptions (GET /v1/tako_tools_description)

- **index_ids** (string, optional) - Comma-separated index IDs to filter. Omit for all.

## Response

### Knowledge Search

Returns `data.outputs.knowledge_cards` array. Each card has:
- **card_id** (string) - Unique card ID (use for Chart Insights, embed URLs)
- **title** (string) - Chart title (e.g. "Nvidia, AMD - Total Revenues (Annual)")
- **description** (string) - Detailed text description of the data and trends
- **card_type** (string) - "chart", "table", "company", or "text"
- **webpage_url** (string) - Interactive card page on Tako
- **image_url** (string) - Static chart image URL (great for embedding in messages)
- **embed_url** (string) - Embeddable iframe URL
- **relevance** (string) - "High", "Medium", or "Low"
- **sources** (array) - Data sources with name and description (e.g. "S&P Global")
- **visualization_data** (object) - Raw chart data points

### Chart Insights

Returns `data` with:
- **insights** (array of strings) - AI-generated observations (e.g. "Tesla's revenue grew at 118% CAGR...")
- **description** (string) - Chart description

### Create Card / Thin-Viz

Returns `data` with:
- **card_id** (string) - Created card ID
- **title** (string) - Card title
- **webpage_url** (string) - Interactive card page
- **image_url** (string) - Static chart image URL
- **embed_url** (string) - Embeddable iframe URL

## Examples

**User:** "What's the US unemployment rate?"
```bash
orth run tako /v1/knowledge_search -b '{"inputs": {"text": "US unemployment rate"}}'
```

**User:** "Compare Apple, Microsoft, and Google revenue"
```bash
orth run tako /v1/knowledge_search -b '{"inputs": {"text": "Apple vs Microsoft vs Google revenue", "search_effort": "deep"}}'
```

**User:** "Give me insights on this chart" (after getting a card_id)
```bash
orth run tako /v1/beta/chart_insights -q 'card_id=sXQPVnixcDUf2Iw35Via'
```

**User:** "Make a pie chart of market share" (with your own data)
```bash
orth run tako /v1/thin_viz/create/ -b '{"components": [{"component_type": "header", "config": {"title": "Browser Market Share 2025"}}, {"component_type": "pie", "config": {"datasets": [{"data": [{"label": "Chrome", "value": 65}, {"label": "Safari", "value": 18}, {"label": "Firefox", "value": 8}, {"label": "Edge", "value": 5}, {"label": "Other", "value": 4}]}]}}], "source": "StatCounter"}'
```

**User:** "What data does Tako have?"
```bash
orth run tako /v1/tako_tools_description
```

## Tips

- **Knowledge Search** is the main endpoint. Start here for any data question.
- Use **Chart Insights** after search to get AI analysis of the results.
- Use **image_url** from responses to display charts in Slack, Discord, or other channels.
- **embed_url** gives you an interactive iframe you can embed in web pages.
- For custom charts, call **List Default Schemas** first to see what chart types and fields are available.
- Set `search_effort: "deep"` for complex multi-metric comparisons.
- Covers: stock prices, revenue, GDP, unemployment, population, sports stats, weather, health data, and much more.

## Error Handling

- **400** - Invalid request body or missing required fields
- **401** - Invalid or missing API key
- **404** - Card not found (for Chart Insights - verify card_id is correct)
- Empty `knowledge_cards` array means no results. Try rephrasing the query or using `source_indexes: ["tako", "web"]` for broader search.
