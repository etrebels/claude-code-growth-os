@AGENTS.md

# Claude Code Growth OS — Claude Code notes

The working conventions, repository layout, rituals, hooks, rules and scheduling
are in [`AGENTS.md`](./AGENTS.md), imported above, so every coding agent reads the
same file. What follows is the part that only applies to Claude Code.

## Open-PR hygiene

This repo has accumulated open, unmerged PRs from prior sessions. Before opening a new PR: check `repo:etrebels/claude-code-growth-os is:pr is:open` for existing work on the same topic and continue or merge it rather than adding a near-duplicate. If a recurring skill's own prior PR is still open, that's a signal worth surfacing in its output, not a fresh PR to pile on top.

**Check the target *file*, not just the topic.** A "same topic" check isn't specific enough: on one day, three separate PRs (#65, #66, #67) were opened adding "field principles" to `docs/principles-from-the-field.md`, while a fourth (#55) was already open against that exact file. Before opening a PR whose primary change touches a given file, check for an *already-open* PR touching that same file specifically and extend it instead — a shared topic label isn't enough; a shared file is the real signal.

**Not all open PRs carry the same urgency — split them before reporting the count.** Some are *intentionally* held open, each blocked on a human-only event in a different repo (a "flip this live" step, a sibling kit going public) that no amount of re-checking resolves any faster. The others are the ones actually waiting on review — CI-green and conflict-free with nothing left for a routine to do. A raw "N open PRs" number treats both groups the same and understates how much is genuinely stuck — when reporting the count, name the split: `<blocked-on-external> blocked on an external/manual event, <needs-review> ready for review`.

**The rule keeps getting proven on `insights-loop` itself.** Naming the pattern doesn't break it — only merging does. A routine that opens a fresh dated branch every week without checking back on last week's branch, or on whether last week's fix even merged, is *how* PRs pile up — the fix is to extend or close out the prior branch before starting a new one, and to verify a previously-proposed fix actually landed before proposing it again.

### PR-health checks should resolve mechanical conflicts, not just re-report them

A PR-health check (`babysit-prs`, when it runs — documented in `AGENTS.md` under *Available Commands*) correctly treats a **content-contradicting** merge conflict as an editorial call outside its authority to resolve on its own. But it had been applying that same hold to conflicts that are purely **additive and non-contradicting** — two branches each adding their own entry under `CHANGELOG.md`'s single `## [Unreleased]` heading, where the fix is simply "keep both entries." **The fix:** before flagging a `CHANGELOG.md`-only conflict as "outside authorization," diff the two sides — if neither deleted or altered the other's lines (a pure two-way addition to the same section), merge `main` in, keep both entries, and say so in the status comment. Reserve the hold-and-flag behavior for conflicts where the two sides actually disagree about the same content.

**The fix generalizes past `CHANGELOG.md` — read it as filename-agnostic:** any shared, append-only section (a changelog, a running list of field principles, a rotation table) can take the same additive collision, and the same diff-first check resolves it the same way.

### A PR reported "ready" five times running is a merge decision waiting, not a check that needs to run again

A PR-health check (`babysit-prs`, when it runs) re-confirms a ready PR as CI-green and conflict-free on every check-in. Repeating an unchanged status is correct behavior for a routine with no merge authority, but it produces no new information after the first repeat — the second and every subsequent "still ready" confirms only that the routine ran, not that anything changed. Faithful status reporting is not the same as a decision getting made. **The fix:** after five consecutive unchanged "ready" check-ins on a PR with no open blocker the routine can act on and no human response, treat it as a decision backlog, not a healthy queue: the status comment should say so plainly — *"ready for N checks running; the only remaining step is yours"* — rather than restating the same table or adding another identical comment. That turns a silent plateau into a visible one without granting the routine any new authority.

## Session-analysis routines (e.g. `insights-loop`)

A remote/cloud session starts from a fresh clone every run — nothing under `~/.claude/projects/` (session transcripts) persists across sessions. "Analyze the last N days of Claude Code session transcripts" therefore has no literal data to read beyond the current run's own in-progress transcript. Any routine making that claim should fall back to evidence that *does* persist — `git log --since`, open/merged PR history and their review comments, and CI check runs — and say plainly that it's using that fallback rather than implying it read transcripts that don't exist in this environment.

## Extending with tools

Add MCP servers (calendar, notes, issue tracker, CRM) by copying `.mcp.json.example` → `.mcp.json` (gitignored), then let your commands and skills reach them. Keep machine-local config and secrets in `.claude/settings.local.json` — copy the committed `.claude/settings.local.example.json` to start. Both real files are gitignored; never commit them.
