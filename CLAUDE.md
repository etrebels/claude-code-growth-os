# Claude Code Growth OS — Project Config

This project uses Claude Code as a go-to-market operating environment — marketing, sales, product, and retention run as one motion, not four silos. The kit spans all four functions across both sides of the bowtie: acquisition on the left, and the post-sale half (onboarding, adoption, renewal, expansion) on the right. Plain-text playbooks in `ops/`, rituals as commands in `.claude/commands/`, go-to-market skills in `.claude/skills/`. The handoffs that connect the four functions — H1–H6 plus the loop close — are mapped in `docs/operating-model.md`.

## Conventions

- **Markdown is the source of truth.** Operating playbooks live in `ops/` as plain markdown. Edit them like docs; commit them like code.
- **Both sides of the bowtie have a surface.** The left side is `ops/pipeline.md` (deals); the right side is `ops/customers.md` (the post-sale account book) and `ops/roadmap-signals.md` (product's triage queue). The renewal motion starts at day 60, not day 85.
- **Rituals are commands.** A recurring task — a morning briefing, an end-of-day wrap-up — is a slash command in `.claude/commands/`. Invoke it by name.
- **One ritual at a time.** Don't port your whole working life on day one. Pick the task you dread most, make it a command, run it daily for a week, then add the next.
- **Commit often.** Your ops get a history. `git log ops/` is your audit trail.

## Hooks

Guardrails run on events, not memory (`.claude/hooks/`):

- **SessionStart** surfaces `ops/priorities.md` and the freshest `ops/feedback-log.md` signals (so the cross-function loop can't go stale silently). On remote / Claude-Code-on-the-web sessions only, a bootstrap step (`web-bootstrap.sh`) also installs the hook linter (`shellcheck`) so you can lint the hooks in-session, matching CI; it's skipped locally and never blocks.
- **PreCompact** re-injects priorities + the latest log entry so long sessions don't lose the thread.
- **PreToolUse(Edit|Write)** blocks writes to secrets, keys, and `.env`.
- **PostToolUse(Edit|Write)** link-checks the changed file and runs your `.claude/scripts/verify.sh` if present — advisory, never blocks.
- **Stop** nudges you to `/end-of-day` until today is logged.
- A **git pre-commit guard** (`pre-commit-guard.sh`, install once) blocks commits containing likely secrets.

All pure bash (two use `python3` to read a hook payload). No API keys, no MCP required. The full thinking is in `docs/methodology.md`.

## Rules

Standing constraints every session honors — interactive or an autonomous [cloud routine](.claude/scheduling/cloud-routines.md) — live in `.claude/rules/` (see [`.claude/rules/README.md`](.claude/rules/README.md)):

- **CRM over MCP** ([`crm-usage.md`](.claude/rules/crm-usage.md)) — the three-lane convention (tasks ≠ deals), the docs-first access protocol, and the write-authority guardrails an unattended run must respect.
- **One to-do list** ([`todo-single-source.md`](.claude/rules/todo-single-source.md)) — the canonical way the to-do list is queried and rendered, so every entry path shows the same list. Pull the whole open set; derive urgency at render; never re-group it per ritual.

## Scheduling

Run the rituals on a clock — locally (cron/launchd), in the cloud, or as a CI backstop. The three layers and setup are in [`.claude/scheduling/`](.claude/scheduling/README.md): cloud Routines run the full rituals without your machine awake; a GitHub Actions `schedule:` runs only the deterministic checks in `.claude/scripts/checks/`.

## Extending with tools

Add MCP servers (calendar, notes, issue tracker, CRM) by copying `.mcp.json.example` → `.mcp.json` (gitignored), then let your commands and skills reach them. Keep machine-local config and secrets in `.claude/settings.local.json` — copy the committed `.claude/settings.local.example.json` to start. Both real files are gitignored; never commit them.
