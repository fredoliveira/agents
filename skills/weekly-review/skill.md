---
name: weekly-review
description: Summarize the past week's daily notes, extracting key findings, links, action items, and potential atomic notes.
---

# Weekly Review

## Purpose

Process the past week's daily notes to generate a summary that captures key insights, tracks action items, and identifies ideas worth developing into atomic notes.

## Instructions

### 1. Locate the week's daily notes

- Calculate the date range for the past 7 days
- Find daily notes in `Daily/YYYY/MM-Month/YYYY-MM-DD.md` format
- Read each note in chronological order

### 2. Extract and summarize

For each daily note, identify:

| Category       | What to look for                                  |
| -------------- | ------------------------------------------------- |
| Key findings   | Insights, learnings, realizations, decisions made |
| Relevant links | URLs, references, resources worth revisiting      |
| Action items   | Tasks mentioned, TODOs, follow-ups needed         |

### 3. Identify emergent topics

Look for recurring themes or ideas that appeared multiple times across the week. These are candidates for atomic notes.

**Signs of an emergent topic:**

- Mentioned in more than one of the daily notes
- An insight that surprised or shifted thinking
- A connection between previously unrelated ideas
- Something worth remembering long-term

### 4. Present the review

Structure the output as:

```
## Week of [start date] - [end date]

### Key Findings
- [Summarized insights from the week]

### Links & Resources
- [Notable links with brief context]

### Action Items
- [ ] [Outstanding tasks or follow-ups]

### Potential Atomic Notes
- **[Proposed title as insight]**: [Brief explanation of why this deserves its own note]
```

### 5. Offer next steps

After presenting the review, ask the user if they'd like to:

- Create any of the suggested atomic notes
- Add action items to a specific location
- Explore any topic in more depth
