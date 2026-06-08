#!/bin/bash
set -euo pipefail

# PostToolUse(Edit|Write): the loop's "verify" step, as a hook.
#
# Guardrails (protect-files) stop a bad write *before* it happens; this checks the
# work *after* it lands — the other half of a closed loop. Advisory only: it warns,
# never blocks (exit 0 always). Two checks, both dependency-light:
#   1. Broken relative links in the changed markdown file (this kit is markdown-first).
#   2. Your project's own verifier, if you supply one at .claude/scripts/verify.sh
#      (copy verify.sh.example to wire `make check`, `npm test`, `pytest`, the
#      checks/ dir, etc.).
#
# Keep it advisory. A verify step you dread is a verify step you'll disable.

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
INPUT=$(cat)

# Match the kit convention: read the hook payload with python3, not jq.
FILE_PATH=$(printf '%s' "$INPUT" | python3 -c \
  'import sys, json; print(json.load(sys.stdin).get("tool_input", {}).get("file_path", ""))' \
  2>/dev/null || true)

WARNED=0

# --- Check 1: broken relative links in a changed markdown file ------------
case "$FILE_PATH" in
  *.md)
    if [ -f "$FILE_PATH" ]; then
      link_dir=$(dirname "$FILE_PATH")
      while IFS= read -r target; do
        [ -z "$target" ] && continue
        clean=${target%%#*}   # strip anchor
        clean=${clean%%\?*}   # strip query
        [ -z "$clean" ] && continue
        case "$clean" in
          http:*|https:*|mailto:*|tel:*) continue ;;
          /*) resolved="$clean" ;;
          *)  resolved="$link_dir/$clean" ;;
        esac
        if [ ! -e "$resolved" ]; then
          [ "$WARNED" -eq 0 ] && { echo "verify-after-change: $FILE_PATH" >&2; WARNED=1; }
          echo "  - broken link: $target" >&2
        fi
      done < <(grep -oE '\]\([^)]+\)' "$FILE_PATH" 2>/dev/null | sed -E 's/^\]\(//; s/\)$//' || true)
    fi
    ;;
esac

# --- Check 2: the project's own verifier, if supplied ---------------------
VERIFY="$PROJECT_DIR/.claude/scripts/verify.sh"
if [ -x "$VERIFY" ]; then
  if command -v timeout >/dev/null 2>&1; then
    CHECK_OUT=$(timeout 60 "$VERIFY" "$FILE_PATH" 2>&1) || CHECK_FAILED=1
  else
    CHECK_OUT=$("$VERIFY" "$FILE_PATH" 2>&1) || CHECK_FAILED=1
  fi
  if [ "${CHECK_FAILED:-0}" -eq 1 ]; then
    [ "$WARNED" -eq 0 ] && { echo "verify-after-change: project check reported issues" >&2; WARNED=1; }
    printf '%s\n' "${CHECK_OUT:-}" | sed 's/^/  /' >&2
  fi
fi

[ "$WARNED" -eq 1 ] && echo "  (advisory — review before commit)" >&2
exit 0
