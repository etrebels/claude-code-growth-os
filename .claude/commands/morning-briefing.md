---
description: Recap yesterday, surface priorities, set today's top three.
---

# Morning Briefing

> Generic chassis variant. If a private operating repo (e.g. your own growth-os) defines a command with this name, that version is canonical for that repo's data.

Run my morning ritual, in order:

1. **Priorities.** Read `ops/priorities.md` and list what's still open.
2. **Yesterday.** Read the most recent entry in `ops/daily-log.md`. Summarize what got done and what's still hanging.
3. **Pipeline.** Read the open pipeline — `ops/pipeline.md`, or a connected CRM per [`.claude/rules/crm-usage.md`](../rules/crm-usage.md) (read-only this run). Flag stalls (no activity in 7+ days), deals closing soon, and qualification red flags. Top-tier first.
4. **Field intel → marketing.** Scan the latest `ops/daily-log.md` entry (and any fresh meeting notes) for recurring objections, competitor mentions, missing proof, or win/loss reasons, and surface them as `MARKETING-ACTION` lines **in `ops/feedback-log.md`** — the one home for tagged loop lines — so marketing can act. This is what the `marketing-feedback` skill does. Skip if there's nothing new.
5. **Post-sale read.** Scan `ops/customers.md` for anything that needs attention today: renewals inside 60 days, accounts at 🔴/🟡 (usage down, champion quiet, single-threaded), and adoption stalls (a workflow never turned on). Then surface the top one or two open items in `ops/roadmap-signals.md`. Skip a line if the file is empty.
6. **Inbox + calendar.** If a mail MCP and calendar MCP are connected, run `inbox-digest` and `calendar-followup` — unread newsletter digest and any meetings older than 3 days with no follow-up. Skip either step if the MCP isn't wired.

7. **Today's top three.** Propose exactly three priorities for today, each with a one-line reason. At least one should move something forward, not just maintain it; lean toward covering both sides of the bowtie when both have live work.
8. **Offer.** Ask if I want to append today's plan to `ops/daily-log.md`.

Keep it short. Lead with the top three. No preamble. Render the to-do list the one canonical way — see [`.claude/rules/todo-single-source.md`](../rules/todo-single-source.md) — and compose the briefing around it; don't re-group it here.

## Depth
- quick: just today's top three.
- standard: the full ritual above.
- deep: add a week-over-week read of the log and flag anything slipping.
