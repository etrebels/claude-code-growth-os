# Scheduling — run the rituals on their own

The rituals in [`.claude/commands/`](../commands/) are worth running on a clock,
not just when you remember. There are three places a schedule can live, and they
do different jobs — pick by what the job needs.

| Layer | Runs where | Runs what | Machine awake? | Set up in |
|---|---|---|---|---|
| **OS scheduler** (cron / launchd) | your machine | full rituals (model + your tools) | ✅ required | your crontab — `claude -p "/morning-briefing"` |
| **Cloud Routines** | Anthropic cloud | full rituals (model + your tools) | ❌ no | [`cloud-routines.md`](cloud-routines.md) |
| **CI backstop** (GitHub Actions) | GitHub cloud | deterministic, no-model checks only | ❌ no | [`scheduled-reviews.yml`](../../.github/workflows/scheduled-reviews.yml) |

Both the OS scheduler and Cloud Routines are valid triggers for the **full**
rituals — the only difference is whether your laptop has to be awake. Start with
whichever fits; many people run cron locally and a cloud routine as the backstop
for when the lid is closed.

The **CI backstop** is a different layer: GitHub Actions can't reach your OAuth
integrations (it's headless — see the note in [`cloud-routines.md`](cloud-routines.md)),
so it never runs a real ritual. It runs the **deterministic checks** in
[`../scripts/checks/growth-os-checks.sh`](../scripts/checks/growth-os-checks.sh) —
structure, freshness, broken local links — so a problem with the operating files
surfaces even in a week when nothing else ran. A failing scheduled run emails the
repo owner; that email *is* the signal.

## Start here

- **Run it in the cloud:** [`cloud-routines.md`](cloud-routines.md) — the full
  runbook (connectors, web-UI + `/schedule` CLI, the paste-ready prompt template).
- **Add the backstop:** [`scheduled-reviews.yml`](../../.github/workflows/scheduled-reviews.yml)
  runs the checks on a weekly cron from the default branch.
