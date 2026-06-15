# Atomic note style guide

This is the codified house style this skill writes in. It's a common Obsidian
Zettelkasten convention; if your own vault differs (different tag names, folder
names), adapt the specifics but keep the principles: **atomic, declaratively
titled, densely linked, source-attributed.**

## What an atomic note is

A single, self-contained idea — the smallest unit of knowledge worth keeping.

- **One idea per note.** If you need "and" in the title, it's probably two notes.
- **The title is a complete declarative sentence** stating the claim. The
  filename *is* the claim: `Inference is a high-margin business.md`, not
  `Inference margins.md`.
- **Understandable on its own.** A reader should grasp the idea from the title
  and first sentence without watching the video.
- **Densely linked.** Concepts, people, and organizations are `[[wikilinked]]`
  so the note joins a graph rather than sitting in isolation.

Notes live in three folders:

- `Atoms/` — the atomic notes (one idea each)
- `Sources/` — one note per video, linking to every atom drawn from it
- `Topics/` — maps of content (MOCs) that gather atoms by subject. This skill
  does **not** create these; a separate indexing pass links atoms into them.
  That's why unresolved `[[links]]` are expected and good — they're seeds.

## Extraction philosophy

- **Idea-driven, NO target count.** Capture every distinct, solid, transferable
  idea the video genuinely contains — could be 2, could be 20+ for a dense
  lecture. Never pad to a number; never cut a real idea. A thin or promotional
  video may yield very few.
- **The bar:** a real, transferable insight or concept. Skip sponsor reads,
  biography, small talk, and pure mechanics / play-by-play summary ("the host
  asked X"). Capture evergreen claims, not a recap of the conversation.

## Atom format

Filename: `<the claim>.md` (identical to the `title`). Frontmatter:

```yaml
---
title: <the claim, identical to the filename>
created: <today's date, YYYY-MM-DD>
source: "[[<Source Note Title>]]"
timestamp: <source URL with &t=<seconds>s appended>
tags:
  - note/atom
topics:
  - "[[Topic A]]"
  - "[[Topic B]]"
category:
  - "[[Atoms]]"
---
```

Body — restate the claim, then elaborate in 1–3 short paragraphs. Rules:

- **Source and timestamp live in frontmatter only.** Never put a `Source:` line
  in the body.
- **`timestamp`** is the source video URL plus `&t=<seconds>s`, where seconds is
  the moment the idea appears (convert the nearest `**[MM:SS]**` / `[H:MM:SS]`
  marker in the transcript to total seconds). A bare URL renders as a clickable
  jump-to-moment link in Obsidian — so don't wrap it in markdown link syntax.
- **`[[wikilink]]` concepts generously**, even if the target note doesn't exist.
- **Always `[[wikilink]]` every person and organization, on every mention** —
  `[[Andrej Karpathy]]`, `[[Anthropic]]`, `[[DeepMind]]`. These are the
  highest-value exploration anchors in the graph; never leave a name as plain
  text. (If only a first name is given and you can't confidently resolve the
  full name, leaving it plain is acceptable.)
- **`topics`:** 2–4 per atom. Reuse consistent names across notes so they
  cluster (e.g. `[[AI Engineering]]`, `[[Reinforcement Learning]]`).
- **Cross-link** related atoms from the same video with a short
  `Relates to [[...]]` line where it adds nuance.

## Source note format

Filename: `<Source Note Title>.md` in `Sources/`. Pick a clean, human title with
no `/`, `:`, or other filename-breaking characters.

```yaml
---
title: <Source Note Title>
created: <today's date>
tags:
  - media/video
  - source/youtube
channel: <channel>
url: <video url>
duration: <duration>
topics:
  - "[[...]]"
---
```

Body: an H1, then `![Video source](<url>)`, a one-line blockquote
(`> [<channel>](<url>) · <duration> · <guest / one-line description, with [[ ]] links>`),
a short context paragraph, then a `## Atomic notes extracted` list linking every
atom with `[[...]]`. Every atom's `source:` must exactly match this title, and
every atom must appear in this list.

---

## Worked example

A transcript line reads:

> **[37:10]** ...if you look at the pure inference part of a business... the floor
> is the cost of electricity... we rent GPUs at scale... there's like an 80%
> margin in there... I wouldn't be surprised if [the big labs are] looking at
> like 90% margin...

### Atom — `Atoms/Inference is a high-margin business.md`

```markdown
---
title: Inference is a high-margin business
created: 2026-06-04
source: "[[Building OpenCode with Dax Raad]]"
timestamp: https://www.youtube.com/watch?v=1VqKUrxR2C8&t=2230s
tags:
  - note/atom
topics:
  - "[[AI Economics]]"
  - "[[Inference]]"
  - "[[Large Language Models]]"
category:
  - "[[Atoms]]"
---

Inference is a high-margin business, despite public sentiment that AI providers are losing money on it. The cost floor for serving a token is essentially the electricity to power the hardware (plus amortized capital and ops); everything above that is margin.

[[Dax Raad]], who rents GPUs at scale, observes ~80% margins on some models even as a middleman, and guesses frontier labs like [[Anthropic]] and [[OpenAI]] may see ~90%. The big caveat: this isolates inference from the enormous R&D and training costs carried elsewhere in the business.

Relates to [[GPU supply is a binding constraint even for small AI companies]].
```

Note: declarative title = filename; `source` and clickable `timestamp` in
frontmatter; people (`[[Dax Raad]]`) and orgs (`[[Anthropic]]`, `[[OpenAI]]`)
linked; an unresolved `Relates to` seed.

### Source note — `Sources/Building OpenCode with Dax Raad.md`

```markdown
---
title: Building OpenCode with Dax Raad
created: 2026-06-04
tags:
  - media/video
  - source/youtube
channel: The Pragmatic Engineer
url: https://www.youtube.com/watch?v=1VqKUrxR2C8
duration: 1:21:02
topics:
  - "[[AI Engineering]]"
  - "[[Developer Tools]]"
---

# Building OpenCode with Dax Raad

![Video source](https://www.youtube.com/watch?v=1VqKUrxR2C8)

> [The Pragmatic Engineer](https://www.youtube.com/watch?v=1VqKUrxR2C8) · 1:21:02 · interview with [[Dax Raad]], co-founder of [[OpenCode]]

## Atomic notes extracted

- [[Inference is a high-margin business]]
- [[Shipping more features easily tends to produce a worse product]]
```
