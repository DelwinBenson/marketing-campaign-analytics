CREATE TABLE dim_campaign AS
SELECT DISTINCT
    campaign_id,
    campaign_name,
    season,
    start_date,
    end_date
FROM clean_campaigns;

ALTER TABLE dim_campaign
ADD PRIMARY KEY (campaign_id);