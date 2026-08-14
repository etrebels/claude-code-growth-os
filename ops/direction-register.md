# Direction register — what is currently binding

> Live standing direction from the person or body you work under — a board, an
> investor, a principal advisor, a supervising executive. Read it before planning and
> before any decision it touches.
>
> **Why this file exists:** the common failure isn't ignoring direction, it's
> *agreeing with it and changing nothing*. Direction gets received, genuinely
> acknowledged, and then the plan it should have redirected runs on unchanged, because
> nothing in the system carries it forward. Weeks later nobody remembers direction was
> given, and the playbook it contradicted is still being followed.
>
> Background: [`docs/principles-from-the-field.md`](../docs/principles-from-the-field.md)
> → *Direction & authority*.

## How it works

- **It interrupts.** Direction arriving mid-task stops the in-flight work. Process it,
  then resume the task as it has reshaped it — not the other way round.
- **It outranks what's written down.** Where it conflicts with a playbook, a rule, a
  ritual, or a live plan in `ops/`, the direction wins and the written thing gets
  amended. Never keep both — a stale rule left in place is a rule someone will follow.
- **It's standing.** Live until satisfied or superseded. It doesn't lapse because time
  passed and nobody mentioned it again.
- **It never moves the irreversible fence.** Direction changes *what gets prepared*,
  never who presses send. See [`.claude/rules/crm-usage.md`](../.claude/rules/crm-usage.md)
  → *Draft, send, delete*.
- **Rows are never deleted.** Mark them `satisfied` or `superseded` with a date and keep
  the history — that record is what stops the same ground being re-litigated.

## Record it at the strength it was given

Quote the words. Log the strength. Never inflate a hedge into a hard gate, never soften
a gate into a preference, and never infer a directive from one that was actually given —
a manufactured constraint gets defended as though someone imposed it.

| Strength | Sounds like | Behaves like |
|---|---|---|
| **Gate** | *"Check with me before you do it"* | Hard stop. The action doesn't happen without the check. |
| **Strong preference** | *"My view at this stage is to avoid it if at all possible"* | The standing default. Departing from it is a conversation, not a solo call. Note any stated horizon — *"at this stage"* is a real qualifier, not filler. |
| **Steer** | *"You might be pitching too high initially"* | Weighted input into a judgment that stays yours. |

**Silence is not permission.** A subject absent from this register is simply absent —
ask, don't extrapolate.

---

## Live

| ID | Directive | Strength | Given | Satisfaction signal | Encoded in |
|---|---|---|---|---|---|
| `<D-01>` | `<what it requires, in plain words>` | `<gate \| strong preference \| steer>` | `<YYYY-MM-DD>` | `<the observable thing that means this is done>` | `<the files you changed so it actually binds>` |

*A row with no satisfaction signal becomes furniture — it sits live forever, gets skimmed
past, and trains you that the register is decorative. Write one even when it's only
"reviewed at the next check-in."*

## Satisfied

*(rows move here with the date they were completed)*

## Superseded

*(rows move here with a pointer to the direction that replaced them)*

---

## The conflict sweep

This is the step that separates a register from a filing cabinet. For every new gate or
strong preference, **go and look** for what it contradicts — don't wait for the conflict
to be obvious. Search your playbooks, rules, `ops/` state, and scheduled rituals for the
subject, then record `file · section · what it says now · what the direction requires ·
resolution` — and make the change in the same pass. A conflict noted and not resolved is
the filing failure under a different name.

Where a conflict lands on a judgment call that's yours — pricing, positioning, whether to
take a role — don't decide it. Amend the *rule* to record the constraint, and surface the
decision as the open question.

## Ritual wiring

- [`/morning-briefing`](../.claude/commands/morning-briefing.md) — read live rows; flag
  any Top-3 item that touches one.
- [`/weekly-review`](../.claude/commands/weekly-review.md) — review every live row: still
  live, satisfiable, or superseded? A row carried unreviewed across three reviews is
  re-rated, not dropped — the same discipline [`pipeline.md`](pipeline.md) applies to
  stalled deals and [`chokepoints.md`](chokepoints.md) to dependencies.
- **Cloud routines** — a required read, not an optional one. An unattended run acting
  against a live row is exactly the damage the guardrails exist to prevent.
