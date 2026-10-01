local env = require("config.env")

-- config/autostart.conf — semua exec-once, urutan sama
hl.on("hyprland.start", function()
    -- System services
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets,ssh")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("qs -c noctalia-shell")
    hl.exec_cmd("noctalia")
    hl.exec_cmd("Telegram -startintray")
    hl.exec_cmd("discord --start-minimized")

    -- Notifikasi saat screenshot
    hl.exec_cmd(env.scrPath .. "/screenshot-monitor.sh")

    -- Wallpaper & UI
    hl.exec_cmd("hyprpaper")
    -- Applets
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("nm-applet --indicator")

    -- Clipboard manager
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    hl.exec_cmd("udiskie")
end)