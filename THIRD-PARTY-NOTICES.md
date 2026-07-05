# Third-Party Notices

This file records third-party work this project has drawn patterns from. Patterns
reimplemented in our own words and structure carry no license obligation, but we
record them here because giving credit where it is due is the rule (see
[CONTRIBUTING.md](CONTRIBUTING.md)).

## claude-context-os — context-OS patterns (reimplemented)

Source:   https://github.com/conorbronsdon/claude-context-os
Author:   Conor Bronsdon
License:  MIT
Used in:
  - `.claude/commands/capture.md` — a capture-now / triage-later inbox, modelled on
    claude-context-os's `/capture` + `inbox/` pattern.
  - `.claude/commands/reconcile.md` — drift detection across parallel sessions,
    modelled on its `/reconcile` command.
Modified: yes — patterns only. No source code, command text, or prose was copied.
          Each command is an independent reimplementation written against this
          kit's own `ops/` layer and its `crm-usage.md` / `todo-single-source.md`
          rules. claude-context-os is a sibling "Claude Code as an operating
          environment" project; these two commands adapt two of its ideas to the
          go-to-market motion this kit runs.
