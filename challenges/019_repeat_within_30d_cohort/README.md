# Challenge 019: Repeat purchase within 30 days (cohort by first purchase month)

Goal: Group customers by the **month of their first purchase** (the cohort), then compute what fraction of that cohort made a **second purchase within 30 days**.

## Files
- `schema.sql` creates tables + inserts sample data
- `solution.sql` returns cohort repeat-within-30d rate

## Run (SQLite)

Windows CMD:

```bat
type challenges\019_repeat_within_30d_cohort\schema.sql challenges\019_repeat_within_30d_cohort\solution.sql | sqlite3
```

## Output

Columns:
- cohort_month
- customers_in_cohort
- repeat_within_30d
- repeat_rate_30d