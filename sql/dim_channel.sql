CREATE TABLE dim_channel AS
SELECT DISTINCT
    channel,
    campaign_tag
FROM clean_campaigns;
ALTER TABLE dim_channel
ADD PRIMARY KEY (channel);