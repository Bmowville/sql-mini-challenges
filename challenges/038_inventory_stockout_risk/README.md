# Challenge 038: Inventory stockout risk

Goal: flag products that may stock out based on recent sales velocity, current inventory, lead time, and the next open purchase order.

Use an as-of date of `2024-05-15`.

Rules:
- `net_available_units` = on hand units minus reserved units
- `recent_7d_units` = units sold from `2024-05-09` through `2024-05-15`
- `avg_daily_units` = `recent_7d_units / 7`
- `days_of_cover` = `net_available_units / avg_daily_units`
- Risk is `critical` when days of cover is at or below lead time, or net availability is at or below safety stock
- Risk is `watch` when days of cover is within 7 days after lead time
- Products with no recent demand should be labeled `no_recent_demand`

## Files
- `schema.sql` creates product, inventory, sales, and purchase order tables
- `solution.sql` computes stockout risk per product

## Run (SQLite)

Windows CMD:
```bat
type challenges\038_inventory_stockout_risk\schema.sql challenges\038_inventory_stockout_risk\solution.sql | sqlite3
```

## Output

Columns:
- product_id
- sku
- net_available_units
- recent_7d_units
- avg_daily_units
- days_of_cover
- next_open_po_date
- risk_level