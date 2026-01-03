# Challenge 029: Cohort weekly retention (rolling 4-week)

Goal: For each signup cohort week + region, compute weekly retention and a rolling 4-week average retention.

## Files
- `schema.sql` creates tables + inserts sample data
- `solution.sql` returns cohort-week retention + rolling 4-week retention

## Run (SQLite)

Windows CMD:
```bat
type challenges\029_cohort_weekly_retention_rolling\schema.sql challenges\029_cohort_weekly_retention_rolling\solution.sql | sqlite3
```

## Output

Columns:
- cohort_week
- region
- week_n
- active_users
- cohort_size
- retention_rate
- rolling_4wk_retention