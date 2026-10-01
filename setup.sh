#!/usr/bin/env bash
# Setup otomatis konfigurasi Hyprland di komputer baru.
# Usage: ./setup.sh [check|deps|env]   (tanpa arg = setup lengkap)
#
# check  : cek paket/monitor/wallpaper yang kurang, tanpa mengubah apa pun
# deps   : install paket yang belum terpasang (Arch/EndeavourOS: pacman + AUR helper)
# env    : deteksi monitor -> patch config/env.lua (dipakai Lua + script bash)

set -euo pipefail
cd "$(dirname "$0")"

CORE_PKGS=(hyprland hyprpaper hyprpicker kitty thunar rofi mako grim slurp swappy \
  cliphist wl-clipboard jq gnome-keyring network-manager-applet blueman udiskie \
  brightnessctl playerctl wireplumber inotify-tools libnotify telegram-desktop \
  discord hyprpolkitagent)
AUR_PKGS=(zen-browser)
# Aplikasi yang dipakai config tapi bukan paket biasa / opsional
OPTIONAL=(noctalia qs)

msg()  { printf '\033[1;32m[setup]\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[setup]\033[0m %s\n' "$*"; }

# ---------- deps ----------

detect_pm() {
  if command -v pacman >/dev/null; then PM=pacman
  elif command -v apt  >/dev/null; then PM=apt
  elif command -v dnf  >/dev/null; then PM=dnf
  else PM=none; fi
}

missing_pkgs() {
  local pkg out=()
  for pkg in "${CORE_PKGS[@]}"; do
    pacman -Q "$pkg" >/dev/null 2>&1 || out+=("$pkg")
  done
  printf '%s\n' "${out[@]}"
}

aur_helper() {
  command -v paru >/dev/null && { echo paru; return; }
  command -v yay  >/dev/null && { echo yay;  return; }
  echo ""
}

do_deps() {
  detect_pm
  case "$PM" in
    pacman)
      mapfile -t MISSING < <(missing_pkgs)
      if [ "${#MISSING[@]}" -eq 0 ]; then
        msg "Semua paket inti sudah terpasang."
      else
        msg "Paket belum terpasang (${#MISSING[@]}): ${MISSING[*]}"
        msg "Install via pacman..."
        sudo pacman -S --needed "${MISSING[@]}"
      fi

      local aur_missing=() helper
      for pkg in "${AUR_PKGS[@]}"; do
        pacman -Q "$pkg" >/dev/null 2>&1 || aur_missing+=("$pkg")
      done
      if [ "${#aur_missing[@]}" -gt 0 ]; then
        helper=$(aur_helper)
        if [ -n "$helper" ]; then
          msg "Install AUR (${aur_missing[*]}) via $helper..."
          "$helper" -S --needed "${aur_missing[@]}"
        else
          warn "Paket AUR belum terpasang: ${aur_missing[*]} — install manual (paru/yay)."
        fi
      fi
      ;;
    apt|dnf)
      warn "Distro ini tidak pakai pacman. Install manual daftar ini (nama paket bisa beda): ${CORE_PKGS[*]}"
      ;;
    none)
      warn "Package manager tidak dikenali. Install manual: ${CORE_PKGS[*]}"
      ;;
  esac

  for pkg in "${OPTIONAL[@]}"; do
    command -v "$pkg" >/dev/null 2>&1 || warn "Opsional '$pkg' tidak ada di sistem — hapus/ubah barisnya di config/autostart.lua kalau tak terpakai."
  done
}

# ---------- env ----------

detect_monitors() {
  MONITORS=()
  if command -v hyprctl >/dev/null && command -v jq >/dev/null && hyprctl monitors -j >/dev/null 2>&1; then
    mapfile -t MONITORS < <(hyprctl monitors -j | jq -r '.[].name')
  fi
}

ask_monitor() {
  local prompt="$1" default="$2" val
  read -r -p "$prompt [$default]: " val || true
  echo "${val:-$default}"
}

write_env() {
  # env.lua git-ignored; kalau belum ada, buat dari template
  [ -f config/env.lua ] || cp config/env.lua.example config/env.lua

  sed -i -E "s|(^[[:space:]]*mainMonitor[[:space:]]*=[[:space:]]*\")[^\"]*(\".*)|\1$MAIN\2|" config/env.lua
  sed -i -E "s|(^[[:space:]]*secondMonitor[[:space:]]*=[[:space:]]*\")[^\"]*(\".*)|\1$SECOND\2|" config/env.lua
  msg "config/env.lua disesuaikan."
}

do_env() {
  detect_monitors

  if [ "${#MONITORS[@]}" -ge 2 ]; then
    MAIN="${MONITORS[0]}"; SECOND="${MONITORS[1]}"
    msg "Monitor terdeteksi: ${MONITORS[*]}. Pakai main=$MAIN second=$SECOND."
  elif [ "${#MONITORS[@]}" -eq 1 ]; then
    MAIN="${MONITORS[0]}"; SECOND="${MONITORS[0]}"
    msg "Satu monitor terdeteksi: $MAIN."
  else
    warn "Monitor tidak terdeteksi (hyprctl belum jalan / belum install). Input manual:"
    MAIN=$(ask_monitor "Nama monitor utama" "eDP-1")
    SECOND=$(ask_monitor "Nama monitor kedua" "${MAIN}")
  fi

  write_env

  mkdir -p "$HOME/Pictures/Screenshots"  # target screenshot (hyprland.lua)
  msg "Direktori $HOME/Pictures/Screenshots siap."

  if [ ! -f "$HOME/Pictures/asci_art.png" ]; then
    warn "Wallpaper tidak ada: $HOME/Pictures/asci_art.png (config isi srcMainBackground di config/env.lua)."
  fi
}

# ---------- main ----------

case "${1:-setup}" in
  check)
    detect_pm
    if [ "$PM" = pacman ]; then
      mapfile -t MISSING < <(missing_pkgs)
      if [ "${#MISSING[@]}" -eq 0 ]; then msg "Semua paket inti terpasang."
      else msg "Paket kurang (${#MISSING[@]}): ${MISSING[*]}"; fi
    else
      warn "Bukan pacman ($PM) — cek manual: ${CORE_PKGS[*]}"
    fi

    detect_monitors
    if [ "${#MONITORS[@]}" -gt 0 ]; then msg "Monitor terdeteksi: ${MONITORS[*]}"
    else warn "Monitor tidak terdeteksi (jalankan 'make env' saat Hyprland sudah jalan, atau isi manual)."; fi

    [ -f "$HOME/Pictures/asci_art.png" ] || warn "Wallpaper kurang: $HOME/Pictures/asci_art.png"
    ;;
  deps) do_deps ;;
  env)  do_env ;;
  *) echo "Usage: $0 [check|deps|env]" >&2; exit 1 ;;
esac