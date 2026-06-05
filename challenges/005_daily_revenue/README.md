# Challenge 005: Daily revenue (7-day rolling)

Goal: Calculate daily revenue and a 7-day rolling total (or average) using window functions.

## Files
- `schema.sql` creates tables + sample data
- `solution.sql` returns daily revenue + rolling metric

## Run (SQLite)
```bash
cat schema.sql solution.sql | sqlite3 -header -column :memory:
```

Windows Command Prompt:
```bat
type schema.sql solution.sql | sqlite3 -header -column :memory:
```
