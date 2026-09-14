#!/usr/bin/env bash
# status.sh — what this repo actually contains, counted off disk.
#
# The rules ask for a lot of counting and nothing was doing it. The rule-count
# cap, the "zero firings in two quarters" retirement test, the open-PR hygiene
# numbers in CLAUDE.md — all asserted by whoever wrote the line, none computed,
# and the CLAUDE.md figures have already drifted twice. An estimate is not
# evidence, so this counts.
#
# Usage:
#   bash .claude/scripts/status.sh              # plain text, for a session or CI
#   bash .claude/scripts/status.sh --html > s.html
#
# No network and no LLM: everything here was counted from files on disk. What
# cannot be counted that way is listed at the end rather than guessed at.

set -u

ROOT=$(git rev-parse --show-toplevel 2>/dev/null || echo .)
cd "$ROOT" || exit 0
REPO=$(basename "$ROOT")
AS_HTML=0
[ "${1:-}" = "--html" ] && AS_HTML=1

TODAY_TS=$(date +%s)
RULE_CAP=12          # meta/l1-l2-migration.md — the memorability cap
L1_CHAR_CAP=20000    # _source/l1-l2-cache-budget.md — ~5,000 tokens

days_since() {
  local d="${1%%T*}" ts
  ts=$(date -d "$d" +%s 2>/dev/null) ||
    ts=$(date -j -f "%Y-%m-%d" "$d" +%s 2>/dev/null) ||
    { echo -1; return; }
  echo $(( (TODAY_TS - ts) / 86400 ))
}

count_md() { find "$1" -maxdepth "${2:-1}" -type f -name '*.md' ! -name 'README.md' 2>/dev/null | wc -l | tr -d ' '; }

# The newest date in a file that is not in the future. Freshness means the most
# recent thing that has actually happened; these logs also carry forward-looking
# dates (the 7/30/90 section), and counting those made files look fresher than
# they are. Sorting descending means no assumption about entry order.
TODAY_ISO=$(date -u +%Y-%m-%d)
newest_date_in() {
  grep -hoE '[0-9]{4}-[0-9]{2}-[0-9]{2}' "$1" 2>/dev/null |
    sort -r | awk -v today="$TODAY_ISO" '$0 <= today {print; exit}'
}

# Any date beyond today — planned, not recorded. Worth showing separately so a
# plan is never mistaken for an entry.
future_dates_in() {
  grep -hoE '[0-9]{4}-[0-9]{2}-[0-9]{2}' "$1" 2>/dev/null |
    sort -ru | awk -v today="$TODAY_ISO" '$0 > today' | wc -l | tr -d ' '
}

row() { printf '%-42s %s\n' "$1" "$2"; }
head2() { printf '\n## %s\n\n' "$1"; }

