-- England's rate is based on total receipts divided by total collectable.
-- This reconstructs it from council rows, whose published amounts are rounded.
SELECT
    financial_year,
    ROUND(100.0 * SUM(collected_gbp_000)
          / NULLIF(SUM(collectable_gbp_000), 0), 2) AS england_rate_pct,
    ROUND(SUM(shortfall_gbp_000) / 1000.0, 2) AS england_shortfall_gbp_m
FROM council_tax
GROUP BY financial_year
ORDER BY financial_year;

-- Compare councils on the share collected and the amount outstanding.
SELECT
    authority,
    financial_year,
    ROUND(collection_rate_pct, 2) AS rate_pct,
    ROUND(collection_rate_pct - LAG(collection_rate_pct) OVER (
        PARTITION BY ons_code ORDER BY financial_year
    ), 2) AS change_pp,
    ROUND(shortfall_gbp_000 / 1000.0, 2) AS shortfall_gbp_m
FROM council_tax
WHERE ons_code IN ('E08000012', 'E08000003')
ORDER BY authority, financial_year;

-- Compare each council against its year's median. Flag three consecutive
-- below-median years for the same ONS code, without bridging gaps in coverage.
WITH ranked_rates AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY financial_year ORDER BY collection_rate_pct, ons_code
           ) AS rate_position,
           COUNT(*) OVER (PARTITION BY financial_year) AS year_count
    FROM council_tax
),
year_medians AS (
    SELECT financial_year, AVG(collection_rate_pct) AS median_rate
    FROM ranked_rates
    WHERE 2 * rate_position BETWEEN year_count AND year_count + 2
    GROUP BY financial_year
),
below_median AS (
    SELECT
        c.authority, c.ons_code, c.financial_year, c.collection_rate_pct, m.median_rate,
        CAST(SUBSTR(c.financial_year, 1, 4) AS SIGNED) AS start_year
    FROM council_tax AS c
    JOIN year_medians AS m ON c.financial_year = m.financial_year
    WHERE c.collection_rate_pct < m.median_rate
),
streaks AS (
    SELECT *,
           LAG(start_year, 2) OVER (
               PARTITION BY ons_code ORDER BY start_year
           ) AS two_observations_back
    FROM below_median
)
SELECT authority, ons_code, financial_year,
       ROUND(collection_rate_pct, 2) AS rate_pct,
       ROUND(median_rate, 2) AS median_rate_pct
FROM streaks
WHERE start_year - two_observations_back = 2
ORDER BY financial_year, rate_pct, authority;
