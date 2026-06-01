---
name: retention-feedback
description: Turn what customer success hears after the sale into product and retention actions. Trigger when an onboarding note, QBR, support thread, or usage review surfaces adoption friction, a churn-risk signal, a feature request that blocks expansion, or a customer who's ready to grow — or when the user says "log this for product", "retention risk", "what's the churn signal", or "post-sale feedback".
---

# Retention Feedback

The loop that keeps the *post-sale* half of the motion connected to product — the half the funnel forgets. Sales→marketing is the loop everyone can see; this is its mirror on the right side of the bowtie. Field intelligence from onboarding, adoption, and renewal flows back to product and CS on a cadence, instead of dying in a QBR. This is the four-function version of the alignment thesis in [`docs/why-align.md`](../../../docs/why-align.md) — made concrete as a tagged line in the same shared log the `marketing-feedback` skill writes to.

From a source — an onboarding note, a usage review, a support thread, a renewal call, a deal update:

1. **Scan for the four signal types:**
   - **Adoption friction** — where customers stall between signing and getting value (the workflow they never turned on, the setup step that blocks them).
   - **Churn risk** — the real leading indicator: usage trending down, a champion gone quiet, a single-threaded account after a reorg.
   - **Expansion blocker / signal** — a missing feature that's holding back a renewal or a second department; or, the opposite, a customer asking for more unprompted.
   - **Renewal-loss reason** — the real one, logged, not remembered (people misdiagnose why accounts leave as often as why deals are lost).
2. **Log each as a tagged line** in the same daily log / feedback log marketing uses, so product and CS can act without a meeting:
   - `RETENTION-RISK: [account] — [the adoption/churn/blocker signal] → [product or CS action]`
   - `EXPANSION-SIGNAL:` when a healthy account is ready to grow (hand to sales with the CS context attached).
3. **Route, don't dump.** A feature request that blocks adoption goes to the *roadmap*, not the backlog void. A churn signal triggers the renewal motion early — day 60, not day 85. Don't tag every quiet week as a risk; tag it when usage, the champion, or the value story is actually slipping.

The tag *is* the hand-off. One file — the same one marketing reads — now carries both loops, so a post-sale signal can't quietly die any more than a field objection can. Product's job is to clear the `RETENTION-RISK` lines that are really roadmap; CS's job is to keep them honest and act on the renewal clock.

## Depth
- quick: scan one note, emit any `RETENTION-RISK` / `EXPANSION-SIGNAL` lines.
- standard: the full four-signal scan across recent post-sale notes, tagged and routed to product vs. CS.
- deep: + a one-line "what this means for the buyer" for the top signal, and the renewal-clock implication (when the motion should start).
