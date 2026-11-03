![Council Tax Collection Analysis](images/council-tax-banner.png)
# UK Council Tax Collection Analysis
*Financial performance of English local authorities | 2021–22 to 2025–26*

## Purpose
To investigate how effectively English councils collect council tax, identify persistent shortfalls, and highlight where finance teams may need to take a closer look.

## The Business Task
**Which councils consistently collect less council tax than expected, how has this changed over five years, and where should revenue managers focus their attention?**

This case study uses official data to answer that question and communicate the results through financial analysis and a Power BI dashboard.

**Audience:** Council finance directors, revenue managers and FP&A teams.  
**Tools:** Python · SQL · Power BI  
**Data:** [MHCLG Council Tax Statistics](https://www.gov.uk/government/collections/council-tax-statistics)

## STEP 1: COLLECT DATA
Obtain council tax collection data for five financial years (2021–22 to 2025–26). Document the source files and publication dates.

**Status:** Not started — source files and collection code will be linked here.

## STEP 2: CLEAN AND COMBINE DATA
Use Python to check missing values, standardise columns, reconcile council names and boundary changes, and create one analysis-ready dataset.

**Status:** Not started — cleaning scripts and validation checks will be linked here.

## STEP 3: ANALYSE COLLECTION PERFORMANCE
Use SQL to calculate and compare:
- **In-year collection rate:** Amount collected for the year's liability ÷ net collectable debit × 100
- **In-year shortfall:** Net collectable debit − amount collected for the year's liability
- **Persistent underperformance:** Below the national median collection rate for three consecutive *comparable* years

Examine year-on-year trends and arrears separately from in-year shortfalls.

**Status:** Not started — SQL queries and results will be added here.

## STEP 4: VISUALISE AND REPORT
Build a Power BI dashboard showing collection rates, shortfalls and performance by council. Summarise the main findings and implications for revenue management.

**Headline finding:** Coming soon.  
**Dashboard:** Coming soon.

## Project Progress
- [ ] Data collected and checked
- [ ] Python cleaning completed
- [ ] SQL analysis completed
- [ ] Power BI dashboard published
- [ ] Findings and recommendations documented

> **Limitations:** Council reorganisations (including Northamptonshire, Cumbria, North Yorkshire and Somerset) affect comparisons between years. We'll flag boundary changes and document revisions or provisional data. A collection shortfall does not, on its own, mean a council is in financial distress.

---
**[DataByKelly](https://github.com/Databykelly)** · Financial Analytics | Business Intelligence
