#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "$0")" && pwd)"
dests=("$HOME/.claude/skills" "$HOME/.agents/skills")
skills=(council-review wawa init-repo-docs)

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
