# STATUS

## 2026-09-20

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
