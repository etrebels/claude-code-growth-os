# Rule: using a CRM over MCP

**Scope.** This rule governs *how* a session reads and writes a CRM reached through
an [MCP](../../README.md#make-it-yours) server — the access protocol and the
write-authority guardrails. The *projection* mechanics (hydrating the CRM into
[`ops/pipeline.md`](../../ops/pipeline.md), find-or-create, stage-ID mapping,
paging) live in [`docs/connecting-a-crm.md`](../../docs/connecting-a-crm.md) and
aren't repeated here. Read that first; this rule is what keeps an **unattended**
run from doing damage with the access it has.

> Generic by design. Wire the specifics — your CRM's endpoints, field names, and
> option IDs — into a private skill or gitignored config, never into this repo.

## Three lanes — don't merge them

Three systems each own one kind of truth. Keeping them separate is what stops a
routine from, say, turning a deal note into a duplicate task.

| Lane | Owns | Example tool |
|---|---|---|
| **Task tool** | *What to do* — the to-do list | your task manager (e.g. Notion, Linear) |
| **Meeting-notes tool → wiki** | *What was said* — transcripts, summaries | your notetaker |
| **CRM (via MCP)** | *What changed about the deal* — stage, qualification scores, opportunity fields, deal notes | your CRM |

- **Tasks stay single-homed in the task tool.** Routines do **not** create CRM
  tasks — that forks the to-do list into two places (see
  [`todo-single-source.md`](todo-single-source.md)).
- The CRM is the system of record for *deals*; [`ops/pipeline.md`](../../ops/pipeline.md)
  is a **mirror** of it. On any conflict, the CRM wins and the mirror is rewritten.

## Docs-first access protocol

For a CRM whose MCP server is **documentation-driven** (it exposes its own API docs
rather than a fixed tool per field), never guess a path. Follow the chain every
time:

1. **Discover** — list the available docs paths / endpoint families.
2. **Fetch the schema** — get the exact request/response shape for the one endpoint
   you need, using only a path returned by step 1.
3. **Read or write only via discovered paths** — with the parameters and body the
   schema specified. An API path you didn't get from the docs is a guess; don't
   send it.
4. **Resolve a self-scoped identity when needed** — for "my deals / my accounts,"
   resolve the current-user identity from the server rather than assuming an ID.

Two things bite every time, so make them habits:

- **Resolve select-option IDs from the schema's definitions endpoint on every run.**
  Pipeline stages, qualification tiers, and other dropdowns are **org-specific** and
  change. Writing a stage *label* where the API wants an option *ID* fails silently.
- **Dedup before create.** Search by name first; find-or-create, never blind-create.
  (The mechanics are in [`connecting-a-crm.md`](../../docs/connecting-a-crm.md).)

## Write-authority guardrails

These exist because a [cloud routine](../scheduling/cloud-routines.md) runs
**autonomously** — there's no one to catch a bad write mid-run. Every write obeys
all six:

1. **Read before write.** Fetch the current value first; decide the change against
   what's actually there, not what you assume is there.
2. **Append, never overwrite, notes.** Add a dated note; don't replace the deal's
   note field. The same goes for *many*-relationships (committee members): add,
   don't replace.
3. **Log every write as an audit trail.** In the run's output, record each mutation
   as `object · field · old → new`. An unattended run that can't show what it
   changed shouldn't have changed it.
4. **Touch only the fields this routine owns.** A briefing that owns *stage* and
   *deal note* does not edit *amount* or *close date*. Stay in your lane.
5. **Never cascade on a CRM failure.** If a write fails, log it, flag the mirror
   stale, and continue the rest of the run — don't retry-storm and don't let one
   failed field abort the ritual.
6. **Treat AI-generated / computed fields as read-only.** Scores or summaries the
   CRM writes itself are outputs, not inputs you overwrite.

## Choose your write authority

Pick the level you're comfortable handing an autonomous run, and set the MCP
server's scope (or a private skill's logic) to match:

| Level | What a routine may do | Trade-off |
|---|---|---|
| **Read-only** | Read the pipeline; write nothing back | Safest. The mirror in `ops/` and your notes hold all edits; the CRM is never touched by automation. |
| **Read + safe writes** | Read, plus append notes and set the fields it owns (stage, score) | The recommended default — useful, bounded by the guardrails above. |
| **Full read-write** | Read and write any field | **Autonomous runs mutate your system of record without review.** Only with the guardrails above and a `Run now` you've audited. |

If unsure, start **read-only**, watch a few `Run now` outputs, then widen.

## Routine wiring

Each ritual touches the CRM in one specific way — and only that way:

- **`/morning-briefing`** — *read* the open pipeline for **stalls** (no activity in
  N days), deals **closing soon**, and **qualification red flags**. No writes.
- **`/midday-checkin`** — if a deal moved during the day, *persist* the stage/score
  change (safe writes only); otherwise read-only.
- **`/end-of-day`** — *persist* the day's stage/score/note changes, then **reconcile
  the mirror**: rewrite [`ops/pipeline.md`](../../ops/pipeline.md) from the CRM so
  tomorrow opens consistent.
- **`/weekly-review`** — read for the week's movement; reconcile the mirror; write
  nothing the daily rituals didn't already persist.

## See also

- [`docs/connecting-a-crm.md`](../../docs/connecting-a-crm.md) — the projection loop
  and the find-or-create / select-ID / paging mechanics this rule assumes.
- [`todo-single-source.md`](todo-single-source.md) — why deals (CRM) and tasks (task
  tool) stay in separate lanes.
- [`../scheduling/cloud-routines.md`](../scheduling/cloud-routines.md) — the
  autonomous runs these guardrails protect.
