---
name: marketing-feedback
description: Turn what sales hears in the field into marketing actions. Trigger when a meeting note or call recap surfaces a recurring objection, a competitor mention, the buyer's own language, a missing proof point, or a win/loss reason — or when the user says "log this for marketing", "what should marketing know", or "field intel".
---

# Marketing Feedback

The loop that keeps sales and marketing as one system: field intelligence flows from sales back to marketing on a cadence, instead of dying inside a meeting note. This is mechanism #5 from [`docs/why-align.md`](../../docs/why-align.md) — made concrete as a tagged line in a shared log.

From a source — a note in `ops/daily-log.md`, a file in `demo/meetings/`, a call recap, a deal update:

1. **Scan for the five signal types:**
   - **Recurring objection** — the same pushback in 3+ conversations.
   - **Competitor mention** — who showed up, and how the buyer described them.
   - **Buyer language** — the words they actually used (use them in content; don't translate them into your own).
   - **Missing proof** — evidence they asked for that doesn't exist yet.
   - **Win/loss reason** — the real one, not the polite one.
2. **Log each as a tagged line** in the daily log, so marketing can act on it without a meeting:
   - `MARKETING-ACTION: [signal] — [the content or proof that would answer it]`
   - `MARKETING-ACTION-URGENT:` when a live deal was affected.
   - `MARKETING-STRATEGIC:` when it signals a positioning or new-segment shift.
3. **Don't invent signals.** One offhand comment isn't a pattern — tag it only when it recurs across deals or clearly cost one. A log full of false patterns is worse than an empty one.

The tag *is* the hand-off. One file, both functions read it — that's the loop, version-controlled, with a diff and a history. Marketing's job is to clear the `MARKETING-ACTION` lines; sales' job is to keep them honest and current.

## Depth
- quick: scan one note, emit any `MARKETING-ACTION` lines.
- standard: the full five-signal scan across recent notes, tagged and ranked by urgency.
- deep: + a one-line content brief for the top signal (who it's for, the claim to make, the proof to find).
