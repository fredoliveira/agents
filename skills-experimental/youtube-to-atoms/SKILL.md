---
name: youtube-to-atoms
description: Given a YouTube URL, fetch its transcript and extract atomic notes into an Obsidian vault. Use when handed a YouTube link to mine for ideas, or asked to "turn this video into atomic notes / atoms".
allowed-tools: Bash, Read, Write, Edit
argument-hint: <youtube url>
---

# YouTube → atomic notes

## Purpose

Turn one YouTube video into a **source note** plus a set of **atomic notes** in
an Obsidian vault. The unit of extraction is a *solid, transferable idea or
concept* — not a summary.

The note style (what an atomic note is, frontmatter, linking, a worked example)
is fully codified in the bundled **[reference.md](reference.md)** — this skill is
self-contained and does not depend on any particular vault existing beforehand.

## Configuration

The vault root is the `YT_VAULT` environment variable, defaulting to
`~/Documents/obsidian/yt`. The skill reads/writes three subfolders (created
automatically):

- `$YT_VAULT/Transcripts/` — fetched transcript (provenance)
- `$YT_VAULT/Sources/` — one source note per video
- `$YT_VAULT/Atoms/` — the atomic notes

To target a different vault, set `YT_VAULT` before invoking (e.g.
`export YT_VAULT=~/notes/myvault`).

## Instructions

### 1. Fetch the transcript

Run the bundled script with the URL the user gave you:

```bash
python3 "${CLAUDE_SKILL_DIR}/fetch_transcript.py" "<youtube url>"
```

It prints the absolute path of the transcript markdown file (or an `ERROR:` line
if the video has no English captions, or if YouTube throttled the request —
relay that to the user and stop). If a transcript for that video already exists,
it prints the existing path.

> Requires `yt-dlp` (`python3 -m pip install yt-dlp`). Auto-generated captions
> are used when no human captions exist — they extract fine.

### 2. Read the transcript IN FULL

Read the printed file completely (page through with offset/limit if it's long —
many videos run for hours). Do **not** extract from a partial read. The
frontmatter holds `url`, `channel`, `duration`; body paragraphs are prefixed
with `**[MM:SS]**` timestamps.

### 3. Learn the style, then extract

Read **[reference.md](reference.md)** (in this skill's directory) — it is the
authoritative guide for note shape, linking, and the worked example. Then extract
atomic notes from the transcript following it. The essentials:

- **Idea-driven, NO target count.** Capture every distinct, solid, transferable
  idea the video genuinely contains — could be 2, could be 20+. Never pad to a
  number; never cut a real idea. Thin/promotional videos may yield very few.
- **The bar:** a real, transferable insight or concept. Skip sponsor reads,
  biography, small talk, and pure mechanics / play-by-play summary.
- **One idea per note;** declarative full-sentence titles (the filename *is* the
  claim).
- **Always `[[wikilink]]` every person and organization** on every mention, plus
  concepts and 2–4 reused `topics` — even unresolved. These anchor the graph.
- **Source + clickable timestamp go in frontmatter**, never in the body.

### 4. Write the files

Per the formats in `reference.md`:

- Each atom → `$YT_VAULT/Atoms/<the claim>.md`
- One source note → `$YT_VAULT/Sources/<Source Note Title>.md`, listing every
  atom under `## Atomic notes extracted`. Every atom's `source:` must exactly
  match this title.

Use today's date for the `created:` field.

### 5. Mark the transcript processed

Edit the transcript file: change `status: unprocessed` to `status: processed`.

### 6. Report

Tell the user the source note title, how many atoms you wrote, and their titles.
Offer to run an indexing pass (e.g. an `index-atomic-notes` skill, if available)
to weave the new atoms' `[[links]]` into `Topics/` maps of content.

## Notes

- **Batches:** this skill is the per-video unit — drive it once per URL for
  multiple videos.
- **Garbled caption names:** auto-captions often misspell names; canonicalize
  people/org names to their correct spelling and flag any you're unsure about.
- **Adapting:** if a user's vault uses different conventions (tag names, folder
  names), keep the principles in `reference.md` and adjust the specifics.
