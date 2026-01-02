# Challenge 008: Daily revenue with missing dates (date spine)

Goal: show every day in the date range, even if revenue is zero. Then compute a 7 day rolling sum and rolling average.

## Files
- `schema.sql` creates the table and inserts sample data
- `solution.sql` builds the date spine, fills missing days, and calculates rolling metrics

## Run (SQLite)

Windows CMD:
```bash
type challenges\008_daily_revenue_date_spine\schema.sql challenges\008_daily_revenue_date_spine\solution.sql | sqlite3
```

## Output

- order_date
- revenue_usd
- rolling_7d_revenue
- rolling_7d_avg
