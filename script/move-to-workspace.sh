#!/bin/bash
# Smart Move to Workspace untuk Hyprland (Hardcoded Monitor)

ENV_FILE="$(dirname "$0")/../env.conf"

# Baca variabel monitor dari env.conf dengan format Hyprland
mainMonitor=$(grep '^\$mainMonitor=' "$ENV_FILE" | sed 's/^\$mainMonitor=//' | tr -d ' ')
secondMonitor=$(grep '^\$secondMonitor=' "$ENV_FILE" | sed 's/^\$secondMonitor=//' | tr -d ' ')

WORKSPACE_NUM=$1

# Validasi input (1-5)
if [ -z "$WORKSPACE_NUM" ] || [ "$WORKSPACE_NUM" -lt 1 ] || [ "$WORKSPACE_NUM" -gt 5 ]; then
    echo "Error: Workspace number harus antara 1-5"
    exit 1
fi

# Dapatkan nama monitor yang sedang aktif (difokuskan)
ACTIVE_MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')

# Logika penentuan workspace berdasarkan nama monitor
if [ "$ACTIVE_MONITOR" = "$mainMonitor" ]; then
    # Jika di monitor laptop: Workspace 1-5
    TARGET_WORKSPACE=$WORKSPACE_NUM
elif [ "$ACTIVE_MONITOR" = "$secondMonitor" ]; then
    # Jika di monitor eksternal: Workspace 6-10 (offset +5)
    TARGET_WORKSPACE=$((WORKSPACE_NUM + 5))
else
    # Fallback: Jika monitor tidak dikenal, gunakan angka asli
    TARGET_WORKSPACE=$WORKSPACE_NUM
fi

# Pindahkan window ke workspace tujuan tanpa mengubah fokus
hyprctl dispatch movetoworkspacesilent $TARGET_WORKSPACE

# Kemudian ikuti window dengan beralih ke workspace tersebut di monitor yang sama
hyprctl dispatch workspace $TARGET_WORKSPACE

# Pindahkan window ke workspace tujuan tanpa mengubah fokus
hyprctl dispatch movetoworkspacesilent $TARGET_WORKSPACE

# Kemudian ikuti window dengan beralih ke workspace tersebut di monitor yang sama
hyprctl dispatch workspace $TARGET_WORKSPACE