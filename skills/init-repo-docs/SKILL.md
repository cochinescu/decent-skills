---
name: init-repo-docs
description: Backfill STATUS.md + TODO.md (and DECISIONS.md if warranted) for an existing repo from git history, plans, and the wiki.
disable-model-invocation: true
---

User-invoked. Run only when the user asked for this skill.
Target: $ARGUMENTS (optional scope hint, e.g. "last 6 months" or
"only STATUS"; empty = full backfill of this repo)

Run from the repo root. Goal: bootstrap STATUS.md, TODO.md, and optionally
DECISIONS.md for a repo that predates that convention. Read-only toward
everything except those three files; never commit.

Step 1 — Mine sources (delegate bulk reading if a cheaper worker is
available; the main session adjudicates and writes):
- git log: dates, merges, release tags, bursts of activity →
  milestone candidates. Use commit dates as the source of truth for
  entry dates.
- Repo CLAUDE.md + README: current capabilities, stated conventions.
- Planning docs (planning-docs/ or the repo's detected plan dir):
  dated plans → compare plan vs what actually landed; unimplemented
  plan items are TODO candidates.
- If README or CLAUDE.md points at a project wiki or history page, read
  it. If a local wiki page exists for this repo, read that too.
  READ-ONLY — never edit wiki content from here.
- In-code markers: TODO/FIXME/HACK comments → TODO candidates
  (with file:line).
- gh: open PRs/issues and non-default branches → TODO candidates.

Step 2 — Categorize. Every entry must trace to evidence (a commit,
file, plan doc, or wiki line); never invent history or rationale.
- STATUS.md: things that HAPPENED — shipped features, milestones,
  migrations, fixes worth remembering. Dated yyyy-mm-dd, newest
  first, one short block each (what changed, where, outcome). For a
  long history, summarize older periods into coarse per-month/quarter
  blocks instead of per-commit noise; recent work gets finer grain.
- TODO.md: things still OPEN — unimplemented plan items, wiki open
  threads, code markers, open PRs/branches, known gaps. Prioritized
  checklist; each item notes its source. Drop items that evidence
  shows already landed (that's what the cross-check is for).
- DECISIONS.md: ONLY if the mining surfaces real architectural
  choices with a recoverable "why" (from plan docs, wiki, commit
  messages). One line each: date, decision, why. If the why is not
  recoverable, write "(rationale not recorded)" — never fabricate.
  Fewer than ~3 solid entries → skip the file entirely.

Step 3 — Write. If any of the files already exist, merge into them
(preserve existing entries, keep date ordering) — never clobber.
Then report a compact summary: entry counts per file, the top open
TODOs, and anything ambiguous that needs my judgment (e.g. "branch X
looks abandoned — TODO or drop?"). Stop there; do not commit.
