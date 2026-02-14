#!/bin/bash
# Smart Move to Workspace untuk Hyprland
# Script ini akan move window ke workspace yang berbeda tergantung monitor yang aktif
#
# Usage: ./move-to-workspace.sh <workspace_number>
# Workspace number: 1-5
#
# Ketika fokus di HDMI-A-1: akan move ke workspace 1-5
# Ketika fokus di DP-1: akan move ke workspace 6-10

WORKSPACE_NUM=$1

# Validasi input
if [ -z "$WORKSPACE_NUM" ] || [ "$WORKSPACE_NUM" -lt 1 ] || [ "$WORKSPACE_NUM" -gt 5 ]; then
    echo "Error: Workspace number harus antara 1-5"
    exit 1
fi

# Dapatkan monitor yang sedang aktif
ACTIVE_MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')

# Tentukan workspace ID berdasarkan monitor aktif
if [ "$ACTIVE_MONITOR" = "HDMI-A-1" ]; then
    # Monitor utama: workspace 1-5
    TARGET_WORKSPACE=$WORKSPACE_NUM
elif [ "$ACTIVE_MONITOR" = "DP-1" ]; then
    # Monitor kedua: workspace 6-10 (offset +5)
    TARGET_WORKSPACE=$((WORKSPACE_NUM + 5))
else
    # Fallback ke workspace asli jika monitor tidak dikenal
    TARGET_WORKSPACE=$WORKSPACE_NUM
fi

# Move window ke workspace yang ditentukan
hyprctl dispatch movetoworkspace $TARGET_WORKSPACE