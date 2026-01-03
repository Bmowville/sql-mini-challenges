# Challenge 017: Longest purchase streak (consecutive months)

Goal: For each customer, find the longest streak of consecutive months with at least one purchase.

## Files
- `schema.sql` creates tables + inserts sample data
- `solution.sql` returns longest streak length per customer

## Run (SQLite)

Windows CMD:

```bat
type challenges\017_longest_purchase_streak\schema.sql challenges\017_longest_purchase_streak\solution.sql | sqlite3
```

## Output

Columns:
- customer_id
- longest_streak_months