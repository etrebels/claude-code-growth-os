---
description: Capture a raw thought now; triage it to the right place later.
---

# Capture

A frictionless inbox so a passing thought doesn't cost you a context switch. Two modes — drop and triage. The inbox is a staging buffer, never a second to-do list.

## Drop (default — when I hand you a note)

1. Append the note verbatim to `inbox/notes.md`, one dated line per item: `- [YYYY-MM-DD HH:MM] <the note>`. Create the file if it's absent.
2. Confirm in one line. Do **not** act on it, file it, expand it, or ask follow-ups — the whole point is to *not* break my focus.

## Triage (when I say "triage the inbox" / "process capture")

Walk `inbox/notes.md` top to bottom. Route each item to the lane that owns it — never let a captured note become a parallel task list (see [`.claude/rules/todo-single-source.md`](../rules/todo-single-source.md)):

- **A task** → the one task list (`ops/priorities.md`, or your task tool).
- **Something said in a meeting** → your notes / wiki lane.
- **A deal change** → the CRM / `ops/pipeline.md`, per [`.claude/rules/crm-usage.md`](../rules/crm-usage.md).
- **A post-sale signal** → `ops/customers.md` or `ops/roadmap-signals.md` (tag `RETENTION-RISK` / `FEATURE-REQUEST`).
- **A field-intel signal for marketing** → `ops/feedback-log.md` (`MARKETING-ACTION`).
- **A reference fact or a preference** → the right `ops/` or `docs/` file.
- **Noise** → delete it.

Remove each item from `inbox/notes.md` as you route it. Close with one line: routed N, deleted M, left K (and why each was left).

## Depth

- quick: drop only.
- standard: drop, or triage the whole inbox.
- deep: triage, flag anything sitting more than 7 days, and propose a standing route for any capture pattern that keeps recurring.
