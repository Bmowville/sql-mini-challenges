# Challenge 035: Subscription renewals + missed renewals + winback (within 30 days)

Assume a 30-day billing cycle.

Definitions:
- **on_time_renewal**: next payment is **25–35 days** after prior payment (tolerance window)
- **missed_renewal**: no on-time renewal after a payment
- **winback_30d**: after a missed renewal, the user pays again within **30 days after the expected renewal date**

## Files
- `schema.sql` creates the table + inserts sample data
- `solution.sql` outputs renewals, misses, and winbacks per user

## Run (SQLite)

Windows CMD:
```bat
type challenges\035_subscription_renewal_winback\schema.sql challenges\035_subscription_renewal_winback\solution.sql | sqlite3
```

## Output

Columns:
- user_id
- cycles
- on_time_renewals
- missed_renewals
- winbacks_30d