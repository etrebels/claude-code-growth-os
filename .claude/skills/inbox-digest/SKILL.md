---
name: inbox-digest
description: Scan the last 48 hours of unread newsletters, news emails, and blog digests. Summarize what's relevant to your work. Trigger when the user asks "what did I miss", "any interesting newsletters", or as part of the morning briefing ritual.
---

# Inbox Digest

Surface the signal from newsletter noise — read unread emails from the last 48 hours and summarize what's relevant.

## Process

1. **Fetch unread emails from the last 48 hours (Gmail MCP).** Filter for newsletter and publication senders — Substack, Beehiiv, Mailchimp, Medium, and similar. Exclude personal correspondence, team emails, and transactional notifications.

2. **Assess relevance.** For each email, decide if it's relevant to your work context (industry news, competitors, fundraising, product trends, etc.). Skip anything unrelated.

3. **Summarize what matters.** For each relevant email:
   - Source and subject line
   - 2–3 sentence summary — what it covers and why it might matter

4. **Keep it short.** Maximum 5 items. If more are relevant, pick the 5 most useful.

## Output format

```
📬 Inbox Digest — last 48 hours

1. [Source] — [Subject]
   [2-3 sentence summary]

2. ...

If nothing stands out: "No notable newsletters in the last 48 hours."
```

## Notes
- Runs as part of `/morning-briefing` by default
- Can be run standalone at any time
- Relevance filtering is based on your CLAUDE.md context — the more it knows about your work, the better the filtering

## Depth
- quick: headlines only, no summaries.
- standard: summaries for relevant items (default).
- deep: summaries + one suggested action per item (share, save, respond).
