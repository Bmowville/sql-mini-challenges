# Challenge 040: Revenue leakage audit

Goal: reconcile completed orders against payments and refunds, then label revenue issues by priority.

This is the hardest challenge in the current set. It combines order totals, discounts, tax, successful payments, duplicate payment references, completed refunds, and variance classification.

Issue priority:
1. `missing_payment`
2. `duplicate_payment`
3. `underpaid`
4. `overpaid`
5. `ok`

Only non-`ok` orders should appear in the final output.

## Files
- `schema.sql` creates order, item, discount, payment, and refund tables
- `solution.sql` calculates expected order amounts and compares them with collected cash

## Run (SQLite)

Windows CMD:
```bat
type challenges\040_revenue_leakage_audit\schema.sql challenges\040_revenue_leakage_audit\solution.sql | sqlite3
```

## Output

Columns:
- order_id
- expected_amount
- successful_payments
- duplicate_successful_payments
- completed_refunds
- net_collected
- variance
- issue_type