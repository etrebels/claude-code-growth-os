# Repository map

The directory layout, file by file. Moved here from `AGENTS.md` so the
instruction file carries how to work, not what is on disk — a layout an agent can
list for itself does not need to sit in every session's context.

```
claude-code-growth-os/
├── CLAUDE.md                        # Project config, conventions, session protocol
├── AGENTS.md                        # This file
├── README.md                        # Public-facing overview and quick-start
├── CHANGELOG.md                     # Version history
├── CONTRIBUTING.md                  # Contribution guidelines
├── SECURITY.md                      # Security policy
├── CODE_OF_CONDUCT.md               # Community standards
├── LICENSE                          # MIT license
├── THIRD-PARTY-NOTICES.md           # Credits for adapted third-party patterns
├── inbox/
│   └── notes.md                     # /capture staging buffer — raw notes, triaged later
├── ops/                             # LIVE STATE LAYER — mutable, routines read/write
│   ├── pipeline.md                  # Live deal board (one line per open deal)
│   ├── customers.md                 # Post-sale account health
│   ├── priorities.md                # This week's priority + today's Top 3
│   ├── daily-log.md                 # Append-only field-capture log
│   ├── feedback-log.md              # Cross-function feedback loops (sales→marketing, post-sale→product)
│   ├── roadmap-signals.md           # Field/retention signals → product
│   ├── chokepoints.md               # The few narrow dependencies most revenue flows through
│   ├── direction-register.md        # Live standing direction — outranks a conflicting rule
│   └── icp.md                       # Ideal customer profile definition
├── demo/                            # Fictional-data sandbox for testing rituals
│   ├── pipeline.md
│   ├── customers.md
│   ├── priorities.md
│   ├── daily-log.md
│   ├── feedback-log.md
│   ├── roadmap-signals.md
│   ├── support-tickets.md
│   └── meetings/                    # Sample meeting notes
├── docs/                            # Reference documentation
│   ├── operating-model.md           # Bowtie, six handoffs, the one number (NRR)
│   ├── methodology.md               # Why this system is built the way it is
│   ├── designing-loops.md           # Why the loop, not the prompt, is the thing you design
│   ├── connecting-a-crm.md          # CRM projection loop and find-or-create mechanics
│   ├── first-ritual.md              # Getting-started guide
│   ├── launch-scrub-checklist.md    # Pre-launch safety checklist
│   ├── why-align.md                 # Why sales + marketing alignment matters
│   ├── why-brand.md                 # Why brand investment matters
│   ├── principles-from-history.md   # Operating principles sourced from history
│   ├── principles-from-science.md   # Operating principles sourced from science
│   ├── principles-from-the-field.md # Operating principles from running the motion itself
│   └── assets/                      # Diagrams, images
├── .github/
│   └── workflows/                   # CI: scheduled deterministic checks + shellcheck on hooks
├── .claude/
│   ├── settings.json                # Claude Code settings (hooks, permissions)
│   ├── settings.local.example.json  # Template for local secrets config (gitignored when copied)
│   ├── commands/                    # Slash commands — the daily rituals
│   │   ├── morning-briefing.md      # Recap yesterday, surface priorities, set today's top three
│   │   ├── midday-checkin.md        # Mid-day reset — done, slipping, what to protect
│   │   ├── end-of-day.md            # Daily-log entry + tomorrow's Top 3
│   │   ├── weekly-review.md         # Weekly patterns + next week's one priority
│   │   ├── retention-report.md      # Monthly NRR/GRR readout from the customer book
│   │   ├── capture.md               # Drop a raw note now, triage it later
│   │   ├── reconcile.md             # Catch drift when multiple sessions write the same files
│   │   └── demo-briefing.md         # The morning ritual run on the fictional demo/ data
│   ├── hooks/                       # Guardrails that fire on events
│   │   ├── session-start.sh         # Surfaces ops/priorities.md + feedback-log signals
│   │   ├── pre-compact.sh           # Re-injects priorities + latest log before compaction
│   │   ├── protect-files.sh         # Blocks writes to secrets and .env files
│   │   ├── verify-after-change.sh   # Post-change link check + optional project verifier (advisory)
│   │   ├── stop-reminder.sh         # Nudges /end-of-day until today is logged
│   │   ├── pre-commit-guard.sh      # Git pre-commit hook — blocks likely secrets
│   │   └── web-bootstrap.sh         # Installs shellcheck on cloud/web sessions only
│   ├── rules/                       # Standing constraints every session honors
│   │   ├── README.md                # Rules overview and conventions
│   │   ├── crm-usage.md             # CRM-over-MCP: docs-first protocol, write-authority guardrails
│   │   └── todo-single-source.md    # One to-do list, rendered one way (the canonical spec)
│   ├── scheduling/                  # Running rituals on a clock
│   │   ├── README.md                # Three-layer scheduling overview (local / cloud / CI)
│   │   └── cloud-routines.md        # Cloud Routines runbook (Anthropic-hosted)
│   ├── scripts/
│   │   ├── verify.sh.example        # Template for your own post-change verifier
│   │   └── checks/
│   │       └── growth-os-checks.sh  # Deterministic checks run by CI / scheduled jobs
│   └── skills/                      # Reusable growth skills (one directory per skill)
│       ├── account-health/          # Post-sale health review for a named account
│       ├── calendar-followup/       # Draft follow-up based on today's calendar events
│       ├── churn-save/              # Recovery play for a red/amber account
│       ├── cold-outreach/           # Generate a targeted cold outreach sequence
│       ├── content-repurpose/       # Repurpose a piece of content across channels
│       ├── event-to-pipeline/       # Work a conference or event into booked calls
│       ├── example-skill/           # Template / reference skill
│       ├── expansion-signal/        # Work a ready-to-grow account and hand it to sales
│       ├── follow-up/               # Draft a follow-up for a named deal or contact
│       ├── inbox-digest/            # Summarize and triage inbound messages
│       ├── lead-qualify/            # Score a lead against the ICP fit check
│       ├── marketing-feedback/      # Surface MARKETING-ACTION tags from ops/
│       ├── meeting-prep/            # Prep brief for a named meeting or prospect
│       ├── onboarding-handoff/      # CS handoff document for a new customer
│       ├── product-signal/          # Surface FEATURE-REQUEST / RETENTION-RISK tags
│       ├── qbr-prep/                # Value-realization review brief for a customer
│       ├── retention-feedback/      # Surface RETENTION-RISK tags for review
│       ├── status-update/           # Draft a status update for a named deal or account
│       ├── support-signal/          # Cluster support tickets into ranked product themes
│       └── triage/                  # Triage open items across ops/ files
└── .mcp.json.example                # Template for MCP server config (copy → .mcp.json, gitignored)
```

