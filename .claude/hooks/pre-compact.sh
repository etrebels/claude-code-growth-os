#!/usr/bin/env bash
set -euo pipefail

# PreCompact — re-inject durable state so a long session doesn't lose the thread.
# The trick: your state lives in plain-text files, so compaction can't erase it.
# This hook simply re-surfaces it. Pure bash, no dependencies.

DIR="${CLAUDE_PROJECT_DIR:-.}"

echo "## Re-injected after compaction — $(date '+%Y-%m-%d %H:%M')"
echo

if [ -f "$DIR/ops/priorities.md" ]; then
  echo "### Priorities"
  cat "$DIR/ops/priorities.md"
  echo
fi

if [ -f "$DIR/ops/daily-log.md" ]; then
  echo "### Latest log entry"
  awk '/^## /{c++} c==1{print} c==2{exit}' "$DIR/ops/daily-log.md"
fi
