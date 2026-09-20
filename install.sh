#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "$0")" && pwd)"
dests=("$HOME/.claude/skills" "$HOME/.agents/skills")
skills=(council-review wawa init-repo-docs)

# The blind reviewer /council-review dispatches for "with claude".
# Never clobber an unrelated agent of the same name: this is someone's
# own definition until proven otherwise.
agent_dir="$HOME/.claude/agents"
agent_src="$root/agents/blind-reviewer.md"
agent_target="$agent_dir/blind-reviewer.md"
mkdir -p "$agent_dir"
if [[ -e "$agent_target" || -L "$agent_target" ]] \
  && [[ "$(readlink "$agent_target" 2>/dev/null)" != "$agent_src" ]]; then
  echo "skipped $agent_target (already exists, left untouched)"
elif ln -sf "$agent_src" "$agent_target" 2>/dev/null; then
  echo "linked $agent_target -> $agent_src"
else
  cp "$agent_src" "$agent_target"
  echo "copied $agent_target"
fi

for dest in "${dests[@]}"; do
  mkdir -p "$dest"
  # Legacy cleanup: the review skill was renamed to council-review in 0.2.0.
  # Only remove a link this installer created, never an unrelated skill.
  legacy="$dest/review"
  if [[ -L "$legacy" && "$(readlink "$legacy")" == "$root/skills/"* ]]; then
    rm -f "$legacy"
  fi
  for name in "${skills[@]}"; do
    src="$root/skills/$name"
    target="$dest/$name"
    if [[ -L "$target" || -e "$target" ]]; then
      rm -rf "$target"
    fi
    if ln -s "$src" "$target" 2>/dev/null; then
      echo "linked $target -> $src"
    else
      cp -R "$src" "$target"
      echo "copied $target"
    fi
  done
done
