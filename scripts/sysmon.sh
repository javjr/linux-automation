#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/config.env" ]; then
    source "$SCRIPT_DIR/config.env"
else
    echo "Error: File config.env is not Found"
    exit 1
fi

LOG_DIR="$HOME/logs"
LOG_FILE="$LOG_DIR/sys_hp.log"
TIMESTAMP=$(date +"%Y-%m-%d %H-%M-%S")

mkdir -p  "$LOG_DIR"

send_telegram() {
   local message="$1"
   curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
      -d "chat_id=${ID}" \
      -d "text=${message}" >/dev/null 2>&1
}

DISK_HOLD=80
RAM_HOLD=85

DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
RAM_USAGE=$(free -m | awk '/Mem:/ {printf "%d", $3/$2 * 100}') 

log_message() {
   echo "[$TIMESTAMP] $1" | tee -a "$LOG_FILE"
}

check_service() {
   local SERVICE_NAME="$1"
   if pgrep "$SERVICE_NAME" > /dev/null 2>&1; then
      log_message "[OK] Service '$SERVICE_NAME' aktif"
   else
      local msg="[CRITICAL] Service '$SERVICE_NAME' tidak aktif"
      log_message "$msg"
      send_telegram "$msg"
fi
}

log_message "=== SYSTEM HEALTH CHECK ==="
log_message "Disk Usage : $DISK_USAGE%"
log_message "RAM Usage : $RAM_USAGE%"

if [ "$DISK_USAGE" -gt "$DISK_HOLD" ]; then
    msg="[WARNING] Kapasitas Disk Kritis! Terpakai: $DISK_USAGE%"
    log_message "$msg"
    send_telegram "$msg"
else
    log_message "[OK] Kapasitas Disk Masih Aman"
fi


if [ "$RAM_USAGE" -gt "$RAM_HOLD" ]; then
    msg="[WARNING] Kapasitas RAM Kritis! Terpakai: $RAM_USAGE%"
    log_message "$msg"
    send_telegram "$msg"
else
    log_message "[OK] Kapasitas RAM Masih Aman"
fi

log_message "-----CHECKING SERVICE-----"
for service in cron ssh; do
    check_service "$service"
done
log_message "---------------------------"
