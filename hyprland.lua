-- Port Lua dari hyprland.conf
-- Urutan require = urutan `source =` di hyprland.conf.

local env = require("config.env")

----------------------------
-- ENVIRONMENT VARIABLES  --
-- (bagian env = di hyprland.conf)
----------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("SSH_AUTH_SOCK", os.getenv("XDG_RUNTIME_DIR") .. "/gcr/ssh")
-- Force Wayland untuk berbagai aplikasi
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")

-- Variabel screenshot & notify
hl.env("HYPR_SCREENSHOT_TARGET", os.getenv("HOME") .. "/Pictures/Screenshots")
hl.env("HYPR_NOTIFY_SCRIPT", env.scrPath .. "/notify-send.sh")

-- Source config (mirror dari `source =` di hyprland.conf)
require("config.monitors")
require("config.autostart")
require("config.decoration")
require("config.keybindings")
require("config.windowrules")