---
name: support-signal
description: Cluster a batch of support tickets or threads into ranked product themes, then hand them to product-signal for the roadmap. Trigger when there's a pile of support tickets, or the user says "what are the tickets telling us", "cluster these tickets", "support themes", "top issues this month", or wants raw support volume turned into product feedback.
---

# Support Signal

The front-end to `product-signal`. A roadmap fed by raw tickets is noise; this clusters the volume into a few ranked themes first, so what reaches product is a pattern, not a pile. It reads a batch of tickets — from a support tool over MCP, or a pasted / `demo/support-tickets.md` list — and emits the themes `product-signal` routes.

From the batch:

1. **Cluster by the underlying job, not the wording.** Group tickets by what the customer was trying to do, not the words they used — three phrasings of "I can't get the data out" are one theme.
2. **Rank by frequency × severity.** How many accounts raised it, and how much it hurts — is it blocking adoption or a renewal, or is it a papercut? A one-off annoyance isn't a theme; a recurring blocker is. Rank the themes; don't route a flat list.
3. **Split the types.** Each theme is one of: **adoption friction** (a setup or UX gap — product), **feature request** (a missing capability — roadmap), **bug** (it's broken — engineering), or **how-to** (they couldn't find it — an *enablement / docs* gap, not a product one). The how-to pile is a signal too: it's where onboarding or the docs are failing.
4. **Tie themes to accounts.** Name which customers each theme touches — especially any tied to a renewal or an expansion. That tie is what lifts a theme above raw count.
5. **Hand the top themes to `product-signal`.** Emit each as a line it can triage into `ops/roadmap-signals.md` — `FEATURE-REQUEST` or adoption-friction, with the account tie — so the clustering and the routing compose into one loop (handoff H4 in [`docs/operating-model.md`](../../../docs/operating-model.md)).

Don't route every ticket; cluster first, route the pattern. The point is to turn volume into a short, ranked list product can actually act on.

## Depth
- quick: the top 3 themes, ranked, with counts.
- standard: the full clustering above — themes ranked, typed, tied to accounts, handed to product-signal.
- deep: + the how-to / enablement split (the themes that are really a docs or onboarding gap, routed there instead) and a buyer-facing line for any theme already shipped.
