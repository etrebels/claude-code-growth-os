# AGENTS.md — Claude Code Growth OS

Instructions for AI coding agents working on this repository. For project overview, conventions, and session protocol, see [CLAUDE.md](./CLAUDE.md).

## Purpose

This is a **public, generic growth-OS kit** built on Claude Code — a markdown + bash system for running marketing, sales, product, and retention as one motion. It ships as a reusable template. For Edwin's personal live-state (pipeline, customers, priorities), see `etrebels/langoptima-growth-os`.

No code. No build system. Markdown playbooks in `ops/`, rituals as slash commands in `.claude/commands/`, skills in `.claude/skills/`.

## Repository Map

```
claude-code-growth-os/
├── CLAUDE.md                        # Project config, conventions, session protocol
├── AGENTS.md                        # This file
├── README.md                        # Public-facing overview and quick-start
├── CHANGELOG.md                     # Version history
├── CONTRIBUTING.md                  # Contribution guidelines
├── SECURITY.md                      # Security policy
├── CODE_OF_CONDUCT.md               # Community standards
├── LICENSE                          # MIT license
├── THIRD-PARTY-NOTICES.md           # Credits for adapted third-party patterns
├── inbox/
│   └── notes.md                     # /capture staging buffer — raw notes, triaged later
├── ops/                             # LIVE STATE LAYER — mutable, routines read/write
│   ├── pipeline.md                  # Live deal board (one line per open deal)
│   ├── customers.md                 # Post-sale account health
│   ├── priorities.md                # This week's priority + today's Top 3
│   ├── daily-log.md                 # Append-only field-capture log
│   ├── feedback-log.md              # Cross-function feedback loops (sales→marketing, post-sale→product)
│   ├── roadmap-signals.md           # Field/retention signals → product
│   ├── chokepoints.md               # The few narrow dependencies most revenue flows through
│   ├── direction-register.md        # Live standing direction — outranks a conflicting rule
│   └── icp.md                       # Ideal customer profile definition
├── demo/                            # Fictional-data sandbox for testing rituals
│   ├── pipeline.md
│   ├── customers.md
│   ├── priorities.md
│   ├── daily-log.md
│   ├── feedback-log.md
│   ├── roadmap-signals.md
│   ├── support-tickets.md
│   └── meetings/                    # Sample meeting notes
├── docs/                            # Reference documentation
│   ├── operating-model.md           # Bowtie, six handoffs, the one number (NRR)
│   ├── methodology.md               # Why this system is built the way it is
│   ├── designing-loops.md           # Why the loop, not the prompt, is the thing you design
│   ├── connecting-a-crm.md          # CRM projection loop and find-or-create mechanics
│   ├── first-ritual.md              # Getting-started guide
│   ├── launch-scrub-checklist.md    # Pre-launch safety checklist
│   ├── why-align.md                 # Why sales + marketing alignment matters
│   ├── why-brand.md                 # Why brand investment matters
│   ├── principles-from-history.md   # Operating principles sourced from history
│   ├── principles-from-science.md   # Operating principles sourced from science
│   ├── principles-from-the-field.md # Operating principles from running the motion itself
│   └── assets/                      # Diagrams, images
├── .github/
│   └── workflows/                   # CI: scheduled deterministic checks + shellcheck on hooks
├── .claude/
│   ├── settings.json                # Claude Code settings (hooks, permissions)
│   ├── settings.local.example.json  # Template for local secrets config (gitignored when copied)
│   ├── commands/                    # Slash commands — the daily rituals
│   │   ├── morning-briefing.md      # Recap yesterday, surface priorities, set today's top three
│   │   ├── midday-checkin.md        # Mid-day reset — done, slipping, what to protect
│   │   ├── end-of-day.md            # Daily-log entry + tomorrow's Top 3
│   │   ├── weekly-review.md         # Weekly patterns + next week's one priority
│   │   ├── retention-report.md      # Monthly NRR/GRR readout from the customer book
│   │   ├── capture.md               # Drop a raw note now, triage it later
│   │   ├── reconcile.md             # Catch drift when multiple sessions write the same files
│   │   └── demo-briefing.md         # The morning ritual run on the fictional demo/ data
│   ├── hooks/                       # Guardrails that fire on events
│   │   ├── session-start.sh         # Surfaces ops/priorities.md + feedback-log signals
│   │   ├── pre-compact.sh           # Re-injects priorities + latest log before compaction
│   │   ├── protect-files.sh         # Blocks writes to secrets and .env files
│   │   ├── verify-after-change.sh   # Post-change link check + optional project verifier (advisory)
│   │   ├── stop-reminder.sh         # Nudges /end-of-day until today is logged
│   │   ├── pre-commit-guard.sh      # Git pre-commit hook — blocks likely secrets
│   │   └── web-bootstrap.sh         # Installs shellcheck on cloud/web sessions only
│   ├── rules/                       # Standing constraints every session honors
│   │   ├── README.md                # Rules overview and conventions
│   │   ├── crm-usage.md             # CRM-over-MCP: docs-first protocol, write-authority guardrails
│   │   └── todo-single-source.md    # One to-do list, rendered one way (the canonical spec)
│   ├── scheduling/                  # Running rituals on a clock
│   │   ├── README.md                # Three-layer scheduling overview (local / cloud / CI)
│   │   └── cloud-routines.md        # Cloud Routines runbook (Anthropic-hosted)
│   ├── scripts/
│   │   ├── verify.sh.example        # Template for your own post-change verifier
│   │   └── checks/
│   │       └── growth-os-checks.sh  # Deterministic checks run by CI / scheduled jobs
│   └── skills/                      # Reusable growth skills (one directory per skill)
│       ├── account-health/          # Post-sale health review for a named account
│       ├── calendar-followup/       # Draft follow-up based on today's calendar events
│       ├── churn-save/              # Recovery play for a red/amber account
│       ├── cold-outreach/           # Generate a targeted cold outreach sequence
│       ├── content-repurpose/       # Repurpose a piece of content across channels
│       ├── event-to-pipeline/       # Work a conference or event into booked calls
│       ├── example-skill/           # Template / reference skill
│       ├── expansion-signal/        # Work a ready-to-grow account and hand it to sales
│       ├── follow-up/               # Draft a follow-up for a named deal or contact
│       ├── inbox-digest/            # Summarize and triage inbound messages
│       ├── lead-qualify/            # Score a lead against the ICP fit check
│       ├── marketing-feedback/      # Surface MARKETING-ACTION tags from ops/
│       ├── meeting-prep/            # Prep brief for a named meeting or prospect
│       ├── onboarding-handoff/      # CS handoff document for a new customer
│       ├── product-signal/          # Surface FEATURE-REQUEST / RETENTION-RISK tags
│       ├── qbr-prep/                # Value-realization review brief for a customer
│       ├── retention-feedback/      # Surface RETENTION-RISK tags for review
│       ├── status-update/           # Draft a status update for a named deal or account
│       ├── support-signal/          # Cluster support tickets into ranked product themes
│       └── triage/                  # Triage open items across ops/ files
└── .mcp.json.example                # Template for MCP server config (copy → .mcp.json, gitignored)
```

