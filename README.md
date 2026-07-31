## Linux Automation: Backup & Restore Scripts

---

## Features & Workflow

This repository contains two main shell scripts located in `scripts/`:

1. **`backup.sh`**
   * Compresses target directories into a `.tar.gz` archive.
   * Automatically generates a `.sha256` checksum file to log the integrity hash of the backup.
   * Stores the generated files inside `~/backup`.

2. **`restore.sh`**
   * Ask the user for the target backup file name.
   * **Integrity Check:** Verifies the SHA-256 checksum before extracting any files.
   * If the hash matches (`OK`), it extracts the archive to `~/restored`.
   * If the hash fails or the file is corrupted/missing, it triggers a safety exit and cancels the extraction.

---

## Repository Structure

```text
linux-automation/
├── scripts/
│   ├── backup.sh
│   └── restore.sh
├── .gitignore
└── README.md
```

## Linux Concepts Practiced

Building this project helped reinforce key Linux administration concepts:

* **File Hierarchy Standard (FHS):** Separating script execution paths from storage (`~/backup`) and extraction targets (`~/restored`).
* **File Permissions (`chmod`):** Granting executable permissions (`chmod +x`) to shell scripts.
* **Stream & Redirection:** Redirecting standard output and errors (`> /dev/null 2>&1`).
* **Exit Statuses (`$?`):** Leveraging command return codes (`0` for success) to direct `if-else` logic flow.
* **Integrity Verification:** Using `sha256sum -c` to validate file authenticity prior to restorative actions.
* **Task Scheduling (`crontab`):** Automating periodic execution in the background.

---

## How to Use

 - Set Executable Permissions
Grant execution rights to the scripts:
```bash
chmod +x scripts/backup.sh scripts/restore.sh
```
 - Run the backup script manually:
```bash
./scripts/backup.sh
```
 - Run the restore script:
```bash
./scripts/restore.sh
```
 - Automation backup:
   to automate the backup process daily at midnight (00:00), configure using `crontab -e`:

```bash
crontab -e
```
   you can edit by using nano (recommended)
   then, add this in the bottom of your crontab:
```bash
0 0 * * * * /home/kingjav/Desktop/linux-automation/scripts/backup.sh
```
   cntrl o > enter > cntrl x
