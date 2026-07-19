---
description: Check on this repo's open PRs — CI, review comments, merge conflicts, and any external launch dependency — without re-litigating the same unchanged signal every time.
---

# Babysit PRs

Codifies a ritual that was already running against this repo's open PRs without a
checked-in definition — [`Open-PR hygiene`](../../CLAUDE.md#open-pr-hygiene) named the
backlog problem; this command is the recurring check that watches it. Run on a
schedule (daily or every few days) or on demand.

## What to check, per open PR

1. **CI status** — the latest check run / workflow run on the PR's head commit. If
   there are **zero** check runs, say so explicitly — don't imply "green" for a PR
   CI never actually ran on. (README/CHANGELOG-only diffs can fail to trigger the
   [CI backstop](../scheduling/README.md) workflow even though its `paths:` filter
   should catch them — if you see this, name it as a gap to root-cause, not a
   one-off oddity.)
2. **Review comments** — any unresolved thread. Unresolved beats "any comment exists."
3. **Merge conflicts** — `mergeable_state`. Flag `dirty` distinctly from `clean`;
   a draft sitting on a known external dependency can drift into conflict with
   `main` while it waits, and that drift compounds the longer it's ignored.
4. **External launch dependencies** — if the PR body names a condition it's
   waiting on (another repo's PR merging, a page going live, a manual step called
   out in another PR's checklist), re-verify that specific condition this run.

## Stale-signal escalation — don't just repeat the same check forever

Track, per PR, how many **consecutive** runs reported the *same* external-dependency
signal with *no change* (e.g. the same HTTP status on a fetch, the same "still
DRAFT" on a linked PR). On the **third** consecutive unchanged report:

- Stop re-verifying that signal the same way every run — a fourth identical check
  adds no information.
- Escalate **once**, plainly: name that this is now stale and needs a human decision
  or a different verification method, not another automated recheck.
- Keep watching CI / review comments / merge conflicts as normal — only the
  unchanged external signal goes quiet.

This is the fix for the pattern observed on PR #44: the same "`langoptima.com/...`
returns 403, could be live or could be blocked" line ran unchanged for four straight
weekly checks before anyone called it stale. One clear escalation beats a fifth
identical paragraph.

## Output format

One comment per PR, short:

```
**🤖 Babysit-PRs — <date>**

| Check | Status |
|---|---|
| CI | <✅/⚠️/❌ + one-line detail> |
| Review comments | <✅/⚠️ + detail> |
| Merge conflicts | <✅ clean / ⚠️ dirty> |

<one line: action taken, or "no action — still ready" / the escalation, if triggered>
```

Post via the repo's PR-comment tool. Take no other action unless the PR is
genuinely ready (CI green, no unresolved comments, clean merge state, no
outstanding dependency) **and** you have explicit standing permission to merge it —
otherwise this command only reports.

## Depth
- quick: one PR, the four checks, no escalation tracking.
- standard: every open PR in the repo, the four checks, stale-signal tracking against the prior comment on each PR.
- deep: add a cross-PR summary (how many PRs, how long the oldest has been open, which are blocked vs. actionable) and flag any PR open longer than 30 days with no comment in the last 7.
