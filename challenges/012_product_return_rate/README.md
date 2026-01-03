# Challenge 012: Product return rate

Goal: compute return rate per product as returned lines divided by purchased lines.

## Files
- `schema.sql` creates tables + inserts sample data
- `solution.sql` returns return rate per product

## Run (SQLite)

Windows CMD:
```bat
type challenges\012_product_return_rate\schema.sql challenges\012_product_return_rate\solution.sql | sqlite3
```

## Output

Columns:
- product_id
- product_name
- category
- purchased_lines
- returned_lines
- return_rate