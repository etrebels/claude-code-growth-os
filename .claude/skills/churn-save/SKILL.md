---
name: churn-save
description: Turn a red/amber account into a recovery play — the real risk, the re-engagement outreach, the renewal-clock timing. Trigger when account-health flags a 🔴/🟡 account, when the user says "save this account", "they're going to churn", "the customer went quiet", "renewal at risk", or right after a RETENTION-RISK line is logged.
---

# Churn Save

The act-skill on the right side of the bowtie. `account-health` *detects* — it scores the account and writes the `RETENTION-RISK` line; this one *acts* on it. The split mirrors the left side, where `lead-qualify` scores and the pursuit skills work the deal. A save is re-earning the outcome the customer bought — not sending a warmer email.

From the at-risk row in `ops/customers.md`, the `RETENTION-RISK` line that flagged it, and any recent notes:

1. **Name the real risk, not the symptom.** The cancellation is the lagging indicator; the cause is upstream — usage trending down, the champion gone quiet, a single-threaded account after a reorg, or the value the deal was sold on never landing. Separate the one that's actually moving from the noise.
2. **Time the motion.** The renewal clock starts at **day 60**, not day 85. If the renewal date is inside 60 days, the save runs now, in parallel with the renewal — don't let the contract surface the risk for you.
3. **Re-thread if it's single-threaded.** If one name carried the account and that name went quiet, the save is a *second* relationship, not a better message to the first. Name who else to reach, and why they'd care.
4. **Draft the re-engagement.** Lead with their outcome — the metric the deal was bought to move — not "just checking in". One concrete next step, with a date. Offer to debrief any reply with `follow-up`.
5. **Route the cause if it's a product gap.** If a missing capability is what's blocking value, that's a `RETENTION-RISK` / `FEATURE-REQUEST` for product — hand it on with `product-signal` so the save and the roadmap move together (handoff H4 in [`docs/operating-model.md`](../../../docs/operating-model.md)).
6. **Log the play and update the book.** Record the play and its outcome; update the account's stage, signal, and next step in `ops/customers.md`. If it's lost anyway, log the *real* reason — `/retention-report`'s churn-by-reason read depends on it.

Don't paper a value miss over with a nicer email; a save the customer can see through costs you the reference too. And don't tag every quiet week as a churn — a book full of false alarms gets ignored.

## Depth
- quick: the real risk + the one next move.
- standard: the full play above — risk, timing, re-thread, the re-engagement draft, routed cause.
- deep: + the internal escalation note and the day-by-day renewal-motion timing to the renewal date.
