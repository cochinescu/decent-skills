<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/banner-dark.png">
    <source media="(prefers-color-scheme: light)" srcset="assets/banner-light.png">
    <img alt="decent-skills — Check, then trust." src="assets/banner-light.png" width="800">
  </picture>
</p>

# Skills that check, then trust

The agent skills I actually run. Small. User-invoked. They work with Claude, Codex, ChatGPT, Gemini, and Grok.

They do not auto-fire. `/council-review` can spend three paid CLIs — that is a gesture, not a reflex.

## The skills

- **[council-review](./skills/council-review/SKILL.md)** — Isolated multi-model review. Codex, Antigravity, and Grok see the same target. None of them see your repo. None of them can use tools. The orchestrator adjudicates. It does not fix until you say `fix`. Not Claude `/code-review`, not Matt Pocock `/code-review`, not Codex `/review`.
- **[wawa](./skills/wawa/SKILL.md)** — Where we are, and what's next. Notes are hypotheses with a timestamp. Checks the repo first, then distrusts `STATUS.md`.
- **[init-repo-docs](./skills/init-repo-docs/SKILL.md)** — Backfill `STATUS.md`, `TODO.md`, and `DECISIONS.md` from git history, plans, and the wiki. Evidence-traced. Does not commit.

## Install

Two ways in. The Claude plugin is a managed bundle. `install.sh` symlinks the files so you can hack on them. Pick one.

<details>
<summary><strong>Claude Code</strong></summary>

```bash
claude plugin marketplace add cochinescu/decent-skills
claude plugin install decent-skills@decent-skills
```

Then `/council-review`, `/wawa`, `/init-repo-docs`.

</details>

<details>
<summary><strong>Codex, ChatGPT, Grok, Gemini</strong></summary>

```bash
git clone https://github.com/cochinescu/decent-skills.git
cd decent-skills
./install.sh
```

That symlinks `skills/*` into `~/.claude/skills/` and `~/.agents/skills/`. If a host refuses symlinks, the script copies instead.

One skill only:

```bash
cp -R skills/wawa ~/.agents/skills/
```

</details>

## Why these exist

Agents fail in three boring ways. These skills are the fix I actually type.

1. **The agent reviews itself.** `/council-review` sends the same packet to three isolated CLIs and adjudicates the findings against the files. A missing reviewer is reduced coverage, not a hard failure. Needs `codex`, `agy`, and `grok` on PATH for full coverage. Default pins: Codex `gpt-5.6-sol`, Antigravity `Gemini 3.1 Pro (High)`, Grok `grok-4.6`. Change them if your account differs.
2. **The agent quotes the notes.** `/wawa` treats `STATUS.md`, `TODO.md`, and anything said earlier as dated hypotheses. If a note and the repo disagree, that disagreement is the finding.
3. **The repo has no memory.** `/init-repo-docs` mines git, plans, and the wiki into `STATUS.md` / `TODO.md` / `DECISIONS.md`, then stops. You commit when you mean to.

## Also useful, not copied here

Copying forks a licence or an identity, and a vendored copy always drifts.

- [anxiety-reset](https://github.com/Anima-Felix/anima-felix-agent-skills) — Anima Felix
- [agentmarkup](https://github.com/agentmarkup/agentmarkup)

## License

[MIT](./LICENSE) · [Sebastian Cochinescu](https://cochinescu.com)
