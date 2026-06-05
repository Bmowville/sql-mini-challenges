# Challenge 004 — Cohort retention

**Goal:** For each signup month (cohort), count how many users are active in month 0, 1, 2… after signup.

## Files
- `schema.sql` — creates `users` + `events` and inserts sample data
- `solution.sql` — returns `cohort | month_offset | active_users`

## Run (SQLite)
```bash
cat challenges/004_cohort_retention/schema.sql challenges/004_cohort_retention/solution.sql | sqlite3 -header -column :memory:
```

Windows Command Prompt:
```bat
type challenges\004_cohort_retention\schema.sql challenges\004_cohort_retention\solution.sql | sqlite3 -header -column :memory:
```
