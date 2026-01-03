# Challenge 015: Sessionization (30-min inactivity)

Goal: convert an event stream into sessions per user. A new session starts if the gap from the prior event is > 30 minutes.

## Files
- `schema.sql` creates tables + inserts sample data
- `solution.sql` assigns sessions + returns session summaries

## Run (SQLite)

Windows CMD:

```bat
type challenges\015_sessionization\schema.sql challenges\015_sessionization\solution.sql | sqlite3
```

## Output

Columns:
- user_id
- session_num
- session_start
- session_end
- duration_min
- event_count
- pageviews