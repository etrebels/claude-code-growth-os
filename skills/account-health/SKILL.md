---
name: account-health
description: Score a customer's health, start the renewal motion, and flag churn or expansion early. Trigger when the user asks "how's this account doing", "health check", "are we at risk of churn", "is this account ready to expand", or before a renewal or QBR.
---

# Account Health

The right-side operating skill — the equivalent of `lead-qualify` for the post-sale half of the bowtie. Where `lead-qualify` scores a deal's fit, this scores a *customer's* health: is value landing, is the renewal safe, is there room to grow? It reads the account book and writes the signal back into the same loop the field uses.

From `ops/customers.md` (or a single account the user names) and any recent post-sale notes:

1. **Read the adoption signal.** Against the account's value hypothesis — is the customer getting what they bought this to do? Usage trend, workflows live vs. in scope, who's actually using it.
2. **Score it green / amber / red:**
   - 🟢 **Green** — using it as intended, champion engaged, value visible.
   - 🟡 **Amber** — one warning sign (a stalled workflow, a quiet month, a single thread).
   - 🔴 **Red** — value not landing: usage down, champion gone quiet, or single-threaded after a change.
3. **Watch the renewal clock.** The renewal motion starts at **day 60**, not day 85. If the renewal date is inside 60 days, say so and start the motion now — don't wait for the contract to surface it.
4. **Flag churn early-warnings.** Name the leading indicators, not the lagging one: usage trending down, the champion gone quiet, a single-threaded account after a reorg. These precede a lost renewal; the cancellation is just when it becomes visible.
5. **Spot expansion-readiness.** A healthy account using the core well, or a second team asking unprompted, is an expansion signal — not a renewal risk.
6. **Write the signal to the loop and update the book.** Log a tagged line in the same feedback log marketing and product read:
   - `RETENTION-RISK: [account] — [the adoption/churn signal] → [CS or product action]`
   - `EXPANSION-SIGNAL: [account] — [the readiness signal] → hand to sales with CS context`

   Then update the account's stage, key signal, and next step in `ops/customers.md`.

Don't tag every quiet week as a risk — flag it when usage, the champion, or the value story is actually slipping. A book full of false alarms gets ignored.

## Depth
- quick: the green/amber/red call + the one signal driving it.
- standard: the full health read, renewal-clock check, and tagged loop line.
- deep: + the churn early-warning list, the expansion read, and the day-by-day renewal-motion timing.
