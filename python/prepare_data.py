"""Download official council tax tables and build the council-year CSV."""

from io import BytesIO
from pathlib import Path
from urllib.request import urlopen

import pandas as pd

ASSETS = "https://assets.publishing.service.gov.uk/media/"
SOURCES = (
    (
        "66ea9df39975b7a980b304ab/Table_6_Council_Tax_and_non-domestic_rates_"
        "-_collection_amounts_and_rates__2021-22_and_2022-23.ods",
        "Table_6a",
        ("2021–22", "2022–23"),
    ),
    (
        "66e2f8cb718edd817713169b/Table_6_Council_Tax_and_non-domestic_rates_"
        "-_collection_amounts_and_rates__2022-23_and_2023-24__revised_.ods",
        "Table_6a",
        ("2022–23", "2023–24"),
    ),
    (
        "6a6b2fc98319ab05f7caa211/Table_6_2025-26.ods",
        "Table_6a_-_council_tax",
        ("2024–25", "2025–26"),
    ),
)
IDENTIFIERS = ["Authority", "E-Code", "ONS Code", "Class", "Region"]
MEASURES = ["Collectable (£000)", "Collected (£000)", "Collection Rate (%)"]
OUTPUT = Path(__file__).resolve().parents[1] / "data/processed/council_tax_2021-22_to_2025-26.csv"


def read_release(path, sheet, years):
    with urlopen(ASSETS + path, timeout=30) as response:
        workbook = pd.read_excel(BytesIO(response.read()), sheet_name=sheet, engine="odf", header=2)
    if list(workbook.columns[:5]) != IDENTIFIERS:
        raise ValueError(f"Unexpected identification columns in {path}")

    councils = workbook.loc[workbook["ONS Code"].str.fullmatch(r"E\d{8}", na=False)]
    for start, year in zip((5, 8), years):
        financial_headers = workbook.columns[start:start + 3].str.replace("–", "-")
        if len(financial_headers) != 3 or not all(year.replace("–", "-") in h for h in financial_headers):
            raise ValueError(f"Unexpected financial headings for {year} in {path}")

        table = councils.iloc[:, [0, 1, 2, 3, 4, start, start + 1, start + 2]].copy()
        table.columns = IDENTIFIERS + MEASURES
        # The published [z] rows have no figures for that authority-year.
        placeholders = table[MEASURES].eq("[z]").all(axis=1)
        table = table.loc[~placeholders].copy()
        table[MEASURES] = table[MEASURES].apply(pd.to_numeric)
        if table[MEASURES].isna().any().any():
            raise ValueError(f"Incomplete financial figures for {year} in {path}")
        table["Financial Year"] = year
        yield year, table


def main():
    annual_tables = {}
    for source in SOURCES:
        for year, table in read_release(*source):
            if year in annual_tables:
                earlier = annual_tables[year].set_index("ONS Code")[MEASURES].sort_index()
                later = table.set_index("ONS Code")[MEASURES].sort_index()
                pd.testing.assert_frame_equal(earlier, later, check_dtype=False, check_exact=True)
            else:
                annual_tables[year] = table

    result = pd.concat(annual_tables.values(), ignore_index=True)
    if result.duplicated(["ONS Code", "Financial Year"]).any():
        raise ValueError("Duplicate authority-year records")

    result["Shortfall (£000)"] = result["Collectable (£000)"] - result["Collected (£000)"]
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    result.to_csv(OUTPUT, index=False)
    print(f"Saved {len(result):,} rows to {OUTPUT}")


if __name__ == "__main__":
    main()
