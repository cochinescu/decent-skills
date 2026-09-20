<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/banner-dark.png">
    <source media="(prefers-color-scheme: light)" srcset="assets/banner-light.png">
    <img alt="decent-skills. Check, then trust." src="assets/banner-light.png" width="800">
  </picture>
</p>

# The three skills I actually type

Public, MIT. They work with Claude Code, Codex, ChatGPT, and Grok. They do not start on their own. `/council-review` can spend three paid CLIs, so you have to mean it.

I found myself typing the same things over and over. "Where are we at, and what's next," a few dozen times a day. That is how [`/wawa`](./skills/wawa/SKILL.md) came to life. It still means that. It looks at the repo first, then at `STATUS.md`. If they disagree, that is the point.

[`/council-review`](./skills/council-review/SKILL.md) used to be a pile of terminal windows. I copied the diff around, then asked each of the four LLMs I use to review it. Now it is one command. Codex, Antigravity, and Grok get the same packet. They cannot see the repo. They cannot use tools. Claude orchestrates and is the only one allowed to look at the repo, so every finding gets checked against the real files. Nothing gets fixed until I say `fix`. If one of them is missing, you just get less of a review.

It is not Matt Pocock's [`/code-review`](https://www.aihero.dev/skills-code-review), which checks a diff against standards and spec in the same session. It is not Claude's `/code-review`, which hunts bugs in a PR. It is not Codex's `/review`, which is one pass on local git. Same word, different job.

[`/init-repo-docs`](./skills/init-repo-docs/SKILL.md) is how I already split work in the rest of my life: decisions, todos, status. Same thing, for repos, and for the other work I do with agents. It writes `STATUS.md`, `TODO.md`, and `DECISIONS.md` from git, plans, and the wiki. It does not commit.

<p align="center">
  <img src="assets/how-to-web-demo-nights.webp" alt="Sebastian Cochinescu at How to Web Demo Nights 2026" width="480">
</p>

I wanted them small, like [Matt Pocock's skills](https://www.aihero.dev/skills). You type them. They do not take over your process.

## Install

**Claude Code**

```bash
claude plugin marketplace add cochinescu/decent-skills
claude plugin install decent-skills@decent-skills
```

Then `/council-review`, `/wawa`, `/init-repo-docs`.

**Codex, ChatGPT, Grok**

```bash
git clone https://github.com/cochinescu/decent-skills.git
cd decent-skills
./install.sh
```

That puts `skills/*` into `~/.claude/skills/` and `~/.agents/skills/`. Symlink if it can, copy if it cannot.

One skill only:

```bash
cp -R skills/wawa ~/.agents/skills/
```

`/council-review` wants `codex`, `agy`, and `grok` on PATH for a full run. Default models: Codex `gpt-5.6-sol`, Antigravity `Gemini 3.1 Pro (High)`, Grok `grok-4.6`. Change the pins if your account differs.

## Also, not copied here

I also publish [anxiety-reset](https://github.com/Anima-Felix/anima-felix-agent-skills) from Anima Felix, and [agentmarkup](https://github.com/agentmarkup/agentmarkup). I do not copy them into this repo. Copies go stale, and the licences are not mine to flatten.

## License

[MIT](./LICENSE) · [Sebastian Cochinescu](https://cochinescu.com)
