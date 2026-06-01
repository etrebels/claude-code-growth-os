# Rule: one to-do list, rendered one way

**The bug this prevents.** A briefing grows its *own* way of grouping the to-do
list — "due today," sorted by project — that drifts from how the list is shown at
session start. Now the same tasks render two different ways depending on how you
entered, and you can't trust either. The fix is a single canonical render spec that
every entry path defers to.

This file **is** that spec. It owns *how the to-do list is queried and displayed*.
Nothing else re-derives it.

## The query + render contract

1. **One source for the list.** The open task set comes from the **task tool**
   (your task manager, or [`ops/priorities.md`](../../ops/priorities.md) if you
   haven't connected one) — one place, queried one way.
2. **Pull the whole open set; don't pre-filter at query time.** Fetch *all* open
   tasks. Do **not** query for "due today" or "this project" at the source — that
   filter is exactly what makes two sessions show different lists.
3. **Derive urgency at render, not at query.** "Due today," "overdue," "top three"
   are *views* computed from the full set when you display it. Same input set every
   time → same list every time, whoever's asking.
4. **Render the same shape everywhere.** Newest/by-due ordering, the same grouping,
   the same fields — defined once, here.

## Everything defers to this spec

Keep this defer-list current. If you add a path that shows tasks, add it here and
point it back at this rule rather than letting it grow its own grouping:

- The **SessionStart hook** ([`session-start.sh`](../hooks/session-start.sh)) — what
  you see when a session opens.
- [`/morning-briefing`](../commands/morning-briefing.md),
  [`/midday-checkin`](../commands/midday-checkin.md),
  [`/end-of-day`](../commands/end-of-day.md),
  [`/weekly-review`](../commands/weekly-review.md), and
  [`/demo-briefing`](../commands/demo-briefing.md).
- **Cloud routines** — the unattended runs of the rituals above
  ([`../scheduling/cloud-routines.md`](../scheduling/cloud-routines.md)). A routine
  is the most important entry to keep on this list: it can't notice that its list
  diverged from yours.

## Routines compose around the list — they never fork it

A ritual adds *context* around the one list; it does not re-render the list:

- **Compose:** wrap the list with the CRM read (deals — via
  [`crm-usage.md`](crm-usage.md)) and calendar context (what's on today). That's
  additive.
- **Don't fork:** never re-group, re-filter, or re-sort the tasks into a second
  arrangement. The Top 3 a briefing produces is a *derived view*, not a new list.

## Three lanes feed the brief — keep them straight

The same separation as [`crm-usage.md`](crm-usage.md), from the to-do angle:

| Lane | Role in the brief |
|---|---|
| **Task tool** | The **list** — the open set, the single source rendered here. |
| **CRM** | **Deals** — feeds the brief and the priorities, but is *not* the task list. Deals don't become tasks automatically. |
| **Priorities file** ([`ops/priorities.md`](../../ops/priorities.md)) | The derived **"Top 3" output** a ritual writes — a *render target*, never a source you query back as if it were the full list. |

The trap is treating the priorities file as a second source: a routine reads its own
Top-3 output, re-ranks it, and now it disagrees with the task tool. The priorities
file only ever *receives* the derived view; the task tool is the source.

## See also

- [`crm-usage.md`](crm-usage.md) — the deal lane, and why tasks and deals stay apart.
- [`../scheduling/cloud-routines.md`](../scheduling/cloud-routines.md) — the routines
  that must defer to this spec rather than each rendering the list their own way.
