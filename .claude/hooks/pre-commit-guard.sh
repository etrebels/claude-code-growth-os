#!/usr/bin/env bash
set -euo pipefail

# git pre-commit guard — block commits that contain likely secrets.
# This is a *git* hook, not a Claude Code hook. Install it once:
#
#   ln -s ../../.claude/hooks/pre-commit-guard.sh .git/hooks/pre-commit
#   chmod +x .claude/hooks/pre-commit-guard.sh
#
# Pure bash + grep. Scans only what's staged.

staged="$(git diff --cached --name-only --diff-filter=ACM || true)"
[ -z "$staged" ] && exit 0

patterns='(AKIA[0-9A-Z]{16}|-----BEGIN [A-Z ]*PRIVATE KEY-----|sk-[A-Za-z0-9]{20,}|xox[baprs]-[A-Za-z0-9-]+|ghp_[A-Za-z0-9]{36}|(password|api[_-]?key|secret|token)[[:space:]]*[:=][[:space:]]*[^[:space:]]+)'

hits="$(git diff --cached -U0 | grep -nEi "$patterns" || true)"
if [ -n "$hits" ]; then
  echo "Commit blocked — possible secret in staged changes:" >&2
  echo "$hits" | head -5 >&2
  echo "Remove it (and rotate it if it ever touched disk), then commit again." >&2
  exit 1
fi
exit 0
