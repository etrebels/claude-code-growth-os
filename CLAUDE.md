@AGENTS.md

# Claude Code Growth OS — Claude Code notes

The working conventions, repository layout, rituals, hooks, rules and scheduling
are in [`AGENTS.md`](./AGENTS.md), imported above, so every coding agent reads the
same file. What follows is the part that only applies to Claude Code.

## Open-PR hygiene

This repo has accumulated open, unmerged PRs from prior sessions (7 open as of 2026-07-05, drifted to 6 by 2026-08-09, and back up to **9 as of 2026-09-06**). Before opening a new PR: check `repo:etrebels/claude-code-growth-os is:pr is:open` for existing work on the same topic and continue or merge it rather than adding a near-duplicate. If a recurring skill's own prior PR is still open, that's a signal worth surfacing in its output, not a fresh PR to pile on top.

**Check the target *file*, not just the topic.** The count kept climbing because the "same topic" check wasn't specific enough: on 2026-09-05 alone, three separate PRs (#65, #66, #67) were opened adding "field principles" to `docs/principles-from-the-field.md`, while a fourth (#55, opened 2026-08-02) was already open against that exact file. Before opening a PR whose primary change touches a given file, check for an *already-open* PR touching that same file specifically and extend it instead — a shared topic label isn't enough; a shared file is the real signal.

**The rule keeps getting proven on `insights-loop` itself.** #38 sat unmerged for four weeks before merging; #53 (opened 2026-07-19, "codify `/babysit-prs`, fix hygiene drift" — itself a fix for this exact problem) was closed as superseded without shipping; #58 documented the gap again instead of shipping it; #62 (opened 2026-08-23) tried to document it a third time and is *itself* still open two weeks later. Three consecutive weekly runs have now touched this one gap without landing a fix on `main`. A routine that opens a fresh dated branch every week without checking back on last week's branch, or on whether last week's fix even merged, is *how* PRs pile up — the fix is to extend or close out the prior branch before starting a new one, and to verify a previously-proposed fix actually landed before proposing it again.

**"Ready for review" reported forever is not the same as landed.** A background PR-health routine (see `babysit-prs` below) has posted an accurate "CI green, no conflicts, ready for your review" comment on #55 **eleven times** over five weeks (2026-08-03 → 2026-09-04) with zero merges — faithful status reporting substituting for a decision ever getting made. A PR with 5+ consecutive "no action, ready" reports and no human response is a decision backlog, not a healthy queue — surface it as one rather than adding a twelfth identical comment.

## Session-analysis routines (e.g. `insights-loop`)

A remote/cloud session starts from a fresh clone every run — nothing under `~/.claude/projects/` (session transcripts) persists across sessions. "Analyze the last N days of Claude Code session transcripts" therefore has no literal data to read beyond the current run's own in-progress transcript. Any routine making that claim should fall back to evidence that *does* persist — `git log --since`, open/merged PR history and their review comments, and CI check runs — and say plainly that it's using that fallback rather than implying it read transcripts that don't exist in this environment.

## Extending with tools

Add MCP servers (calendar, notes, issue tracker, CRM) by copying `.mcp.json.example` → `.mcp.json` (gitignored), then let your commands and skills reach them. Keep machine-local config and secrets in `.claude/settings.local.json` — copy the committed `.claude/settings.local.example.json` to start. Both real files are gitignored; never commit them.
