# Claude Code Skills

Custom skills for managing an Obsidian vault via Claude Code. Maintained by [Fred Oliveira](https://helloform.com)

## Installation

- Ensure [Claude Code](https://github.com/anthropics/claude-code) is installed
- Clone this repo into your Obsidian vault's `.claude/skills/` directory:
  ```bash
  cd /path/to/your/vault/.claude
  mkdir -p skills
  git clone https://github.com/fredoliveira/obsidian-skills skills
  ```
- Adjust the skill instructions to match your vault's folder structure if needed

## Available Skills

| Skill                    | Description                                                                             |
| ------------------------ | --------------------------------------------------------------------------------------- |
| `organize-inbox`         | Move notes from `Inbox/` to appropriate folders based on their frontmatter category     |
| `index-atomic-notes`     | File atomic notes under relevant topic MOCs and discover connections to related notes   |
| `find-place-coordinates` | Add lat/lon coordinates to place notes for map visualization                            |
| `weekly-review`          | Summarize the past week's daily notes, extracting key findings, links, and action items |
