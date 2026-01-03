# Challenge 031: Longest consecutive-day activity streak (gap & islands)

Goal: for each user, find the longest streak of consecutive active days.

## Files
- `schema.sql` creates the table + inserts sample data
- `solution.sql` finds each user’s longest consecutive-day streak

## Run (SQLite)

Windows CMD:
```bat
type challenges\031_longest_activity_streak\schema.sql challenges\031_longest_activity_streak\solution.sql | sqlite3
```

## Output

Columns:
- user_id
- longest_streak_days
- streak_start
- streak_end