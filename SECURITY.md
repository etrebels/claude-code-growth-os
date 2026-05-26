# Security Policy

This is a plain-text starter — no server, no database, no build step, no telemetry. The risk is about what you put *into* it.

## Keep secrets out of git

- API keys and machine-local config belong in `.claude/settings.local.json` and `.mcp.json` — **both are gitignored.** Copy the committed `.claude/settings.local.example.json` and `.mcp.json.example` to start.
- A **PreToolUse hook** (`.claude/hooks/protect-files.sh`) blocks the agent from writing to `.env*`, keys, and `settings.local.json`.
- Install the **commit guard** once so a secret can't slip into a commit:
  ```
  ln -s ../../.claude/hooks/pre-commit-guard.sh .git/hooks/pre-commit
  ```

## Keep real client data out of a public fork

- The `demo/` data is fictional by design. The safe way to present or share is to run from `demo/`.
- Don't commit real prospect names, deals, or meeting notes to a repo you intend to publish — that is third-party personal data.
- **Before you flip a fork to public, run the [pre-launch scrub checklist](docs/launch-scrub-checklist.md)** — copy-paste commands that scan the working tree *and* full git history for secrets and other people's data.

## Reporting

Found a security issue with the starter itself (e.g. a hook that could be abused)? Please open a **private** report via GitHub → **Security → Report a vulnerability**, or open a regular issue for anything non-sensitive.
