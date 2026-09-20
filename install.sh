#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "$0")" && pwd)"
dests=("$HOME/.claude/skills" "$HOME/.agents/skills")
skills=(review wawa init-repo-docs)

for dest in "${dests[@]}"; do
  mkdir -p "$dest"
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
