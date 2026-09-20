# A real `/council-review` run

**2026-09-20, against this repo.** Reviewed: the v0.3.0 diff, which had just shipped
`agents/blind-reviewer.md` so that `with claude` would stop naming a subagent that existed
only on my own machine.

This is a real run with its real result, not a demo. It is also a degraded run, and that is
part of what it shows.

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
