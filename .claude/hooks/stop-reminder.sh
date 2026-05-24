#!/usr/bin/env bash
set -euo pipefail

# Stop — a gentle nudge to log the day. Stays quiet once you've logged today,
# so it isn't noisy. Prints to stderr; never blocks. Pure bash.

DIR="${CLAUDE_PROJECT_DIR:-.}"
LOG="$DIR/ops/daily-log.md"
TODAY="$(date '+%Y-%m-%d')"

if [ -f "$LOG" ] && grep -q "## $TODAY" "$LOG"; then
  exit 0
fi
echo "No log entry for $TODAY yet — run /end-of-day before you wrap up." >&2
