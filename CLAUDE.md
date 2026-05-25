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

- **SessionStart** surfaces `ops/priorities.md`.
- **PreCompact** re-injects priorities + the latest log entry so long sessions don't lose the thread.
- **PreToolUse(Edit|Write)** blocks writes to secrets, keys, and `.env`.
- **Stop** nudges you to `/end-of-day` until today is logged.
- A **git pre-commit guard** (`pre-commit-guard.sh`, install once) blocks commits containing likely secrets.

All pure bash (one uses `python3` to read a payload). No API keys, no MCP required. The full thinking is in `docs/methodology.md`.

## Extending with tools

Add MCP servers (calendar, notes, issue tracker, CRM) by copying `.mcp.json.example` → `.mcp.json` (gitignored), then let your commands and skills reach them. Keep machine-local config and secrets in `.claude/settings.local.json` — copy the committed `.claude/settings.local.example.json` to start. Both real files are gitignored; never commit them.
