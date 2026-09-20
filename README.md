<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/banner-dark.png">
    <source media="(prefers-color-scheme: light)" srcset="assets/banner-light.png">
    <img alt="decent-skills. Check, then trust." src="assets/banner-light.png" width="800">
  </picture>
</p>

# decent-skills

Agent skills I built for my own use, and decided to open source. Enjoy. Public, MIT.

[**`/council-review`**](./skills/council-review/README.md) runs a code review through Codex, Gemini and Grok at once, and Claude as a fourth when you ask for it. The reviewers get the same evidence packet, cannot inspect the repo, and never see each other's answers. Only the host model reads the real files, and it checks every finding against them before anything is reported to you. Nothing is changed until you say `fix`.

[A full run is in `examples/review.md`](./examples/review.md): four reviewers, three said FAIL and one said PASS, three findings verified and two rejected, including one that three of them agreed on.

[**`/wawa`**](./skills/wawa/SKILL.md) answers "where are we at, and what's next". It reads the repo first and `STATUS.md` second. When the two disagree, that disagreement is the answer, because notes are hypotheses with a timestamp on them.

[**`/init-repo-docs`**](./skills/init-repo-docs/SKILL.md) writes `STATUS.md`, `TODO.md` and `DECISIONS.md` from git history, planning docs and your own notes, with the evidence traced. It does not commit.

None of the three start on their own. You type them.

## Install

**Claude Code**

```bash
claude plugin marketplace add cochinescu/decent-skills
claude plugin install decent-skills@decent-skills
```

**Codex and Grok**

```bash
git clone https://github.com/cochinescu/decent-skills.git
cd decent-skills
./install.sh
```

That links `skills/*` into `~/.claude/skills/` and `~/.agents/skills/`, and the blind reviewer into `~/.claude/agents/`. ChatGPT's hosted app does not read a local skills directory, so the script cannot install there; the skills themselves are plain Markdown with frontmatter and carry an `agents/openai.yaml` manifest, so any host that loads a local skills folder can use them. It symlinks when it can and copies when it cannot, and it leaves an existing `blind-reviewer.md` alone rather than overwriting yours.

`/council-review` wants `codex`, `agy` and `grok` on PATH for a full run. Default pins: Codex `gpt-5.6-sol`, Antigravity `Gemini 3.1 Pro (High)`, Grok `grok-4.6`, and Claude `fable` when you add `with claude`. All four sit at their vendor's top tier. Change the pins if your account differs.

## Prerequisites

`/council-review` dispatches to external CLIs, so it is only as good as what you have installed. Each reviewer is a separate vendor account, billed to you.

| Reviewer | CLI on PATH | Vendor | Role |
|---|---|---|---|
| Codex | `codex` | OpenAI | core |
| Gemini, via Antigravity | `agy` | Google | core |
| Grok | `grok` | xAI | supplemental |
| Claude, blind subagent | `claude` | Anthropic | off by default, see below |

Claude Code itself (`claude`) is the usual host, and is also what runs the blind reviewer when it is enabled.

Check what you have:

```bash
for c in codex agy grok claude; do printf "%-7s " "$c"; command -v $c >/dev/null && $c --version 2>&1 | head -1 || echo "not installed"; done
```

Verified against `codex-cli 0.153.4`, `agy 1.2.7`, `grok 1.0.34` and `claude 2.1.278`. Install each from its own vendor; this repo ships no installers for them.

**With none of the three installed**, `/council-review` would have nothing to dispatch to, so it falls back to the Claude blind reviewer and says so in the report. That is a real review, but a weaker one: Claude is the least independent seat, because it is usually also the host that built the packet. Install at least Codex and Antigravity for the review this skill is actually for.

`/wawa` and `/init-repo-docs` have no prerequisites beyond the host.

## What this sends, and what it cannot see

`/council-review` sends the code you selected to **OpenAI, Google and xAI**, through their own CLIs under your own accounts. It builds a packet: the diff, the relevant file excerpts, and the check results. That packet leaves your machine. Read it before you point this at anything you cannot share.

Isolation is the design, and it has a cost. Reviewers know only what is in the packet, so they will sometimes be confidently wrong about the code around it. In [the example run](./examples/review.md) the reviewer declared a shell command syntactically broken; it was not, and it could not find out, because it cannot run anything. That is the trade: you get an opinion uncontaminated by the session that wrote the code, and you pay for it in context. The host model exists to catch exactly this, which is why findings are verified against the real files and not passed through.

The Claude reviewer stays **off by default** for the same reason. This command is normally typed in Claude Code, so Claude built the packet and usually wrote the code under review. That makes it the least independent of the four. Add `with claude` when you want it anyway, and note that it switches itself on when fewer than two of the others are reachable, rather than handing you an empty review.

## Where it came from

The method predates the skill. Codex, Antigravity and Grok went over the plan, three rounds of it, for the skill we took to the [GTM Skillathon](https://gtm-skillathon-2026-results.upb-alexander.chatgpt.site/) in August, Europe's first agent skill hackathon, supported by OpenAI's Codex. It won first place out of the 34 that shipped that evening.

## Also, not copied here

I also publish [anxiety-reset](https://github.com/Anima-Felix/anima-felix-agent-skills) from Anima Felix, and [agentmarkup](https://github.com/agentmarkup/agentmarkup). I do not copy them into this repo. Copies go stale, and the licences are not mine to flatten.

## License

[MIT](./LICENSE) · [Sebastian Cochinescu](https://cochinescu.com)
