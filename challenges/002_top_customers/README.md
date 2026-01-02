# Challenge 002: Top customers by total spend

Goal: Rank customers by total spend and return the top customers (window function).

## Files
- `schema.sql` creates tables + sample data
- `solution.sql` returns the ranked customers

## Run (SQLite)
```bash
sqlite3 :memory: < challenges/002_top_customers/schema.sql

sqlite3 :memory: < challenges/002_top_customers/solution.sql
```
