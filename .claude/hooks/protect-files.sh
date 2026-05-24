#!/usr/bin/env bash
set -euo pipefail

# PreToolUse(Edit|Write) — block the agent from writing to sensitive files.
# Reads the hook payload with python3 (standard). Exit 2 blocks the tool call.

payload="$(cat)"
path="$(printf '%s' "$payload" | python3 -c 'import sys, json
try:
    d = json.load(sys.stdin)
    print(d.get("tool_input", {}).get("file_path", ""))
except Exception:
    print("")' 2>/dev/null || true)"

case "$path" in
  *.env|*.env.*|*.pem|*.key|*.p12|*.pfx|*id_rsa*|*secret*|*credentials*|*.claude/settings.local.json)
    echo "Blocked: '$path' looks sensitive. Edit it yourself, outside the agent." >&2
    exit 2
    ;;
esac
exit 0
