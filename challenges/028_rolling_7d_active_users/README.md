# Challenge 028: Rolling 7-day active users (WAU) + DAU + new users + change %

Goal: for each day and country, compute:
- `dau` (active users that day)
- `wau_7d` (active users in last 7 days including that day)
- `new_users_7d` (users whose first-ever activity is within last 7 days)
- `new_user_share` = `new_users_7d / wau_7d`
- `wau_change_pct` = day-over-day % change in `wau_7d`

## Files
- `schema.sql` creates tables + inserts sample data
- `solution.sql` returns the metrics

## Run (SQLite)

Windows CMD:

```bat
type challenges\028_rolling_7d_active_users\schema.sql challenges\028_rolling_7d_active_users\solution.sql | sqlite3
```

## Output

Columns:
- day
- country
- dau
- wau_7d
- new_users_7d
- new_user_share
- wau_change_pct