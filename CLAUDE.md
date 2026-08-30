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

This repo has accumulated open, unmerged PRs from prior sessions. As of 2026-08-30: **6 open** (#44, #48, #49, #55, #57, #62) — unchanged in count from 2026-08-23, because the PR that refreshed this note last week (#62) is *itself* one of the six, still unreviewed a week later. Before opening a new PR: check `repo:etrebels/claude-code-growth-os is:pr is:open` for existing work on the same topic and continue or merge it rather than adding a near-duplicate. If a recurring skill's own prior PR is still open, that's a signal worth surfacing in its output, not a fresh PR to pile on top.

**Not all open PRs carry the same urgency — split them before reporting the count.** Three of the six (#44, #48, #49) are *intentionally* held open, each blocked on a human-only event in a different repo (a "flip this live" step, a sibling kit going public) that no amount of re-checking resolves any faster. The other three (#55, #57, #62) are the ones actually waiting on review — all three have been CI-green and conflict-free (post-resolution, for #55) for a week or more with nothing left for a routine to do. A raw "N open PRs" number treats both groups the same and understates how much is genuinely stuck — when reporting the count, name the split: `<blocked-on-external> blocked on an external/manual event, <needs-review> ready for review`.

**The rule keeps getting proven on `insights-loop` itself — for a third cycle running, and this time by the fix, not just the problem.** #38 sat unmerged for four weeks; #53 (its fix) sat three weeks before closing as superseded; #62 (#53's replacement, and the PR that *wrote the paragraph above*) has now sat open, green, and unreviewed for a full week itself. Naming the pattern doesn't break it — only merging does. This week's run extended #62 in place rather than opening `claude/weekly-insights-2026-08-30`, precisely to stop adding a seventh branch to a pile whose actual bottleneck is a merge decision, not more analysis.

### PR-health checks should resolve mechanical conflicts, not just re-report them

`babysit-prs` — the recurring PR-health check referenced above and documented (as a known gap) in `AGENTS.md`'s *Scheduling* section — correctly treats a **content-contradicting** merge conflict as an editorial call outside its authority to resolve on its own. But it had been applying that same hold to conflicts that are purely **additive and non-contradicting** — two branches each adding their own entry under `CHANGELOG.md`'s single `## [Unreleased]` heading, where the fix is simply "keep both entries." The cost was concrete: PR #44's `CHANGELOG.md` conflict was reported unchanged, almost verbatim, across at least seven consecutive check-ins (07-27 through 08-22) with zero resolution. **The fix:** before flagging a `CHANGELOG.md`-only conflict as "outside authorization," diff the two sides — if neither deleted or altered the other's lines (a pure two-way addition to the same section), merge `main` in, keep both entries, and say so in the status comment. Reserve the hold-and-flag behavior for conflicts where the two sides actually disagree about the same content.

**The same pattern showed up again this week, one section over from `CHANGELOG.md` — the fix generalizes past that one file.** #55's addition to `docs/principles-from-the-field.md` collided with an unrelated principle that landed on `main` in the same section afterward. Both were pure additions at the same anchor point, not a real disagreement, but the conflict sat `dirty` for **12 days across five check-ins (08-16 → 08-24)** before a run finally merged `main` in and kept both entries in full on 08-28 — the exact "keep both" move the CHANGELOG.md fix above already prescribes, just not yet applied outside that one file. **Read the fix above as filename-agnostic:** any shared, append-only section (a changelog, a running list of field principles, a rotation table) can take the same additive collision, and the same diff-first check resolves it the same way.

### A PR reported "ready" five times running is a merge decision waiting, not a check that needs to run again

`babysit-prs` re-confirms #57 as CI-green and conflict-free on every check-in since 2026-08-11 — five consecutive checks, 19 days, with nothing to report but "unchanged." The single open item (`/plugin marketplace add` verification) has been Edwin-owned and unresolvable by the routine for the entire window. Repeating an unchanged status is correct behavior for a routine with no merge authority, but it produces no new information after the first repeat — the second and every subsequent "still ready" confirms only that the routine ran, not that anything changed. **The fix:** after N (suggest 3) consecutive unchanged "ready" check-ins on a PR with no open blocker the routine can act on, the status comment should say so plainly — *"ready for N checks running; the only remaining step is yours"* — rather than restating the same table. That turns a silent plateau into a visible one without granting the routine any new authority.

## Session-analysis routines (e.g. `insights-loop`)

A remote/cloud session starts from a fresh clone every run — nothing under `~/.claude/projects/` (session transcripts) persists across sessions. "Analyze the last N days of Claude Code session transcripts" therefore has no literal data to read beyond the current run's own in-progress transcript. Any routine making that claim should fall back to evidence that *does* persist — `git log --since`, open/merged PR history and their review comments, and CI check runs — and say plainly that it's using that fallback rather than implying it read transcripts that don't exist in this environment.

## Extending with tools

Add MCP servers (calendar, notes, issue tracker, CRM) by copying `.mcp.json.example` → `.mcp.json` (gitignored), then let your commands and skills reach them. Keep machine-local config and secrets in `.claude/settings.local.json` — copy the committed `.claude/settings.local.example.json` to start. Both real files are gitignored; never commit them.
