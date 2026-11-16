-- Run once, then import the CSV into this table in column order.
CREATE TABLE IF NOT EXISTS council_tax (
    authority VARCHAR(120) NOT NULL,
    e_code VARCHAR(16) NOT NULL,
    ons_code CHAR(9) NOT NULL,
    council_class VARCHAR(40) NOT NULL,
    region VARCHAR(16) NOT NULL,
    collectable_gbp_000 DECIMAL(15, 3) NOT NULL,
    collected_gbp_000 DECIMAL(15, 3) NOT NULL,
    collection_rate_pct DECIMAL(18, 12) NOT NULL,
    financial_year VARCHAR(7) NOT NULL,
    shortfall_gbp_000 DECIMAL(15, 3) NOT NULL,
    PRIMARY KEY (ons_code, financial_year)
);

-- Expected counts: 309, 309, 296, 296, 296.
SELECT financial_year, COUNT(*) AS council_year_rows
FROM council_tax
GROUP BY financial_year
ORDER BY financial_year;

-- Expected: zero rows. Allow for rounding in the published inputs and rates.
SELECT ons_code, financial_year, collection_rate_pct, shortfall_gbp_000
FROM council_tax
WHERE collectable_gbp_000 <= 0
   OR shortfall_gbp_000 <> collectable_gbp_000 - collected_gbp_000
   OR ABS(collection_rate_pct
          - 100.0 * collected_gbp_000 / NULLIF(collectable_gbp_000, 0)) > 0.02;