## Content Layers

| Layer | Lives in | Owner | Purpose |
|---|---|---|---|
| **Playbooks** | `ops/` | Daily routines (read/write) | *What's true now* — live pipeline, customers, priorities, log |
| **Rituals** | `.claude/commands/` | Human (invoke) | *How to run the day* — the recurring task the command executes |
| **Skills** | `.claude/skills/` | Human (invoke) / agent | *On-demand depth* — account health, outreach, meeting prep |
| **Rules** | `.claude/rules/` | Always-on | *How to behave safely* — CRM guardrails, to-do list spec |
| **Reference** | `docs/` | Human (read) | *Why this works* — methodology, operating model, connecting a CRM |

**Never mix layers.** Live values stay in `ops/`; templates and playbooks stay in `docs/`; reusable task logic stays in `.claude/commands/` or `.claude/skills/`.

## Key Conventions

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

### Keep this map in sync
This file's repository map, commands table, and hooks table have drifted from the actual repo three separate times in about two months (#38, #58, #60 each caught a different gap — a missing command, a wrong file path, a description carried over from a different repo). Any PR that adds, removes, renames, or moves a command, hook, skill, or top-level file updates the matching table here in the same diff — don't leave it for the next audit to notice.

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
| `protect-files.sh` | **PreToolUse (Edit\|Write)** | Block writes to `.env*`, `*.key`, `*.secret`, `*.token`, `credentials.*` |
| `verify-after-change.sh` | **PostToolUse (Edit\|Write)** | Link-check the changed file + run `.claude/scripts/verify.sh` if present — advisory, never blocks |
| `stop-reminder.sh` | **Stop** | Nudge `/end-of-day` if today is not yet logged |
| `pre-commit-guard.sh` | git pre-commit | Block commits that contain likely secrets (install once: `ln -s ../../.claude/hooks/pre-commit-guard.sh .git/hooks/pre-commit`) |
| `web-bootstrap.sh` | **SessionStart** (cloud only) | Install `shellcheck` on cloud/web sessions; no-op locally |

## Scheduling

Three layers — run the rituals without your machine awake:

1. **Local** — cron (Linux) or launchd (macOS). Setup in `.claude/scheduling/README.md`.
2. **Cloud Routines** — Anthropic-hosted Claude Code sessions triggered on a schedule. Runbook in `.claude/scheduling/cloud-routines.md`.
3. **GitHub Actions CI backstop** — deterministic checks only (`.claude/scripts/checks/growth-os-checks.sh`).

**Known gap: `babysit-prs`.** A recurring PR-health check (CI status, review threads, merge conflicts, external launch dependencies) has been posting dated status comments on this repo's own open PRs since 2026-06-13 — visible directly in the PR history — but it has no `.claude/commands/babysit-prs.md`, isn't listed in `.claude/scheduling/cloud-routines.md`'s routine table, and isn't in the *Available Commands* table below. A prior attempt to formalize it (#53) was closed as superseded before the command file itself landed. Treat this as an open item, not a shipped feature — if you're adapting this kit and want the same check, write your own `.claude/commands/babysit-prs.md` rather than assuming one exists.

## Source-of-Truth Hierarchy

1. **`.claude/rules/crm-usage.md`** — canonical for CRM access protocol and write guardrails
2. **`.claude/rules/todo-single-source.md`** — canonical for to-do list query and render spec
3. **`docs/operating-model.md`** — canonical for the bowtie model and six handoffs
4. **`docs/connecting-a-crm.md`** — canonical for CRM projection loop mechanics
5. **`CLAUDE.md`** — canonical for project conventions and session protocol
