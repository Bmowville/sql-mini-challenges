# Challenge 018: Time to repeat purchase (1st → 2nd order)

Goal: For each customer who placed **at least 2 orders**, return the **first order date**, **second order date**, and **days between** them.

## Files
- `schema.sql` creates tables + inserts sample data
- `solution.sql` returns first/second purchase + days_to_second

## Run (SQLite)

Windows CMD:

```bat
type challenges\018_time_to_repeat\schema.sql challenges\018_time_to_repeat\solution.sql | sqlite3
```

## Output

Columns:
- customer_id
- customer_name
- first_order_date
- second_order_date
- days_to_second

Notes:
- Customers with only 1 order are excluded
- If a customer has multiple orders on the same day, we break ties by order_id