# A full council run

**2026-08-27, on a personal website's repo.** This ran before the skill was packaged and
published, under its earlier name: same dispatch, same isolation contract, same reviewers.
Under review: a new call-to-action component rendered site-wide, the build-time script
written to guard it, and structured-data markup for a set of media appearances. No proprietary code is described below, and none is needed: every
finding is about markup, a check script, or a date.

## Reviewers

| Reviewer | Verdict |
|---|---|
| Codex `gpt-5.6-sol`, xhigh | FAIL |
| Gemini 3.1 Pro, via `agy` | FAIL |
| Grok `grok-4.6`, xhigh | PASS |
| Claude, blind subagent | FAIL |

Three failed, one passed, on identical input. That disagreement is the product.

## Three findings that held

**1. The guard could pass without checking anything.** The new check script counted matches by
splitting the page body on a string, then validated attributes by walking parsed anchor tags.
Two different notions of "a match", so an element that was not a link at all could be counted
as passing while never being validated. The host reproduced it: replacing the anchor with a
`<span>` carrying the same attribute left the guard cheerfully reporting 594 passes. A test
that cannot fail is worse than no test, and it had been written that same day, by the same
session that wrote the thing it was guarding.

Fixed by counting from the parsed anchors, rejecting the attribute on any non-anchor element,
exempting redirect documents only when they actually carry a refresh meta, and giving both
counters a zero-floor so an empty run cannot read as a clean one.

**2. A date in the structured data matched no source.** One appearance carried a date that fed
a schema `uploadDate`. The host checked three live sources rather than the repo: the video
platform said one date, the publisher's own page markup said another, its Open Graph said a
third, and the value in the file matched none of them. It had been copied from the entry below
it in the same file. Corrected, with the two genuinely different works keeping their own
different dates.

**3. Structured data claimed an English headline for a Romanian article.** The markup asserted
an editorial title, written in English, as the headline of a publisher's Romanian URL. The real
headline was fetched from the live page and used instead, with the language tagged, a local
canonical, and the publisher's permalink moved to where it belonged.

## One finding rejected, and three reviewers were wrong together

Three of the four independently flagged a hardcoded padding and border-radius as a design-token
violation. The host checked the tokens and the rest of the codebase: those exact values match an
existing sibling component, and no token carries them. Changing it would have broken visual
parity to satisfy a rule that does not exist. Rejected, with the reason recorded.

Reviewer agreement is not evidence. Three models reading the same packet share the same blind
spot, because they were handed the same context and none of them could open the token file.

A fourth finding, a claim that an embedded video loaded before consent, was also rejected. It
described real behaviour, but site-wide and pre-existing, and the host traced why it surfaced
at all: an over-broad framing in the orchestrator's own reviewer prompt. The packet you send
shapes what comes back, and a finding can be an artifact of your own question.

## Outcome

Three MAJORs verified and fixed, two rejected with reasons, plus several smaller fixes from the
blind reviewer including a label that echoed the link it sat next to and a pill that clipped its
own text when a longer translation wrapped to two lines. Nothing was changed until the host had
checked each finding against the files.

---

# A degraded run, against this repo

**2026-09-20.** Reviewed: the v0.3.0 diff, which had just shipped
`agents/blind-reviewer.md` so that `with claude` would stop naming a subagent that existed
only on my own machine.

Only one reviewer was available. Kept here because a review that cannot say what it failed
to check is not a review, and because the finding it got wrong is instructive.

## Reviewers

| Reviewer | Status |
|---|---|
| Codex (`gpt-5.6-sol`) | unavailable: account limit |
| Gemini 3.1 Pro, via `agy` | completed |
| Grok (`grok-4.6`) | unavailable: account limit |
| Claude (`fable`) | off by default, and unavailable |

Codex is a core reviewer, so this could not produce a clean verdict. One reviewer answered.
Under the skill's rules a single named reviewer's verdict decides, so the run continued as a
one-reviewer review and is reported as exactly that.

Packet: 20,962 bytes. The diff and the surrounding context inline, no paths to open, no repo
access, no tools.

