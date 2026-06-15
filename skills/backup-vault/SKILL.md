---
name: backup-vault
description: Create a dated zip backup of the Obsidian vault and rotate old backups on a grandfather-father-son schedule (14 daily, 5 weekly, 12 monthly, 5 yearly). Use when asked to back up the vault, make a snapshot, or run/prune vault backups.
---

# Vault backup & rotation

## Purpose

Keep a rolling set of zip snapshots of the vault in `~/Documents/obsidian/backups`,
pruned to a grandfather-father-son (GFS) retention schedule so the backup folder
stays bounded instead of growing forever.

The actual work is done by `backup.sh` (next to this file) — the logic is
deterministic, so run the script rather than reimplementing it by hand.

## Retention schedule

A backup is **kept** if any tier wants it; everything else is deleted.

| Tier    | Rule                                              |
| ------- | ------------------------------------------------- |
| Daily   | every backup from the last **14 days**            |
| Weekly  | newest backup of each of the **5** most recent ISO weeks |
| Monthly | newest backup of each of the **12** most recent months   |
| Yearly  | newest backup of each of the **5** most recent years     |

Tunable at the top of `backup.sh` (`DAILY_DAYS`, `WEEKLY_KEEP`, `MONTHLY_KEEP`, `YEARLY_KEEP`).

## What gets backed up

- The full vault at `~/Documents/obsidian/umwelt`, **including** `.obsidian`
  (themes, plugins, settings) so a restore reproduces the exact setup.
- Excluded: `.DS_Store`, `.Trash/`, and the backup directory itself.
- Archives are named `umwelt-YYYY-MM-DD.zip` and contain a top-level `umwelt/`
  folder, so restoring is just `unzip umwelt-<date>.zip`.

## Instructions

1. Run the script:
   ```sh
   bash ~/.claude/skills/backup-vault/backup.sh
   ```
   - Preview without changing anything: `bash .../backup.sh --dry-run`
   - Override paths if needed: `VAULT_DIR=... BACKUP_DIR=... bash .../backup.sh`
2. Report the summary line (how many backups were created / kept / pruned) and
   the resulting archive size.

The script is **idempotent per day**: at most one backup is created per calendar
date, so it's safe to run repeatedly. Running it both creates today's snapshot
**and** applies retention in one pass.

## Notes

- This is local only. To replicate offsite, `rsync` the `backups/` directory to
  the remote target after running the script, e.g.
  `rsync -a --delete ~/Documents/obsidian/backups/ <remote>:obsidian-backups/`.
  Because retention deletes files locally, use `--delete` so the remote mirrors
  the same pruned set.
- For unattended daily runs, schedule the script (launchd/cron, or the
  `/schedule` skill). Nothing in the script needs an interactive session.
