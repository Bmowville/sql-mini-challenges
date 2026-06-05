# Challenge 001: Passenger survival by class

Goal: Calculate survival rate by `sex` and `passenger_class` (Titanic-style aggregation).

## Files
- `schema.sql` creates the table + sample data
- `solution.sql` answers the question

## Run (SQLite)
```bash
cat schema.sql solution.sql | sqlite3 -header -column :memory:
```

Windows Command Prompt:
```bat
type schema.sql solution.sql | sqlite3 -header -column :memory:
```
