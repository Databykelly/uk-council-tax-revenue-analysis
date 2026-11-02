# UK Council Tax Collection Performance Analysis

**Business question:** Which English local authorities face persistent council tax collection shortfalls, and where should finance teams focus their attention?

## The problem

Council tax helps fund local public services. But councils do not always collect everything owed within the financial year. For example, collecting £94 million against £100 million due leaves a £6 million **in-year collection shortfall**. Some of that money may be recovered later.

Finance managers need to know **where collection performance is deteriorating**, whether the problem persists, and which authorities merit further investigation. This project uses five financial years of official statistics (2021–22 to 2025–26) to answer those questions.

## What we'll investigate

| Business question | Measure |
| --- | --- |
| How much is collected? | Council tax due and in-year receipts |
| Where are shortfalls greatest? | Amount and percentage uncollected |
| Is performance improving? | Year-on-year collection-rate changes |
| Which councils lag consistently? | Collection rates below the annual national median for **three consecutive comparable years** |
| What remains outstanding? | Year-end council tax arrears, where comparable |

**Core metrics:** In-year collection rate = receipts for the year's liability ÷ net collectable debit × 100. In-year shortfall = net collectable debit − receipts for that year's liability.

## Approach and deliverables

Using **Python**, we'll collect, clean and validate the data; **SQL** will support trends and benchmarking; and **Power BI** will turn the findings into a management dashboard. The final deliverables will include reproducible scripts, a cleaned dataset, financial comparisons, a dashboard and a short executive summary.

**Audience:** Council finance directors, revenue managers and FP&A teams.

**Source:** [MHCLG council tax statistics](https://www.gov.uk/government/collections/council-tax-statistics).

## Progress

- [ ] Obtain and validate five annual datasets
- [ ] Clean and reconcile authority identifiers (Python)
- [ ] Analyse collection performance (SQL)
- [ ] Build and validate the dashboard (Power BI)
- [ ] Publish key findings and recommendations

**Headline findings:** To be added after analysis.

### Important limitations

Council reorganisations (including Northamptonshire, Cumbria, North Yorkshire and Somerset) affect comparisons over time. We'll flag or adjust breaks in authority boundaries rather than treat them as real performance changes. In-year shortfalls differ from total arrears, and a low collection rate **does not by itself prove financial distress**. We'll document source revisions and any provisional figures.

---

**[DataByKelly](https://github.com/Databykelly)** · Financial Analytics | Business Intelligence | Decision Support
