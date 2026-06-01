#!/usr/bin/env bash
set -euo pipefail

# SessionStart — surface your priorities the moment a session opens, and the
# freshest cross-function loop signals so they can't go stale silently.
# Pure bash: no API keys, no MCP, runs anywhere. Edit ops/priorities.md (and
# ops/feedback-log.md) to change what shows up here.

DIR="${CLAUDE_PROJECT_DIR:-.}"

# Print the newest dated batch of feedback-log signals (the sales<->product
# loop). Called below as `surface_loop || true`, which suspends `set -e` inside
# the function, so a missing file or an empty match can never block the session.
surface_loop() {
  local feedback="$DIR/ops/feedback-log.md" latest
  [ -f "$feedback" ] || return 0
  latest=$(grep -oE '^#{2,}[[:space:]]+[0-9]{4}-[0-9]{2}-[0-9]{2}' "$feedback" \
    | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}' | sort -r | head -n1) || return 0
  [ -n "$latest" ] || return 0
  echo
  echo "Open loop — newest signals ($latest), in ops/feedback-log.md:"
  awk -v d="$latest" '
    /^##/ { show = (index($0, d) > 0) ? 1 : 0; next }
    show && /^- / { print "  " $0 }
  ' "$feedback" | head -n 5
}

echo "## Session start — $(date '+%Y-%m-%d %H:%M')"
echo
if [ -f "$DIR/ops/priorities.md" ]; then
  cat "$DIR/ops/priorities.md"
else
  echo "No ops/priorities.md yet — run /morning-briefing to start the day."
fi
surface_loop || true
echo
echo "Rituals: /morning-briefing · /midday-checkin · /end-of-day · /weekly-review"
echo "New here? Run /demo-briefing to see it work on sample data."
