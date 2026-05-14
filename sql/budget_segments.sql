CREATE TABLE budget_segments AS
SELECT
    campaign_name,
    spend,

    CASE
        WHEN spend > 2000 THEN 'High Budget'
        WHEN spend > 1000 THEN 'Medium Budget'
        ELSE 'Low Budget'
    END AS budget_category

FROM clean_campaigns;