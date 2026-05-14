CREATE TABLE fact_campaign_performance AS
SELECT
    campaign_id,
    channel,
    start_date,

    impressions,
    clicks,
    spend,
    conversions,

    ctr,
    conversion_rate,
    cost_per_conversion

FROM clean_campaigns;
-- campaign_id → dim_campaign
ALTER TABLE fact_campaign_performance
ADD CONSTRAINT fk_campaign
FOREIGN KEY (campaign_id)
REFERENCES dim_campaign(campaign_id);


-- channel → dim_channel
ALTER TABLE fact_campaign_performance
ADD CONSTRAINT fk_channel
FOREIGN KEY (channel)
REFERENCES dim_channel(channel);


-- start_date → dim_date
ALTER TABLE fact_campaign_performance
ADD CONSTRAINT fk_date
FOREIGN KEY (start_date)
REFERENCES dim_date(date);