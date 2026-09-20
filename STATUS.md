# STATUS

## 2026-09-20

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
