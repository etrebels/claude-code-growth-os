# `ops/runs/` — did the ritual actually run?

A ritual that died half-way and a ritual with nothing to say used to look
identical from here: silence. That is the failure this folder ends.

Every scheduled ritual finishes by recording its own outcome:

| File | Written when | Cleared when |
|---|---|---|
| `<ritual>.last` | the ritual completes | overwritten by the next good run |
| `FAILED-<ritual>.md` | the ritual cannot complete | the next good run of that ritual |

`<ritual>.last` is one tab-separated line — UTC timestamp, the commit it ran
against, and a short note on what it left behind. `FAILED-…` records what broke,
and it **stays on disk until a good run removes it**, so a failure cannot
quietly become last week's problem.

## Why the markers are committed

A cloud routine starts from a fresh clone every run. State that is not in git
does not exist to it, so these files travel with the repo.

## Reading it

```bash
bash .claude/scripts/routine-state.sh status   # the full table
bash .claude/scripts/routine-state.sh due      # only what is overdue or failing
```

The schedule they are judged against is `.claude/scripts/routines.tsv` — one row
per ritual, with its cadence and its grace period. Adding a ritual is a row
there, never an edit to the script. Delete the rows you do not run.

`run-state-surface.sh` runs `due` at every session start, so the first thing a
session knows is which ritual is failing — counted off disk each time, never
remembered from last time.

## The rule this serves

*No ritual assumes the previous one happened.* Each ritual reads what the last
one wrote; without these markers, a skipped one is invisible to everything
downstream of it.
