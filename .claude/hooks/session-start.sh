#!/usr/bin/env bash
set -euo pipefail

# SessionStart — surface your priorities the moment a session opens.
# Pure bash: no API keys, no MCP, runs anywhere. Edit ops/priorities.md to
# change what shows up here.

DIR="${CLAUDE_PROJECT_DIR:-.}"

echo "## Session start — $(date '+%Y-%m-%d %H:%M')"
echo
if [ -f "$DIR/ops/priorities.md" ]; then
  cat "$DIR/ops/priorities.md"
else
  echo "No ops/priorities.md yet — run /morning-briefing to start the day."
fi
echo
echo "Rituals: /morning-briefing · /midday-checkin · /end-of-day · /weekly-review"
echo "New here? Run /demo-briefing to see it work on sample data."
