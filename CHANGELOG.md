# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- **`CLAUDE.md` and `AGENTS.md`** — reworked the *Open-PR hygiene* note into
  standing rules instead of a dated PR count: check for an already-open PR on the
  same *file*, not just the same topic, and extend it; split the open-PR count into
  blocked-on-an-external-event vs. ready-for-review; extend or close out a routine's
  prior branch, and confirm its earlier fix landed, before opening a new one. Added
  two subsections for the recurring PR-health check (`babysit-prs`): resolve purely
  additive, non-contradicting conflicts in shared append-only sections (a changelog,
  a running principles list) by keeping both entries, and after five consecutive
  unchanged "ready" check-ins say plainly that the only remaining step is a human
  merge decision. In `AGENTS.md`, documented `babysit-prs` as a routine with no
  command file (in *Available Commands* and as a known gap in *Scheduling*), and
  added a *Keep this map in sync* convention under *Key Conventions*: any change that
  adds, removes, renames or moves a command, hook, skill or top-level file updates
  the matching table in the same diff.
- **`AGENTS.md`** — new *Key conventions* bullet, *Play the market as a contest;
  fight only your own weaknesses*: a contest run within the rules (play offense,
  respect the opponent, the score a consequence of serving better), fair measure for
  good-faith counterparts, prudence rather than retaliation for the bad-faith one, the situation read before the posture is chosen — and the only war against
  your own weaknesses and the status quo, never a person. Links the new *Campaign*
  section.
- **`/morning-briefing`** and **`/weekly-review`** — one-line hooks to *Campaign*: the
  forward-moving item in today's Top 3 is a move you start, not a reply; the weekly
  summary names won vs. lost (deals and accounts gained and lost): conversations
  started, renewals and expansions secured, against accounts drifting and deals left
  to go quiet.
- **`README.md`** — docs-table row for `docs/principles-from-history.md` now lists
  the *Campaign* section.
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

- **`docs/principles-from-the-field.md`** — two more field principles with worked
  examples: write down only what you'll act on (notes carry actions, the recorder
  keeps the record), and only teach a method you've used to fix your own problem.
  Two matching candidate lines added to *Where these land in the kit*.
- **`docs/principles-from-the-field.md`** — three more field principles: review any
  conference, workshop or offsite within 24 hours (reread and mark up the notes, list the
  action items, talk it through with one person), count the people who paid attention
  rather than the people who showed up, and run a new motion in full while it is small,
  judging the early cycles on whether it ran in full rather than on volume. Three
  candidate skill and ritual updates added to the landing map.
- **`docs/principles-from-the-field.md`** — new *Pricing* section (charge one clear
  rate the buyer can add up in a minute, rather than a stack of separate fees), plus
  one principle each in *Alignment* (test the company's purpose by asking people to
  explain it to a newcomer) and *Dependencies* (write the customer's part next to every
  promised result, with an owner and a date), and an extension to the last-contact list
  for accounts you only see in person once or twice a year. Four candidate ritual and
  skill updates added to the landing map; README docs-table row lists the new section.
- **`docs/principles-from-the-field.md`** — four more field principles with worked
  examples: answer *why do you do it that way?* with the practical reason in the
  asker's terms (*Alignment*); hand over decisions in proportion to how well someone
  predicts your call, and say which of your opinions are positions (*Direction &
  authority*); the side that joins carries most of the change (*Change*). Four
  candidate updates added to the landing map.
- **`docs/principles-from-the-field.md`** — two more field principles: review a
  long-range goal one real problem at a time and end with one action today (*Alignment*),
  and put a small fixed amount into each core capability every week instead of a
  quarterly push (*Daily discipline*). Two candidate ritual updates added to the landing map.
- **`docs/principles-from-the-field.md`** — three more field principles with worked GTM
  examples: you only know a customer or team has adopted something when it keeps working
  after you step back, so schedule the step-back before you rely on it (*Change*); review
  what your filters turn away, not only what they let through (*Attention & inputs*); and
  a rule is broken after a story about why it was really made, so keep the reason beside
  the rule and answer the story when you hear it (*Standards*). Three candidate skill and
  ritual updates added to the landing map.
