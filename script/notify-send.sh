#!/bin/sh

TARGET="${1:-${HYPR_SCREENSHOT_TARGET:-$HOME/Gambar/Screenshots}}"
FILENAME="$2"

if [ -z "$FILENAME" ]; then
  exit 0
fi

(
  AKSI=$(notify-send "Screenshot saved" "File: $FILENAME" \
    -a "Screenshot Manager" \
    -i camera-photo \
    --action="open=Buka Gambar" \
    --action="folder=Buka Folder" \
    --action="delete=Hapus" \
    --wait)

  case "$AKSI" in
    "open")
      xdg-open "$TARGET/$FILENAME"
      ;;
    "folder")
      xdg-open "$TARGET"
      ;;
    "delete")
      rm "$TARGET/$FILENAME"
      notify-send "Terhapus" "$FILENAME berhasil dihapus." -t 2000
      ;;
  esac
) &