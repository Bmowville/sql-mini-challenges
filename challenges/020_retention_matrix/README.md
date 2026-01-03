# Challenge 020: Retention matrix (cohort month x month number)

Goal: Create a retention table showing **active users** for each signup cohort by **months since signup**.

## Files
- `schema.sql` creates tables + sample data
- `solution.sql` returns retention counts

## Run (SQLite)

Windows CMD:

```bat
type challenges\020_retention_matrix\schema.sql challenges\020_retention_matrix\solution.sql | sqlite3
```

## Output

Columns:
- cohort_month (YYYY-MM)
- month_number (0 = signup month)
- active_users