# Contributing

This is a starter — a clean, generic scaffold people fork and fill. Contributions that keep it that way are welcome.

## Good contributions

- **New hooks** — generic guardrails or automations (a useful PreToolUse check, a smarter session-start). Pure bash where possible; `python3` is fine where you need to parse a payload. No other dependencies.
- **New ritual commands** — a daily/weekly ritual that generalizes beyond one job.
- **New skill templates** — a repeatable unit of work with a specific trigger `description`.
- **Docs and examples** — clearer quickstart, a worked example for a different kind of work (research, support, content).

## The one rule

**Keep it generic. No real data, ever.** No real company names, playbooks, pricing, credentials, or personal data — in code, commits, or examples. The `demo/` folder is fictional and must stay that way. If a contribution only makes sense with your private content in it, it belongs in your fork, not here.

A note on scope: this repo is the free chassis of an [open-core ladder](README.md#whats-free-vs-whats-paid). Patterns, generic templates, and chassis improvements belong here; filled playbooks and named-tool integration packs are what the paid tier sells, so maintainer additions of that shape land there instead (the boundary is written down in [`.claude/rules/open-core-boundary.md`](.claude/rules/open-core-boundary.md)). Community contributions that fit the "good contributions" list above always land here, under MIT, with credit — never behind the paywall.

## Conventions

- Markdown for commands, skills, ops, and docs.
- Commands and skills lead with a clear, specific `description` — it's the trigger.
- Hooks must run with no setup and no secrets. Make destructive or blocking behavior obvious.
- Keep the README skimmable; put depth in `docs/`.

## Before you open a PR

- Run `/demo-briefing` and confirm it still works.
- Install and trip the commit guard: `ln -s ../../.claude/hooks/pre-commit-guard.sh .git/hooks/pre-commit`, then try committing a fake key — it should block.
- Keep the diff focused; one idea per PR.

## Code of conduct

By taking part, you agree to uphold our [Code of Conduct](CODE_OF_CONDUCT.md) — be kind, assume good intent, keep it professional.
