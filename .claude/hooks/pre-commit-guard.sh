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

# Credential formats we block (matched case-insensitively). Add new ones here:
#   AWS access key id    — AKIA + 16 chars
#   GitHub tokens        — ghp_/gho_/ghs_/ghr_/ghu_ + 36 chars, and fine-grained github_pat_…
#   Slack tokens         — xoxb-/xoxa-/xoxp-/xoxr-/xoxs-…
#   Google API keys      — AIza + 35 chars
#   Stripe live keys     — sk_live_… / rk_live_…
#   OpenAI-style keys    — sk- + 20+ chars
#   PEM private keys     — -----BEGIN … PRIVATE KEY-----
#   Generic assignments  — password / api_key / secret / token = <value>
patterns='('
patterns+='AKIA[0-9A-Z]{16}'                                                              # AWS access key id
patterns+='|gh[opsru]_[A-Za-z0-9]{36}'                                                    # GitHub token (ghp_/gho_/ghs_/ghr_/ghu_)
patterns+='|github_pat_[A-Za-z0-9_]{22,}'                                                 # GitHub fine-grained PAT
patterns+='|xox[baprs]-[A-Za-z0-9-]+'                                                     # Slack token
patterns+='|AIza[0-9A-Za-z_-]{35}'                                                        # Google API key
patterns+='|(sk|rk)_live_[0-9A-Za-z]{24,}'                                                # Stripe live key
patterns+='|sk-[A-Za-z0-9]{20,}'                                                          # OpenAI-style key
patterns+='|-----BEGIN [A-Z ]*PRIVATE KEY-----'                                           # PEM private key
patterns+='|(password|api[_-]?key|secret|token)[[:space:]]*[:=][[:space:]]*[^[:space:]]+' # generic assignment
patterns+=')'

# Scan only ADDED lines (^+, excluding the +++ file header) so that *removing*
# a secret is never itself blocked.
added="$(git diff --cached -U0 | grep -E '^\+' | grep -vE '^\+\+\+' || true)"
hits="$(printf '%s\n' "$added" | grep -nEi "$patterns" || true)"
if [ -n "$hits" ]; then
  echo "Commit blocked — possible secret in staged changes:" >&2
  echo "$hits" | head -5 >&2
  echo "Remove it (and rotate it if it ever touched disk), then commit again." >&2
  exit 1
fi
exit 0
