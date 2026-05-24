---
name: example-skill
description: A template skill. Replace it with a task you repeat. Trigger only when the user explicitly asks to run the example skill.
---

# Example Skill (template)

A skill is a reusable unit of work Claude runs when your request matches its `description`. The description *is* the trigger — keep it specific, or it fires at the wrong time (or never).

This one does nothing on purpose. Swap it for your own. A good skill:

- does one job well,
- reads from `ops/` (or `demo/`) instead of asking for context it could find,
- ends by writing its result somewhere durable — a file, a log.

See `skills/status-update/` and `skills/triage/` for two worked examples.
