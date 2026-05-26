# Write your first ritual in 5 minutes

A ritual is a recurring task you've turned into a slash command — a short markdown prompt you run by name. This kit ships a few (`/morning-briefing`, `/midday-checkin`, `/end-of-day`, `/weekly-review`). The fastest way to get your own is to copy one and tweak it. Here's the whole thing, start to finish.

We'll turn the built-in `/midday-checkin` into a new `/inbox-sweep` — "what came in, what needs a reply, what can wait." Same shape, different job. Swap in whatever recurring task you dread; the steps are identical.

## 1. Look at the one you're copying — 30 sec

Open `.claude/commands/midday-checkin.md`. Every ritual has the same two parts:

```markdown
---
description: Mid-day reset — what's done, what's slipping, what to protect this afternoon.
---

# Midday Check-in

A quick reset. In order:

1. Read `ops/priorities.md` ...
2. Mark what's done ...
3. Name the one thing that must happen this afternoon ...
```

- The bit between the `---` lines is the **frontmatter**. Its `description` is what shows up when you type `/` in Claude Code.
- Everything below is the **prompt** — plain instructions, usually a short numbered list. That's the whole ritual.

## 2. Copy it to a new name — 30 sec

The file name *is* the command name. Copy it:

```bash
cp .claude/commands/midday-checkin.md .claude/commands/inbox-sweep.md
```

(No terminal handy? Duplicate the file in your editor and rename it — same thing.) `inbox-sweep.md` becomes `/inbox-sweep`. Lowercase, dashes for spaces.

## 3. Rewrite the description — 1 min

Open your new `inbox-sweep.md` and change the `description` to what this ritual actually does. This line is the trigger — it's what you see in the menu — so make it concrete:

```markdown
---
description: Inbox sweep — what needs a reply now, what can wait, what to ignore.
---
```

## 4. Rewrite the steps — 2 min

Now the body. Keep the shape — a title and a short numbered list — and put your job in it. Tell it what to read, what to decide, and what to hand back:

```markdown
# Inbox Sweep

Clear the noise. In order:

1. List anything waiting on a reply from me — newest first.
2. Sort into three: **reply now** (matters today), **can wait**, **ignore**.
3. For each "reply now", draft a one-line response I can send or edit.

Keep it short. Don't show me the "ignore" pile unless I ask.
```

Two things make a ritual work:

- **Be specific about inputs and outputs.** "List what's waiting on a reply, newest first" beats "check my inbox." A clear, specific `description` matters for the same reason — it's the trigger.
- **Say what *not* to do.** "Don't show me the ignore pile" keeps it from rambling.

(`/midday-checkin` ends with a `## Depth` block — quick / standard / deep variants of the same ritual. Keep and adapt it if you like the option, or just delete it. It's optional.)

## 5. Run it — 30 sec

In Claude Code, type `/` and you'll see `inbox-sweep` in the list. Run it:

```
/inbox-sweep
```

That's a ritual. If it doesn't show up yet, start a fresh session so Claude Code picks up the new file.

## 6. Make it a habit

One ritual, run daily for a week, beats ten you set up once and forget. When `/inbox-sweep` feels automatic, copy it again for the next thing you dread. Commit it — `git add .claude/commands/inbox-sweep.md && git commit` — and your rituals get a history like everything else here.

---

Want it to reach your real inbox, calendar, or CRM? That's what MCP servers are for — see **Connect your tools** under [Make it yours](../README.md#make-it-yours) in the README.
