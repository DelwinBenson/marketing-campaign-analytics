CREATE TABLE dim_date AS
SELECT DISTINCT
    start_date AS date,

    EXTRACT(YEAR FROM start_date) AS year,

    EXTRACT(MONTH FROM start_date) AS month,

    EXTRACT(QUARTER FROM start_date) AS quarter

FROM clean_campaigns
WHERE start_date IS NOT NULL;
ALTER TABLE dim_date
ADD PRIMARY KEY (date);