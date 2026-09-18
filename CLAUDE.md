@AGENTS.md

# Claude Code Growth OS — Claude Code notes

The working conventions, repository layout, rituals, hooks, rules and scheduling
are in [`AGENTS.md`](./AGENTS.md), imported above, so every coding agent reads the
same file. What follows is the part that only applies to Claude Code.

## Open-PR hygiene

This repo has accumulated open, unmerged PRs from prior sessions (7 open as of 2026-07-05; #38 has since merged, but the count has since drifted back up to 6 as of 2026-08-09, several dating to early July). Before opening a new PR: check `repo:etrebels/claude-code-growth-os is:pr is:open` for existing work on the same topic and continue or merge it rather than adding a near-duplicate. If a recurring skill's own prior PR is still open, that's a signal worth surfacing in its output, not a fresh PR to pile on top.

**The rule keeps getting proven on `insights-loop` itself.** #38 sat unmerged for four weeks before merging; its successor, #53 (opened 2026-07-19, "codify `/babysit-prs`, fix hygiene drift" — itself a fix for this exact problem), sat as a draft for three weeks and has since drifted into a real merge conflict with `main` (`mergeable_state: dirty`) as unrelated content landed on top of it. A routine that opens a fresh dated branch every week without checking back on last week's branch is *how* PRs pile up, not just a bystander reporting it — the fix is to extend or close out the prior branch before starting a new one, not just to log the number.

## Session-analysis routines (e.g. `insights-loop`)

A remote/cloud session starts from a fresh clone every run — nothing under `~/.claude/projects/` (session transcripts) persists across sessions. "Analyze the last N days of Claude Code session transcripts" therefore has no literal data to read beyond the current run's own in-progress transcript. Any routine making that claim should fall back to evidence that *does* persist — `git log --since`, open/merged PR history and their review comments, and CI check runs — and say plainly that it's using that fallback rather than implying it read transcripts that don't exist in this environment.

## Extending with tools

Add MCP servers (calendar, notes, issue tracker, CRM) by copying `.mcp.json.example` → `.mcp.json` (gitignored), then let your commands and skills reach them. Keep machine-local config and secrets in `.claude/settings.local.json` — copy the committed `.claude/settings.local.example.json` to start. Both real files are gitignored; never commit them.
