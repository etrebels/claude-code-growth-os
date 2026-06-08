---
name: onboarding-handoff
description: Run the Won→onboarding handoff — the seam most teams drop. Trigger when a deal is marked won/closed-won, when the user says "we won X", "hand this off to onboarding", "kick off the new customer", or "onboarding checklist".
---

# Onboarding Handoff (Won → onboarding)

The handoff most teams never define: a signed deal drops silently into a customer-success void, the value the buyer was sold gets lost, and the renewal clock starts late. This is handoff **H3** in [`docs/operating-model.md`](../../../docs/operating-model.md) — made concrete as a 48-hour checklist that turns a won deal into the first row of the account book.

From the won deal (point me at the row in `ops/pipeline.md`, or paste the deal context):

1. **Carry the value hypothesis forward.** Write down, in one line, what the customer bought this to do — in their words, from discovery. This becomes the value hypothesis in `ops/customers.md`, and the thing every adoption check is measured against. Lose it here and onboarding optimizes for activity, not value.
2. **Set the date markers.** Record the renewal date, the contract value (ARR — the number the book rolls up to NRR), and note the **day-60** renewal-motion trigger (not day-85). Set a first-expansion check date too — the moment to look for a second team or use case.
3. **Identify the power user / champion.** Name who will actually use it and who sponsors it internally. A single-threaded account is a churn risk before it's even live — if there's only one name, that's the first gap to close.
4. **Write the first adoption milestone.** One concrete, dated outcome that proves value is landing (the first workflow live, the first cross-system answer, the first report shipped). Vague onboarding has no finish line.
5. **Open the row.** Create the account in `ops/customers.md` at stage **Onboarding**, with the value hypothesis, the ARR, the first adoption signal to watch, the renewal date, an owner, and the next step. Offer to log the handoff in `ops/daily-log.md`.

Don't invent commitments the deal didn't contain. Bring your own onboarding playbook; this carries the deal's context across the seam so nothing drops.

## Depth
- quick: open the `ops/customers.md` row with value hypothesis, renewal date, and owner.
- standard: the full 48-hour checklist above.
- deep: + a single-threading risk read and the first two adoption milestones with dates.
