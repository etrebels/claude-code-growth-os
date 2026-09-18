#!/bin/bash
# InstructionsLoaded — record what actually loaded into context, and what it cost.
#
# Why this exists: the L1/L2 design assumed L2 rules loaded on demand. They did
# not — the loader walks .claude/rules/ recursively, so every "on-demand" rule
# loaded every session. Nothing was measuring it, so the figure written into the
# rules file (~300K chars) drifted to ~420K without anyone noticing. This closes
# that gap: "Count it, don't assert it" (CLAUDE.md) needs something that counts.
#
# Appends one summary line per run, then one line per loaded file, to
# .claude/logs/instructions-loaded.log. Never blocks and never fails a session —
# a broken measurement instrument must not break the work it measures.
set -uo pipefail

LOG="${CLAUDE_PROJECT_DIR:-.}/.claude/logs/instructions-loaded.log"
mkdir -p "$(dirname "$LOG")" 2>/dev/null || exit 0

read -r -d '' PYSCRIPT <<'PY' || true
import sys, json, os, datetime

log = sys.argv[1]
try:
    data = json.load(sys.stdin)
except Exception:
    sys.exit(0)

# The payload shape is not contractual across versions, so collect anything that
# looks like a markdown path rather than depending on one key staying put.
paths = []
def walk(node):
    if isinstance(node, str):
        if node.endswith(".md"):
            paths.append(node)
    elif isinstance(node, dict):
        for v in node.values():
            walk(v)
    elif isinstance(node, list):
        for v in node:
            walk(v)
walk(data)

seen, uniq = set(), []
for p in paths:
    if p not in seen:
        seen.add(p)
        uniq.append(p)

sizes = {}
for p in uniq:
    try:
        sizes[p] = os.path.getsize(p)
    except OSError:
        sizes[p] = 0
total = sum(sizes.values())

stamp = datetime.datetime.now().isoformat(timespec="seconds")
with open(log, "a") as fh:
    fh.write("%s\tfiles=%d\tchars=%d\ttokens~%d\n" % (stamp, len(uniq), total, total // 4))
    for p in sorted(uniq, key=lambda x: -sizes[x]):
        fh.write("\t%8d  %s\n" % (sizes[p], p))
PY

printf '%s' "$(cat)" | python3 -c "$PYSCRIPT" "$LOG" 2>/dev/null
exit 0
