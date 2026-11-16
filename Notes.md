# Project Notes

## How to run the Python script

1. On the main GitHub page, click **Code → Download ZIP**.
2. Extract the ZIP and open the folder that contains `requirements.txt` and the `python` folder.
3. On Windows, click the address bar in File Explorer, type `cmd`, and press Enter. This opens Command Prompt in the project folder.
4. Install the Python packages:

   ```bash
   python -m pip install -r requirements.txt
   ```

5. Run the script:

   ```bash
   python python/prepare_data.py
   ```

The script downloads the three GOV.UK spreadsheets and rebuilds the cleaned CSV. When it finishes, look for `Saved 1,506 rows to` in the terminal. You can find the CSV in `data/processed/`.

[View the cleaned CSV](data/processed/council_tax_2021-22_to_2025-26.csv)

## SQL analysis

I’ll add the MySQL Workbench steps after I import the CSV and run the queries.

## Power BI report

I’ll add a link to the interactive report once it’s ready to share.
