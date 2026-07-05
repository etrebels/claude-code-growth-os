---
description: Monthly retention readout — NRR, GRR, churn by reason, and expansion, from the customer book in one page.
---

# Retention Report

> Generic chassis variant. If a private operating repo (e.g. your own growth-os) defines a command with this name, that version is canonical for that repo's data.

The monthly readout for the right side of the bowtie. `/weekly-review` reads the direction; this puts a number on it: are you keeping and growing the revenue you've already won, or filling a leaking bucket? It rolls the account book up to the one number the whole motion answers to — net revenue retention.

From `ops/customers.md` (the account book, with its `ARR` column) and its git history over the period:

1. **Set the period and the starting base.** Default to the trailing month (or quarter). The cohort is the accounts you held at the *start* of the period — reconstruct their starting ARR from the book's git history (`git show <commit-as-of-period-start>:ops/customers.md`). New logos signed mid-period don't count toward retention.
2. **Compute GRR and NRR — from the numbers, never eyeballed.** Name the formula, then compute:
   - **GRR** (gross revenue retention) = (starting ARR − downgrades − churn) ÷ starting ARR. Caps at 100% — it's the floor, what you keep *before* any expansion.
   - **NRR** (net revenue retention) = (starting ARR + expansion − downgrades − churn) ÷ starting ARR. Above 100% means the base grew without a single new logo.
   - If the book doesn't carry `ARR` yet, say so and report the **count-based** picture instead (logos retained / at-risk / churned / expanded) — and add the column so next month computes.
3. **Churn by reason.** Group the accounts lost or downgraded this period by the *real* reason — value miss, champion exit, budget, product gap, fit. Use the same reasons `churn-save` logs. The reason column is the roadmap for retention; counts without reasons can't be acted on.
4. **Expansion.** Which accounts grew, by how much, and off what trigger — the `EXPANSION-SIGNAL`s `expansion-signal` worked. Net expansion is what carries NRR above 100%.
5. **The one read.** State it plainly: is the base net-expanding or net-leaking? Below 100% NRR means acquisition spend is filling a leaking bucket ([`docs/operating-model.md`](../../docs/operating-model.md) — the one number). One line.
6. **Next month's two bets.** The single biggest retention risk to clear and the single biggest expansion to chase. Write them to the top of `ops/priorities.md`.

Lead with the two numbers and the one read. Don't pad it, and don't invent a number the book can't support — an honest count beats a confident guess. If a CRM is your system of record for ARR, reconcile against it per [`.claude/rules/crm-usage.md`](../rules/crm-usage.md) — read-only beyond what the daily rituals already persisted.

## Depth
- quick: NRR, GRR, and the one read.
- standard: the full report above — both numbers, churn by reason, expansion, next month's two bets.
- deep: + month-over-month trend on each number, the logo-vs-revenue retention split, and the cohort detail behind the move.
