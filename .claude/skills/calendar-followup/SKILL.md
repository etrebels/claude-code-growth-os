---
name: calendar-followup
description: Surface unfinished follow-ups from last week's external meetings. Trigger when the user asks "who do I need to follow up with", "what meetings haven't I followed up on", or as part of the morning briefing ritual.
---

# Calendar Follow-up

Close the loop on last week's external meetings — find what hasn't been followed up and offer to draft the message.

## Process

1. **Fetch last 7 days from Google Calendar (via MCP).** Pull all events. Filter out internal team meetings — only external contacts matter here.

2. **Match to pipeline and customers.** Cross-reference attendee names and company names against `ops/pipeline.md` and `ops/customers.md`. If a match is found, pull the current stage and last noted next step.

3. **Check if follow-up was logged.** Scan `ops/daily-log.md` — has this meeting already been debriefed or followed up? If yes, skip it.

4. **List what's open.** For each external meeting without a logged follow-up:
   - Meeting name / contact
   - Pipeline stage (if matched)
   - Days since the meeting

5. **Ask which one to act on.** "Which of these would you like to follow up on?" Then run the `follow-up` skill for the chosen meeting.

## Notes
- If a meeting doesn't match pipeline or customers, flag it: "This contact isn't in your pipeline — add them?"
- Internal meetings (same domain as sender) are excluded automatically
- Runs as step 5 in `/morning-briefing` by default

## Depth
- quick: list of unfinished follow-ups only.
- standard: list + offer to draft one follow-up message.
- deep: list + draft all follow-ups, prioritized by deal stage.
