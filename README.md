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
**Data source:** Ministry of Housing, Communities and Local Government (MHCLG) Council Tax Statistics, licensed under the Open Government Licence v3.0. [MHCLG Council Tax Statistics](https://www.gov.uk/government/collections/council-tax-statistics)

## STEP 1: COLLECT DATA

I used Python’s `requests` library to download three official GOV.UK spreadsheets. I used `pathlib` to set up the project folder and `shutil` to save copies of the original files in Google Drive. Together, the three files covered all five financial years, from 2021–22 to 2025–26.

[2022–23 release](https://www.gov.uk/government/statistics/collection-rates-for-council-tax-and-non-domestic-rates-in-england-2022-to-2023) · [2023–24 release](https://www.gov.uk/government/statistics/collection-rates-for-council-tax-and-non-domestic-rates-in-england-2023-to-2024) · [2025–26 release](https://www.gov.uk/government/statistics/collection-rates-for-council-tax-and-non-domestic-rates-in-england-2025-to-2026)

## STEP 2: CLEAN AND COMBINE DATA

I used Python’s `pandas` library with `odfpy` to open the spreadsheets. In `pandas`, I combined the figures into one table with one row per council per financial year. I checked that the figures for 2022–23 matched across the two files and kept one copy. I left out 17 rows with no figures for 2023–24 after some councils were reorganised, then checked that no council appeared twice in the same year. I calculated how much council tax was still uncollected at year-end and saved the finished table as a CSV with **1,506 rows and 10 columns**.

[Cleaned CSV](data/processed/council_tax_2021-22_to_2025-26.csv) · [Python preparation script](python/prepare_data.py)

## STEP 3: ANALYSE COLLECTION PERFORMANCE

**Next step.** I will use SQL to analyse the cleaned CSV and answer this business question:

**Which councils consistently collect less council tax than expected, how has this changed over five years, and where should revenue managers focus their attention?**

## Run the project

1. From the repository root, run `python -m pip install -r requirements.txt` and `python python/prepare_data.py` to rebuild the CSV.
2. In MySQL 8+, create or select a schema using UTF-8 (`utf8mb4`). Run the `CREATE TABLE` statement in [01_validate.sql](sql/01_validate.sql).
3. In MySQL Workbench, use **Table Data Import Wizard** to load the CSV into the existing `council_tax` table. The CSV columns follow the table's order. Run the validation queries, then [02_collection_performance.sql](sql/02_collection_performance.sql).

Contains public sector information licensed under the [Open Government Licence v3.0](https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/).
