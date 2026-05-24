---
name: triage
description: Triage a list of incoming items into do-now / schedule / delegate / drop. Trigger when the user pastes a list and asks to triage, prioritize, or "what should I do first".
---

# Triage

Given a list the user pastes (or a file they point to):

1. Sort each item into one of four buckets: **Do now · Schedule · Delegate · Drop.**
2. Within "Do now", order by leverage, not urgency.
3. Flag anything that's clearly been sitting too long.

Return the four buckets, shortest first. Don't pad, and don't keep things in "Do now" to be polite.
