# Claude Code Growth OS — Project Config

This project uses Claude Code as a go-to-market operating environment — marketing, sales, product, and retention run as one motion, not four silos. The kit spans all four functions across both sides of the bowtie: acquisition on the left, and the post-sale half (onboarding, adoption, renewal, expansion) on the right. Plain-text playbooks in `ops/`, rituals as commands in `.claude/commands/`, go-to-market skills in `.claude/skills/`. The handoffs that connect the four functions — H1–H6 plus the loop close — are mapped in `docs/operating-model.md`.

## Conventions

- **Markdown is the source of truth.** Operating playbooks live in `ops/` as plain markdown. Edit them like docs; commit them like code.
- **Both sides of the bowtie have a surface.** The left side is `ops/pipeline.md` (deals); the right side is `ops/customers.md` (the post-sale account book) and `ops/roadmap-signals.md` (product's triage queue). The renewal motion starts at day 60, not day 85.
- **Rituals are commands.** A recurring task — a morning briefing, an end-of-day wrap-up — is a slash command in `.claude/commands/`. Invoke it by name.
- **One ritual at a time.** Don't port your whole working life on day one. Pick the task you dread most, make it a command, run it daily for a week, then add the next.
- **Commit often.** Your ops get a history. `git log ops/` is your audit trail.
- **Straight answers.** When a session evaluates your work — a plan, a draft, a pipeline read — the assistant's first duty is an accurate assessment, not an agreeable one. Verdict first, then reasons; plain disagreement before you decide; alignment once you have decided. Hedges express real uncertainty, never politeness.

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

This repo has accumulated open, unmerged PRs from prior sessions. As of 2026-08-23: **5 open** (#44, #48, #49, #55, #57) — down from 6 as of 2026-08-09, since #53 was closed as superseded by #58 (merged 2026-08-22) and #60 merged directly. Before opening a new PR: check `repo:etrebels/claude-code-growth-os is:pr is:open` for existing work on the same topic and continue or merge it rather than adding a near-duplicate. If a recurring skill's own prior PR is still open, that's a signal worth surfacing in its output, not a fresh PR to pile on top.

**Not all open PRs carry the same urgency — split them before reporting the count.** Three of the five (#44, #48, #49) are *intentionally* held open, each blocked on a human-only event in a different repo (a "flip this live" step, a sibling kit going public) that no amount of re-checking resolves any faster. The other two (#55, #57) are the ones actually waiting on review or a rebase. A raw "N open PRs" number treats both groups the same and understates how much is genuinely stuck — when reporting the count, name the split: `<blocked-on-external> blocked on an external/manual event, <needs-review> ready for review`.

**The rule keeps getting proven on `insights-loop` itself, and this note needed refreshing again this run.** #53 (last week's fix for this exact hygiene problem) is now closed — but the sentence that described it as "still a draft, drifting into conflict" was already stale one week later, because it named a specific PR's live state rather than a pattern. That's why this version leans on the blocked-vs-needs-review split above instead of a single PR number: a split-by-status framing keeps describing reality after the PR it was written about has closed.

### PR-health checks should resolve mechanical conflicts, not just re-report them

`babysit-prs` — the recurring PR-health check referenced above and documented (as a known gap) in `AGENTS.md`'s *Scheduling* section — correctly treats a **content-contradicting** merge conflict as an editorial call outside its authority to resolve on its own. But it has been applying that same hold to conflicts that are purely **additive and non-contradicting** — two branches each adding their own entry under `CHANGELOG.md`'s single `## [Unreleased]` heading, where the fix is simply "keep both entries." The cost is concrete: PR #44's `CHANGELOG.md` conflict was reported unchanged, almost verbatim, across at least seven consecutive check-ins (07-27 through 08-22) with zero resolution, and #55 hit the identical failure mode. **The fix:** before flagging a `CHANGELOG.md`-only conflict as "outside authorization," diff the two sides — if neither deleted or altered the other's lines (a pure two-way addition to the same section), merge `main` in, keep both entries, and say so in the status comment. Reserve the hold-and-flag behavior for conflicts where the two sides actually disagree about the same content.

## Session-analysis routines (e.g. `insights-loop`)

A remote/cloud session starts from a fresh clone every run — nothing under `~/.claude/projects/` (session transcripts) persists across sessions. "Analyze the last N days of Claude Code session transcripts" therefore has no literal data to read beyond the current run's own in-progress transcript. Any routine making that claim should fall back to evidence that *does* persist — `git log --since`, open/merged PR history and their review comments, and CI check runs — and say plainly that it's using that fallback rather than implying it read transcripts that don't exist in this environment.

## Extending with tools

Add MCP servers (calendar, notes, issue tracker, CRM) by copying `.mcp.json.example` → `.mcp.json` (gitignored), then let your commands and skills reach them. Keep machine-local config and secrets in `.claude/settings.local.json` — copy the committed `.claude/settings.local.example.json` to start. Both real files are gitignored; never commit them.
