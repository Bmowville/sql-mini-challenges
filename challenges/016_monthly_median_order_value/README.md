# Challenge 016: Monthly median order value

Goal: compute the median order value per month in SQLite (median is not built-in, so we use window functions).

## Files
- `schema.sql` creates tables + inserts sample data
- `solution.sql` returns median order value per month

## Run (SQLite)

Windows CMD:

```bat
type challenges\016_monthly_median_order_value\schema.sql challenges\016_monthly_median_order_value\solution.sql | sqlite3
```

## Output

Columns:
- ym
- median_order_value