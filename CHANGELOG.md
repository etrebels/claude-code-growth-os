# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] — 2026-05-25

First public release — the open-core scaffold for running your whole
go-to-market inside Claude Code. Structure is included; the judgment you put
inside it is yours to add.

### Added

- **Hooks** (`.claude/hooks/`) — five guardrails: session-start context,
  state re-injection across compaction, a commit secret-guard, sensitive-file
  write protection, and an end-of-day nudge. Pure bash, no dependencies.
- **Rituals** (`.claude/commands/`) — `/morning-briefing`, `/midday-checkin`,
  `/end-of-day`, `/weekly-review`, and a `/demo-briefing` that runs the whole
  loop on fictional sample data.
- **Skills** (`.claude/skills/`) — go-to-market skill templates across all four
  functions (marketing, sales, product, retention), plus cross-cutting helpers
  and an example template to copy.
- **Operating surfaces** (`ops/`) — plain-text playbook templates: priorities,
  pipeline, customers, daily log, and roadmap signals. Yours to fill.
- **Demo** (`demo/`) — a fully fictional pipeline, customer book, meeting notes,
  and feedback log, so the whole motion runs in about 30 seconds and is safe to
  present from.
- **Docs** — the operating model (the bowtie, the six handoffs, net revenue
  retention as the one number), the methodology, a sourced argument for running
  the four functions as one system, and a pre-launch scrub checklist.
- **Project hygiene** — README with a demo animation, MIT license, contributing
  guide, security policy, code of conduct, and issue + pull-request templates.

[0.1.0]: https://github.com/etrebels/claude-code-growth-os/releases/tag/v0.1.0
