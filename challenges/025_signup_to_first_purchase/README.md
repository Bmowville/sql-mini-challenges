# Challenge 025: Signup → first purchase lag

Goal: compute the number of days between a user’s signup date and their first order date.
Also output overall average and median lag (median is the harder part).

## Files

- `schema.sql` creates tables + inserts sample data
- `solution.sql` returns per-user lag + a summary row

## Run (SQLite)

Windows CMD:

```bat
type challenges\025_signup_to_first_purchase\schema.sql challenges\025_signup_to_first_purchase\solution.sql | sqlite3
```

## Output

First result set (per user):
- user_id
- user_name
- signup_date
- first_order_date (NULL if never purchased)
- days_to_first_purchase (NULL if never purchased)