#!/usr/bin/env bash
# PreToolUse — the irreversible fence, enforced rather than requested.
#
# The rules already say what an unattended run may never do: send, post outside
# the agreed briefing channel, delete a record, or commit Edwin to anyone
# (.claude/rules/lightfield-crm-usage.md; LangOptima-General
# .claude/rules/multi-agent/autonomy-lane.md). Until now that was prose a run
# was asked to honour. This is the same fence at the tool layer, so it holds
# when the reasoning does not.
#
# The decision lives in .claude/scripts/fence-check.py — one place, readable,
# testable on its own. This script only turns a reason into a block.
#
# Deliberate override for an interactive session where Edwin has decided:
#   LO_FENCE_OVERRIDE=1        (per session; never committed to settings)
#
# Blocks by printing a deny decision *and* exiting 2, so the block holds
# whether the harness reads the JSON or the exit code.

set -u

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
CHECK="$PROJECT_DIR/.claude/scripts/fence-check.py"
[ -f "$CHECK" ] || exit 0

REASON=$(LO_BRIEFING_CHANNEL="${LO_BRIEFING_CHANNEL:-}" \
  python3 "$CHECK" 2>/dev/null) || exit 0
[ -n "$REASON" ] || exit 0

if [ "${LO_FENCE_OVERRIDE:-}" = "1" ]; then
  printf 'irreversible-fence: overridden for this session — %s\n' "$REASON" >&2
  exit 0
fi

FULL="Blocked by the irreversible fence. $REASON Prepare it, then stop for sign-off. To do it deliberately in this session, set LO_FENCE_OVERRIDE=1."

python3 -c 'import json,sys; print(json.dumps({"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":sys.argv[1]}}))' "$FULL"
printf '%s\n' "$FULL" >&2
exit 2
