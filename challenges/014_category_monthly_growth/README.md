# Challenge 014: Category monthly growth

Goal: compute monthly revenue per category and month-over-month (MoM) growth per category.

## Files
- `schema.sql` creates tables + inserts sample data
- `solution.sql` returns monthly revenue per category + MoM growth

## Run (SQLite)

Windows CMD:
```bat
type challenges\014_category_monthly_growth\schema.sql challenges\014_category_monthly_growth\solution.sql | sqlite3
```

## Output

Columns:
- ym
- category
- revenue_usd
- prev_revenue_usd
- mom_growth_pct

Notes:
- First month per category has prev_revenue_usd = NULL and mom_growth_pct = NULL.

- mom_growth_pct is returned as a decimal (0.25 = 25%).