# Demo — GTM Feedback Log (fictional)

The two loops that keep the whole motion in sync, in one file. **Nothing here is real** — these are made-up companies.

- **Field intel → marketing** (`MARKETING-ACTION`) — what sales hears, handed to marketing.
- **Retention signal → product** (`RETENTION-RISK`, `EXPANSION-SIGNAL`, `FEATURE-REQUEST`) — where customers stall, grow, or ask for something after the sale, handed to product/CS.

The `marketing-feedback` and `retention-feedback` skills write lines like these; `product-signal` pulls the product-shaped ones (`FEATURE-REQUEST`, roadmap-worthy `RETENTION-RISK`) into `ops/roadmap-signals.md`. This is the raw cross-function loop; `roadmap-signals.md` is product's triaged queue downstream of it. One file, every function — that's the loop, version-controlled.

## Field intel → marketing

### 2026-05-22
- `MARKETING-ACTION`: "How is this actually different from the BI tool we already have?" came up again at **Cascadia BioSciences** — third time this month. Needs a one-pager that answers it without a feature list. (buyer language: they keep saying *"another dashboard"*)
- `MARKETING-ACTION`: **Rheinkraft Manufacturing** asked for a manufacturing reference customer we don't have published yet. Missing proof point.
- `MARKETING-STRATEGIC`: Two insurance prospects this month framed the problem as *"compliance,"* not *"efficiency."* Worth testing compliance-led messaging for that segment.

### 2026-05-20
- `MARKETING-ACTION-URGENT`: Momentum stalled at **Thornbury Insurance** partly because a competitor's published case study did the convincing we couldn't match. We need a comparable proof asset.
- `MARKETING-ACTION`: Recurring buyer language — prospects say *"single source of truth"* far more than *"integration."* Mirror their words in the next campaign.

## Retention signal → product

### 2026-05-22
- `RETENTION-RISK`: **Northwind Robotics** (signed Q1, in onboarding) — weekly active usage down two weeks running; they've only adopted one of the three workflows in scope. Adoption friction → product. The stall is at the second workflow's setup step.
- `RETENTION-RISK`: **Halden Maritime** (production) — asked twice for an export feature that doesn't exist; it's now blocking their renewal case. Feature request that affects retention → roadmap, not the backlog void.
- `FEATURE-REQUEST`: **Halden Maritime** — the blocking item, stated plainly for the roadmap: export the connected view to their reporting tool. Tied to the renewal above. (product-signal routes this to `roadmap-signals.md`)
- `FEATURE-REQUEST`: **Cascadia BioSciences** (adopting) — asked for saved, re-runnable views so analysts don't rebuild a query each time. Recurred across a few accounts now — a pattern, not a one-off.

### 2026-05-19
- `RETENTION-RISK`: **Northwind Robotics** — champion (their ops lead) went quiet after a reorg; no power user identified yet. Single-threaded post-sale → CS to re-map stakeholders before renewal (day 60, not day 85).
- `EXPANSION-SIGNAL`: **Meridian Health** (production, healthy) — a second department asked for access unprompted. Expansion pattern → hand to sales with the CS context attached.
