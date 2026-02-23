---
name: summarize-urls
description: Fetch and summarize a list of URLs (e.g. from OneTab) into Obsidian-friendly markdown with a brief description of each link.
allowed-tools: WebFetch, Bash
argument-hint: <paste URL list>
---

# Summarize URLs

## Purpose

Turn a batch of URLs -- typically exported from OneTab or a similar browser extension -- into a curated, Obsidian-friendly markdown summary. Each link is fetched, read, and distilled into a short description so the list becomes a useful reference note rather than a wall of raw URLs.

## Instructions

### 1. Parse the input

The user will paste a list of URLs. Each line can be in one of these formats:

| Format | Example |
| --- | --- |
| `url \| title` | `https://example.com \| Example Site` |
| `url \| title \| source` | `https://example.com \| Example Site \| Hacker News` |
| bare URL | `https://example.com` |

- Split on ` \| ` (pipe surrounded by spaces) to separate URL from title/source.
- Ignore blank lines.
- If a title is present, use it as the display name; otherwise derive one from the page content.

### 2. Fetch and summarize each URL

For each URL:

1. Fetch the page content using WebFetch.
2. Ask WebFetch to extract: what the page is about in 1-2 sentences, and any key takeaways.
3. If a URL is unreachable (localhost, paywalled, 404, etc.), note it as `(could not fetch)` and use the title if available.

Fetch multiple URLs in parallel where possible to save time.

### 3. Build the markdown summary

Structure the output as:

```
## Link Summary

| Link | Summary |
| --- | --- |
| [Display Title](url) | 1-2 sentence summary |
| ... | ... |
```

If there are more than 5 links and clear thematic clusters emerge (e.g. "AI / Agents", "Web Dev", "Security"), group them under subheadings instead of a single flat table:

```
## Link Summary

### AI / Agents
| Link | Summary |
| --- | --- |
| ... | ... |

### Web Dev
| Link | Summary |
| --- | --- |
| ... | ... |
```

### 4. Append to the daily note

1. Find the Obsidian vault path by running `obsidian vault`.
2. Append the markdown summary to the daily note by running:

```
obsidian daily:append content="<the full markdown summary>" silent
```

- Escape any double quotes in the content so the shell command works.

### 5. Confirm and offer next steps

Tell the user the summary was appended to their daily note, with a brief count (e.g. "Added 8 links to your daily note"). Then ask if they'd like to:

- Expand on any particular link
- Remove or re-categorize any entries
