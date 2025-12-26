---
note: find-place-coordinates
description: Find lat/lon coordinates for a place mentioned in a note and add them to the frontmatter for map integration
---

# Coordinate finder

## Purpose

Enhance notes about places by adding geographic coordinates to their frontmatter, enabling map visualisation across Obsidian.

## Instructions

1. Identify the place the note is about (from the note title or content)
2. Search for the most accurate coordinates for that location
3. Add the coordinates to the note's frontmatter using the `coordinates` property

## Frontmatter Format

The `coordinates` property is a multitext field where:

- First value = latitude (positive for North, negative for South)
- Second value = longitude (positive for East, negative for West)

```yaml
coordinates:
  - "41.1469"
  - "-8.6148"
```

## Examples

A note called "Livraria Lello" refers to a library in Porto, at `41.1469° N, 8.6148° W`. This means that its frontmatter should include:

```yaml
coordinates:
  - "41.1469"
  - "-8.6148"
```
