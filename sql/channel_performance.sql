CREATE TABLE channel_performance AS
SELECT
    channel,

    COUNT(*) AS total_campaigns,

    SUM(impressions) AS total_impressions,

    SUM(clicks) AS total_clicks,

    ROUND(SUM(spend)::numeric,2) AS total_spend,

    SUM(conversions) AS total_conversions,

    ROUND(
        AVG(spend)::numeric,
        2
    ) AS avg_spend,

    ROUND(
        (SUM(clicks)::numeric / NULLIF(SUM(impressions),0)::numeric) * 100,
        2
    ) AS overall_ctr,

    ROUND(
        (SUM(conversions)::numeric /NULLIF(SUM(clicks),0)::numeric) * 100,
        2
    ) AS overall_conversion_rate

FROM clean_campaigns
GROUP BY channel;