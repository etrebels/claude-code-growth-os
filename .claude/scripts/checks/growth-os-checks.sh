#!/usr/bin/env bash
set -uo pipefail

# growth-os-checks.sh — deterministic, no-model health checks for the operating
# files. Runs anywhere: pure bash + coreutils, no API key, no MCP, no Claude.
#
# This is the CI backstop layer (see .claude/scheduling/README.md): the full
# rituals need the model and your integrations, but these checks don't — so they
# can run on a GitHub Actions schedule from the default branch and catch a
# structural problem even in a week when nothing else ran.
#
# Contract:
#   HARD failure  -> counts toward a non-zero exit (CI fails, owner gets emailed).
#   SOFT warning  -> printed, but never changes the exit code (advisory only).
# Exit 1 if any HARD failure, else exit 0.

# Advisory freshness threshold, in days. Meaningful mainly in a populated fork;
# the shipped fictional ops/ data will eventually trip it (harmless — it's SOFT).
FRESH_DAYS=14

# --- locate the repo root, however we were invoked ---------------------------
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
if REPO=$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel 2>/dev/null); then
  :
else
  REPO=$(cd "$SCRIPT_DIR/../../.." && pwd)
fi
cd "$REPO" || { echo "cannot cd to repo root: $REPO" >&2; exit 1; }

HARD=0
SOFT=0
hard() { HARD=$((HARD + 1)); printf '  HARD  %s\n' "$1"; }
soft() { SOFT=$((SOFT + 1)); printf '  SOFT  %s\n' "$1"; }
pass() { printf '  ok    %s\n' "$1"; }

today_epoch=$(date +%s)

# days_since "YYYY-MM-DD" -> integer days, or empty if the date can't be parsed
# (GNU date and BSD/macOS date take different flags; try both, then give up).
days_since() {
  local d=$1 e=""
  if e=$(date -d "$d" +%s 2>/dev/null); then
    :
  elif e=$(date -j -f "%Y-%m-%d" "$d" +%s 2>/dev/null); then
    :
  else
    echo ""
    return 0
  fi
  echo $(( (today_epoch - e) / 86400 ))
}

# newest_date_in FILE -> most recent YYYY-MM-DD used as a "## "/"### " heading
newest_date_in() {
  grep -hoE '^#{2,}[[:space:]]+[0-9]{4}-[0-9]{2}-[0-9]{2}' "$1" 2>/dev/null \
    | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}' | sort -r | head -n1
}

# --- 1. Structure: the files the rituals depend on ---------------------------
echo "Structure"
required=(
  CLAUDE.md
  README.md
  .claude/settings.json
  .claude/commands/morning-briefing.md
  .claude/commands/midday-checkin.md
  .claude/commands/end-of-day.md
  .claude/commands/weekly-review.md
  ops/priorities.md
  ops/daily-log.md
  ops/pipeline.md
  ops/customers.md
  ops/roadmap-signals.md
  ops/feedback-log.md
)
for rel in "${required[@]}"; do
  if [ -e "$rel" ]; then
    pass "present: $rel"
  else
    hard "missing required file: $rel"
  fi
done

# --- 2. Broken local links across all tracked markdown -----------------------
echo "Local links"
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  md_files=$(git ls-files '*.md')
else
  md_files=$(find . -name '*.md' -not -path './.git/*')
fi
link_problems=0
while IFS= read -r f; do
  [ -z "$f" ] && continue
  dir=$(dirname "$f")
  # awk skips fenced code blocks (```), then prints every ](target) target.
  while IFS= read -r raw; do
    tgt=${raw%% *}   # drop any "title" after the path
    tgt=${tgt%%#*}   # drop any #anchor
    [ -z "$tgt" ] && continue
    case "$tgt" in
      http://*|https://*|mailto:*|tel:*|//*) continue ;;
    esac
    if [ ! -e "$dir/$tgt" ]; then
      hard "broken link in $f -> $raw"
      link_problems=$((link_problems + 1))
    fi
  done < <(awk '
    /^```/ { infence = !infence; next }
    infence { next }
    {
      line = $0
      while (match(line, /\]\([^)]+\)/)) {
        print substr(line, RSTART + 2, RLENGTH - 3)
        line = substr(line, RSTART + RLENGTH)
      }
    }
  ' "$f")
done <<EOF
$md_files
EOF
[ "$link_problems" -eq 0 ] && pass "all relative markdown links resolve"

# --- 3. Freshness: has the day been logged lately? (advisory) ----------------
echo "Freshness"
if [ -f ops/daily-log.md ]; then
  nd=$(newest_date_in ops/daily-log.md)
  if [ -n "$nd" ]; then
    ds=$(days_since "$nd")
    if [ -n "$ds" ] && [ "$ds" -gt "$FRESH_DAYS" ]; then
      soft "ops/daily-log.md newest entry is $nd (${ds}d old) — the log has gone quiet"
    else
      pass "ops/daily-log.md current (newest ${nd:-unknown})"
    fi
  else
    soft "ops/daily-log.md has no dated entries yet"
  fi
fi

# --- 4. Staleness: is the cross-function loop still moving? (advisory) --------
echo "Loop"
if [ -f ops/feedback-log.md ]; then
  fd=$(newest_date_in ops/feedback-log.md)
  if [ -n "$fd" ]; then
    fs=$(days_since "$fd")
    if [ -n "$fs" ] && [ "$fs" -gt "$FRESH_DAYS" ]; then
      soft "ops/feedback-log.md newest signal is $fd (${fs}d old) — the sales<->product loop has gone quiet"
    else
      pass "ops/feedback-log.md current (newest ${fd:-unknown})"
    fi
  else
    soft "ops/feedback-log.md has no dated signals yet"
  fi
fi

# --- summary -----------------------------------------------------------------
echo
echo "Summary: ${HARD} hard, ${SOFT} soft."
if [ "$HARD" -gt 0 ]; then
  echo "FAIL — $HARD hard check(s) failed."
  exit 1
fi
echo "PASS — no hard failures."
exit 0
