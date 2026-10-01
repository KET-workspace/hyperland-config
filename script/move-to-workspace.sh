#!/bin/bash
# Smart Move to Workspace untuk Hyprland (Hardcoded Monitor)

ENV_FILE="$(dirname "$0")/../config/env.lua"

# Baca monitor dari config/env.lua (format Lua)
mainMonitor=$(grep -E '^\s*mainMonitor\s*=' "$ENV_FILE" | sed -E 's/^.*=\s*"([^"]*)".*/\1/')
secondMonitor=$(grep -E '^\s*secondMonitor\s*=' "$ENV_FILE" | sed -E 's/^.*=\s*"([^"]*)".*/\1/')

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

# Pindahkan window ke workspace tujuan (sintaks Lua: hl.dsp.window.move)
hyprctl dispatch "hl.dsp.window.move({workspace=$TARGET_WORKSPACE})"