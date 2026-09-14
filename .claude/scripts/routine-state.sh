#!/usr/bin/env bash
# Routine run state — did the routine actually run, or does it only look like it?
#
# A routine that dies half-way and a routine with nothing to say used to produce
# the same thing: silence. That is how /end-of-day-close could skip in early July
# and need a manual [DRIFT] catch-up two days later, and how the 2026-08-07
# morning briefing miss was caught by /autonomy-review rather than by anything
# watching the chain (docs/loop-topology.md).
#
# So a run only counts as finished when it says so, in writing, on disk:
#
#   ok    -> ops/runs/<routine>.last        (ISO timestamp, commit, note)
#            and any FAILED- marker is cleared
#   fail  -> ops/runs/FAILED-<routine>.md   (stays until the next good run)
#
# The markers are committed, not local, because a cloud routine starts from a
# fresh clone every run — state that is not in git does not exist to it.
#
# Usage:
#   routine-state.sh ok     <routine> [note]
#   routine-state.sh fail   <routine> <reason>
#   routine-state.sh status            # the full table
#   routine-state.sh due               # only what is overdue or failing (hooks)
#
# Portable bash 3.2+. No network, no LLM, nothing counted from memory.

set -u

ROOT=$(git rev-parse --show-toplevel 2>/dev/null || echo .)
cd "$ROOT" || exit 0

RUNS_DIR="ops/runs"
SCHEDULE="${ROUTINE_SCHEDULE:-.claude/scripts/routines.tsv}"
TODAY_TS=$(date +%s)

# Days between an ISO date ($1) and today. -1 when unparseable, so a caller
# skips rather than false-flags. GNU (-d) and BSD/macOS (-j) both handled.
days_since() {
  local d="${1%%T*}" ts
  ts=$(date -d "$d" +%s 2>/dev/null) ||
    ts=$(date -j -f "%Y-%m-%d" "$d" +%s 2>/dev/null) ||
    { echo -1; return; }
  echo $(( (TODAY_TS - ts) / 86400 ))
}

# How old a run of this cadence may be before it is overdue. Weekday routines
# tolerate the weekend: on a Monday the last weekday run was three days ago.
max_age() {
  local cadence="$1" grace="$2" dow
  dow=$(date +%u)   # 1=Mon .. 7=Sun
  case "$cadence" in
    weekday)
      if [ "$dow" -eq 1 ]; then echo $(( 3 + grace ))
      elif [ "$dow" -ge 6 ]; then echo $(( 2 + grace ))
      else echo $(( 1 + grace )); fi ;;
    weekly)  echo $(( 7 + grace )) ;;
    monthly) echo $(( 31 + grace )) ;;
    *)       echo -1 ;;   # adhoc — tracked, never overdue
  esac
}

cmd="${1:-status}"

case "$cmd" in
  ok)
    routine="${2:?routine name required}"
    note="${3:-}"
    mkdir -p "$RUNS_DIR"
    commit=$(git rev-parse --short HEAD 2>/dev/null || echo "-")
    printf '%s\t%s\t%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$commit" "$note" \
      > "$RUNS_DIR/$routine.last"
    rm -f "$RUNS_DIR/FAILED-$routine.md"
    echo "GROWTH_OS_OK $routine $(date -u +%Y-%m-%dT%H:%M:%SZ)"
    ;;

  fail)
    routine="${2:?routine name required}"
    reason="${3:-unstated}"
    mkdir -p "$RUNS_DIR"
    {
      printf '# FAILED: %s\n\n' "$routine"
      printf -- '- when: %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
      printf -- '- commit: %s\n' "$(git rev-parse --short HEAD 2>/dev/null || echo '-')"
      printf -- '- reason: %s\n\n' "$reason"
      # shellcheck disable=SC2016  # literal backticks — this writes markdown, not a command
      printf 'This file is removed by the next successful run of `%s`.\n' "$routine"
      printf 'While it exists, every session start says so.\n'
    } > "$RUNS_DIR/FAILED-$routine.md"
    echo "GROWTH_OS_FAILED $routine — $reason"
    ;;

  status|due)
    [ -f "$SCHEDULE" ] || { echo "no schedule table at $SCHEDULE"; exit 0; }
    overdue=0; failing=0; unrecorded=0; lines=""
    while IFS=$'\t' read -r routine cadence grace _rest; do
      case "$routine" in ''|'#'*) continue ;; esac
      last_file="$RUNS_DIR/$routine.last"
      failed_file="$RUNS_DIR/FAILED-$routine.md"
      if [ -f "$last_file" ]; then
        when=$(cut -f1 < "$last_file")
        age=$(days_since "$when")
      else
        when="never"; age=-1
      fi
      limit=$(max_age "$cadence" "$grace")
      state="ok"
      if [ -f "$failed_file" ]; then
        state="FAILING"; failing=$((failing + 1))
      elif [ "$when" = "never" ]; then
        state="no run recorded"; unrecorded=$((unrecorded + 1))
      elif [ "$limit" -ge 0 ] && [ "$age" -gt "$limit" ]; then
        state="OVERDUE (${age}d, limit ${limit}d)"; overdue=$((overdue + 1))
      fi
      if [ "$cmd" = "status" ] || { [ "$state" != "ok" ] && [ "$state" != "no run recorded" ]; }; then
        lines="${lines}$(printf -- '- %-26s %-22s %s\n' "$routine" "${when%%T*}" "$state")
"
      fi
    done < "$SCHEDULE"

    if [ "$cmd" = "due" ]; then
      if [ "$overdue" -eq 0 ] && [ "$failing" -eq 0 ]; then
        # Nothing wrong. One quiet line if some routines have never recorded a
        # run — visible, never an alarm, because a hook that shouts on day one
        # is a hook that gets tuned out.
        [ "$unrecorded" -gt 0 ] &&
          echo "Routine run state: all clear; $unrecorded routine(s) have not recorded a run yet."
        exit 0
      fi
      echo "### Routine run state — counted off disk, not remembered"
      printf '%s' "$lines"
      echo "$failing failing, $overdue overdue. Markers live in \`$RUNS_DIR/\`; clear one by running the routine."
      exit 0
    fi

    echo "# Routine run state — $(date -u +%Y-%m-%dT%H:%MZ)"
    echo
    printf '%s' "$lines"
    echo
    echo "$failing failing, $overdue overdue, $unrecorded never recorded."
    [ "$failing" -gt 0 ] && exit 1
    exit 0
    ;;

  *)
    sed -n '2,30p' "$0"
    exit 2
    ;;
esac
