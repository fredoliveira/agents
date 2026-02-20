---
name: index-atomic-notes
description: Index an atomic note in existing maps of content and find potential connections to related atomic notes.
---

# Atomic note indexer

## Purpose

Integrate a new atomic note into the knowledge graph by:

1. Filing it under relevant topic maps of content (MOCs)
2. Discovering and creating meaningful connections to other atomic notes

## Instructions

### 1. Understand existing topics

Browse the `Topics/` folder to understand what maps of content already exist and what subjects they cover.

### 2. File the note under relevant topics

**If the note fits existing topics:**

- Add a link to the atomic note in the appropriate section of each relevant MOC
- Add those topics to the note's frontmatter `topics` property

**If no suitable topic exists:**

- Ask the user whether to create a new topic or leave the note unindexed for now

### 3. Find connections to other atomic notes

- Start by exploring notes already linked from the relevant topics
- Identify notes that relate meaningfully to the new one
- **Always ask the user before modifying other notes**

## Preserving Atomicity When Cross-Linking

Each atomic note should contain a single, focused insight. Cross-links must enhance without diluting.

### Principles

| Do                                  | Don't                                       |
| ----------------------------------- | ------------------------------------------- |
| Add brief links that provide nuance | Add explanatory text that expands the scope |
| Suggest connections to the user     | Modify notes without permission             |
| Preserve the original focus         | Turn notes into discussion hubs             |

### Self-check before adding a link

- Does the note title still capture the complete insight?
- Could a reader understand the core idea from the title and first paragraph alone?
- Am I changing what this note is fundamentally about?

If the answer to the last question is "yes", suggest the link to the user instead of adding it.

### Examples

**Good cross-link** — adds nuance to existing insight:

> Original: "Large language models understand concepts"
> Addition: "However, [[Performance depends on verifiability]], which means they show stronger capabilities on verifiable tasks."

**Bad cross-link** — dilutes atomicity:

> Original: "AIs are currently trained very broadly"
> Addition: "This broad training is particularly effective for verifiable tasks because..."
> Problem: Shifts focus from describing training to explaining task performance.

## Example Workflow

Given this atomic note:

```yaml
---
title: The AIs of today are more grown than written
created: 2025-07-05
tags:
  - note/atom
category:
  - "[[Atoms]]"
---
```

**Steps:**

1. **Identify topic**: This note belongs under `Topics/Artificial Intelligence.md`
2. **Update the MOC**: Add a link to this note in an appropriate section of the AI topic file
3. **Update the note's frontmatter**: Add the `topics` property:

```yaml
---
title: The AIs of today are more grown than written
created: 2025-07-05
tags:
  - note/atom
topics:
  - "[[Artificial Intelligence]]"
category:
  - "[[Atoms]]"
---
```

4. **Explore connections**: Look at other notes linked from the AI topic and ask the user about potential cross-links
