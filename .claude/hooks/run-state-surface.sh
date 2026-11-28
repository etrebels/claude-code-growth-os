#!/usr/bin/env bash
# SessionStart hook — surface any routine that is failing or overdue.
#
# Counted off disk by routine-state.sh every time, never remembered from the
# last session. Silent when everything is current, so it stays worth reading.

set -u
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
STATE="$PROJECT_DIR/.claude/scripts/routine-state.sh"

[ -x "$STATE" ] || exit 0

out=$(cd "$PROJECT_DIR" && bash "$STATE" due 2>/dev/null) || exit 0
[ -n "$out" ] || exit 0

printf '%s\n' "$out"

# The nudge only fires on a real finding. The all-clear line stands alone.
case "$out" in
  *FAILING*|*OVERDUE*)
    printf '\nA failing or overdue routine is work now, not a note. Run it, or record why it cannot.\n' ;;
esac
