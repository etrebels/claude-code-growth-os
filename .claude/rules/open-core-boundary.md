# Rule: the open-core boundary — what lands here vs. in Pro

**The bug this prevents.** A deep, product-grade capability gets merged here in an
afternoon of enthusiasm — and the moment it merges it is MIT-licensed and public
forever. It cannot be unpublished, and it can't move to the paid tier later. The
door only swings one way: anything staged privately can be released here whenever;
nothing released here can ever be taken back. So the boundary check runs **before
merging, on every addition** — and when in doubt, the answer is "stage it in Pro
first."

This repo is the free rung of a three-rung ladder (README → *What's free vs.
what's paid*): this chassis (free, MIT) → [LangOptima Growth OS
Pro](https://langoptima.com/growth-os-pro) (the filled product) → built & run for
you. The free rung stays genuinely useful and maintained — the README promises
*"nothing moves out of the free repo,"* and this rule is what keeps that promise
cheap to keep: nothing lands here that would later be regretted.

## The check — run before adding anything to this repo

Before merging any new file, skill, command, hook, doc section, or capability,
answer the four tests:

| Test | Lands here (free) | Lands in Pro |
|---|---|---|
| **Pattern or playbook?** | The *pattern* — structure, template, `<placeholders>` | The *filled playbook* — frameworks, question banks, sequences, scoring rubrics |
| **Tool posture?** | Tool-agnostic — a generic protocol with placeholders | Named-tool wiring — field maps and presets for a specific CRM, task tool, or notetaker |
| **Who does it serve out of the box?** | One operator exploring the system | A team rolling it out — role packs, multi-seat patterns, adoption programs |
| **What does it improve?** | The demo, the methodology, the first 30 seconds | A paying customer's Monday |

- **Any answer in the right column → Pro.** New *deep* capability defaults to
  Pro-first; this repo can get a pattern/teaser version later if it earns one.
- **All answers in the left column → here.**
- **Unsure → Pro (or private staging) first.** Releasing later is always
  possible; un-releasing never is.

The owner's explicit call overrides the default — this rule decides the default,
not the exception.

## Always free — no check needed

Bug fixes, doc clarity, hook hardening, demo-data improvements, generic
templates, the methodology and operating-model docs — anything that makes the
free kit better at being the free kit. The chassis is the funnel; hollowing it
out or letting it go stale breaks the ladder from the bottom.

## Community contributions

The boundary governs **maintainer-authored** additions. A community PR that
improves the chassis lands here, with credit, under MIT — contributed work is
never rerouted into the paid tier. (What makes a good PR: [CONTRIBUTING.md](../../CONTRIBUTING.md).)

## See also

- [README → What's free vs. what's paid](../../README.md#whats-free-vs-whats-paid) — the public ladder this boundary maintains.
- [CONTRIBUTING.md](../../CONTRIBUTING.md) — the "keep it generic, no real data" rule this extends.
