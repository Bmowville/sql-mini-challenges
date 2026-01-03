# Challenge 013: Monthly revenue growth (MoM %)

Goal: compute monthly revenue and month-over-month (MoM) growth percent.

## Files
- `schema.sql` creates tables + inserts sample data
- `solution.sql` returns monthly revenue + previous month revenue + MoM growth %

## Run (SQLite)

Windows CMD:

```bat
type challenges\013_monthly_revenue_growth\schema.sql challenges\013_monthly_revenue_growth\solution.sql | sqlite3
```

## Output

Columns:
- ym
- revenue_usd
- prev_revenue_usd
- mom_growth_pct (NULL for first month)