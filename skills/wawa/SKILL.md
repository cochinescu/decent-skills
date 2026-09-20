---
name: wawa
description: Where are we at, and what's next — verified session/repo status with a recommended next move.
disable-model-invocation: true
---

User-invoked. Run only when the user asked for this skill.
Scope hint: $ARGUMENTS

"wawa" = **w**here **a**re **w**e at now, and **w**hat's next.

Give me an orientation briefing. Read-only: never edit, commit, deploy, or start
long jobs. If Scope hint is empty, cover the current session and the current repo.
If it names a repo, area, or task, narrow to that.

## Rule that overrides everything else here

**Do not tell me the state of things by quoting notes.** `STATUS.md`, `TODO.md`,
planning docs, and anything I said earlier in this session are *hypotheses with a
timestamp*. Check what is actually true right now, then report. If a note and
reality disagree, the disagreement IS the finding and goes near the top.

Label every claim `verified: <what you ran>` or `assumed`. An unlabeled claim reads
as verified, which is the failure mode this command exists to prevent.

## Step 1: Establish real state (run these, don't reason about them)

- `git status --short` and `git log --oneline -8`. What is uncommitted, what landed
  recently, which branch, ahead/behind.
- Any work in flight I started: background tasks, running processes, spawned agents,
  open monitors. For each: still alive, exited, or silently dead? A process alive but
  producing no output is *running*, not finished — say which, and say how long it has
  been going. Never report a pending job as done, and never invent its result.
- If this session already did work, what of it is actually on disk versus still
  only described in conversation.
- Check anything cheap that would change my next decision: does the build/test state
  still hold, is a published artifact current, does the thing I think is deployed
  match what is live.

## Step 2: Read the tracking files, then distrust them

Read `STATUS.md` and `TODO.md` (and `DECISIONS.md` if present) for intent and
history. For a planning, strategy, or "what should we do" scope, also read any
project wiki or history page the repo points at (README, CLAUDE.md, or a local
wiki path). Skip if none exists. Do not propose building something that already
exists.

Then spot-check the load-bearing claims. Items marked done that are not done, items
marked blocked whose blocker has cleared, and dates that have passed are the most
valuable things you can surface.

## Step 3: Report

Keep it short and decision-shaped. Findings and decisions, not narration. No recap
of what I already watched you do.

**Where we are** — 3-6 bullets. Current state of the work, each one verified.

**In flight** — anything running or half-finished, with its real status and what it
is waiting on. Say plainly if something needs me (a permission, a credential, a
manual step, a decision only I can make).

**Drifted** — where the notes, the plan, or my assumptions no longer match reality.
Omit the heading if nothing drifted. Include overdue dated items.

**What's next** — a short ordered list. For each: the move, why it is next, and
roughly what it costs. Mark anything blocked on me.

**Recommendation** — one line: the single next action you would take, and whether
you need my go-ahead to take it.

If something is genuinely unknown, say "unknown" and name the one check that would
resolve it. Do not fill the gap with a plausible guess.

Do not overcomplicate language, checkups or findings. Aim for simplicity and clarity.
