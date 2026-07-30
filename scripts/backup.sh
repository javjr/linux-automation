#!/bin/bash

TARGET="$HOME/Desktop/linux-automation"
DEST="$HOME/backup"
mkdir -p "$DEST"
TIME=$(date +"%Y%m%d_%H%M%S")
FILENAME="backup_$TIME.tar.gz"

tar -czvf "$DEST/$FILENAME" "$TARGET"

echo "Backup Selesai! Backup Tersimpan di : $DEST/$FILENAME"

