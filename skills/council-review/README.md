# /council-review

Three models review the same code without repo access and without seeing each other's answers. The host model, which does see the repo, checks every finding against the real files before any of it reaches you.

Most review tools put one model in your session, looking at your tree, holding your conversation. That model watched you write the code. It agrees with you too easily. This one is three models that cannot touch the repo at all.

## How it works

1. **The host builds a packet.** The diff, the file excerpts that matter, and the results of whatever checks the repo runs. Everything inline: a reviewer is never given a path to open, because it has nothing to open it with.
2. **The same packet goes to all reviewers at once.** Codex, Gemini (through the Antigravity CLI) and Grok, each in its own temp directory, each with tools disabled, none of them able to read the repo or see the others' output.
3. **The host adjudicates.** Every finding is checked against the actual files. Findings that survive are reported with a verdict; findings that do not are rejected, and the rejection is shown with its reason.
4. **Nothing is changed.** The run is read-only until you reply `fix`.

A missing reviewer is reduced coverage, not a failed run. Codex and Gemini are the core pair; Grok is supplemental. If a reviewer is out of credit or times out, it is marked and the run continues.

## Install

See the [root README](../../README.md). In Claude Code:

```bash
claude plugin marketplace add cochinescu/decent-skills
claude plugin install decent-skills@decent-skills
```

## Use

```
/council-review
```

with no argument reviews your local changes against the base branch. Otherwise pass a target:

```
/council-review src/api/
/council-review planning-docs/2026-07-04-auth-plan.md
/council-review codex only
/council-review with claude
```

`codex only`, `agy only`, `grok only` and `claude only` run a single reviewer, and its verdict alone decides. `with claude` adds a fourth reviewer that is otherwise off, for the reason in [What this sends](../../README.md#what-this-sends-and-what-it-cannot-see).

Every run ends with one of: `REVIEW CLEAN`, `VERDICT: FAIL`, or `REVIEW INCOMPLETE`. Nothing is fixed until you reply `fix` (or `fix + improvements`).

## Example output

[`examples/review.md`](../../examples/review.md) has real runs. The first is a full four-reviewer council that split three FAIL to one PASS, found a guard script that could pass without checking anything, and rejected a finding three of the four agreed on. Below it, a degraded single-reviewer run against this repo, which found two genuine bugs and got its third finding wrong.

## Requirements

`codex`, `agy` and `grok` on PATH for a full run. Default model pins are in the [root README](../../README.md#install). The full specification, including the isolation contract, the dispatch flags for each CLI and the failure handling, is in [`SKILL.md`](./SKILL.md).
