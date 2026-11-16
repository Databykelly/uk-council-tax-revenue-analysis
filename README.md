![Council Tax Collection Analysis](images/council-tax-banner.png.png)
# UK Council Tax Collection Analysis
*Financial performance of English local authorities | 2021–22 to 2025–26*

## Purpose
To investigate how effectively English councils collect council tax, identify persistent shortfalls, and highlight where finance teams may need to take a closer look.

## The Business Task
**Which councils consistently collect less council tax than expected, how has this changed over five years, and where should revenue managers focus their attention?**

This case study uses official collection statistics to compare council performance over five years.

**Audience:** Council finance directors, revenue managers and FP&A teams.  
**Tools:** Python · SQL · Power BI  
**Data:** [MHCLG Council Tax Statistics](https://www.gov.uk/government/collections/council-tax-statistics)

## STEP 1: COLLECT DATA

Downloaded and inspected three revised GOV.UK Table 6 workbooks covering five financial years. [2022–23 release](https://www.gov.uk/government/statistics/collection-rates-for-council-tax-and-non-domestic-rates-in-england-2022-to-2023) · [2023–24 release](https://www.gov.uk/government/statistics/collection-rates-for-council-tax-and-non-domestic-rates-in-england-2023-to-2024) · [2025–26 release](https://www.gov.uk/government/statistics/collection-rates-for-council-tax-and-non-domestic-rates-in-england-2025-to-2026)

## STEP 2: CLEAN AND COMBINE DATA

Reshaped the source tables into **1,506 council-year records**. Compared the overlapping 2022–23 releases by ONS code, retained one copy and excluded 17 placeholder rows for reorganised authorities in 2023–24. Checked that each ONS code and financial year pair was unique.

[Cleaned CSV](data/processed/council_tax_2021-22_to_2025-26.csv) · [Python preparation script](python/prepare_data.py)

## STEP 3: ANALYSE COLLECTION PERFORMANCE

**Started.** The SQL checks cover data quality, the England trend, Liverpool versus Manchester, and authorities below the annual council median for three consecutive years. Compare councils across years on consistent boundaries.

- **Collection rate (%)** = amount received for that year by 31 March ÷ net collectable debit × 100.
- **In-year shortfall (£)** = net collectable debit − amount received for that year by 31 March. Councils can recover some of this balance later.

[Liverpool's collection rate rose from 83.91% to 86.85%, while its year-end shortfall increased from £40.08m to £42.32m](sql/02_collection_performance.sql). The amount due grew over the same period.

## STEP 4: VISUALISE AND REPORT

Built exploratory Python charts for Liverpool, England and Manchester. The interactive Power BI report is planned.

## Run the project

1. From the repository root, run `python -m pip install -r requirements.txt` and `python python/prepare_data.py` to rebuild the CSV.
2. In MySQL 8+, create or select a schema using UTF-8 (`utf8mb4`). Run the `CREATE TABLE` statement in [01_validate.sql](sql/01_validate.sql).
3. In MySQL Workbench, use **Table Data Import Wizard** to load the CSV into the existing `council_tax` table. The CSV columns follow the table's order. Run the validation queries, then [02_collection_performance.sql](sql/02_collection_performance.sql).

Contains public sector information licensed under the [Open Government Licence v3.0](https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/).
