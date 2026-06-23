# Designing loops, not prompts

A short argument for the shape underneath this kit: that the thing you design is the
*loop*, not the prompt.

This page is the *why*. The [methodology](methodology.md) is the *what* (five ideas);
the commands, hooks, and rules are the *how*. Read this when you want the mental
model the rest of the kit is built on.

## The shift

The first instinct with a capable model is to write a better instruction. Phrase it
well, get a better answer. That still helps, but it stopped being where the leverage
is the moment models could *act* — call a tool, read the result, decide the next
step. Once an assistant takes steps, whether it succeeds at a multi-step job is
decided mostly *outside* the prompt: by what it can see, what it can do, and whether
it can tell that a step worked.

So the work moves up a ladder:

- **Prompt** — word the instruction.
- **Context** — control what the model sees (history, files, retrieved notes, tool
  definitions). This kit's "state in plain text, in git" is context engineering.
- **Loop / harness** — design the cycle the model runs in: the tools, the feedback,
  the stopping conditions, the human checkpoints.

A single well-worded instruction is table stakes now. The differentiated skill is
designing the loop the instruction runs inside.

## What an agent actually is

Strip away the vocabulary and a working agent is small: **a model, a set of tools,
and a loop** that calls the model, lets it act, feeds back what happened, and repeats
until the work is done. The intelligence lives in the model. The *reliability* lives
in how you shape that loop.

The loop has a standard shape:

```
   goal ─▶  gather context  ─▶  act (use a tool)  ─▶  verify the result
              ▲                                              │
              └──────────────  repeat until done ◀───────────┘
                         (or: stop, or: ask a human)
```

The pieces you actually design:

| Piece | What it is | The question to answer |
|---|---|---|
| **Tools** | The actions available — read, write, run, search, call an API | What's the smallest, sharpest set? |
| **Context** | Everything the model sees this step | What loads always vs. just-in-time? |
| **The loop** | The control flow that repeats act → observe | Do you own it, or does a framework? |
| **Verification** | The check after each step | A test? A file that should exist? A count that should match? |
| **State** | What persists across steps and sessions | In a file, in git, in the ritual's output? |
| **Termination** | When it stops | Done, budget spent, error ceiling hit, or hand to a human |

Two of these are routinely skipped and cause most of the pain: **verification** and
**termination**. A loop with no check can't tell progress from confident drift. A
loop with no stop either spins or quietly does the wrong thing for a while.

## The piece most setups miss: verification

If you build one thing into a ritual, build the check.

An agent is only as good as its ability to tell whether its last step worked. Give it
something concrete to verify against and it self-corrects across passes; give it
nothing and quality is a coin flip. Verification comes in a few flavors, cheapest
first:

- **Rules-based** — a test suite, a linter, a schema validator, a script that exits
  non-zero. Unambiguous; prefer it.
- **A factual check** — a file that should now exist, a row count that should match,
  a value you read back after writing it.
- **A second opinion** — a model judging the output against a written rubric, for the
  fuzzy cases code can't score.

In this kit, verification can live in a hook so it runs every time instead of only
when you remember — that's what `.claude/hooks/verify-after-change.sh` is, and the
`.claude/scripts/verify.sh.example` template is where you wire your own check (a test
run, `make check`, the `checks/` scripts). It's the *verify* counterpart to the
guardrail hooks that already block bad writes.

## A build playbook

When you turn a recurring task into a ritual, design it as a loop:

1. **Write down "done" so a machine could check it.** If you can't name the signal
   that says it worked, you don't have a loop yet — you have a wish.
2. **Make the check exist before you tune the behavior.** The test, the validator,
   the read-back. Fast and cheap, because every pass pays for it.
3. **Give it the smallest set of sharp tools.** Each returning a result that *teaches*
   the next step — errors included. Resist the thirty-tool drawer.
4. **Put the check *inside* the loop, not at the end.** The model should see the
   result of its last action before choosing the next.
5. **Set the stop conditions up front.** A budget, an error ceiling, and a human gate
   on anything irreversible (send, delete, pay, post). A loop with no stop is a bug.
6. **Instrument, then iterate on the loop — not the prompt.** When something's wrong,
   ask *which part* failed: context (it couldn't see what it needed), tools (it
   couldn't act, or got a useless result), verification (it couldn't tell good from
   bad), or control flow (it looped or stopped wrong). Fix that part. Prompt wording
   is the last thing you touch, not the first.

A useful gut-check throughout: **would a fixed sequence do?** If the path is known and
repeatable, write it down as steps and don't pay for autonomy. Reach for an
open-ended loop only when the path has to be discovered as you go.

## Anti-patterns

- **A loop where a checklist would do.** Autonomy costs time and unpredictability —
  earn it. Most recurring work is a known sequence, which is exactly why this kit
  ships rituals as commands.
- **No verification.** The defining failure. Without a check the loop can't tell it's
  drifting.
- **No stop.** Loops that never terminate, or re-summarize the same overflowing
  context forever. Cap the budget; set an error ceiling.
- **Stuffing the context "to be safe."** A full window reads *worse*, not better —
  recall sags in the middle. Curate; push the rest to files (which is why state lives
  in git here).
- **Letting a framework own your control flow and your context.** When you can't see
  the loop or what's in the window, you can't debug either.
- **No human gate on irreversible actions.** Autonomous send / delete / pay with no
  checkpoint is how a loop does real damage. Keep a hand on the dial — see the
  read-only / safe-write / full-write ladder in
  [`../.claude/rules/crm-usage.md`](../.claude/rules/crm-usage.md).

## How this maps to the kit

You don't have to build any of this from scratch — the kit *is* this shape:

| Loop piece | In this kit |
|---|---|
| Context | State in `ops/` (git), the **SessionStart** hook, the **PreCompact** re-inject |
| Act | Rituals as commands in `.claude/commands/` |
| Tools | MCP servers you wire in (`.mcp.json`) |
| Verify | `verify-after-change.sh` + your `verify.sh`; the `checks/` scripts; CRM guardrail 7 ("verify the write landed") |
| Guardrails | `protect-files.sh`, the pre-commit secret guard |
| Control flow | The [rules](../.claude/rules/) every run honors |
| Termination / human gate | The write-authority ladder in [`crm-usage.md`](../.claude/rules/crm-usage.md); a routine that drafts and waits for review |
| Triggers | [Scheduling](../.claude/scheduling/) — cron, cloud, or a CI backstop |

Designing your loop *is* deciding how these pieces fit for the work in front of you —
not writing a longer prompt.

## Where this comes from

These ideas are a synthesis of public work on building agents, reimplemented in this
kit's own words. Worth reading directly:

- Anthropic, *Building Effective Agents* — the "model + tools + loop" framing, and
  workflow vs. agent.
- Yao et al. (2022), *ReAct: Synergizing Reasoning and Acting in Language Models* —
  the original reason → act → observe loop (arXiv:2210.03629).
- HumanLayer (Dex Horthy), *12-Factor Agents* — own your control flow and your
  context window; reliable agents are mostly well-engineered software.
- Manus, *Context Engineering for AI Agents* — shaping the loop's context in
  production.
- Andrej Karpathy — the "autonomy slider" / keep-a-human-in-the-loop framing.
