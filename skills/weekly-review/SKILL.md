---
name: weekly-review
description: Summarize the past week's daily notes, extracting key findings, links, action items, and potential atomic notes, and write the summary into the matching weekly note.
---

# Weekly Review

## Purpose

Process a calendar week's daily notes to generate a summary that captures key insights, tracks action items, and identifies ideas worth developing into atomic notes. The summary is written into the `## Review` section of that week's weekly note.

## Instructions

### 1. Determine the target week

- Default to the **last completed week** (Monday–Sunday). If the user names a specific week or date, use that instead.
- Compute the weekly note name in `gggg-[W]ww` format. Use the shell to stay accurate:
  - Last completed week: `date -v-7d -v-mon +%G-W%V` (e.g. `2026-W24`)
  - Current week: `date +%G-W%V`
- The weekly note lives at `Weekly/<gggg-[W]ww>.md` (e.g. `Weekly/2026-W24.md`).
- Compute the Monday–Sunday date range for that week (e.g. `date -v-7d -v-mon +%Y-%m-%d` for the Monday, then add days).

### 2. Locate and read the week's daily notes

- Find daily notes in `Daily/YYYY/MM-Month/YYYY-MM-DD.md` format for each of the 7 days.
- Read each note that exists, in chronological order. Skip days with no note.

### 3. Extract and summarize

For each daily note, identify:

| Category       | What to look for                                  |
| -------------- | ------------------------------------------------- |
| Key findings   | Insights, learnings, realizations, decisions made |
| Relevant links | URLs, references, resources worth revisiting      |
| Action items   | Tasks mentioned, TODOs, follow-ups needed         |

### 4. Identify emergent topics

Look for recurring themes or ideas that appeared multiple times across the week. These are candidates for atomic notes.

**Signs of an emergent topic:**

- Mentioned in more than one of the daily notes
- An insight that surprised or shifted thinking
- A connection between previously unrelated ideas
- Something worth remembering long-term

### 5. Write the review into the weekly note

The weekly note's `## Review` section already contains three empty subsections (created from the template):

```
### Key Findings
- 

### Potential Atomic Notes
- 

### Action Items
- [ ] 
```

Fill them in:

- **Key Findings** — summarized insights from the week, one bullet each. Reference the relevant `[[wikilinks]]` inline rather than listing links separately — the source daily notes are already linked from the `## Days` list, so a standalone link dump would just duplicate them.
- **Potential Atomic Notes** — `- **[Proposed title as insight]**: [why it deserves its own note]`.
- **Action Items** — `- [ ]` task per outstanding follow-up.

Then write it to `Weekly/<gggg-[W]ww>.md`:

- **If the weekly note exists:** populate the three subsections under `## Review` in place — replace the empty placeholder bullets with your content, and leave the rest of the note (Days, anything the user added) untouched. If the user has already written content under a subsection, append rather than overwrite.
- **If the weekly note does not exist:** create it from `Meta/Templates/Weekly Note Template.md`. The template uses Templater syntax (`<% %>`), which only runs inside Obsidian — so render the equivalent content yourself: the `note/weekly` tag, a `# Week ww, gggg` heading, the date range, a `## Days` list linking each day (`[[YYYY-MM-DD|dddd, MMM D]]`), and the `## Review` section with the three subsections filled in.

### 6. Confirm and offer next steps

Report which weekly note was written to. Then ask the user if they'd like to:

- Create any of the suggested atomic notes
- Move action items into their Focus section or elsewhere
- Explore any topic in more depth
