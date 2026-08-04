# Linux Automation: Backup & Restore Scripts

---


A structured portfolio of Shell Scripts (Bash) designed for system administration, health monitoring, automated backups, and task scheduling in Linux environments.

## Project Overview

This repository contains modular automation scripts built to streamline routine System Administrator & DevOps tasks:

* **Module 1:** Automated Backup, Compression, Integrity Verification, and Restore Engine.
* **Module 2:** Real-Time System Health Monitoring, Threshold Alerting, Service Inspection, and Logging.

## Features & Workflow

### Module 1: Automated Backup & Integrity Engine
  * **Script:** `scripts/sys_backup.sh` & `scripts/sys_restore.sh`
  * **Key Features:**
  * Creates compressed `.tar.gz` archives of specified source directories.
  * Generates SHA-256 checksums to guarantee data integrity.
  * Automates verification during restore procedures.
  * Prevents accidental data corruption during system recovery.

### Module 2: System Health Monitoring & Alerting
  * **Script:** `scripts/sys_monitor.sh`
  * **Key Features:**
  * **Disk & RAM Monitoring:** Parses system metrics using `df`, `free`, `awk`, and `tr` pipelines.
  * **Threshold Alerts:** Issues `[WARNING]` logs whenever Disk usage exceeds 80% or RAM exceeds 85%.
  * **Service Health Check:** Verifies active states of critical background services (e.g., `cron`, `ssh`) using `pgrep`.
  * **Dual Logging (`tee -a`):** Outputs status directly to stdout while appending timestamped entries to `~/logs/sys_health.log`.

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
   you can edit by using nano (recommended).
   then, add this in the bottom of your crontab (automation backup everyday at 00:00):
```bash
0 0 * * * /home/$USER/Desktop/linux-automation/scripts/backup.sh
```
   and add this in the bottom of your crontab (for automation monitor & logs every hour):
```bash
0 * * * * /home/$USER/Desktop/linux-automation/scripts/sysmon.sh
```
   cntrl o > enter > cntrl x
