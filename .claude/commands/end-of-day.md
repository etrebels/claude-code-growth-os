---
description: Close the day — log what happened, tee up tomorrow.
---

# End of Day

> Generic chassis variant. If a private operating repo (e.g. your own growth-os) defines a command with this name, that version is canonical for that repo's data.

Close out the day:

1. Ask me what got done today (or infer it from `git log` since this morning) — across both sides of the bowtie: deals worked *and* post-sale touches (onboarding steps, adoption nudges, renewal/expansion moves, signals routed to product).
2. Append a dated entry to `ops/daily-log.md` (newest at the top): shipped, slipped, one thing learned. Log post-sale work alongside deals — a renewal call or an adoption fix counts the same as a deal advanced.
3. **Persist & reconcile the CRM.** Write the day's stage/score/note changes back per [`.claude/rules/crm-usage.md`](../rules/crm-usage.md), then reconcile the mirror — rewrite `ops/pipeline.md` from the CRM so tomorrow opens consistent. Skip if no CRM is connected.
4. **Lion check.** If a task keeps rolling forward behind a citable obstacle, name it plainly — a thing repeatedly deferred behind the same reason is usually avoidance, not a blocker. Decide: do it tomorrow, or drop it.
5. Draft tomorrow's top three into `ops/priorities.md`.
6. Confirm what you wrote — and log every CRM write (`object · field · old → new`). Keep it tight.

## Depth
- quick: log one line (shipped / slipped) and tomorrow's top item.
- standard: the full close above.
- deep: add what to stop doing and a 7-day pattern note.
