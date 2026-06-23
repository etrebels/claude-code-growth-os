# The Operating Model

How the four functions run as one motion in this kit. [`why-align.md`](why-align.md) is the *argument* — why marketing, sales, product, and retention belong in one system. This is the *spine* — the handoffs, the one number, and the shared definitions that make it run. The two are meant to be read together.

> The figures below are directional and attributed where used. Treat the **direction** as well-supported and the **magnitudes** as soft. Sources are in [`why-align.md`](why-align.md#sources).

## The bowtie, not the funnel

Draw the customer journey honestly and it isn't a funnel that ends at the sale — it's a **bowtie**. The left half is what most teams instrument: demand and acquisition. The right half is the one the funnel forgets: onboarding, adoption, renewal, expansion. **Two of the three ways a company grows happen after the first sale** (Winning by Design). That right half is where net revenue retention lives — and a leaking bucket can't be filled by pouring in more acquisition.

So the seams a buyer feels aren't only marketing↔sales. They're sales↔the product received, and product↔whether anyone helps the customer get value. Four hands on one motion, not four stages of a relay.

## The four functions

| Function | Owns | On the bowtie |
|---|---|---|
| **Marketing / Demand** | Awareness, demand, the buyer's first surfaces | Left — top |
| **Sales** | Qualification, the deal, the close | Left — bottom |
| **Product** | What the customer actually receives and adopts | Center — the knot |
| **Retention** | Onboarding, adoption, renewal, expansion | Right |

Run as four separate systems, each optimizes its own metric at the others' expense. Run as one, the signal compounds: what sales hears shapes marketing; what customers do shapes product; what product ships re-arms sales.

## The six handoffs

A motion is only as strong as its handoffs. Each one has a **trigger**, an **owner**, and an **artifact** — the place it's written down so it can't drop.

| # | Handoff | Trigger | Owner | Artifact |
|---|---|---|---|---|
| **H1** | Marketing → Sales | A lead clears the MQL→SQL bar | Marketing | A qualified lead in `ops/pipeline.md` |
| **H2** | Sales → Marketing | Sales hears a recurring objection, competitor, missing proof, or win/loss reason | Sales | A `MARKETING-ACTION` line in the feedback log (`marketing-feedback`) |
| **H3** | Won → Onboarding | A deal is marked won | Sales → customer success (CS) | The first `ops/customers.md` row, with the value hypothesis carried forward (`onboarding-handoff`) |
| **H4** | CS → Product | Adoption friction, a churn reason, or a request blocking adoption/expansion | CS | A routed item in `ops/roadmap-signals.md` (`product-signal`) |
| **H5** | Product → GTM | A capability ships | Product | The one-line "what this means for the buyer" in `ops/roadmap-signals.md`, handed to sales and marketing (`product-signal`) |
| **H6** | CS → Marketing | A customer reaches a clear outcome | CS | A reference / proof point — the customer's own words for the value they got |
| **L** | Loop close | Weekly review | All four | `MARKETING-ACTION` cleared, `RETENTION-RISK` routed, references captured — read in `/weekly-review` |

H1 and H2 are the loop most teams can see. H3–H6 are the right side of the bowtie — the half usually left with no owner. **H3 is the seam most teams never define**: a signed deal that drops into a CS void with no shared definition of *ready*. **H5 is the antidote to "build it and they will come"** — Pendo (2019) found ~80% of features rarely or never used across its own accounts (vendor data), often because they ship with no enablement and no buyer-facing reason to adopt them.

## The one number, and a North Star

- **One revenue number: net revenue retention (NRR).** The whole bowtie rolls up to it. Median NRR sits around ~106% (ChartMogul / SaaS benchmarks); below 100% means acquisition spend is filling a leaking bucket. It's the financial number that now decides what a company is worth — and the reason the right side of the bowtie can't be an afterthought.
- **A North Star that captures customer value** — the leading indicator of NRR, specific to your product (the action that means a customer is getting value, counted across the base). NRR is the lagging financial truth; the North Star is the thing you can move this week.

One shared number beats four local metrics — lead volume, bookings, ship count, tickets closed — that conflict the first time a target slips.

## Three shared definitions

Written once, owned jointly, living as one file each — not four arguments in four tools.

1. **One ICP.** Who you're for, agreed by sales and marketing in the same room. (`ops/icp.md` if you keep one — `lead-qualify` reads it.)
2. **One MQL→SQL bar.** The single definition of a qualified lead both sides own — the H1 trigger. (Documented SLAs correlate with ~34% higher odds of higher YoY ROI — HubSpot *State of Inbound* 2015, self-reported.)
3. **One Won→onboarding definition.** What "ready to hand off" means — the H3 trigger and checklist, so a closed deal doesn't drop silently. (`onboarding-handoff` runs it.)

## How this kit maps to the model

You don't need a platform — a plain-text repo run from Claude Code *is* the operating model:

- **One source of truth** → the git repo. Every function reads and writes the same markdown.
- **The handoffs** → `ops/pipeline.md` (H1), the feedback log (H2, H6), `ops/customers.md` (H3), `ops/roadmap-signals.md` (H4, H5).
- **The skills** → `marketing-feedback` (H2), `onboarding-handoff` (H3), `account-health` (the right-side detector) handing to `churn-save`, `expansion-play`, and `qbr-prep` (the act-skills), `support-signal` → `product-signal` (H4/H5), `retention-feedback` (the post-sale→product loop).
- **The rituals** → `/demo-briefing` and `/weekly-review` run the joint motion and close the loop (L) across all four; `/retention-report` rolls the book up to NRR/GRR monthly.

The mature version of this is RevOps — one operating model and one data spine for the whole motion. At a founder-led stage the fix is to *close the loop*, not to hire a RevOps team: keep all four functions learning in one place and document the motion before you delegate it.

## See also

- [`why-align.md`](why-align.md) — the one-page argument, with sources, for why the four belong in one system.
- [`methodology.md`](methodology.md) — Claude Code as the operating environment the model runs in.
- [`connecting-a-crm.md`](connecting-a-crm.md) — optional: make an existing CRM the system of record and project it into `ops/pipeline.md` (the H1 surface), instead of running two pipelines.
