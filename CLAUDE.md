# Claude Code Growth OS — Project Config

This project uses Claude Code as a go-to-market operating environment — marketing, sales, product, and retention run as one motion, not four silos. The kit spans all four functions across both sides of the bowtie: acquisition on the left, and the post-sale half (onboarding, adoption, renewal, expansion) on the right. Plain-text playbooks in `ops/`, rituals as commands in `.claude/commands/`, go-to-market skills in `.claude/skills/`. The handoffs that connect the four functions — H1–H6 plus the loop close — are mapped in `docs/operating-model.md`.

## Conventions

- **Markdown is the source of truth.** Operating playbooks live in `ops/` as plain markdown. Edit them like docs; commit them like code.
- **Both sides of the bowtie have a surface.** The left side is `ops/pipeline.md` (deals); the right side is `ops/customers.md` (the post-sale account book) and `ops/roadmap-signals.md` (product's triage queue). The renewal motion starts at day 60, not day 85.
- **Rituals are commands.** A recurring task — a morning briefing, an end-of-day wrap-up — is a slash command in `.claude/commands/`. Invoke it by name.
- **One ritual at a time.** Don't port your whole working life on day one. Pick the task you dread most, make it a command, run it daily for a week, then add the next.
- **Commit often.** Your ops get a history. `git log ops/` is your audit trail.
- **Straight answers.** When a session evaluates your work — a plan, a draft, a pipeline read — the assistant's first duty is an accurate assessment, not an agreeable one. Verdict first, then reasons; plain disagreement before you decide; alignment once you have decided. Hedges express real uncertainty, never politeness.
- **Plain language first.** The plain statement carries the meaning; the specialist term is a label attached after it, never the sentence itself. This applies to internal output too — headings in your playbooks, PR titles, commit messages, the summary a ritual hands back — not just customer-facing copy. Avoid the audience exemption ("they're technical, they'll know it"): that is what you grant yourself at the moment you most want the jargon. The test is mechanical — delete the specialist word and see whether the sentence still stands. If it collapses, the word was doing the sentence's job. A position nobody can restate from memory is not governing anything.

## Hooks

Guardrails run on events, not memory (`.claude/hooks/`):

- **SessionStart** surfaces `ops/priorities.md` and the freshest `ops/feedback-log.md` signals (so the cross-function loop can't go stale silently). On remote / Claude-Code-on-the-web sessions only, a bootstrap step (`web-bootstrap.sh`) also installs the hook linter (`shellcheck`) so you can lint the hooks in-session, matching CI; it's skipped locally and never blocks.
- **PreCompact** fires around a long-session compaction. Because your state lives in files, **SessionStart** reliably reloads priorities + the latest log entry next session — so the thread is always recoverable. (PreCompact stdout re-injection is best-effort and version-dependent; SessionStart is the guaranteed re-load.)
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

## Open-PR hygiene

This repo has accumulated open, unmerged PRs from prior sessions (7 open as of 2026-07-05; #38 has since merged, but the count has since drifted back up to 6 as of 2026-08-09, several dating to early July). Before opening a new PR: check `repo:etrebels/claude-code-growth-os is:pr is:open` for existing work on the same topic and continue or merge it rather than adding a near-duplicate. If a recurring skill's own prior PR is still open, that's a signal worth surfacing in its output, not a fresh PR to pile on top.

**The rule keeps getting proven on `insights-loop` itself.** #38 sat unmerged for four weeks before merging; its successor, #53 (opened 2026-07-19, "codify `/babysit-prs`, fix hygiene drift" — itself a fix for this exact problem), sat as a draft for three weeks and has since drifted into a real merge conflict with `main` (`mergeable_state: dirty`) as unrelated content landed on top of it. A routine that opens a fresh dated branch every week without checking back on last week's branch is *how* PRs pile up, not just a bystander reporting it — the fix is to extend or close out the prior branch before starting a new one, not just to log the number.

## Session-analysis routines (e.g. `insights-loop`)

A remote/cloud session starts from a fresh clone every run — nothing under `~/.claude/projects/` (session transcripts) persists across sessions. "Analyze the last N days of Claude Code session transcripts" therefore has no literal data to read beyond the current run's own in-progress transcript. Any routine making that claim should fall back to evidence that *does* persist — `git log --since`, open/merged PR history and their review comments, and CI check runs — and say plainly that it's using that fallback rather than implying it read transcripts that don't exist in this environment.

## Extending with tools

Add MCP servers (calendar, notes, issue tracker, CRM) by copying `.mcp.json.example` → `.mcp.json` (gitignored), then let your commands and skills reach them. Keep machine-local config and secrets in `.claude/settings.local.json` — copy the committed `.claude/settings.local.example.json` to start. Both real files are gitignored; never commit them.
