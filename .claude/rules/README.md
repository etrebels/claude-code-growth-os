# Rules — the operating constraints every session honors

A **rule** is a standing constraint on *how* the rituals work — not a task you run,
but a convention every run respects. Where a command in [`.claude/commands/`](../commands/)
says *what to do*, a rule says *how to do it safely and consistently*, whether the
run is you at the keyboard or an unattended [cloud routine](../scheduling/cloud-routines.md).

This matters most when a run is **autonomous**. A cloud routine has no one to ask
mid-run, so the routine prompt tells it to execute the command "honoring CLAUDE.md
and the rules in `.claude/rules/`." These files are what that line points at.

| Rule | Governs |
|---|---|
| [`crm-usage.md`](crm-usage.md) | Reaching a CRM over MCP — the docs-first access protocol, the three-lane convention, and the write-authority guardrails an unattended run must respect. |
| [`todo-single-source.md`](todo-single-source.md) | One canonical way the to-do list is queried and rendered, so every entry path (session start, each ritual, each routine) shows the same list. |

## Conventions

- **Generic, like the rest of the kit.** Rules describe a pattern with
  `<placeholders>`; the specifics (your CRM's API, your field names, your IDs) live
  in a private skill or a gitignored config, never here.
- **A rule is the single source of truth for its concern.** Don't restate its logic
  inside a command or a routine prompt — point to the rule and let it own the detail.
