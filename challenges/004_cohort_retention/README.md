# Challenge 004 — Cohort retention

**Goal:** For each signup month (cohort), count how many users are active in month 0, 1, 2… after signup.

## Files
- `schema.sql` — creates `users` + `events` and inserts sample data
- `solution.sql` — returns `cohort | month_offset | active_users`

## Run (SQLite)
```bash
cat schema.sql solution.sql | sqlite3 -header -column :memory:
```

Windows Command Prompt:
```bat
type schema.sql solution.sql | sqlite3 -header -column :memory:
```
