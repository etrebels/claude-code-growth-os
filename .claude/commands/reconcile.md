---
description: Reconcile drift — make the mirror, the tasks, and the log agree before they diverge.
---

# Reconcile

Catch the drift that creeps in when more than one session writes to the same files — you at the keyboard plus a scheduled [cloud routine](../scheduling/cloud-routines.md). Read first, then fix; never guess at what changed.

1. **Pipeline mirror vs CRM.** If a CRM is connected, re-read it and compare to `ops/pipeline.md` per [`.claude/rules/crm-usage.md`](../rules/crm-usage.md). On any conflict the CRM wins — rewrite the mirror. List what moved (`deal · field · mirror → CRM`).
2. **Tasks vs priorities.** Compare the one task list to `ops/priorities.md` (see [`.claude/rules/todo-single-source.md`](../rules/todo-single-source.md)). Flag any Top-3 item that's done, gone, or missing from the source list. The list is the source; `priorities.md` only *receives* the derived view.
3. **Log vs reality.** Check the newest `ops/daily-log.md` date against today and against `git log` since it. If days were worked but never logged, name them.
4. **Open loops.** Surface any `MARKETING-ACTION` / `RETENTION-RISK` line in `ops/feedback-log.md` that's past its cadence with no resolution.
5. **Fix the mechanical drift, surface the judgment calls.** Rewrite the mirror and correct stale dates yourself; for anything that needs a decision, list it and ask — don't auto-resolve it.

## Depth

- quick: just the mirror-vs-CRM reconcile.
- standard: all five checks.
- deep: add a drift-pattern note — which file drifts most often, and which ritual would stop it at the source.
