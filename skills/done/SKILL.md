---
name: done
description: Summarize the current agent session, create an Obsidian note for it, and link it from today's daily note. Use when the user is finished with a session and wants to log what was accomplished.
disable-model-invocation: true
allowed-tools: Bash
argument-hint: [optional extra context]
---

Summarize this Claude Code session, create a dedicated session note in Obsidian, and link it from today's daily note.

## Instructions

1. Review the full conversation history for this session.
2. Come up with a short summary title (2-6 words, no date) describing the overall theme.
3. Write a detailed session note in markdown. The note MUST begin with YAML frontmatter and then use the sections described below. Skip any sections that don't make sense. The only non-negotiable is the frontmatter, which must always be present. Use this template:

```
---
created: YYYY-MM-DD
project: <working directory name or repo name>
harness: <who you are ('claude-code', or 'codex', or 'pi', etc)>
tags:
  - note/agent-session
---

# <summary title>

## Summary

<1-3 sentence overview of the session>

## What was done

- <bullet list of key actions, changes, and outcomes>

## Decisions made

- <bullet list of decisions and the reasoning behind them>
- <include trade-offs considered, alternatives rejected, and why>

## Relevant code snippets

<relevant new commands that were created, code snippets that were mentioned, etc>

## File changes

- `path/to/file` -- <what changed and why>
- <list every file that was created, modified, or deleted>

## Deferred / Postponed

- <anything discussed but intentionally left for later>
- <known issues discovered but not addressed>
- <if nothing was deferred, write "None">

## Notes

- <any additional context, gotchas, or follow-up items>
- <if $ARGUMENTS was provided, incorporate that context here or in the relevant section above>
```

   Be thorough -- err on the side of detail. The goal is a complete record of the session.
4. Get today's date in YYYY-MM-DD format and construct the note path:
   `Reference/Agent Sessions/YYYY-MM-DD <summary title>`
5. Find the full path to the Obsidian vault by running `obsidian vault` - the path will be listed.
5. Create the session note file at <path>/Reference/Agent Sessions/YYYY-MM-DD <summary title>.md
6. Append a link to the session note in today's daily note by running:

```
obsidian daily:append content="- [[YYYY-MM-DD <summary title>]]" silent
```

## Formatting rules

- **Frontmatter is required** -- every note must start with the YAML frontmatter block
- Always include the `agent-session` tag
- Be detailed and verbose in the body -- capture the full picture of the session
- Use plain markdown (no HTML)
- Escape any double quotes in the content so the shell command works
- Focus on outcomes but include reasoning and context behind decisions
- List every file changed, not just the "key" ones
- The daily note entry should be just a link: `- [[YYYY-MM-DD <summary title>]]`
- For the harness frontmatter property, choose one of 'claude-code', 'codex', 'pi', etc.

## Known issues

- **Obsidian CLI multi-byte character bug**: The `obsidian` CLI fails to create notes when the content or path contains multi-byte characters (e.g., emoji, non-ASCII Unicode). Avoid using emoji or non-ASCII characters in note titles and content. Stick to plain ASCII text.

