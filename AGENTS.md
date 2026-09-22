# AGENTS.md — Claude Code Growth OS

The instruction file for every AI coding agent working in this repository —
Claude Code, Codex, Copilot, Cursor, Gemini CLI. It is the one place the working
conventions live. Claude Code reads it through an `@AGENTS.md` import in
[`CLAUDE.md`](./CLAUDE.md), which adds the few Claude-only notes on top.

## Purpose

This is a **public, generic growth-OS kit** built on Claude Code — a markdown + bash system for running marketing, sales, product, and retention as one motion. It ships as a reusable template. For Edwin's personal live-state (pipeline, customers, priorities), see `etrebels/langoptima-growth-os`.

No code. No build system. Markdown playbooks in `ops/`, rituals as slash commands in `.claude/commands/`, skills in `.claude/skills/`.

## Repository map

The full directory layout is in [`docs/repo-map.md`](docs/repo-map.md). Read it
when you need to find something; it is a listing, not a rule.

## Content Layers

| Layer | Lives in | Owner | Purpose |
|---|---|---|---|
| **Playbooks** | `ops/` | Daily routines (read/write) | *What's true now* — live pipeline, customers, priorities, log |
| **Rituals** | `.claude/commands/` | Human (invoke) | *How to run the day* — the recurring task the command executes |
| **Skills** | `.claude/skills/` | Human (invoke) / agent | *On-demand depth* — account health, outreach, meeting prep |
| **Rules** | `.claude/rules/` | Always-on | *How to behave safely* — CRM guardrails, to-do list spec |
| **Reference** | `docs/` | Human (read) | *Why this works* — methodology, operating model, connecting a CRM |

**Never mix layers.** Live values stay in `ops/`; templates and playbooks stay in `docs/`; reusable task logic stays in `.claude/commands/` or `.claude/skills/`.

## Key conventions

