# Challenge 002: Top customers by total spend

Goal: Rank customers by total spend and return the top customers (window function).

## Files
- `schema.sql` creates tables + sample data
- `solution.sql` returns the ranked customers

## Run (SQLite)
```bash
cat schema.sql solution.sql | sqlite3 -header -column :memory:
```

Windows Command Prompt:
```bat
type schema.sql solution.sql | sqlite3 -header -column :memory:
```
