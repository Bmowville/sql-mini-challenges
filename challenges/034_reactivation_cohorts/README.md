# Challenge 034: Reactivation cohorts (gap > 14 days) + next-month retention

Definition:
- A **reactivation** happens when a user has an event after being inactive for **more than 14 days**.
- The cohort is the **month** of the reactivation date (`YYYY-MM`).
- A user is **retained next month** if they have any event in the next calendar month.

## Files
- `schema.sql` creates table + inserts sample data
- `solution.sql` finds reactivations and next-month retention by cohort month

## Run (SQLite)

Windows CMD:
```bat
type challenges\034_reactivation_cohorts\schema.sql challenges\034_reactivation_cohorts\solution.sql | sqlite3
```

## Output

Columns:
- reactivation_month
- users_reactivated
- retained_next_month
- retention_rate_next_month