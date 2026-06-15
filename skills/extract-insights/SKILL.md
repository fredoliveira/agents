---
name: extract-insights
description: Extract actionable lessons, key insights, emergent todos, and best practices from a note (e.g. a video transcript or article in an Obsidian vault, for example). Use when asked to "extract insights / lessons / takeaways" from a note or document. Outputs bullet lists in chat, or writes them to a markdown file if asked.
allowed-tools: Read, Write, Edit
argument-hint: <path to note> [→ optional output file path]
---

# Extract insights from a note

## Purpose

Read one note (transcript, article, clipping, meeting notes — anything) and pull
out what's worth keeping, as bullet lists under four headings:

- **Actionable lessons** — things to *do* differently, stated as guidance.
- **Key insights** — the non-obvious ideas worth remembering.
- **Todos** — concrete next actions that emerge for *the reader/user*.
- **Best practices** — repeatable rules or standards worth adopting.

## Instructions

1. **Read the note in full.** Take the path the user gave (default to the file
   they `@`-referenced or the active note). Page through long files — don't
   extract from a partial read.

2. **Extract.** For each of the four headings, write a bullet list. Rules:
   - Omit a heading entirely if the note genuinely has nothing for it. Don't pad.
   - One idea per bullet, declarative and self-contained (readable without the
     source open).
   - No fixed count necessary. Capture what's real, skip sponsor reads, filler, and
     biography.
   - Quote a memorable line only when it earns its place.

3. **Output — composable, decided by how you were asked:**
   - **Default (no output file mentioned):** print the bullet lists directly in
     the chat. Nothing is written to disk.
   - **If the user asks for a markdown file** (e.g. "save it", "create a note",
     or gives a path): write the lists to a `.md` file.
     - **Title / filename:** `Insights from <source title>.md` — keep it
       consistent so these notes are easy to spot.
     - **Location:** if the user gave a path, use it. Otherwise default to an
       `Inbox/` folder at the vault root if one exists (so the user can triage
       it later), falling back to the source note's own folder.
     - **Body:** link back to the source note in the first line, then the lists.
     - Include light frontmatter:

     ```markdown
     ---
     source: "[[<source note title>]]"
     created: <today's date, YYYY-MM-DD>
     tags:
       - insights
     ---

     # Insights from <source title>

     Extracted from [[<source note title>]].

     ## Actionable lessons
     - ...

     ## Key insights
     - ...
     ```
     (Drop empty sections here too.) Then tell the user the path you wrote.

## Notes

- Keep it minimal. The model already knows how to extract — this skill just fixes
  the four buckets, the bar for inclusion, and the chat-vs-file output choice.
- Adapt to the vault: if the user's notes use different tags or folders, match them.
