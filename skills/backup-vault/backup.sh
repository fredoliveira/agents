#!/usr/bin/env bash
#
# backup.sh — create a dated zip backup of the Obsidian vault and apply
# grandfather-father-son (GFS) retention to the backup directory.
#
# Retention tiers (union — a backup is kept if ANY tier wants it):
#   - daily:   every backup from the last 14 days
#   - weekly:  newest backup of each of the 5 most recent ISO weeks
#   - monthly: newest backup of each of the 12 most recent months
#   - yearly:  newest backup of each of the 5 most recent years
# Everything else is deleted.
#
# Safe to run repeatedly: at most one backup is created per calendar day.
#
# Usage:
#   ./backup.sh              create today's backup, then rotate
#   ./backup.sh --dry-run    show what would be created/deleted, change nothing
#
# Override defaults via env vars: VAULT_DIR, BACKUP_DIR.

set -euo pipefail

VAULT="${VAULT_DIR:-/Users/fred/Documents/obsidian/umwelt}"
BACKUP_DIR="${BACKUP_DIR:-/Users/fred/Documents/obsidian/backups}"
PREFIX="umwelt"

# Retention knobs
DAILY_DAYS=14     # keep every backup within this many days
WEEKLY_KEEP=5     # distinct ISO weeks to keep one backup from
MONTHLY_KEEP=12   # distinct months
YEARLY_KEEP=5     # distinct years

DRY_RUN=0
[ "${1:-}" = "--dry-run" ] && DRY_RUN=1

run() { if [ "$DRY_RUN" -eq 1 ]; then echo "[dry-run] $*"; else "$@"; fi; }

if [ ! -d "$VAULT" ]; then
  echo "error: vault not found: $VAULT" >&2
  exit 1
fi

mkdir -p "$BACKUP_DIR"

TODAY=$(date +%Y-%m-%d)
ARCHIVE="$BACKUP_DIR/$PREFIX-$TODAY.zip"

# ---------------------------------------------------------------------------
# 1. Create today's backup (idempotent — skip if it already exists)
# ---------------------------------------------------------------------------
if [ -e "$ARCHIVE" ]; then
  echo "= today's backup already exists: $(basename "$ARCHIVE")"
else
  parent=$(dirname "$VAULT")
  base=$(basename "$VAULT")
  echo "+ creating $(basename "$ARCHIVE")"
  if [ "$DRY_RUN" -eq 1 ]; then
    echo "[dry-run] zip -r $ARCHIVE $base  (from $parent)"
  else
    # cd into the parent so the archive contains a top-level "umwelt/" dir.
    # Exclude macOS cruft and, defensively, the backup dir itself.
    ( cd "$parent" && zip -r -q -X "$ARCHIVE" "$base" \
        -x "*/.DS_Store" "*/.Trash/*" "$(basename "$BACKUP_DIR")/*" )
    echo "  done ($(du -h "$ARCHIVE" | cut -f1))"
  fi
fi

# ---------------------------------------------------------------------------
# 2. Apply GFS retention
# ---------------------------------------------------------------------------
CUTOFF=$(date -v-$((DAILY_DAYS - 1))d +%Y-%m-%d)

shopt -s nullglob
files=("$BACKUP_DIR/$PREFIX-"*.zip)
if [ ${#files[@]} -eq 0 ]; then
  echo "no backups to rotate."
  exit 0
fi

# Build a date-sorted (descending) table: <date>\t<isoweek>\t<month>\t<year>
table=$(
  for f in "${files[@]}"; do
    b=$(basename "$f")
    d=${b#"$PREFIX"-}; d=${d%.zip}
    [[ $d =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]] || continue
    keys=$(date -j -f "%Y-%m-%d" "$d" "+%G-%V	%Y-%m	%Y" 2>/dev/null) || continue
    printf '%s\t%s\n' "$d" "$keys"
  done | sort -r
)

[ -z "$table" ] && { echo "no dated backups to rotate."; exit 0; }

# Decide which dates to delete. Input is sorted newest-first, so the first
# time a week/month/year key is seen it belongs to the newest backup in it.
to_delete=$(printf '%s\n' "$table" | awk -F'\t' \
  -v cutoff="$CUTOFF" -v wk="$WEEKLY_KEEP" -v mk="$MONTHLY_KEEP" -v yk="$YEARLY_KEEP" '
  {
    date=$1; week=$2; month=$3; year=$4
    keep=0
    if (date >= cutoff)                                    keep=1   # daily window
    if (!(week  in sw)) { sw[week]=1;   if (++nw <= wk)    keep=1 } # weekly
    if (!(month in sm)) { sm[month]=1;  if (++nm <= mk)    keep=1 } # monthly
    if (!(year  in sy)) { sy[year]=1;   if (++ny <= yk)    keep=1 } # yearly
    if (!keep) print date
  }')

kept=0; deleted=0
while IFS= read -r d; do
  [ -z "$d" ] && continue
  kept=$((kept + 1))
done <<< "$(printf '%s\n' "$table" | cut -f1)"

if [ -n "$to_delete" ]; then
  while IFS= read -r d; do
    [ -z "$d" ] && continue
    echo "- pruning $PREFIX-$d.zip"
    run rm -f "$BACKUP_DIR/$PREFIX-$d.zip"
    deleted=$((deleted + 1))
    kept=$((kept - 1))
  done <<< "$to_delete"
fi

echo "retention complete: $kept kept, $deleted pruned in $BACKUP_DIR"
