---
description: Weekly review — read the week's logs, surface patterns, set next week's one priority.
---

# Weekly Review

Run an honest weekly review across the whole motion — both sides of the bowtie.

**Left side (demand → close):**

1. Read the last seven entries in `ops/daily-log.md`.
2. Summarize the week: what shipped, what stalled, any pattern worth naming.
3. Clear the loop: surface any open `MARKETING-ACTION` lines in the feedback log that haven't been acted on.

**Right side (post-sale — read `ops/customers.md`):**

4. **Renewals due** in the next 30 / 60 / 90 days. Flag any inside 60 days — that's when the renewal motion starts (not day 85).
5. **Accounts at risk.** List anything at 🔴/🟡 — usage down, champion quiet, single-threaded — and the next step for each.
6. **Adoption stalls.** Accounts stuck between onboarding and live (a workflow never turned on, a setup step blocking them).
7. **Expansion candidates.** Healthy accounts ready to grow — hand to sales with the CS context.
8. **Top roadmap signals.** The highest-priority items in `ops/roadmap-signals.md` — what product should hear, and anything shipped that still needs its buyer-facing line.

**Then:**

9. Pick next week's single most important priority and write it to the top of `ops/priorities.md`.
10. Name one thing to stop doing.

Lead with the summary. Don't pad it. If `ops/customers.md` or `ops/roadmap-signals.md` is empty, say so and skip that section. Reconcile the pipeline mirror against the CRM per [`.claude/rules/crm-usage.md`](../rules/crm-usage.md) — read-only beyond what the daily rituals already persisted.

## Depth
- quick: the week's three-line summary, renewals/risks inside 60 days, and next week's one priority.
- standard: the full review above, both sides.
- deep: add month-over-month patterns, a stop-doing list, and an NRR-direction read (are accounts net expanding or net leaking?).
