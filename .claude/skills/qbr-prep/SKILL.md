---
name: qbr-prep
description: Turn a customer's recent calls, adoption signal, and roadmap status into a QBR brief that leads with the outcome they bought. Trigger when a quarterly business review is coming up, before a renewal or value-review call, or when the user says "QBR prep", "build the QBR", "quarterly review for X", or "value review".
---

# QBR Prep

The recurring right-side ritual. A QBR isn't a status meeting or a feature tour — it's a *value-realization review*: did the customer get the outcome they bought, and what's the next one? This assembles the brief from what's already in the repo, so the review leads with their metric, not your release notes.

From the account in `ops/customers.md`, its recent meeting notes (in `ops/` or `demo/meetings/`), and `ops/roadmap-signals.md`:

1. **Outcome recap — lead here.** State the value hypothesis the deal was bought on, then the evidence it's landing: the adoption signal, what's live, who's using it. Their metric, their words. This is the spine of the brief; everything else hangs off it.
2. **Risks, named first.** What isn't landing yet — a stalled workflow, a quiet stretch, a single-threaded relationship — said before the customer raises it. Naming the gap yourself is what makes the recap credible.
3. **What shipped for them.** Pull anything in `ops/roadmap-signals.md` tied to this account that's now Shipped, with its buyer-facing line. "You asked, we shipped" closes the loop the customer started (handoff H5 in [`docs/operating-model.md`](../../../docs/operating-model.md)) and earns the next ask.
4. **The next desired outcome.** Frame the expansion thesis as *their* next goal — the adjacent team or use case — not a quota. If it's real, this is the seed `expansion-play` works after the QBR.
5. **One ask, one offer.** A single ask (a reference, a case study, an intro) and a single offer (an expansion, a new team, a deeper rollout). More than one of each dilutes both.

Output a brief you can walk in with. Don't invent outcomes the notes don't support — a QBR that claims value the customer didn't feel is the fastest way to lose the renewal.

## Depth
- quick: the one-page brief — outcome recap, top risk, the one ask.
- standard: the full brief above, ready to present from.
- deep: + a slide-ready outline to hand to a deck tool, and the expansion thesis written up for `expansion-play`.
