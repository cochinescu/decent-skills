# decent-skills

Three user-invoked agent skills. One `SKILL.md` each, for Claude, Codex/ChatGPT, Grok, Gemini, and any host that loads Agent Skills.

| Skill | What it does |
|---|---|
| **review** | Isolated multi-model review (Codex + Antigravity + Grok). Read-only. Does not fix until you say `fix`. |
| **wawa** | Where we are, and what's next. Checks the repo, then distrusts the notes. |
| **init-repo-docs** | Backfill `STATUS.md`, `TODO.md`, and `DECISIONS.md` from git history, plans, and the wiki. Does not commit. |

Also useful, not copied here:

- [anxiety-reset](https://github.com/Anima-Felix/anima-felix-agent-skills) — Anima Felix
- [agentmarkup](https://github.com/agentmarkup/agentmarkup)

## Install

**Claude**

```bash
claude plugin marketplace add cochinescu/decent-skills
claude plugin install decent-skills@decent-skills
```

Then `/review`, `/wawa`, `/init-repo-docs`.

**Codex, ChatGPT, Grok, Gemini**

```bash
git clone https://github.com/cochinescu/decent-skills.git
cd decent-skills
./install.sh
```

That symlinks `skills/*` into `~/.claude/skills/` and `~/.agents/skills/`. If a host refuses symlinks, the script copies instead.

Or copy a single skill:

```bash
cp -R skills/wawa ~/.agents/skills/
```

These are slash/user skills, not auto-run. `review` can dispatch three paid CLIs — it should not fire on its own.

## review

Needs `codex`, `agy`, and `grok` on PATH for full coverage. A missing reviewer is reduced coverage, not a hard failure.

Default models (change the pins if your account differs): Codex `gpt-5.6-sol`, Antigravity `Gemini 3.1 Pro (High)`, Grok `grok-4.6`.

## License

MIT
