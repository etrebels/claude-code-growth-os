# Cloud Routines — run your daily rituals without a local machine

> Run the rituals in [`.claude/commands/`](../commands/) on a schedule, even when
> your laptop is closed. Replace every `<placeholder>` with your own repo,
> timezone, and integrations.

Most "AI chief of staff" setups schedule their daily rituals with a local
scheduler (cron / launchd) that shells out to `claude -p "/morning-briefing"`.
That works, but it only fires **when your machine is awake** — close the lid and
the briefing silently doesn't run.

**Routines** (Claude Code on the web) fix that: they run a scheduled session on
Anthropic-managed infrastructure that executes a slash command such as
`/morning-briefing`, independent of any machine of yours.

## The three scheduling layers

| Layer | Runs where | Runs what | Machine awake? |
|---|---|---|---|
| OS scheduler (cron / launchd) | your machine | full rituals (model + your tools) | ✅ required |
| **Cloud Routines** (this guide) | Anthropic cloud | full rituals (model + your tools) | ❌ no |
| CI backstop (GitHub Actions) | GitHub cloud | deterministic, no-model checks only | ❌ no |

Use **Routines** for anything that needs the model + your integrations; use a
GitHub Actions `schedule:` job only for deterministic checks — that's the CI
backstop, wired up in [`scripts/checks/`](../scripts/checks/) and
[`.github/workflows/scheduled-reviews.yml`](../../.github/workflows/scheduled-reviews.yml)
(see the last section for why Actions can't run the full ritual). The same table,
from the reliability angle, is in [`README.md`](README.md).

## Prerequisite — your integrations must be account-level connectors

This is the make-or-break detail. A routine can only use integrations connected to
your **claude.ai account** as **connectors** (<https://claude.ai/customize/connectors>),
**not** MCP servers you added locally with `claude mcp add` or in a gitignored
`.mcp.json`.

- If a routine needs your task tool / calendar / meeting-notes tool / CRM / chat,
  each must appear in the routine's **Connectors** tab.
- Local-only MCP servers won't appear unless you add them as a connector **or**
  declare them in a committed `.mcp.json` (which travels with the cloned repo).
  This kit keeps `.mcp.json` gitignored by default — see
  [Connect your tools](../../README.md#make-it-yours) — so for routines, prefer
  account connectors.
- Connector traffic routes through Anthropic, so connectors work **without** adding
  their domains to the environment's **Allowed domains** list.

**Always do a `Run now` first** — a routine whose connectors aren't authorized still
runs, but produces an empty result. Verify before you trust the schedule.

## What to schedule

The rituals this chassis ships, on a weekday loop:

| Routine | Schedule | Cron (routine's local tz) |
|---|---|---|
| [`/morning-briefing`](../commands/morning-briefing.md) | Weekdays, morning | `30 7 * * 1-5` |
| [`/midday-checkin`](../commands/midday-checkin.md) | Weekdays, midday | `0 14 * * 1-5` |
| [`/end-of-day`](../commands/end-of-day.md) | Weekdays, late afternoon | `30 17 * * 1-5` |
| [`/weekly-review`](../commands/weekly-review.md) | Friday, late afternoon | `0 16 * * 5` |

> Cron in a routine is evaluated in the **routine's own timezone**, not UTC — set
> the timezone to `<your timezone, e.g. Europe/London>` and use clock times directly.

## Create a routine (web UI)

1. Go to **<https://claude.ai/code/routines>** → **New routine**.
2. **Name** it (e.g. `morning-briefing`).
3. **Prompt** — paste the matching prompt from *Routine prompts* below.
4. **Repository:** `<your-org>/<your-repo>` (your fork of this chassis), branch `main`.
5. **Environment:** the cloud environment configured for that repo (so connectors +
   env vars match an interactive session).
6. **Connectors tab:** confirm every integration your routine needs is present.
7. **Trigger:** Schedule → Daily → the days/time you want → your timezone.
8. **Create**, then **Run now** to verify connectors fire (and any email sends).
9. Repeat per routine.

## Create from the CLI

From a **local** Claude Code CLI (the `/schedule` command talks to the same backend):

```
/schedule run /morning-briefing every weekday at 07:30 <your timezone>
```

`/schedule list` / `/schedule update` manage existing routines.

> Note: a **headless web execution environment does not expose the routine-creation
> tool** — create routines from the web UI or a local CLI, not from inside an
> automated web session.

## Routine prompts (paste-ready, template)

Keep each routine prompt thin: invoke the committed slash command (whose definition
travels with the cloned repo and is your single source of truth) and add only the
cross-cutting run constraints.

```
Run <your routine>. In repo <your-org>/<your-repo> (branch main, cloned in your
workspace), execute the slash command /<routine-name> (defined in
.claude/commands/<routine-name>.md) end to end, honoring CLAUDE.md and the rules
in .claude/rules/. Use the connected integrations it needs (e.g. task tool,
calendar, meeting-notes tool, CRM, chat); if one is unavailable, degrade
gracefully, note it, and continue — never abort. Write all updates the command
specifies. If an email/delivery key is configured, send the output. Run
autonomously; do not wait for confirmation.
```

Because the routine runs **autonomously**, the rules it honors do real work here —
in particular [`.claude/rules/crm-usage.md`](../rules/crm-usage.md) (read-before-write,
append-don't-overwrite, log every write) governs what an unattended run is allowed
to change, and [`.claude/rules/todo-single-source.md`](../rules/todo-single-source.md)
keeps a routine from re-rendering the to-do list a different way than your
interactive session does.

## Email / external delivery

If your routine delivers output via an external API (e.g. an email-sending API), that
API is **not** a connector: set its key (e.g. `EMAIL_API_KEY`) in the routine's
**environment** variables and add its domain (e.g. `api.youremailprovider.com`) to that
environment's **Allowed domains**. (Connectors skip the allowlist; plain APIs don't.)

## Limits & notes

- **Minimum interval** is 1 hour; routines count against your daily routine-run
  limit (see <https://claude.ai/code/routines>).
- Routines run **autonomously** — no permission prompts mid-run. Make prompts
  explicit about "degrade gracefully, never abort."
- **Why GitHub Actions can't run the full ritual:** OAuth-based MCP integrations
  (task tools, calendars, most meeting-notes tools) require interactive,
  browser-based authorization, which a headless Actions runner can't do. So an
  Actions `schedule:` job can drive `claude -p` with an `ANTHROPIC_API_KEY`, but it
  can't reach your OAuth integrations — use it only for **static-token** integrations
  or **deterministic, no-model checks** (the CI backstop). For anything needing your
  connectors, use Routines.

## See also

- [`README.md`](README.md) — the scheduling overview and the three-layer table.
- [`.claude/rules/`](../rules/) — the rules a routine honors when it runs unattended.
- [`../../docs/connecting-a-crm.md`](../../docs/connecting-a-crm.md) — projecting a
  CRM into `ops/pipeline.md`, which the morning routine reads.

## Sources

- Routines: <https://code.claude.com/docs/en/routines>
- Claude Code on the web (environments, connectors, network): <https://code.claude.com/docs/en/claude-code-on-the-web>
- GitHub Actions: <https://code.claude.com/docs/en/github-actions>
