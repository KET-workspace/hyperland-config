#!/bin/bash

# Pindah ke workspace 6
hyprctl dispatch workspace 6

# Tunggu sebentar
sleep 0.5

# Jalankan aplikasi
kitty --class htop -e htop &
sleep 0.3
kitty &