# .agents

Maintained by [Fred Oliveira](https://x.com/f).

This is a set of custom skills and agent files for AI agents like Pi, Claude Code, or Codex. Many of them manage my Obsidian vault, because that's fundamental to my workflow.

## Installation

- Clone this repository somewhere
- Read (please, *always read install scripts*), customize, and run `./install.sh` to symlink these to your agent folders
- Share your own skills if you have them!

## Obsidian skills

These are relatively specific to the inner workings of my [Obsidian](https://obsidian.md) vault, but you may find them useful too. Probably pretty quick to adapt if your vault is relatively close to [@kepano](https://x.com/kepano)'s [vault template](https://github.com/kepano/kepano-obsidian).

| Skill                    | Description                                                                              |
| ------------------------ | --------------------------------------------------------------------------------------- |
| `done`                   | Summarize an agentic session and add the summary to Obisidian                           |
| `organize-inbox`         | Move notes from `Inbox/` to appropriate folders based on their frontmatter category     |
| `index-atomic-notes`     | File atomic notes under relevant topic MOCs and discover connections to related notes   |
| `find-place-coordinates` | Add lat/lon coordinates to place notes for map visualization                            |
| `weekly-review`          | Summarize the past week's daily notes, extracting key findings, links, and action items |
| `extract-insights`       | Extract actionable lessons, key insights, emergent todos, and best practices from a note |
| `summarize-urls`         | Fetch and summarize a list of URLs into Obsidian-friendly markdown                       |
| `backup-vault`           | Create a dated zip backup of the vault, rotating old backups on a grandfather-father-son schedule |

## Experimental skills

Work-in-progress skills living in `skills-experimental/`.

| Skill              | Description                                                                              |
| ------------------ | --------------------------------------------------------------------------------------- |
| `youtube-to-atoms` | Fetch a YouTube video's transcript and extract atomic notes into an Obsidian vault      |
