#!/bin/sh

TARGET="${HYPR_SCREENSHOT_TARGET:-$HOME/Gambar/Screenshots}"
NOTIFY_SCRIPT="${HYPR_NOTIFY_SCRIPT:-$HOME/.config/hypr/script/notify-send.sh}"

inotifywait -m -e close_write --format '%f' --include '\.(png|jpg|jpeg)$' "$TARGET" | while read FILENAME; do
  "$NOTIFY_SCRIPT" "$TARGET" "$FILENAME" &
done