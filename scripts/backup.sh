#!/bin/bash

TARGET="$HOME/Desktop/linux-automation"
DEST="$HOME/backup"
mkdir -p "$DEST"
TIME=$(date +"%Y%m%d_%H%M%S")
FILENAME="backup_$TIME.tar.gz"

tar -czvf "$DEST/$FILENAME" "$TARGET" > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "[SUCCESS] Backup Selesai! Backup Tersimpan di : $DEST/$FILENAME"
    sha256sum "$DEST/$FILENAME" > "$DEST/$FILENAME.sha256"
    echo "[SECURITY] SHA-256 Checksum dibuat: $FILENAME.sha256"
else
    echo "[ERROR] Backup Gagal! Periksa Ruang Penyimpanan atau Izin Direktori"
    exit 1
fi
