---
name: product-signal
description: Route post-sale and field signals into product's roadmap queue, and write the buyer-facing line for anything shipped. Trigger when the user says "what should product hear", "triage the roadmap signals", "route this to product", "feature request", or "what does this feature mean for the buyer".
---

# Product Signal

The product function's place in the loop. Marketing has `marketing-feedback`; CS has `account-health`; this is product's. It pulls the signals that should shape what gets built out of the shared log into product's own triage queue, and — for anything shipped — writes the one-line "what this means for the buyer" so a feature doesn't land silently. This closes handoffs **H4** (CS→product) and **H5** (product→GTM) in [`docs/operating-model.md`](../../docs/operating-model.md).

From the shared feedback log (`demo/feedback-log.md`, or your own) and `ops/customers.md`:

1. **Pull the product-shaped signals.** Three kinds belong on the roadmap, not in a meeting note:
   - `RETENTION-RISK` lines that are really a product gap — adoption friction or a missing capability, not a CS task.
   - `FEATURE-REQUEST` items that block an adoption or an expansion (the ones tied to a renewal or a second team).
   - Win/loss reasons that are about the *product*, not the deal — what we couldn't do that cost us, or won us, the deal.
2. **Route each into `ops/roadmap-signals.md`.** One row per signal: the source, the type, the account or pattern it's tied to, where it's routed, and a status (New → Routed → Shipped). This is product's working surface — distinct from the raw log it's pulled from.
3. **Wait for the pattern on anything ambiguous.** A single request isn't a roadmap item; a request that recurs across accounts, or one blocking a real renewal, is. Don't route noise.
4. **Close the loop on anything shipped.** For each item that ships, write the one-line buyer-facing translation in the last column: *what can the customer now do that they couldn't before* — in their language, not the release note's. Hand that line to GTM (it's what `marketing-feedback`'s readers and the deal follow-ups need). No feature ships without it — the antidote to building things no one adopts.

Don't promise a roadmap; this routes the signal and frames the outcome. The build decision is yours.

## Depth
- quick: pull the product-shaped signals from the log into `ops/roadmap-signals.md`.
- standard: the full triage above — routed, status-tagged, patterns separated from noise.
- deep: + the buyer-facing line for each shipped item, ready to hand to GTM.