- **Markdown is the source of truth.** Operating playbooks live in `ops/` as plain markdown. Edit them like docs; commit them like code.
- **Both sides of the bowtie have a surface.** The left side is `ops/pipeline.md` (deals); the right side is `ops/customers.md` (the post-sale account book) and `ops/roadmap-signals.md` (product's triage queue). The renewal motion starts at day 60, not day 85.
- **Rituals are commands.** A recurring task — a morning briefing, an end-of-day wrap-up — is a slash command in `.claude/commands/`. Invoke it by name.
- **One ritual at a time.** Don't port your whole working life on day one. Pick the task you dread most, make it a command, run it daily for a week, then add the next.
- **Commit often.** Your ops get a history. `git log ops/` is your audit trail.
- **A ritual that died must not look like a quiet day.** Every scheduled ritual ends by recording its own outcome — `routine-state.sh ok <ritual>` on a clean finish, `routine-state.sh fail <ritual> "<what blocked it>"` otherwise. The failure marker stays in [`ops/runs/`](ops/runs/README.md) until a good run clears it, and session start reads it. Recording a failure is the ritual finishing correctly; leaving nothing behind is the failure. The cadence each ritual is judged against is a row in `.claude/scripts/routines.tsv` — delete the rows you do not run.
- **Count it, don't assert it.** `bash .claude/scripts/status.sh` counts what the repo actually contains — ops freshness, ritual state, the size of your own rulebook — and says plainly what it cannot count without the network instead of guessing. `--html` renders it as a page. A number written into a document is a number that was true once.
- **Two machines, two merge rules.** If you run this locally *and* in the cloud, both append to the same logs on the same day. [`.gitattributes`](.gitattributes) sets `merge=union` on the append-only logs so two entries stack instead of conflicting; snapshot files (`ops/priorities.md`, `ops/pipeline.md`) are left on the default merge and have one writer at a time, because a snapshot merged from two machines describes neither.
- **Straight answers.** When a session evaluates your work — a plan, a draft, a pipeline read — the assistant's first duty is an accurate assessment, not an agreeable one. Verdict first, then reasons; plain disagreement before you decide; alignment once you have decided. Hedges express real uncertainty, never politeness.
- **Plain language first.** The plain statement carries the meaning; the specialist term is a label attached after it, never the sentence itself. This applies to internal output too — headings in your playbooks, PR titles, commit messages, the summary a ritual hands back — not just customer-facing copy. Avoid the audience exemption ("they're technical, they'll know it"): that is what you grant yourself at the moment you most want the jargon. The test is mechanical — delete the specialist word and see whether the sentence still stands. If it collapses, the word was doing the sentence's job. A position nobody can restate from memory is not governing anything.

And the conventions specific to this kit's shape:

### Generic by design
This kit ships with `<placeholder>` values for anything installation-specific (CRM endpoints, calendar IDs, field names). Wire the real values into `.claude/settings.local.json` (gitignored) or a private skill — never commit them here.

### No code
This is a markdown + bash system. Never create `.js`, `.ts`, `.json`, or `.html` files in `ops/`, `docs/`, or `.claude/commands/`. Shell scripts in `.claude/hooks/` and `.claude/scripts/` are the only non-markdown exception.

### Commit ops/ like code
`ops/` files are mutable state. Commit them often — `git log ops/` is the audit trail. Each routine writes ops/ and commits at end-of-run so tomorrow's session opens consistent.

### Rules are the single source of truth for their concern
A rule in `.claude/rules/` owns its domain. Commands and cloud routines point to the rule — they don't re-derive its logic. See `.claude/rules/README.md`.

### CRM lives in one lane
Deals → CRM (via MCP). Tasks → task tool. Priorities → `ops/priorities.md` (derived). Never create CRM tasks from a ritual — that forks the to-do list. See `.claude/rules/crm-usage.md`.

### To-do list has one canonical render spec
Every entry point (session start, each ritual, each cloud routine) uses the spec in `.claude/rules/todo-single-source.md`. Don't re-derive the grouping or filtering inside a command.

## Available Commands

| Command | Cadence | Role |
|---|---|---|
| `/morning-briefing` | Daily (morning) | Recap yesterday, surface priorities, set today's top three |
| `/midday-checkin` | Daily (mid-day) | Mark what's done, flag what's slipping, protect the afternoon |
| `/end-of-day` | Daily (close) | Daily-log entry, tomorrow's Top 3, CRM persist + audit log |
| `/weekly-review` | Weekly | Patterns across both sides of the bowtie, next week's one priority |
| `/retention-report` | Monthly | Roll the customer book up to NRR/GRR, churn by reason, expansion |
| `/capture` | Ad-hoc | Drop a raw note into `inbox/notes.md` now; triage it later |
| `/reconcile` | Ad-hoc | Catch drift when more than one session writes the same files |
| `/demo-briefing` | Ad-hoc | The morning ritual run safely on the fictional `demo/` data |

## Hooks

| Hook | Event | Purpose |
|---|---|---|
| `session-start.sh` | **SessionStart** | Surface `ops/priorities.md` + latest `ops/feedback-log.md` signals |
| `pre-compact.sh` | **PreCompact** | Re-inject priorities + latest log entry before compaction |
| `irreversible-fence.sh` | **PreToolUse (`mcp__*`)** | Block a connector call that sends, shares, deletes, publishes, cancels, or commits you to someone; drafting passes through. What counts as irreversible is two editable lists at the top of `.claude/scripts/fence-check.py` — name the tools your own stack exposes. `LO_FENCE_OVERRIDE=1` opens it for one session |
| `protect-files.sh` | **PreToolUse (Edit\|Write)** | Block writes to `.env*`, `*.key`, `*.secret`, `*.token`, `credentials.*` |
| `verify-after-change.sh` | **PostToolUse (Edit\|Write)** | Link-check the changed file + run `.claude/scripts/verify.sh` if present — advisory, never blocks |
| `run-state-surface.sh` | **SessionStart** | Read `ops/runs/` and name any ritual that is failing or overdue — counted off disk each time, silent when everything is current |
| `instructions-loaded-log.sh` | **InstructionsLoaded** | Append every session's loaded instruction files and their size to `.claude/logs/` — so "the size of your own rulebook" is a number you read, not one you remember |
| `stop-reminder.sh` | **Stop** | Nudge `/end-of-day` if today is not yet logged |
| `pre-commit-guard.sh` | git pre-commit | Block commits that contain likely secrets (install once: `ln -s ../../.claude/hooks/pre-commit-guard.sh .git/hooks/pre-commit`) |
| `web-bootstrap.sh` | **SessionStart** (cloud only) | Install `shellcheck` on cloud/web sessions; no-op locally |

Because your state lives in files, **SessionStart** reliably reloads priorities and
the latest log entry next session, so the thread is always recoverable. PreCompact
re-injection is best-effort and version-dependent; SessionStart is the guaranteed
reload.

All pure bash (two use `python3` to read a hook payload). No API keys, no MCP
required. The full thinking is in [`docs/methodology.md`](docs/methodology.md).

## Scheduling

Three layers — run the rituals without your machine awake:

1. **Local** — cron (Linux) or launchd (macOS). Setup in `.claude/scheduling/README.md`.
2. **Cloud Routines** — Anthropic-hosted Claude Code sessions triggered on a schedule. Runbook in `.claude/scheduling/cloud-routines.md`.
3. **GitHub Actions CI backstop** — deterministic checks only (`.claude/scripts/checks/growth-os-checks.sh`).

## Source-of-Truth Hierarchy

1. **`.claude/rules/crm-usage.md`** — canonical for CRM access protocol and write guardrails
2. **`.claude/rules/todo-single-source.md`** — canonical for to-do list query and render spec
3. **`docs/operating-model.md`** — canonical for the bowtie model and six handoffs
4. **`docs/connecting-a-crm.md`** — canonical for CRM projection loop mechanics
5. **`AGENTS.md`** (this file) — canonical for project conventions and session protocol