## What came back

**VERDICT: FAIL**, three findings.

### 1. The Claude CLI dispatch was not actually blind — CONFIRMED

> When orchestrated from a host without a subagent mechanism, the skill shells out to the
> `claude` CLI from the project root. Claude Code inherently auto-ingests local repository
> context on startup. This grants the supposedly "blind" reviewer passive access to the
> codebase before the prompt is even processed.

True, and embarrassing. Every other reviewer in `SKILL.md` gets `--cd <review-tempdir>`. The
Claude CLI path I had added the same day pinned no working directory at all, so run from a
repo root it would inherit that project's context. Fixed in 0.3.1: it runs from the review
tempdir like the rest, with the residual limitation written down, since user-level config
still loads.

### 2. `install.sh` never installed the agent it claimed to ship — CONFIRMED, and worse than reported

The reviewer flagged the README's hand-copy path. Checking against the real files showed the
bug was bigger: `install.sh` only ever touched `~/.claude/skills` and `~/.agents/skills`. The
second of those is the Codex skills directory, not Claude's `agents/`. So **the entire clone
path still left `with claude` broken**, which is the exact bug v0.3.0 existed to fix. Shipping
the file was not the same as installing it, and I had assumed it was.

Fixed in 0.3.1, and the installer now skips rather than overwrites when a `blind-reviewer.md`
already exists, so it cannot clobber an unrelated agent of the same name. Verified against
three throwaway `HOME`s: clean install, rerun, and a pre-existing file left untouched.

### 3. The CLI command is syntactically broken — REJECTED

> In `claude -p --model fable ... < <promptfile>`, the `-p` flag expects a string argument.
> It will consume `--model` as the literal prompt text, treat `fable` as an invalid
> positional argument, and ignore the stdin redirection entirely.

Not true. `-p` takes no argument and reads stdin. The command had been run before it was
written down, and was run again to confirm:

```
$ claude -p --model sonnet --disallowed-tools "Bash,Read,Write,..." < p3.txt
PARSED
```

This is the most useful finding in the run, because of how it is wrong. A blind reviewer
cannot execute anything, so when it reasons about a CLI's behaviour it is reasoning from
memory of that CLI's conventions. That is precisely where isolation costs you accuracy, and
precisely why the host verifies findings against reality instead of forwarding them.

## Outcome

Two bugs fixed, one finding rejected with evidence, shipped as v0.3.1. Two of three reviewers were unavailable, so this is one model's opinion that happened to be
right twice, not the full council. The difference is worth stating rather than hiding: a review that cannot say what it
failed to check is not a review.

---

# Earlier runs, on other repos

The same method, before it was packaged as a skill.

## A release-ordering bug that was not in the code

**2026-08-22, [agentmarkup](https://github.com/agentmarkup/agentmarkup).** Under review: a
plan and its implementation for shipping a plugin, run as `codex only with claude`.

The same isolated packet was sent to Codex twice, at two reasoning efforts. **Medium passed
with no findings. Extra-high failed with one MAJOR** — and the finding was not a code defect
at all. It was sequencing: four npm packages carried unpublished source changes, and pushing
the plugin would make it publicly installable while its entire job was to tell users to
`npm install` those packages. Publish first, or ship a plugin that instructs people to
install code that does not exist yet.

Two things worth noting. The reviewer knew nothing about the author's own private worry on
exactly this point, and arrived at it independently from the packet alone. And the cheaper
setting found nothing, on identical input: on release-safety questions, effort is not a
formality.

Nothing shipped that day. The sequence was reordered.

## A precedence bug in crawler detection

**2026-07-07, agentmarkup.** Four short blind, tool-free review dispatches against a
bug-backlog branch. Round one found dead code, an escape helper nothing called any more. A
later round found the real one: the routine that decides which AI crawlers a site blocks
mishandled `robots.txt` group precedence, so it could report the wrong answer about a site's
own crawler rules. For a tool whose whole output is "here is what crawlers can see", that is
the load-bearing function.

Both were found by reviewers that could not open the repo, from the packet alone.
