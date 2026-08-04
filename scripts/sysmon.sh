#!/bin/bash

LOG_DIR="$HOME/logs"
LOG_FILE="$LOG_DIR/sys_hp.log"
TIMESTAMP=$(date +"%Y-%m-%d %H-%M-%S")

mkdir -p  "$LOG_DIR"

DISK_HOLD=80
RAM_HOLD=85

DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
RAM_USAGE=$(free -m | awk '/Mem:/ {printf "%d", $3/$2 * 100}') 

log_message() {
   echo "[$TIMESTAMP] $1" | tee -a "$LOG_FILE"
}

check_service() {
   SERVICE_NAME=$1
   if pgrep "$SERVICE_NAME" > /dev/null 2>&1; then
      log_message "[OK] Service '$SERVICE_NAME' aktif"
   else
      log_message "[OK] Service '$SERVICE_NAME' tidak aktif"
fi
}

log_message "=== SYSTEM HEALTH CHECK ==="
log_message "Disk Usage : $DISK_USAGE%"
log_message "RAM Usage : $RAM_USAGE%"

if [ "$DISK_USAGE" -gt "$DISK_HOLD" ]; then
    log_message "[WARNING] Kapasitas Disk Kritis! Terpakai: $DISK_USAGE%"
else
    log_message "[OK] Kapasitas Disk Masih Aman"
fi


if [ "$RAM_USAGE" -gt "$RAM_HOLD" ]; then
    log_message "[WARNING] Kapasitas RAM Kritis! Terpakai: $RAM_USAGE%"
else
    log_message "[OK] Kapasitas RAM Masih Aman"
fi

log_message "-----CHECKING SERVICES-----"
check_service "cron"
check_service "ssh"

log_message "---------------------------"
