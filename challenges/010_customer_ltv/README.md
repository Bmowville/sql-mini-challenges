# Challenge 010: Customer LTV

Goal: compute lifetime value (total revenue) per customer and rank customers by LTV.

## Files
- `schema.sql` creates tables + inserts sample data
- `solution.sql` returns LTV + order count + rank

## Run (SQLite)

Windows CMD:
```bash
type challenges\010_customer_ltv\schema.sql challenges\010_customer_ltv\solution.sql | sqlite3
```