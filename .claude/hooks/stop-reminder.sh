#!/usr/bin/env bash
set -euo pipefail

# Stop — a gentle nudge to log the day. Stays quiet once you've logged today,
# so it isn't noisy. Pure bash; never blocks.
#
# Emits a JSON `systemMessage` on stdout: a Stop hook's stderr on exit 0 only
# surfaces as a "<hook> hook error" notice in the transcript, not as a clean
# message — so the nudge would be missed. `systemMessage` is shown to the user
# as a warning without forcing the turn to continue.
# Ref: https://code.claude.com/docs/en/hooks (Stop decision control).

DIR="${CLAUDE_PROJECT_DIR:-.}"
LOG="$DIR/ops/daily-log.md"
TODAY="$(date '+%Y-%m-%d')"

if [ -f "$LOG" ] && grep -q "## $TODAY" "$LOG"; then
  exit 0
fi

printf '{"systemMessage": "No log entry for %s yet — run /end-of-day before you wrap up."}\n' "$TODAY"
