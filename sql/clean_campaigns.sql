CREATE TABLE clean_campaigns AS
SELECT
    campaign_id,
    campaign_name,
    start_date,
    end_date,
    
    CASE
        WHEN channel IS NULL AND campaign_tag = 'FA' THEN 'Facebook'
        WHEN channel IS NULL AND campaign_tag = 'TI' THEN 'TikTok'
        WHEN channel IS NULL AND campaign_tag = 'IN' THEN 'Instagram'
        WHEN channel IS NULL AND campaign_tag = 'EM' THEN 'Email'
        WHEN channel IS NULL AND campaign_tag = 'GO' THEN 'Google Ads'
        WHEN channel IS NULL THEN 'Unknown'
        ELSE channel
    END AS channel,
    impressions,
    clicks,
    spend,
    conversions,
    active,

    CASE
        WHEN channel = 'Facebook' AND campaign_tag != 'FA' THEN 'FA'
        WHEN channel = 'TikTok' AND campaign_tag != 'TI' THEN 'TI'
        WHEN channel = 'Instagram' AND campaign_tag != 'IN' THEN 'IN'
        WHEN channel = 'Email' AND campaign_tag != 'EM' THEN 'EM'
        WHEN channel = 'Google Ads' AND campaign_tag != 'GO' THEN 'GO'
        WHEN campaign_tag NOT IN ('FA','TI','IN','EM','GO') THEN 'UNKNOWN'
        ELSE campaign_tag
    END AS campaign_tag,

    season,

    ROUND(
        (clicks::numeric /NULLIF(impressions,0)::NUMERIC) * 100,
        2
    ) AS ctr,

    ROUND(
        (conversions::numeric / NULLIF (clicks,0)::NUMERIC) * 100,
        2
    ) AS conversion_rate,

    ROUND(
        spend::NUMERIC / NULLIF(conversions, 0)::NUMERIC,
        2
    ) AS cost_per_conversion

FROM raw_campaigns;