report() {
  printf '# %s — counted %s\n' "$REPO" "$(date -u +%Y-%m-%dT%H:%MZ)"
  printf '\nEvery number below was counted off disk. Nothing here is remembered or estimated.\n'

  # -------------------------------------------------------------------------
  head2 "Routine run state"
  if [ -x .claude/scripts/routine-state.sh ]; then
    bash .claude/scripts/routine-state.sh status | sed '1,2d'
  else
    row "routine-state.sh" "not installed in this repo"
  fi

  # -------------------------------------------------------------------------
  if [ -d ops ]; then
    head2 "Live state (ops/)"
    for f in daily-log.md priorities.md pipeline.md customers.md feedback-log.md roadmap-signals.md direction-register.md; do
      [ -f "ops/$f" ] || continue
      d=$(newest_date_in "ops/$f")
      ahead=$(future_dates_in "ops/$f")
      suffix=""
      [ "$ahead" -gt 0 ] && suffix=" · $ahead dated ahead of today"
      if [ -n "$d" ]; then
        row "ops/$f" "last entry $d (${age_pad:-}$(days_since "$d")d ago)$suffix"
      else
        row "ops/$f" "no past-dated entry found$suffix"
      fi
    done
    [ -f ops/chokepoint-register.md ] &&
      row "chokepoint register rows" "$(grep -cE '^\|[^-|]' ops/chokepoint-register.md 2>/dev/null)"
    [ -f ops/direction-register.md ] &&
      row "live direction rows" "$(grep -ciE '^\|.*\blive\b' ops/direction-register.md 2>/dev/null)"
    row "handoffs on file" "$(count_md ops/handoffs)"
  fi

  # -------------------------------------------------------------------------
  if [ -d knowledge ]; then
    head2 "Knowledge base"
    for d in entities concepts comparisons synthesis; do
      [ -d "knowledge/$d" ] && row "knowledge/$d" "$(count_md "knowledge/$d")"
    done
    [ -d knowledge/raw ] && row "knowledge/raw (immutable sources)" "$(count_md knowledge/raw 3)"

    thin=0; orphan=0; total=0
    while IFS= read -r f; do
      total=$((total + 1))
      # The 2+ rule: an entity or concept needs two distinct raw sources, unless
      # it is explicitly marked an exception.
      grep -qiE '^exception:\s*true' "$f" && continue
      n=$(awk '/^sources:/{f=1;next} f&&/^[a-z_]+:/{exit} f&&/^[[:space:]]*-[[:space:]]/{c++} END{print c+0}' "$f")
      [ "$n" -lt 2 ] && thin=$((thin + 1))
      r=$(awk '/^related:/{f=1;next} f&&/^[a-z_]+:/{exit} f&&/^[[:space:]]*-[[:space:]]/{c++} END{print c+0}' "$f")
      [ "$r" -lt 1 ] && orphan=$((orphan + 1))
    done < <(find knowledge/entities knowledge/concepts -maxdepth 1 -name '*.md' ! -name 'README.md' 2>/dev/null)
    row "entity+concept pages checked" "$total"
    row "  under the 2+ sources rule" "$thin"
    row "  orphans (no related: entry)" "$orphan"
  fi

  # -------------------------------------------------------------------------
  if [ -d .claude/rules ]; then
    head2 "Rulebook size"
    row "rule files" "$(find .claude/rules -name '*.md' 2>/dev/null | wc -l | tr -d ' ')"
    row "total characters" "$(find .claude/rules -name '*.md' -exec cat {} + 2>/dev/null | wc -c | tr -d ' ')"
    if [ -d .claude/rules/_source ]; then
      l1=$(cat .claude/rules/_source/*.md 2>/dev/null | wc -c | tr -d ' ')
      state="within cap"
      [ "$l1" -gt "$L1_CHAR_CAP" ] && state="OVER the ${L1_CHAR_CAP}-char cap"
      row "L1 (_source/) characters" "$l1 — $state"
    fi
    # The memorability cap: a rules file past ~12 enumerated rules stops being
    # consulted and starts being guessed at (meta/l1-l2-migration.md).
    over=""
    while IFS= read -r f; do
      n=$(grep -cE '^\s*([0-9]+\.|[-*]\s\*\*)' "$f" 2>/dev/null)
      [ "$n" -gt "$RULE_CAP" ] && over="${over}$(printf -- '  - %-58s %s enumerated\n' "${f#./}" "$n")
"
    done < <(find .claude/rules -name '*.md' 2>/dev/null | sort)
    if [ -n "$over" ]; then
      printf -- '- rule files past the %s-rule cap:\n%s' "$RULE_CAP" "$over"
    else
      row "rule files past the ${RULE_CAP}-rule cap" "0"
    fi
  fi

  # -------------------------------------------------------------------------
  head2 "Configuration surface"
  [ -d .claude/skills ] && row "skills" "$(find .claude/skills -maxdepth 2 -name 'SKILL.md' 2>/dev/null | wc -l | tr -d ' ')"
  [ -d .claude/commands ] && row "commands" "$(count_md .claude/commands)"
  [ -d .claude/hooks ] && row "hooks" "$(find .claude/hooks -name '*.sh' 2>/dev/null | wc -l | tr -d ' ')"
  [ -d .claude/agents ] && row "agents" "$(count_md .claude/agents)"
  row "tracked files" "$(git ls-files 2>/dev/null | wc -l | tr -d ' ')"
  last_commit=$(git log -1 --format=%cs 2>/dev/null || echo "")
  [ -n "$last_commit" ] && row "last commit" "$last_commit ($(days_since "$last_commit")d ago)"

  # -------------------------------------------------------------------------
  head2 "Counted elsewhere — not repeated here"
  printf 'These already have an owner. A second script computing them its own way would\n'
  printf 'produce two numbers that disagree, which is worse than one in the right place:\n\n'
  printf -- '- open feedback-log loops, competitive-intel staleness, proof-point freshness,\n'
  printf -- '  wiki frontmatter, internal links: `.claude/scripts/checks/growth-os-checks.sh`\n'
  printf -- '- asserted-edge wiki queries (dangling, asymmetric, orphan, god-node):\n'
  printf -- '  `.claude/scripts/vault-ld/query-wiki-graph.py --refresh`\n'

  head2 "Not counted here"
  printf 'These need the network, so this script does not guess at them. Ask for them\n'
  printf 'directly rather than quoting a number from a document:\n\n'
  printf -- '- open pull requests per repo (GitHub)\n'
  printf -- '- weekly model usage and whether capacity lasted the week (usage panel)\n'
  printf -- '- open Notion tasks, live CRM pipeline, unread inbox\n\n'
  printf 'A number in a CLAUDE.md is a number that was true once. Count it here instead.\n'
}

if [ "$AS_HTML" -eq 1 ]; then
  body=$(report)
  cat <<HTML
<!doctype html>
<meta charset="utf-8">
<title>$REPO — counted off disk</title>
<style>
  :root { color-scheme: light dark; }
  body { margin: 0; padding: 2.5rem 1.25rem; font: 15px/1.6 ui-sans-serif, system-ui, sans-serif;
         background: #fbfbfa; color: #1c1c1c; }
  main { max-width: 56rem; margin: 0 auto; }
  pre { white-space: pre-wrap; word-wrap: break-word; font: 13px/1.65 ui-monospace, SFMono-Regular, Menlo, monospace;
        background: #fff; border: 1px solid #e4e4e2; border-radius: 10px; padding: 1.5rem; }
  @media (prefers-color-scheme: dark) {
    body { background: #131313; color: #e8e8e6; }
    pre { background: #1b1b1b; border-color: #2e2e2e; }
  }
</style>
<main><pre>$(printf '%s' "$body" | sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g')</pre></main>
HTML
else
  report
fi
