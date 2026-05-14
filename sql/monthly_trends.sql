CREATE TABLE monthly_trends AS
SELECT
    DATE_TRUNC('month', start_date) AS month,

    ROUND(SUM(spend)::numeric, 2) AS total_spend,

    SUM(clicks) AS total_clicks,

    SUM(conversions) AS total_conversions,

    ROUND(
        AVG(spend)::numeric,
        2
    ) AS avg_spend

FROM clean_campaigns
GROUP BY month
ORDER BY month;