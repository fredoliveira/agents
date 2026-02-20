#!/usr/bin/env bash
# Symlink skills from this repo into the appropriate agent folders
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_SRC="$REPO_DIR/skills"
SKILLS_DSTS=(
  "$HOME/.claude/skills"
  "$HOME/.agents/skills"
)

for skills_dst in "${SKILLS_DSTS[@]}"; do
  mkdir -p "$skills_dst"
done

for skill_dir in "$SKILLS_SRC"/*/; do
  [ -d "$skill_dir" ] || continue
  name="$(basename "$skill_dir")"

  for skills_dst in "${SKILLS_DSTS[@]}"; do
    target="$skills_dst/$name"

    if [ -L "$target" ]; then
      echo "relink: $name -> $skill_dir ($skills_dst)"
      rm "$target"
    elif [ -e "$target" ]; then
      echo "skip:   $name (already exists and is not a symlink at $skills_dst)"
      continue
    else
      echo "link:   $name -> $skill_dir ($skills_dst)"
    fi

    ln -s "$skill_dir" "$target"
  done
done
