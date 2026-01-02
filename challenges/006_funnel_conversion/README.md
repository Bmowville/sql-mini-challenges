# Challenge 006: Funnel conversion rates

Goal: Count users at each funnel stage and compute conversion rates:
view → add_to_cart → purchase.

## Files
- `schema.sql` creates the `events` table and inserts sample data
- `solution.sql` returns stage counts + conversion rates

## Run (SQLite)
```bash
sqlite3 :memory: < challenges/006_funnel_conversion/schema.sql

sqlite3 :memory: < challenges/006_funnel_conversion/solution.sql
```
