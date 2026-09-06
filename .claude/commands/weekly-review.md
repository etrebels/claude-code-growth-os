---
description: Weekly review — read the week's logs, surface patterns, set next week's one priority.
---

# Weekly Review

> Generic chassis variant. If a private operating repo (e.g. your own growth-os) defines a command with this name, that version is canonical for that repo's data.

Run an honest weekly review across the whole motion — both sides of the bowtie.

**Left side (demand → close):**

1. Read the last seven entries in `ops/daily-log.md`.
2. Summarize the week: what shipped, what stalled, any pattern worth naming. Read each channel or effort by the *quality* of relationships it surfaced, not only headline volume — one deep, high-fit relationship can be the whole return on an effort that looks thin by the numbers.
3. Clear the loop: surface any open `MARKETING-ACTION` lines in `ops/feedback-log.md` that haven't been acted on.

**Right side (post-sale — read `ops/customers.md`):**

4. **Renewals due** in the next 30 / 60 / 90 days. Flag any inside 60 days — that's when the renewal motion starts (not day 85).
5. **Accounts at risk.** List anything at 🔴/🟡 — usage down, champion quiet, single-threaded — and the next step for each.
6. **Adoption stalls.** Accounts stuck between onboarding and live (a workflow never turned on, a setup step blocking them).
7. **Expansion candidates.** Healthy accounts ready to grow — hand to sales with the CS context.
8. **Top roadmap signals.** The highest-priority items in `ops/roadmap-signals.md` — what product should hear, and anything shipped that still needs its buyer-facing line.

**Then:**

9. **Ownership read.** For each live area on both sides, check it has an owner who treats the number as theirs — not just what moved this week. An area no one owns is the pattern to fix first.
10. **Chokepoint read** (`ops/chokepoints.md`). Walk the short list of narrow dependencies most of the revenue flows through. Two questions: has anything changed hands or become more concentrated this week, and does every row still have a named owner? A row carried unresolved for **3+ reviews is re-rated, not dropped** — sitting there longer earns more attention, not less. Use the same list as a news filter: market noise touching nothing on it gets no time in this review.
11. Pick next week's single most important priority and write it to the top of `ops/priorities.md`.
12. **Name one thing to stop doing — and write the sentence that makes it a prune.** Removal is fast and visible while building is slow and invisible, so teams drift toward cutting and call it discipline. Before anything comes off: *"this is cut so that **X** specifically improves, measured by **Y**, checked on `<date>`."* **No sentence, no cut.** Log the check date and read it when it arrives — an unverified cut is a dismantling, not a prune.

Lead with the summary. Don't pad it. If `ops/customers.md` or `ops/roadmap-signals.md` is empty, say so and skip that section. Reconcile the pipeline mirror against the CRM per [`.claude/rules/crm-usage.md`](../rules/crm-usage.md) — read-only beyond what the daily rituals already persisted.

## Depth
- quick: the week's three-line summary, renewals/risks inside 60 days, and next week's one priority.
- standard: the full review above, both sides.
- deep: add month-over-month patterns, a stop-doing list, and an NRR-direction read (are accounts net expanding or net leaking?).

## Once a quarter, add these two

- **The advantages you didn't earn.** Name the three inputs that drove results this quarter which nobody here created or controls — a market tailwind, a partner referring for no contractual reason, an open regulatory window, an inherited pricing position. Give each a named maintainer and a signal that it's going away. Unearned inputs are the ones you stop noticing, and what you stop noticing you stop protecting. Cross-check against `ops/chokepoints.md`: anything on **both** lists is load-bearing *and* unowned — the quarter's top risk.
- **Check the origin record still exists and is being read.** The playbook is an abstraction of the motion that won the first customers, and it sheds load-bearing parts unless the reasons stay attached. Confirm the first-ten-customers account (who they were, the pitch actually used, the objections, what each bad deal changed) is written down and lands in onboarding *before* playbook training. The tell that it's decaying: someone can run a qualification rule fluently but can't say which deal produced it.
