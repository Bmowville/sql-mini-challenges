# Challenge 005: Daily revenue (7-day rolling)

Goal: Calculate daily revenue and a 7-day rolling total (or average) using window functions.

## Files
- `schema.sql` creates tables + sample data
- `solution.sql` returns daily revenue + rolling metric

## Run (SQLite)
```bash
sqlite3 :memory: < challenges/005_daily_revenue/schema.sql

sqlite3 :memory: < challenges/005_daily_revenue/solution.sql
```
