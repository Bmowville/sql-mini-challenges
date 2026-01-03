# Challenge 027: Weekly retention

Goal: show weekly active customers, how many were retained from the previous week, and the week-over-week retention rate.

## Files
- `schema.sql` creates tables + inserts sample data
- `solution.sql` returns weekly active + retained + retention rate

## Run (SQLite)

Windows CMD:
```bat
type challenges\027_weekly_retention\schema.sql challenges\027_weekly_retention\solution.sql | sqlite3
```

## Output

Columns:
- week_start
- active_customers
- prev_week_active
- retained_from_prev
- retention_rate