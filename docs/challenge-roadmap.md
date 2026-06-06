# Challenge Roadmap

This roadmap collects practical SQL challenge ideas that would fit the repo. It is meant to help people request, discuss, or contribute new challenges without starting from a blank page.

If you want to suggest one of these, open a [challenge request](https://github.com/Bmowville/sql-mini-challenges/issues/new?template=challenge_request.yml). If you want to build one, use the [contributing guide](../CONTRIBUTING.md) and include validation output in the pull request.

## Good Next Challenges

| Idea | Skill area | What the query should answer |
| --- | --- | --- |
| First-touch attribution | Product analytics | Which acquisition channel should receive credit for a customer's first purchase? |
| Rolling funnel drop-off | Funnel analysis | Where does conversion fall week over week across view, cart, checkout, and purchase events? |
| Late-arriving facts | Data engineering SQL | Which staged facts arrived after the reporting cutoff and need a correction load? |
| Slowly changing product prices | Data modeling | Which product price was effective at the time each order was placed? |
| Support backlog aging | Operations analytics | Which support queues are breaching age targets by priority and owner? |

## Recently Added

| Challenge | Skill area | Focus |
| --- | --- | --- |
| [038 Inventory stockout risk](../challenges/038_inventory_stockout_risk) | Product operations | Sales velocity, lead time, and inventory risk scoring |
| [039 Trial to paid conversion](../challenges/039_trial_to_paid_conversion) | SaaS metrics | Cohort conversion windows and new MRR rollups |
| [040 Revenue leakage audit](../challenges/040_revenue_leakage_audit) | Data quality | Invoice, payment, refund, and exception reconciliation |

## Contribution Fit

A strong new challenge usually has:

- A clear business question that can be answered in one final query.
- Small sample data that still covers edge cases.
- Deterministic output with an explicit `ORDER BY`.
- A README that explains the question, expected result, and run command.
- SQLite-compatible SQL unless the challenge calls out a Postgres-specific pattern.

## Useful Issue Labels

- `challenge`: a request for a new SQL challenge or analytics pattern.
- `bug`: broken command, unclear expected output, or incorrect snapshot.
- `good first issue`: small fixes, README clarity, or one contained challenge idea.
- `help wanted`: larger challenge ideas where the schema or expected output needs discussion.

## What Not To Add

- Large datasets that make manual review difficult.
- Vendor-specific SQL without a clear reason.
- Challenges that need a paid service or cloud account.
- Queries with nondeterministic output order.