- **`docs/principles-from-history.md`** — new *Campaign* section. This section states
  the rule first; the military canon and the conflict research appear only where
  they independently agree. It opens by fixing the frame: the
  market is a contest run within the rules (play offense, train, respect the
  opponent, shake hands after, the score a consequence rather than the object); deal
  fairly with good-faith counterparts and meet the bad-faith actor with
  prudence, not retaliation; read the situation before choosing the posture (five
  questions, seven postures, a fixed order for moving between them, and six written
  tests before any public confrontation), with Rapoport (1960) and Axelrod (1984) as
  corroboration; and the only war is against your own weaknesses and the status quo
  (the 40–60% no-decision range, graded DIRECTIONAL). Thirteen principles follow,
  each with a worked go-to-market example — take the initiative, close the distance,
  a plan acted on, a clear picture, concentrate, lay siege to the recurring weakness,
  time, name the victory, count the cost, one owner and a written intent, the
  wholehearted few, morale, the supply line — quoting only wording verified
  (secondary) against independent copies of the primary: Nelson's Trafalgar
  Memorandum, Lincoln to McClellan (13 July 1862), Sun Tzu (Giles), Clausewitz
  (Graham), MacArthur (19 April 1951), Eisenhower (14 November 1957). Adds a *where
  the metaphor breaks* note (Kilduff et al. 2016, SOLID: rivalry raises unethical
  behavior), extends the misquote note (MacArthur, not Churchill; Moltke's actual
  1871 wording; the logistics line unsourced; Villeneuve's remark a legend), and
  credits every source with its grade.
- **`docs/principles-from-the-field.md`** — new *Changing minds* section: scope a pilot
  so a failure rules out one question rather than the whole approach; plan the first
  question around what the buyer already believes, because proof alone doesn't move a
  settled belief; budget a coaching ratio and an adoption window and judge the trend,
  not a week-two snapshot; and check whether someone can say "I was wrong" before you
  hire, partner, or bet a deal on them. Four candidate skill updates added to the
  landing map; README docs-table row refreshed.
- **`docs/principles-from-the-field.md`** — a new **Tools & capability** section carrying three
  principles on what a powerful new tool does to an operator's capability when no rule is attached
  to it: *whatever you let the tool do for you, expect to lose the ability to do yourself*
  (capability is maintained by use, so keep unassisted reps of the few capabilities your work rests
  on, and give the tool the step *after* the judgment is formed); *adoption is two decisions, and
  almost everyone only makes the first* (a two-line use policy — what it's for, what it must not
  touch — written the same week, or the tool drifts to its easiest use); and *well-written stopped
  being evidence of care* (polish is now free, so the correlation between how a document reads and
  how carefully its claims were made is broken — score sourcing before quality, and put your own
  sourcing on the page rather than behind it). Plus a fourth under **Decisions** — *before you cut a
  slow step, ask whether the slowness was the work*, with the test that the person bearing the
  effort of a step is the least reliable judge of whether it's waste. Landing-map and README rows
  updated.
- **`docs/principles-from-the-field.md`** — four additions: plan for each tool the motion runs on being down for three days, then stop preparing; ask for commitments the other side could genuinely refuse; after someone lets you down, add the one missing check and keep extending trust; and keep exact definitions of your core terms, because drift arrives as an edited definition. Four candidate ritual updates added to the landing map.
- **`docs/principles-from-the-field.md`**: new *Messaging* section (open with the
  buyer's problem in their words and put the central claim last, without cutting it)
  and new *Accounts* section (accounts cool slowly, so track three cooling dates and
  repeat the first-ninety-days work before launching anything new). *Change* gains a
  principle: write down why a lasting process exists before removing it, change the
  delivery freely, and change the rules underneath only on evidence. The cold-answer
  test is sharpened: drill harder than the real call, with hand-written answers that
  give a reason. Three candidate ritual updates added to the landing map, and the
  README docs-table row refreshed.

- **`docs/principles-from-the-field.md`** — five additions on what to do after something
  goes wrong between people: keep wrong calls, with dates, in customer stories and the
  origin record; go back with an ordinary work request after a sharp disagreement, or split
  the territory; put the reopening condition in the same message as a refusal; have the new
  lead talk to the working-level people in the first week of a handover; and after a lost
  deal, own it in one line and book the next useful call. Five candidate ritual updates
  added to the landing map.

- **`docs/principles-from-the-field.md`** — new *Developing people* section: give the
  strongest seller the same specific critique as everyone else; change a threshold for
  everyone in writing or not at all (one-off exceptions teach that the rule is an opening
  offer); size a correction to the mistake, with a misreported number always the top tier;
  and give a new hire a real account to own early. Four candidate ritual updates added to
  the landing map; README docs-table row refreshed.

- **`docs/principles-from-the-field.md`** — new *Liability* section: whoever switches an
  automation on owns what it does (risk follows control — unattended, reviewed, or sold —
  and the incident write-up names the decision that let the error out, never the tool);
  when you cause a customer a loss, pay back more than the loss and put your best people
  on the fix, sized by how avoidable it was; and in a payment dispute, never withhold the
  customer's own data or export. Plus two in *Direction & authority* (escalate when a
  problem stops someone's normal work, with the two-line question as the middle option;
  one named owner decides and a review is not a vote) and one in *Live moments* (explain
  to a new customer from where you stood when you were new). Six candidate skill and
  ritual updates added to the landing map; README docs-table row refreshed.

- **`docs/principles-from-the-field.md`** — new *Live moments* section (the omissions
  pass before doors open — what is missing, forgotten, could go wrong, answered by
  someone outside the planning; the opener owns the handoffs and confirms the next
  speaker before their slot; a problem that looks minor to you is not minor to the
  person raising it), plus one principle each in *Direction & authority* (three lines
  for everyone acting for you: decide alone, bring up, and who to) and *Morale* (say
  out loud that a role can be too much — nobody carrying one volunteers it). Five
  candidate skill and ritual updates added to the landing map; README docs-table row
  refreshed to list every section.

- **`docs/principles-from-the-field.md`** — new *Standards* section (enforce a written
  rule promptly or delete it), plus two more field principles: watch for a tactic you
  need more of each quarter for the same result, and grade a workshop or kickoff by what
  people do differently on day 30. Three candidate ritual updates added to the landing map.

- **`docs/principles-from-the-field.md`** — new *Morale* section: fund the celebration
  of wins in advance and spend it in full, and prepare the state you show a room the way
  you prepare its agenda. Two candidate ritual updates added to the landing map.

- **`docs/principles-from-the-field.md`** — six more field principles with worked
  GTM examples: bring a decision for review as the facts plus the case against, not
  the case for what you already decided (a review that can't return a no is a
  signature, not a check); being able to do something is not a reason to do it, the
  sibling of *approval is not justification*; filing a finding is not delivering it,
  so whoever learned it owns landing it with a named recipient; after a cut, report
  the number you were afraid it would damage, not just the money saved, and say
  where the freed capacity went; paying for a failure, fixing what broke and
  removing what caused it are three different jobs that teams reliably collapse into
  one; and the standard everyone agrees with is the one nobody audits. The *Where
  these land in the kit* map gains six candidate rows, covering the two-line
  pre-decision note, outcome-before-capability triage, named delivery on the
  cross-function loop, the threatened-metric-before-the-cut rule, the
  paid/repaired/removed close-out, and turning the periodic re-read into a check
  against real work.

- **`docs/principles-from-the-field.md`** — five more field principles with worked
  GTM examples: after a bad outing, name the mitigation and keep going, or stop in
  writing (going quiet is neither, and it's how capabilities die without anyone
  deciding); the longer a decision stays open the more dangerous the option looks,
  with no new evidence behind the change; the thing you haven't cleaned up is why
  you hedge in the room where directness pays; everyone traveling with you is the
  company, including at dinner; and a rep is enabled when they can answer cold, not
  when the material shipped. The *Where these land in the kit* map gains five
  candidate rows — mitigation-or-written-stop on the stop-doing step, the
  day-one-versus-today risk estimate, checking what's outstanding before coaching a
  technique, briefing the whole traveling group, and the cold-answer test built from
  the last ten calls.

- **`docs/principles-from-the-field.md`** — four more field principles with worked
  GTM examples: describing the finished state concretely (a plan nobody can picture
  doesn't move anyone, and the fix is unit conversion rather than eloquence), one
  name a day said specifically (with the obstacle-removing form that beats praise),
  conduct as the proof against content as the claim (including who is in the room
  being a decision rather than a rota), and the ten-minute entry rung in front of a
  deep asset. Four matching rows added to *Where these land in the kit*.
- **`docs/principles-from-the-field.md`** — five further field principles with worked
  GTM examples: run a discipline **fully for a fixed window** before you kill it (a
  half-run practice tests the penalty, not the value, so below full compliance no
  verdict is admissible); the **prose write-up test** (if it can't be written as
  continuous prose under a thousand words it isn't understood yet — bullets hide gaps,
  paragraphs can't); **ask before you improvise**, plus a sanction line on every new
  initiative (an initiative that was never approved doesn't become approved by
  working); **some things outrank what's on your calendar**, so name the short
  list that beats a scheduled commitment before you're in the moment (slack lowers the
  cost of acting on it, but it is not the principle — "I had no room" is the most
  respectable excuse there is); and **containment assumptions
  written as conditions** — the barriers you rely on *not* to fail, each with the
  condition that would break it, as the second half of the chokepoint register. Each
  mapped to its candidate landing spot in *Where these land in the kit*.

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

- **`docs/principles-from-the-field.md`** — added three more field principles with worked
  go-to-market examples. Under **Ownership:** *when a team underperforms, check who owns
  what before you check who's good* (most of what reads as a talent problem is ownership
  geometry — a capable person whose boundary is two millimetres wrong destabilizes the
  people around them, and the assembly, not any part, is the unit of strength). Under
  **Daily discipline:** *a rule you keep having to remind people about will get dropped —
  put it in the workflow instead* (distance from the workflow, not size, is what makes a
  standard heavy; ask who pays the cost each time it's applied, and use the post-change
  reminder count to check the artifact isn't decorative). Under **Character & judgment:**
  *score who changed after feedback, not who agreed with it* (names the selective hearer
  and the compliant non-changer, and why interviews reward the second). Refreshed the
  "Where these land in the kit" map with all three as candidate updates.
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
