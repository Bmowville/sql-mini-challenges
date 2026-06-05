# Contributing

Contributions should keep each challenge small, reproducible, and useful for analytics practice.

## Challenge Format
Each challenge belongs in `challenges/NNN_short_name/` and should include:

- `README.md` with the goal, files, expected output, and run command
- `schema.sql` with table definitions and sample data
- `solution.sql` with the final query

Use a three-digit challenge number and a lowercase folder name with underscores.

## SQL Style
- Prefer readable common table expressions over deeply nested queries.
- Keep sample data small enough to inspect manually.
- Include deterministic ordering in final outputs.
- Use SQLite-compatible syntax unless the README clearly calls out a Postgres-specific variation.
- Avoid external dependencies or setup beyond SQLite for core challenges.

## Validation
Before submitting a change, run the challenge from the repository root:

```bash
cat challenges/001_passenger_survival/schema.sql challenges/001_passenger_survival/solution.sql | sqlite3 -header -column :memory:
```

Replace the folder name with the challenge you changed.

The CI workflow also validates every `schema.sql` + `solution.sql` pair against SQLite.

## Adding a New Challenge
1. Pick the next available number.
2. Create the challenge folder and the three required files.
3. Add the challenge to the root README index.
4. Add it to a learning path when it fits an existing topic.
5. Run validation locally before opening a pull request.
