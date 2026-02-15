# Konfigurasi Hyprland oleh KET

Repositori ini berisi kumpulan file konfigurasi pribadi saya untuk manajer jendela Hyprland. Konfigurasi ini dirancang untuk alur kerja yang efisien dan estetika yang terinspirasi dari tema Nord

## Struktur Direktori

Berikut adalah penjelasan singkat tentang struktur file dalam repositori ini:

```
.
├── hyprland.conf       # File konfigurasi utama Hyprland
├── hyprpaper.conf      # Konfigurasi untuk wallpaper
├── env.conf            # Variabel lingkungan tambahan
├── config/
│   ├── autostart.conf    # Aplikasi yang dijalankan saat startup
│   ├── decoration.conf   # Pengaturan visual (border, shadow, blur)
│   ├── keybindings.conf  # Semua pintasan keyboard (keybindings)
│   ├── monitors.conf     # Pengaturan untuk monitor (resolusi, posisi)
│   └── windowrules.conf  # Aturan spesifik untuk jendela aplikasi
└── script/
    ├── move-to-workspace.sh  # Script untuk memindahkan jendela ke workspace
    └── workspace-switcher.sh # Script untuk beralih antar workspace
```

## Fitur Utama

- **Dual Monitor Setup**: Dikonfigurasi untuk dua monitor (`HDMI-A-1` dan `DP-1`).
- **Smart Workspace Switching**: Pintasan keyboard untuk beralih dan memindahkan jendela (1-5) secara dinamis beradaptasi dengan monitor yang sedang aktif.
- **Estetika Nord**: Skema warna yang konsisten di seluruh antarmuka.
- **Aplikasi Startup**: Termasuk `waybar`, `hyprpaper`, `mako`, `nm-applet`, dan `blueman-applet`.
- **Pintasan Keyboard Intuitif**: Didefinisikan dalam `config/keybindings.conf` untuk akses cepat ke aplikasi dan fungsi jendela.

## Konfigurasi

### `hyprland.conf`

File ini adalah titik masuk utama. File ini mengatur variabel lingkungan, mendefinisikan program utama (terminal, file manager), dan memuat semua file konfigurasi lainnya dari direktori `config/` serta file `env.conf` untuk variabel lingkungan tambahan.

### `config/keybindings.conf`

Beberapa pintasan keyboard penting:

| Pintasan                | Aksi                               |
| ----------------------- | ---------------------------------- |
| `SUPER + Q`             | Buka Terminal (`kitty`)            |
| `SUPER + C`             | Tutup jendela aktif                |
| `SUPER + E`             | Buka File Manager (`thunar`)       |
| `SUPER + D`             | Buka Browser (`firefox`)           |
| `SUPER + R`             | Buka App Launcher (`rofi`)         |
| `SUPER + M`             | Buka Power Menu                    |
| `SUPER + V`             | Tampilkan riwayat clipboard        |
| `SUPER + Print`         | Ambil screenshot area tertentu     |
| `SUPER + [1-5]`         | Beralih ke workspace 1-5 (dinamis) |
| `SUPER + SHIFT + [1-5]` | Pindahkan jendela ke workspace 1-5 |
| `SUPER + panah`         | Pindah fokus jendela               |
| `SUPER + SHIFT + panah` | Pindahkan jendela                  |
| `SUPER + CTRL + panah`  | Ubah ukuran jendela                |

### `script/`

- **`workspace-switcher.sh`**: Script cerdas yang memungkinkan Anda menggunakan `SUPER + 1` untuk beralih ke workspace 1 jika fokus pada monitor utama, atau ke workspace 6 jika fokus pada monitor kedua.
- **`move-to-workspace.sh`**: Mirip dengan di atas, tetapi untuk memindahkan jendela aktif ke workspace yang sesuai di monitor yang relevan.

## Instalasi

1.  **Backup Konfigurasi Anda**:

    ```bash
    mv ~/.config/hypr ~/.config/hypr.bak
    ```

2.  **Clone Repositori**:

    ```bash
    git clone https://github.com/KET-workspace/hyperland-config.git ~/.config/hypr
    ```

3.  **Instal Dependensi**:
    Pastikan semua aplikasi yang tercantum di bawah ini terinstal di sistem Anda.

4.  **Sesuaikan Konfigurasi**:
    - Ubah nama monitor di `config/monitors.conf` dan `hyprpaper.conf` agar sesuai dengan setup Anda.
    - Ubah path wallpaper di `hyprpaper.conf`.
    - Sesuaikan aplikasi di `config/autostart.conf` dan `hyprland.conf` sesuai kebutuhan.

## Dependensi

- `hyprland`
- `hyprpaper`
- `waybar`
- `rofi`
- `kitty` (atau terminal pilihan Anda)
- `thunar` (atau file manager pilihan Anda)
- `mako` (notifikasi)
- `grim` & `slurp` (screenshot)
- `wl-clipboard` & `cliphist` (manajemen clipboard)
- `jq` (dibutuhkan oleh script)
- `gnome-keyring`
- `nm-applet` (network manager applet)
- `blueman` (bluetooth manager)
- `spotify-launcher`

---

Dibuat dengan ❤️ oleh KET.
