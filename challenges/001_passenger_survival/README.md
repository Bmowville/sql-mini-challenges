# Challenge 001: Passenger survival by class

Goal: Calculate survival rate by `sex` and `passenger_class` (Titanic-style aggregation).

## Files
- `schema.sql` creates the table + sample data
- `solution.sql` answers the question

## Run (SQLite)
```bash
sqlite3 :memory: < challenges/001_passenger_survival/schema.sql

sqlite3 :memory: < challenges/001_passenger_survival/solution.sql
```
