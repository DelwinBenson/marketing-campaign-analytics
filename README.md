# Marketing Campaign Analytics Pipeline & Power BI Dashboard

## Project Overview

This project is an end-to-end marketing analytics solution built using Python, PostgreSQL, SQL, and Power BI.

The workflow includes:

* Extracting raw campaign data from CSV files
* Cleaning and transforming data using Python (Pandas)
* Loading data into PostgreSQL
* Building a star schema with fact and dimension tables
* Creating interactive Power BI dashboards for business insights

The project simulates a real-world analytics engineering workflow and focuses on campaign performance analysis, channel optimization, conversion tracking, and trend analysis.

---

# Tech Stack

| Tool       | Purpose                        |
| ---------- | ------------------------------ |
| Python     | ETL Pipeline                   |
| Pandas     | Data Cleaning & Transformation |
| PostgreSQL | Data Warehouse                 |
| SQL        | Data Modeling & Analytics      |
| Power BI   | Dashboard & Visualization      |
| VS Code    | Development Environment        |

---

# Project Architecture

```text
CSV Dataset
    ↓
Python ETL Pipeline
    ↓
PostgreSQL Staging Table (raw_campaigns)
    ↓
SQL Transformations
    ↓
Fact & Dimension Tables
    ↓
Power BI Dashboards
```

---

# ETL Pipeline Features

## Extraction

* Reads campaign dataset from CSV
* Logs extraction details

## Data Cleaning

* Standardized column headers
* Cleaned currency formatting
* Standardized categorical values
* Parsed date columns
* Cleaned boolean values

## Validation

* Corrected invalid date logic
* Capped spend outliers using IQR method
* Performed load validation checks

## Feature Engineering

* Derived seasonal campaign categories

## Secure Configuration

* Database credentials managed using environment variables (`.env`)

---

# Data Warehouse Design

## Fact Table

* `fact_campaign_performance`

## Dimension Tables

* `dim_campaign`
* `dim_channel`
* `dim_date`

## Additional Analytical Tables

* `channel_performance`
* `campaign_rankings`
* `monthly_trends`
* `budget_segments`

---

# Power BI Dashboard Pages

## 1. Executive Marketing Overview

Provides high-level KPIs and campaign summaries.

### Key Metrics

* Total Spend
* Total Impressions
* Total Clicks
* Total Conversions
* Average CTR
* Average Conversion Rate

### Visuals

* Channel Spend Distribution
* Monthly Spend Trend
* Top Campaigns by Conversions

---

## 2. Channel Performance Dashboard

Analyzes marketing performance across channels.

### Insights

* Spend by Channel
* CTR by Channel
* Conversion Rate by Channel
* Channel Comparison Table

---

## 3. Campaign Analytics Dashboard

Campaign-level deep dive analysis.

### Insights

* Spend vs Conversion Correlation
* Top Campaigns by Spend
* Budget Distribution Analysis
* Campaign Ranking Table

---

## 4. Performance Trends Dashboard

Tracks monthly performance and trend analysis.

### Insights

* Monthly Spend Trends
* Monthly Conversion Trends
* CTR Trend Over Time
* Spend vs Conversion Trend

---

# Key Business Insights

* Facebook and TikTok generated the highest marketing spend.
* Conversion rates remained relatively stable across channels.
* High-budget campaigns contributed the majority of total spend.
* Increased spend generally correlated with increased conversions.
* Certain campaigns achieved significantly lower cost per conversion.

---

# Sample Dashboard Screenshots

## Executive Overview

![Executive Overview](screenshots/executive_overview.png)

## Channel Performance

![Channel Performance](screenshots/channel_performance.png)

## Campaign Analytics

![Campaign Analytics](screenshots/campaign_analytics.png)

## Performance Trends


![Performance Trends](screenshots/performance_trends.png)

---

# How to Run the Project

## 1. Clone Repository

```bash
git clone <your-repository-link>
```

---

## 2. Install Dependencies

```bash
pip install -r requirements.txt
```

---

## 3. Configure Environment Variables

Create a `.env` file:

```env
DB_USER=postgres
DB_PASSWORD=your_password
DB_HOST=localhost
DB_PORT=5432
DB_NAME=marketing_db
```

---

## 4. Run ETL Pipeline

```bash
python etl_pipeline.py
```

---

## 5. Execute SQL Scripts

Run SQL scripts inside PostgreSQL/pgAdmin to create analytical tables.

---

## 6. Open Power BI Dashboard

Open:

```text
marketing_campaign_dashboard.pbix
```

---

# Future Improvements

* Automate SQL transformations using Airflow/dbt
* Add incremental data loading
* Deploy dashboards to Power BI Service
* Add real-time streaming analytics
* Integrate cloud storage and cloud data warehouse

---

# Author

Delwin

Aspiring Data Engineer / Analytics Engineer
