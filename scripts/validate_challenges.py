import argparse
import json
import sqlite3
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[1]
CHALLENGES_DIR = ROOT / "challenges"
EXPECTED_FILE = "expected.json"


def require(condition: bool, message: str) -> None:
    if not condition:
        raise AssertionError(message)


def challenge_dirs() -> list[Path]:
    return sorted(
        path
        for path in CHALLENGES_DIR.iterdir()
        if path.is_dir() and (path / "schema.sql").exists() and (path / "solution.sql").exists()
    )


def split_statements(sql: str) -> list[str]:
    statements: list[str] = []
    buffer = ""

    for line in sql.splitlines(keepends=True):
        buffer += line
        if sqlite3.complete_statement(buffer):
            statement = buffer.strip()
            if statement:
                statements.append(statement)
            buffer = ""

    if buffer.strip():
        statements.append(buffer.strip())

    return statements


def normalize_value(value: Any) -> Any:
    if isinstance(value, float):
        return round(value, 10)
    return value


def run_challenge(challenge_dir: Path) -> dict[str, Any]:
    schema = (challenge_dir / "schema.sql").read_text(encoding="utf-8")
    solution = (challenge_dir / "solution.sql").read_text(encoding="utf-8")

    with sqlite3.connect(":memory:") as connection:
        connection.executescript(schema)
        result_sets = []

        for statement in split_statements(solution):
            cursor = connection.execute(statement)
            if cursor.description is None:
                continue

            columns = [description[0] for description in cursor.description]
            rows = [[normalize_value(value) for value in row] for row in cursor.fetchall()]
            result_sets.append({"columns": columns, "rows": rows})

    require(result_sets, f"{challenge_dir.name}: solution produced no result sets")

    return {
        "challenge": challenge_dir.name,
        "result_sets": result_sets,
    }


def load_expected(challenge_dir: Path) -> dict[str, Any]:
    expected_path = challenge_dir / EXPECTED_FILE
    require(expected_path.exists(), f"{challenge_dir.name}: missing {EXPECTED_FILE}")
    return json.loads(expected_path.read_text(encoding="utf-8"))


def write_expected(challenge_dir: Path, output: dict[str, Any]) -> None:
    expected_path = challenge_dir / EXPECTED_FILE
    expected_path.write_text(
        json.dumps(output, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
    )


def validate_challenge(challenge_dir: Path, write: bool) -> None:
    actual = run_challenge(challenge_dir)

    if write:
        write_expected(challenge_dir, actual)
        print(f"wrote {challenge_dir.name}/{EXPECTED_FILE}")
        return

    expected = load_expected(challenge_dir)
    require(
        actual == expected,
        f"{challenge_dir.name}: actual output does not match {EXPECTED_FILE}",
    )
    print(f"validated {challenge_dir.name}")


def main() -> None:
    parser = argparse.ArgumentParser(description="Validate SQL challenge outputs")
    parser.add_argument(
        "--write-expected",
        action="store_true",
        help="Regenerate expected.json snapshots from current solutions",
    )
    args = parser.parse_args()

    challenges = challenge_dirs()
    require(challenges, "No challenges found")

    for challenge_dir in challenges:
        validate_challenge(challenge_dir, write=args.write_expected)

    if args.write_expected:
        print(f"wrote expected outputs for {len(challenges)} challenges")
    else:
        print(f"validated expected outputs for {len(challenges)} challenges")


if __name__ == "__main__":
    main()