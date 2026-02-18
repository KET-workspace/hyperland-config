#!/bin/bash
# Smart Workspace Switcher untuk Hyprland (Hardcoded Monitor)

ENV_FILE="$(dirname "$0")/../env.conf"

# Baca variabel monitor dari env.conf dengan format Hyprland
mainMonitor=$(grep '^\$mainMonitor=' "$ENV_FILE" | sed 's/^\$mainMonitor=//' | tr -d ' ')
secondMonitor=$(grep '^\$secondMonitor=' "$ENV_FILE" | sed 's/^\$secondMonitor=//' | tr -d ' ')

WORKSPACE_NUM=$1

# Validasi input (hanya menerima angka 1-5)
if [ -z "$WORKSPACE_NUM" ] || [ "$WORKSPACE_NUM" -lt 1 ] || [ "$WORKSPACE_NUM" -gt 5 ]; then
    echo "Error: Workspace number harus antara 1-5"
    exit 1
fi

# Dapatkan nama monitor yang sedang aktif
ACTIVE_MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')

# Tentukan workspace tujuan berdasarkan monitor yang sedang difokuskan
if [ "$ACTIVE_MONITOR" = "$mainMonitor" ]; then
    # Jika fokus di monitor laptop: buka workspace 1-5
    TARGET_WORKSPACE=$WORKSPACE_NUM
elif [ "$ACTIVE_MONITOR" = "$secondMonitor" ]; then
    # Jika fokus di monitor eksternal: buka workspace 6-10
    TARGET_WORKSPACE=$((WORKSPACE_NUM + 5))
else
    # Fallback jika nama monitor tidak cocok
    TARGET_WORKSPACE=$WORKSPACE_NUM
fi

# Berpindah ke workspace yang ditentukan
hyprctl dispatch workspace $TARGET_WORKSPACE

# Berpindah ke workspace yang ditentukan
hyprctl dispatch workspace $TARGET_WORKSPACE