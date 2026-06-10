# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

_Nothing yet — next changes land here._

## [0.2.0] — 2026-06-10

Hardening release: the hooks now behave as documented, the kit installs with no
external plugin dependency, and the accumulated retention, CRM, and scheduling
features below are rolled up from the previous `[Unreleased]`.

### Added

- **Post-change verify hook** (`.claude/hooks/verify-after-change.sh` +
  `PostToolUse(Edit|Write)` wiring in `.claude/settings.json`) — the loop's
  "verify" step as a hook: after a write lands it checks broken relative links in
  the changed markdown file and runs your own `.claude/scripts/verify.sh` if you
  supply one (copy `.claude/scripts/verify.sh.example` to wire `make check`,
  `npm test`, `pytest`, the `checks/` dir, etc.). Advisory only — it warns, never
  blocks.
- **Retention act-skills — the right side gets more than a detector**
  (`.claude/skills/`): `churn-save` (recover a red/amber account — the real risk,
  the re-engagement draft, the renewal-clock timing), `expansion-play` (work a
  ready-to-grow account into an angle and a clean hand to sales), `qbr-prep`
  (assemble a value-realization QBR brief from the book, recent notes, and roadmap
  status), and `support-signal` (cluster a batch of support tickets into ranked
  product themes, then hand them to `product-signal`). `account-health` now hands
  off to `churn-save` / `expansion-play`; together they close the customer-success
  playbook on the right side of the bowtie. (#39)
- **`/retention-report` command** (`.claude/commands/retention-report.md`) — a
  monthly readout that rolls the customer book up to NRR and GRR (formulae named,
  computed from the `ARR` column over git history), churn by reason, and expansion,
  then writes next month's two bets to `ops/priorities.md`. Scheduled monthly in
  `.claude/scheduling/cloud-routines.md`. (#39)
- **`ARR` column in the customer book** (`ops/customers.md`, `demo/customers.md`) —
  the recurring revenue that rolls up to NRR, captured at the `onboarding-handoff`
  seam so `/retention-report` can compute it. Seeded in the demo data, alongside a
  `demo/support-tickets.md` batch and a `demo/meetings/` value-review note so the
  new skills run against realistic data out of the box. (#39)
- **Cloud Routines scheduling** (`.claude/scheduling/`) — a runbook for running the
  rituals on Anthropic-managed infrastructure without your machine awake
  (`cloud-routines.md`), plus a three-layer scheduling overview (OS scheduler vs
  cloud Routines vs CI backstop) in `.claude/scheduling/README.md`. (#31)
- **Operating rules** (`.claude/rules/`) — standing constraints every session *and*
  autonomous routine honors: `crm-usage.md` (the docs-first MCP access protocol, the
  three-lane tasks≠deals convention, and write-authority guardrails for unattended
  runs) and `todo-single-source.md` (one canonical to-do render spec every entry path
  defers to). Wired into the rituals and `CLAUDE.md`. (#31)
- **Scheduled-reviews CI backstop** (`.github/workflows/scheduled-reviews.yml` +
  `.claude/scripts/checks/growth-os-checks.sh`) — deterministic, no-model checks
  (structure, freshness, broken local links; HARD→exit 1, SOFT→exit 0) run weekly
  from the default branch, so a structural problem surfaces even in a quiet week.
  `shellcheck` CI now lints `.claude/scripts/` alongside `.claude/hooks/`. (#31)
- **Loop signals at session start** (`.claude/hooks/session-start.sh`) — the hook now
  also surfaces the freshest `ops/feedback-log.md` signals, so the cross-function
  loop can't go stale silently. (#31)
- **Principles from science** (`docs/principles-from-science.md`) — twenty-one
  portable operating principles drawn from seven sciences, each with two sourced
  quotes and a worked go-to-market example; linked from the README docs table. (#26)
- **Web-session bootstrap hook** (`.claude/hooks/web-bootstrap.sh`) — a
  SessionStart hook that installs `shellcheck` in remote / Claude-Code-on-the-web
  containers only, so the hook lint (`.github/workflows/shellcheck.yml`) also runs
  in-session. Skipped locally, idempotent, and non-blocking. (#23)
- **Demand-side argument** (`docs/why-brand.md`) — the companion to `why-align`:
  where demand comes from (the 95-5 reality, mental & physical availability, the
  brand-vs-activation split), with sources. (#21)
- **Fictional starter data in `ops/`** — the operating books now ship seeded with
  a coherent set of fictional accounts (pipeline, customers, daily log, feedback
  log, roadmap signals) so the rituals run against realistic data out of the box.
  (#15, #16)
- **Connecting-a-CRM guide** (`docs/connecting-a-crm.md`) — an optional pattern
  for making an existing CRM the system of record and projecting it into
  `ops/pipeline.md`, so you never run two pipelines. (#12)
- **First-ritual guide** (`docs/first-ritual.md`) — a 5-minute walkthrough that
  copies `/midday-checkin` into your own ritual, linked from the README. (#10)
- **Shellcheck CI** (`.github/workflows/shellcheck.yml`) — lints the bash hooks
  in `.claude/hooks/` on every push and pull request. (#9)

### Changed

- **`meeting-prep` skill** (`.claude/skills/meeting-prep/SKILL.md`) — question
  guidance upgraded with Chris Voss labeling and calibrated What/How questions
  (label-then-ask, the two closes, a replace-on-sight list for why/yes-no). (#25)
- **Explicit effort level** (`.claude/settings.json`) — pins `effortLevel: "xhigh"`
  so the rituals get full reasoning for long-horizon, multi-step work regardless of
  the model's default (degrades gracefully on Sonnet). (#24)
- **Tightened stat sourcing** in `docs/why-align.md` and `docs/operating-model.md`
  — a primary-source audit reframed unverifiable vendor figures as directional,
  led with peer-reviewed evidence, corrected the win-loss and feature-usage
  attributions, and rebuilt the Sources list into tiers. (#17, #18, #19, #20, #22)
- **Commit secret-guard** (`.claude/hooks/pre-commit-guard.sh`) — broadened to
  catch GitHub fine-grained PATs and OAuth/server tokens, Google API keys, and
  Stripe live keys, with the covered formats documented inline. (#8)

### Fixed

- **Broken doc links in four skill templates** (`marketing-feedback`,
  `onboarding-handoff`, `product-signal`, `retention-feedback`) — they pointed at
  `../../docs/…` (which resolves to a non-existent `.claude/docs/`) instead of
  `../../../docs/…`. Surfaced by the new checks script on its first run. (#31)
- **Stop-hook nudge now reaches you.** `stop-reminder.sh` emitted its
  "run /end-of-day" reminder to stderr on exit 0 — which a Stop hook surfaces only
  as a terse `hook error` notice in the transcript, not as a readable nudge. It now
  emits a JSON `systemMessage`, the supported way to show a Stop-hook message in the
  default UI without forcing the turn to continue.
- **`security-guidance` plugin reference removed** from `.claude/settings.json` —
  it was undocumented and pointed at a marketplace a fresh clone can't resolve,
  breaking the "no setup, runs anywhere out of the box" promise. Add your own
  plugins locally if you use them.
- **PreCompact claim corrected** (README + CLAUDE.md). A `PreCompact` hook's stdout
  is not guaranteed to be re-injected into context (it's best-effort and
  version-dependent). The durable guarantee is that state lives in files and
  `session-start.sh` reloads it every session — so the docs now credit SessionStart
  as the reliable re-load, not PreCompact.
- **Pre-commit secret guard scans only added lines**, so a commit that *removes* a
  leaked secret is no longer blocked; **`autoMemoryEnabled` set to `false`** so a
  public kit carrying prospect detail doesn't persist it outside the repo; the
  paid-offer CTA URL made consistent across README and the issue template.

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

[0.2.0]: https://github.com/etrebels/claude-code-growth-os/releases/tag/v0.2.0
[0.1.0]: https://github.com/etrebels/claude-code-growth-os/releases/tag/v0.1.0
