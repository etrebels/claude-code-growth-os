# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- README cross-link to the sibling kit, [Claude Code Startup OS](https://github.com/etrebels/claude-code-startup-os) — the founder's stage before a repeatable motion (searching), where this kit runs the motion itself (scaling).

### Changed

- **`CLAUDE.md`** — refreshed the *Open-PR hygiene* note (7 open PRs as of 2026-07-05,
  #38 since merged, but the count has drifted back up to 6 as of 2026-08-09) and named
  the pattern plainly: `insights-loop`'s own prior deliverable (#53, opened
  2026-07-19) sat as a draft for three weeks and drifted into a merge conflict —
  proof that opening a fresh dated branch every week without checking back on last
  week's is *how* the backlog grows, not just a number to log. Added a new
  *Session-analysis routines* section naming that a cloud/web session has no
  persisted session-transcript history across runs (`~/.claude/projects/` doesn't
  survive a fresh clone), so a routine like `insights-loop` should fall back to
  git/PR/CI history as its evidence base and say so, rather than implying it read
  transcripts that don't exist in this environment.
- **`AGENTS.md`** — repository map and commands table were missing `/capture`,
  `/reconcile`, and `/retention-report` (all shipped in earlier releases); backfilled
  alongside their existing descriptions in `docs/first-ritual.md` / `.claude/rules/`.

### Added

- **`docs/principles-from-the-field.md`** — five more field principles with worked
  GTM examples: the wait-state your-side checklist (a deal "waiting on them" still
  has work on your side), the closing-terms pass (concession pressure peaks at
  signing), the partner-risk ledger (repay risk taken for you from strength),
  converting a hostile counterpart at their moment of need, and the postdating
  ratio that puts the origin-record retelling on a calendar trigger. Each mapped
  to its candidate landing spot in *Where these land in the kit*.

- **`ops/chokepoints.md`** — a new standing list for the few narrow dependencies most
  of the revenue actually flows through (dependency · who controls it · what breaks
  without it · what would de-risk it · owner · carried-since), pre-seeded with
  fictional rows like the rest of `ops/`. Deliberately short — five-ish passages, not
  a long risk register. Carries a re-rating rule: a row unresolved for 3+ reviews is
  re-rated, not dropped.

### Changed

- **`/weekly-review`** — wired in three of the four new field principles. A new
  **chokepoint read** (step 10) walks `ops/chokepoints.md` for concentration changes
  and unowned rows, and doubles as a news filter. The **stop-doing step** (step 12)
  now requires the prune sentence — *cut so that X improves, measured by Y, checked
  on `<date>`* — before anything is removed; no sentence, no cut. And a new **quarterly
  addendum** covers the advantages you didn't earn (named maintainer + going-away
  signal per input, cross-checked against the chokepoint list) and a check that the
  origin record still exists and is being read before playbook training.

- **`docs/principles-from-the-field.md`** — added four more field principles with worked
  go-to-market examples, in two new sections. **Dependencies:** *name the few chokepoints
  your revenue flows through, and who controls each one* (a short list of narrow
  dependencies beats a long risk register — and it doubles as the filter that makes
  market news readable), and *track the advantages you didn't earn* (unearned inputs are
  the ones you stop noticing and therefore stop protecting; overlap with the chokepoint
  list is the quarter's top risk). **Institutional memory:** *write down how you won your
  first ten customers, and put it in onboarding* (the current process is an abstraction
  of the origin motion and sheds load-bearing parts; annotate each gate with the deal
  that produced it). Under **Decisions:** *before cutting a program, name what gets
  stronger because of the cut* (pruning names what improves and when it's checked;
  dismantling doesn't — an unverified cut is recorded as a dismantling). Refreshed the
  "Where these land in the kit" map with the four as candidate updates.
- **`docs/principles-from-the-field.md`** — added four more field principles with worked
  go-to-market examples: *two teams stop fighting when both are measured on the same
  number* (put both on one shared scoreboard instead of refereeing the handoff), *keep a
  last-contact date on every account, oldest first* (the oldest-silent accounts churn
  first, and surface before the metric does), *take a problem with someone straight to
  them, in private, first* (a direct-and-private-first escalation ladder; don't vent
  sideways, don't assume bad intent), and *hire for who holds up under pressure, then
  give them time* (pick for pressure-tolerance over polish; don't judge a half-finished
  pick by the snapshot). Refreshed the "Where these land in the kit" map with the four
  as candidate updates.
- **`docs/principles-from-the-field.md`** — added three field principles with worked
  go-to-market examples: *a problem going quiet is not the same as a problem being
  fixed* (a quieted symptom is not a fixed root), *hear both sides before you assign
  fault* (both accounts on the record
  before attributing a miss), and *removing the blocker doesn't remove the habit*
  (pair a structural change with re-education; behaviour, not the switch, is the done
  signal). Refreshed the "Where these land in the kit" map with the three as candidate
  updates.

### Added

- **`event-to-pipeline` skill** (`.claude/skills/event-to-pipeline/SKILL.md`) — turn a
  conference, meetup, or event you attend or host into booked calls: book the next
  step rather than hold it on the floor, a QR to your booking link, a call-earning
  offer, fit-sorting on the spot, and a 48–72h follow-up. Includes the Voss
  calibrated question for "let me think about it".
- **`/capture` ritual + `inbox/`** (`.claude/commands/capture.md`) — a capture-now,
  triage-later inbox so a passing thought doesn't cost a context switch; triage routes
  each note to the lane that owns it (task list, notes/wiki, CRM, customer book,
  feedback log) and never lets the inbox become a second to-do list. Adapts the
  `/capture` pattern from [claude-context-os](https://github.com/conorbronsdon/claude-context-os)
  (Conor Bronsdon, MIT).
- **`/reconcile` ritual** (`.claude/commands/reconcile.md`) — catches drift when more
  than one session (you, plus a scheduled cloud routine) writes the same files:
  mirror-vs-CRM, tasks-vs-priorities, log-vs-reality, and stale open loops. Adapts the
  `/reconcile` pattern from claude-context-os. Both new rituals defer to
  `todo-single-source.md`; both are credited in `THIRD-PARTY-NOTICES.md`.

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
- **Model-choice guidance for scheduled rituals** (`.claude/scheduling/README.md`)
  — which tier to run a ritual on: a cheap/default model for the daily loop, the
  frontier tier for the few judgment-heavy runs (weekly review, retention report).
  Written tier-generic so it survives model releases.
- **Retention act-skills — the right side gets more than a detector**
  (`.claude/skills/`): `churn-save` (recover a red/amber account — the real risk,
  the re-engagement draft, the renewal-clock timing), `expansion-signal` (work a
  ready-to-grow account into an angle and a clean hand to sales), `qbr-prep`
  (assemble a value-realization QBR brief from the book, recent notes, and roadmap
  status), and `support-signal` (cluster a batch of support tickets into ranked
  product themes, then hand them to `product-signal`). `account-health` now hands
  off to `churn-save` / `expansion-signal`; together they close the customer-success
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
- **Principles from the field** (`docs/principles-from-the-field.md`) — a third
  thinking-aid companion to the science and history pages: operating principles
  drawn from running the motion itself (ownership, daily focus, decisions, reading
  the return, judgment, attention), each with a worked go-to-market example and a
  map of where it lands in the kit; linked from the README docs table. Its
  ritual-facing updates are applied to the daily commands: an explicit
  forward-motion question in `/morning-briefing`, an ownership read and a
  relationship-quality read in `/weekly-review`, and a "lion check" for
  repeatedly-deferred tasks in `/end-of-day`.
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
