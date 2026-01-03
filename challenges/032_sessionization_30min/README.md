# Challenge 032: Sessionization (30-minute inactivity gap)

Goal: split each user’s events into sessions. A new session starts when the gap from the previous event is **more than 30 minutes**.

## Files
- `schema.sql` creates the table + inserts sample data
- `solution.sql` assigns session ids and summarizes each session

## Run (SQLite)

Windows CMD:
```bat
type challenges\032_sessionization_30min\schema.sql challenges\032_sessionization_30min\solution.sql | sqlite3
```

## Output

Columns:
- user_id
- session_id
- session_start
- session_end
- events_in_session
- session_minutes