#!/usr/bin/env bash
set -euo pipefail

# SessionStart — web/remote dependency bootstrap.
#
# Runtime is pure bash + python3 (no npm/pip/cargo). The one tool a fresh
# Claude Code on the web container lacks is shellcheck — the linter CI runs
# on .claude/hooks/*.sh (see .github/workflows/shellcheck.yml). Without it
# you can lint the hooks in CI or a local terminal, but not inside a web
# session. This hook installs it so `shellcheck .claude/hooks/*.sh` runs
# in-session too, matching CI.
#
# Local sessions skip this entirely (CLAUDE_CODE_REMOTE != true) — your own
# machine already has whatever you installed. Idempotent, non-interactive,
# and never blocks: a setup failure logs a warning and exits 0 so the
# session still starts.

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

log() { echo "[web-bootstrap] $*" >&2; }

# Run a command as root when possible (the web container is usually root;
# fall back to sudo if available). Returns non-zero if neither works.
run_root() {
  if [ "$(id -u)" = "0" ]; then
    "$@"
  elif command -v sudo >/dev/null 2>&1; then
    sudo "$@"
  else
    return 1
  fi
}

ensure_shellcheck() {
  if command -v shellcheck >/dev/null 2>&1; then
    log "shellcheck present ($(shellcheck --version 2>/dev/null | awk '/version:/{print $2; exit}'))"
    return 0
  fi
  if ! command -v apt-get >/dev/null 2>&1; then
    log "WARN: no apt-get — cannot install shellcheck; hook linting will not run this session"
    return 0
  fi
  log "shellcheck missing — installing"
  # Do NOT gate the install on `apt-get update`: some base images ship
  # third-party PPAs that 403 on update and would abort an `update && install`
  # chain. Run them independently and let the install pull from the cache.
  run_root env DEBIAN_FRONTEND=noninteractive apt-get update -y >/dev/null 2>&1 || true
  run_root env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends shellcheck >/dev/null 2>&1 || true
  if command -v shellcheck >/dev/null 2>&1; then
    log "shellcheck installed ($(shellcheck --version 2>/dev/null | awk '/version:/{print $2; exit}'))"
  else
    log "WARN: shellcheck install failed — hook linting will not run this session"
  fi
}

main() {
  log "starting web bootstrap"
  ensure_shellcheck
  log "done"
}

main
