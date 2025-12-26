---
name: organize-inbox
description: Move notes from the Inbox to their respective folders based on their frontmatter category.
---

# Inbox note organizer

## Purpose

Process notes in the Inbox and file them into the appropriate folder based on their `category` frontmatter property.

## Instructions

1. List all notes in `Inbox/`
2. For each note, read its frontmatter `Category` property
3. Move the note to the corresponding destination folder (see mapping below)
4. If the category is missing or unclear, ask the user where the note should go

## Category → Folder Mapping

| Category                 | Destination                    |
| ------------------------ | ------------------------------ |
| `[[Atoms]]`              | `Atoms/`                       |
| `[[Ideas]]`              | `Ideas/`                       |
| `[[Books]]`              | `Reference/Books/`             |
| `[[Meetings]]`           | `Reference/Meetings/`          |
| `[[Organizations]]`      | `Reference/Organizations/`     |
| `[[People]]`             | `Reference/People/`            |
| `[[Places]]`             | `Reference/Places/`            |
| `[[Products]]`           | `Reference/Products/`          |
| `[[Recipes]]`            | `Reference/Recipes/`           |
| _(none or unrecognised)_ | `Notes/` _(confirm with user)_ |

## Notes

- Always confirm with the user before moving notes with missing or unrecognised categories
- If a note has multiple categories, ask the user which folder takes priority
