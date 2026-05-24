# Claude Code as an operating environment

A short argument for using Claude Code to run your work, not just write your code.

## The shift

Most people reach for Claude Code as something to *ask* — a faster way to write the next thing. Useful, but it leaves it as a tool you visit. The shift is to treat it as the room you work *in*: the place your day starts, your rituals run, and your tools get reached. Your CRM, your notes, your calendar, your issue tracker stop being places you go. They become things the room reaches for you.

This kit is set up for the whole go-to-market — all four functions across both sides of the bowtie: marketing and sales on the left (the demo pipeline, the qualification / prep / follow-up / outreach / content skills), product and retention on the right (the customer book, the onboarding handoff, account health, the roadmap-signals queue). But the pattern isn't go-to-market-specific: the same shape runs a research practice, a support queue, a founder's week. If you have recurring work and scattered tools, it applies. The mechanics of the four-function motion — the handoffs, the one number, the shared definitions — live in [`operating-model.md`](operating-model.md); this page is about the *environment* they run in.

## Four ideas that make it work

**1. State lives in plain text, in git.** Your playbooks, priorities, and log are markdown files, not rows in someone's database. That sounds modest until you notice the consequences: your operating system has a diff, a history, and a blame view. You can read it, fork it, and fix it in a text editor. And when a long session's context window compacts, nothing important is lost — it's still on disk, and a hook re-injects it.

**2. Rituals are commands.** A recurring task — a morning briefing, an end-of-day close — becomes a slash command: a short markdown prompt you invoke by name. The sequence is the system. You stop re-deciding how to start the day and just run it.

**3. Guardrails are hooks.** The unglamorous safety net — don't commit a secret, don't write to `.env`, don't lose state on compaction — lives in hooks that run on events, not in your memory. Build the guardrail once; it holds every session after.

**4. One ritual at a time.** The failure mode is porting your whole working life on day one, then abandoning it. Pick the task you dread most. Make it a command. Run it daily for a week. Then add the next. Compounding comes from small reps, not a heroic weekend.

## Why this is one system, not four

The kit runs all four go-to-market functions — marketing, sales, product, retention — in one repo on purpose. The buyer already merged them: they research, buy, adopt, and renew as one relationship, and most of a B2B decision now happens before sales is in the room. Drawn honestly the journey isn't a funnel that ends at the sale; it's a bowtie, with the post-sale half (onboarding, adoption, renewal, expansion) usually left with no owner. Running the four as separate systems is what creates the seams the buyer feels. The fix is structural, not cultural, and the four ideas above happen to be it:

- **One source of truth** → the git repo. Every function reads and writes the same markdown — not four tools with four versions of the truth.
- **Two feedback loops** → the `marketing-feedback` skill plus a `MARKETING-ACTION` line (sales→marketing), and the `retention-feedback` skill plus a `RETENTION-RISK` line (post-sale→product). What the field and the customer base surface becomes an action in the same system, the same day — version-controlled.
- **Shared definitions** → a "qualified lead," and what "ready to hand off at won" means, are each one file every function edits, not four arguments.
- **Shared rituals** → the briefing and review commands run the joint motion across all four, not a relay of hand-offs.

You don't need a RevOps platform to get this. You need one place the whole motion lives. The mechanics — the six handoffs, the one number (NRR), the three shared definitions — are in [`operating-model.md`](operating-model.md); the one-page argument, with sources, is in [`why-align.md`](why-align.md).

## What stays out

The structure is reproducible and worth sharing. The judgment you encode inside it — your actual playbooks, your positioning, your numbers, your relationships — is not, and shouldn't be. A starter hands you the empty cabinet on purpose. The drawers are yours to fill, and what you fill them with is the part no template can give you.

## Where it breaks (because it does)

- **Long sessions drift.** Hence the compaction hook — but it only re-injects what you've written down. Garbage in, garbage out.
- **Skill and command sprawl.** Add only what you use; cut the rest on a cadence.
- **It runs on discipline.** The system doesn't run you. You run it. A ritual you don't run is a file, not a habit.

That's the whole idea. Start with one ritual. See `../README.md` to run it.
