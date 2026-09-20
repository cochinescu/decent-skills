# STATUS

## 2026-09-20

- Corrected a false portability claim: the install path advertised ChatGPT, but `install.sh`
  writes to `~/.claude/skills` and `~/.agents/skills`, and ChatGPT's hosted app reads neither.
  Codex genuinely does (`~/.codex/config.toml` points at `~/.agents/skills`). Heading is now
  "Codex and Grok"; the same claim was removed from the blog post in both languages.
- Stage photo removed from the repo README. It stays on the blog: the blog is Sebastian's
  surface, the README is for someone landing cold who needs the mechanism, not a biography.
- STILL BLOCKING A LAUNCH: `examples/review.md` leads with a one-reviewer run, because Codex
  and Grok were unavailable. A three-reviewer run needs to go above it before this is
  posted anywhere. Nothing else is outstanding.

- Repo prepared for a cold audience (HN). Root README retitled `decent-skills` and opens
  with the mechanism rather than authorship; the Skillathon paragraph and the photo moved
  below the fold. New `skills/council-review/README.md` so that folder does not open with a
  19 KB spec. New `examples/review.md`: the real 0.3.0 run (two bugs found, one finding
  rejected) plus two earlier agentmarkup runs, the medium-vs-xhigh sequencing catch and the
  robots.txt precedence bug.
- Added a "What this sends, and what it cannot see" section: selected code goes to OpenAI,
  Google and xAI under the user's own accounts, and isolation costs reviewers context. The
  rejected finding is used as the worked example of that cost.
- GitHub description and topics updated for discovery: `code-review`, `agent-skills`,
  `claude-code`, `codex`, `gemini`, `grok`, `ai-code-review`.
- Examples are drawn from public repos only. Work on private products is not
  used here.



- v0.3.1, from a `/council-review` run with Antigravity as the only reachable reviewer (Codex
  It returned three findings; two held.
  - `install.sh` never installed `agents/blind-reviewer.md`, so the clone path still left
    `with claude` broken even after 0.3.0 shipped the file. It now installs it, and skips
    rather than overwrites when a `blind-reviewer.md` already exists. Verified against three
    throwaway HOMEs: clean install, rerun, and a pre-existing file left untouched.
  - The Claude CLI dispatch pinned no working directory, so a run started in the repo would
    inherit project context and stop being blind. It now takes the review tempdir, like the
    `--cd` every other reviewer gets.
  - Rejected: the claim that `claude -p --model fable ... < file` is syntactically broken.
    Ran it twice, it parses and reads stdin. A blind reviewer cannot test a CLI, so flag
    reasoning is exactly where its findings need checking.

- v0.3.0: the blind-reviewer agent definition now ships in `agents/blind-reviewer.md`. It had
  only ever existed in Sebastian's `~/.claude/agents/`, so `with claude` named a subagent that
  did not exist for anyone who installed the plugin.
- The Claude reviewer is pinned to `fable`, not `sonnet`. The personal `/review` demoted it to
  a fast model for cost; in public it sits at the same tier as Codex `gpt-5.6-sol`, Antigravity
  `Gemini 3.1 Pro (High)` and Grok `grok-4.6`. Verified the CLI accepts both `fable` and
  `claude-fable-5-1`; a quota message is now handled as CLAUDE-LIMIT, like Grok's.
- SKILL.md states the orchestrator is whichever host the command was typed in (Claude Code,
  Codex, ChatGPT, Grok), that it alone may read the repo, and that all four reviewer types are
  available on any host. Added a `claude -p --model fable --disallowed-tools ...` dispatch path
  for hosts with no subagent mechanism, verified working before it was written down.
- README realigned to the rewritten blog post: authorship framing, `/council-review` leading,
  the Skillathon result, no Matt Pocock references (that credit lives on X).

- v0.1.0: published `council-review` (renamed from `review` to avoid slash-command collision), `wawa`, `init-repo-docs` as a public MIT plugin (`cochinescu/decent-skills`).
- README: same origin story as the cochinescu.com post. How to Web photo added. Cut the launch-copy slop.
- Submitted to Anthropic Console 2026-09-20; the submission shows **Passed review**. Its stored
  Example 1 still says `/review`, typed before the rename, and the console offers no visible
  edit for a reviewed submission. Examples 2 and 3 are correct.
- v0.2.0: `marketplace.json` metadata still advertised `review`, and the rename had shipped
  under the 0.1.0 version number, so two different skill sets existed as 0.1.0. Both fixed.
- `install.sh` removed `$dest/review` unconditionally, which would have deleted an unrelated
  skill of that name for anyone who had one. It now removes that path only when it is a
  symlink this installer created.
