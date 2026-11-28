---
description: Mid-day reset — what's done, what's slipping, what to protect this afternoon.
---

# Midday Check-in

> Generic chassis variant. If a private operating repo (e.g. your own growth-os) defines a command with this name, that version is canonical for that repo's data.

A quick reset. In order:

1. Read `ops/priorities.md` and today's top three (from this morning's `/morning-briefing`, or the latest `ops/daily-log.md` entry).
2. Mark what's done. Flag anything at risk of not happening today.
3. Name the one thing that must happen this afternoon — and protect time for it. (It can be a deal or a post-sale move — whichever is most at risk of slipping.)

Keep it to a few lines. No recap of things already finished. If a deal moved this morning, persist the stage/score change per [`.claude/rules/crm-usage.md`](../rules/crm-usage.md) — safe writes only.

## Depth
- quick: the one thing that must happen this afternoon.
- standard: the full reset above.
- deep: re-rank the afternoon against the week's priorities, not just today's.

## Closing step — record the run (never skip)

A run that died and a run with nothing to say must not look alike. Finish by writing the outcome to disk, from the repo root:

```bash
bash .claude/scripts/routine-state.sh ok midday-checkin "<what landed — one short line>"
```

That writes `ops/runs/midday-checkin.last`, clears any `FAILED-` marker, and returns an `OK` line. Print that line last, so the run output ends with proof it finished.

If the ritual could not complete — a source unreachable, a write that would not land, a step that needs you — record that instead, and say what blocked it:

```bash
bash .claude/scripts/routine-state.sh fail midday-checkin "<what blocked it>"
```

The `FAILED-` marker stays on disk until the next good run of this ritual, and every session start reads it. **Recording a failure is this ritual finishing correctly; leaving nothing behind is the failure.**
