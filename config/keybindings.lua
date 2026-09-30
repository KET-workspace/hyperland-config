local env = require("config.env")

local mainMod = env.mainMod
local scrPath = env.scrPath

-- config/keybindings.conf — input block
hl.config({
    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- device block
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

-- MAIN BINDS — System & Apps
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(env.terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(env.powermenuTheme))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(env.fileManager))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(env.browser))
-- NOTE: di .conf ada DUA bind di `$mainMod R` (launcher + masuk submap).
-- Dipertahankan urutannya; bind kedua men-shadow bind pertama, sama seperti .conf.
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(env.menu .. " -show drun -theme " .. env.menuTheme))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("kitty nmtui"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("blueman-manager"))

-- Utilities
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu -theme " .. env.cliphistTheme .. " | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle", mode = "maximized" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
-- J (togglesplit) dikomentari di .conf — sengaja dihilangkan

-- Screenshots
hl.bind("Print",              hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | swappy -f -"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("grim -g \"$(slurp -d)\" - | wl-copy"))

-- Focus Movement
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }))

-- Move Window
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "d" }))

-- Resize Window (binde = repeating)
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.resize({ x = -50, y = 0,  relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 50,  y = 0,  relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.resize({ x = 0,   y = -50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.resize({ x = 0,   y = 50,  relative = true }), { repeating = true })

-- Workspace Switching (native & script)
hl.bind("SUPER + ALT + left",  hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + ALT + right", hl.dsp.focus({ workspace = "e+1" }))

for i = 1, 5 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.exec_cmd(scrPath .. "/workspace-switcher.sh " .. i))
end

-- Move Window to Workspace
hl.bind("SUPER + ALT + SHIFT + left",  hl.dsp.window.move({ workspace = "e-1" }))
hl.bind("SUPER + ALT + SHIFT + right", hl.dsp.window.move({ workspace = "e+1" }))

for i = 1, 5 do
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.exec_cmd(scrPath .. "/move-to-workspace.sh " .. i))
end

-- Scroll Workspace
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Mouse Drag (bindm)
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Special Workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Multimedia Keys (bindel = repeating+locked; bindl = locked)
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),       { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),            { repeating = true, locked = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),           { locked = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),         { locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                        { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                        { locked = true, repeating = true })
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"),                                      { locked = true })
hl.bind("XF86AudioPause",        hl.dsp.exec_cmd("playerctl play-pause"),                                { locked = true })
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"),                                { locked = true })
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"),                                  { locked = true })

-- RESIZE SUBMAP
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
    hl.bind("right",  hl.dsp.window.resize({ x = 10,  y = 0,   relative = true }), { repeating = true })
    hl.bind("left",   hl.dsp.window.resize({ x = -10, y = 0,   relative = true }), { repeating = true })
    hl.bind("up",     hl.dsp.window.resize({ x = 0,   y = -10, relative = true }), { repeating = true })
    hl.bind("down",   hl.dsp.window.resize({ x = 0,   y = 10,  relative = true }), { repeating = true })

    -- Keluar submap
    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind("return", hl.dsp.submap("reset"))
end)