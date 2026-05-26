# Connecting a CRM (optional)

This kit works fine with [`ops/pipeline.md`](../ops/pipeline.md) as your hand-maintained board. But if you already have a CRM (HubSpot, Salesforce, Attio, …), **don't run two pipelines.** Make your CRM the source of truth and treat `ops/pipeline.md` as a *projection* of it. A hand-typed board that drifts from the CRM is worse than no board.

## The pattern: project, don't duplicate

```
CRM (system of record)  ──hydrate──▶  ops/pipeline.md (snapshot)  ──you work──▶  CRM (write back)
```

- **Morning:** the briefing reads the CRM's open opportunities and rewrites the `ops/pipeline.md` table.
- **During the day:** you glance at `ops/pipeline.md` (fast, no API call per look).
- **End of day:** stage moves get written *back* to the CRM; the board re-projects.

If the CRM is unreachable, fall back to the last projection and flag it stale — never block the routine.

## Hard-won rules (these will bite you otherwise)

1. **Never hardcode the API surface.** Discover endpoints, fields, and especially **select-option IDs** (pipeline stages) from the CRM's own schema endpoint each session — they're org-specific and change. Writing a stage *label* where the API wants an option *ID* silently fails.
2. **Your stages won't match the CRM's.** The stage model you keep in [`ops/pipeline.md`](../ops/pipeline.md) — and the motion in [`operating-model.md`](operating-model.md) — rarely maps 1:1 to a CRM's stage list. Keep the conceptual model for coaching; report deals in the CRM's actual stages; document the mapping once.
3. **Check relationship cardinality before writing.** Linking people to a deal (champion, economic buyer) is usually a *many* relationship — append (`add`), don't `replace`.
4. **Find-or-create, always.** Search by name before creating an account, contact, or opportunity. Bulk imports without a dedup check are how CRMs rot.
5. **Filter the exhaust.** Most CRMs are mostly closed/disqualified records. Project only the *open* set; compute the forecast only from real, weighted stages.
6. **Render live; don't commit a giant snapshot.** Don't paste 200 deals into a committed file — it's stale the next day. Commit a thin "last hydrated" sample + the hydration spec; let the routine render the full set on demand.

## Reconciling notes ↔ CRM

If you keep per-deal working files, they drift from the CRM. A deal with a rich dossier but no CRM record is research that never became a tracked deal. Periodically reconcile: find-or-create the account + one opportunity, link the **named** committee (skip unnamed hypotheses), set a conservative stage. Keep the narrative in the working file; keep structured fields in the CRM. Don't duplicate.

## Working with large CRM responses

A full-pipeline list call can be large. Page deliberately (most list APIs cap page size and serve a search index that lags — use a single-record fetch when you need freshness). For analysis, stream the response through a query tool (`jq`) or a sub-agent rather than loading the whole dump into context.

---

*Vendor-neutral by design. Wire it to your CRM's specific API in a private rule/skill — keep credentials and internal IDs out of this repo.*

## See also

- [`operating-model.md`](operating-model.md) — the spine: where `ops/pipeline.md` sits in the four-function motion (handoff H1).
- [`../ops/pipeline.md`](../ops/pipeline.md) — the board this projects into.
