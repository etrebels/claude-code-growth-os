# Pre-Launch Scrub Checklist

Run this before you flip a repo — this one, or a fork you've filled with your own
content — to **public**. It catches the two things that actually hurt: secrets,
and other people's data. Every item is a copy-paste command plus a yes/no.

> **Why it matters.** This kit is built to be filled with *your* playbooks,
> pipeline, and customer notes. The empty starter is safe to publish; a populated
> fork is **not** until you've checked it. The `demo/` folder is fictional on
> purpose — present and share from that.

## 1. Secrets — working tree *and* full history

A secret deleted in a later commit still lives in history. Scan both.

```bash
# High-confidence key formats across every commit
git log -p --all | grep -niE \
  'sk-ant-[a-z0-9]|sk-[A-Za-z0-9]{20,}|AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{36}|github_pat_|AIza[0-9A-Za-z_-]{35}|xox[baprs]-|-----BEGIN.*PRIVATE KEY|eyJ[A-Za-z0-9_-]{10,}\.eyJ'
```

- [ ] No output. (The only acceptable hit is the pattern list inside
  `.claude/hooks/pre-commit-guard.sh` — that's the guard describing itself.)

```bash
# Generic credential words assigned a value
git log -p --all | grep -niE '(password|api[_-]?key|secret|token)[[:space:]]*[:=][[:space:]]*[^[:space:]]+' \
  | grep -viE 'example|placeholder|your[_-]|<|settings.local|\.env'
```

- [ ] Nothing real — only examples and placeholders.

## 2. Local / secret config is gitignored and untracked

- [ ] `.mcp.json`, `.claude/settings.local.json`, and `.env*` are listed in
  `.gitignore`.
- [ ] None are tracked:
  `git ls-files | grep -E '\.env|settings\.local\.json|^\.mcp\.json$'` returns
  nothing.
- [ ] Only the committed `*.example` versions exist.

## 3. Other people's data (the legal one)

Real prospect / customer names, deals, and meeting notes are third-party personal
data. Keep them out of a public repo.

```bash
# Emails in history — a commit-author email is fine; emails in file content are not
git log -p --all | grep -oiE '[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}' | sort -u

# Phone-like numbers
git log -p --all | grep -oiE '\+?[0-9]{1,3}[ -]?\(?[0-9]{2,4}\)?[ -][0-9]{3,4}[ -][0-9]{3,4}' | sort -u
```

- [ ] `ops/` files are empty templates, or filled only with data you're willing
  to publish.
- [ ] `demo/` contains only fictional names (or you've deleted it).
- [ ] No real account or contact names in any tracked file.
- [ ] (Optional, privacy) Decide whether your commit-author email should be your
  real address or a GitHub `noreply` one.

## 4. The repo is actually launch-shaped

- [ ] `LICENSE` present and correct.
- [ ] `README` renders, and its call-to-action link is right.
- [ ] The **default branch** (`main`) holds the real content, not a stub —
  `git ls-tree -r main --name-only | wc -l` looks right.
- [ ] Visibility is **Public** — do this **last**, once everything above passes.

## 5. Leave the guard armed

```bash
ln -s ../../.claude/hooks/pre-commit-guard.sh .git/hooks/pre-commit
```

- [ ] Commit guard installed so a future secret can't slip in. Test it: try to
  commit a fake key — it should block.
