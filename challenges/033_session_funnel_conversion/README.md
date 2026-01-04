# Challenge 033: Session funnel conversion (view → add_to_cart → purchase)

Goal:
- Split events into sessions using a 30-minute inactivity gap
- For each session, check whether it contains the funnel steps:
  - `view`
  - `add_to_cart`
  - `purchase`
- Count funnel conversion by region, where steps must occur **within the same session**

## Files
- `schema.sql` creates tables + inserts sample data
- `solution.sql` returns session funnel conversion metrics by region

## Run (SQLite)

Windows CMD:
```bat
type challenges\033_session_funnel_conversion\schema.sql challenges\033_session_funnel_conversion\solution.sql | sqlite3
```

## Output

Columns:
- region
- sessions_total
- view_sessions
- cart_sessions (sessions with view + cart)
- purchase_sessions (sessions with view + cart + purchase)
- cart_rate_from_view
- purchase_rate_from_view
- purchase_rate_from_cart