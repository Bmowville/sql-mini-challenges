# Challenge 036: SCD Type 2 customer dimension (history table)

Input: customer change events over time.

Goal: build a dimension history table with:
- `effective_start` = change date
- `effective_end` = day before the next change date (or NULL if current)
- `is_current` = 1 for the latest row per customer

## Files
- `schema.sql` creates the input change table + sample data
- `solution.sql` outputs SCD Type 2 history rows

## Run (SQLite)

Windows CMD:
```bat
type challenges\036_scd2_customer_dimension\schema.sql challenges\036_scd2_customer_dimension\solution.sql | sqlite3
```

## Output

Columns:
- customer_id
- tier
- region
- effective_start
- effective_end
- is_current