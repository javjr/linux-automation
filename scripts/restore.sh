#!/bin/bash

PATH_TARGET="$HOME/backup"

read -p "Masukkan nama file backup yang ingin di restore: " NAMA_FILE


if [ ! -f "$PATH_TARGET/$NAMA_FILE" ]; then
    echo "[ERROR] Tidak ada file seperti itu"
    exit 1
fi
cd "$PATH_TARGET" || exit 1
sha256sum -c "$PATH_TARGET/$NAMA_FILE.sha256" > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "[SUCCESS] File Aman!"
    echo "Mulai mengekstrak file..."

    DEST_RESTORE="$HOME/restored"
    mkdir -p "$DEST_RESTORE"

    tar -xzvf "$PATH_TARGET/$NAMA_FILE" -C "$DEST_RESTORE"

    echo "[DONE] Data berhasil dikembalikan ke: $DEST_RESTORE"

else
    echo "[ERROR] Bahaya! File backup mungkin rusak"
    echo "Proses restore DIBATALKAN demi keamanan"
    exit 1
fi
