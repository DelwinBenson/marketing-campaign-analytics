DROP TABLE IF EXISTS campaign_rankings;

CREATE TABLE campaign_rankings AS
SELECT
    campaign_name,
    channel,
    spend,

    RANK() OVER (
        ORDER BY spend DESC
    ) AS spend_rank

FROM clean_campaigns;