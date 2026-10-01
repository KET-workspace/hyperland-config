local env = require("config.env")

-- config/windowrules.conf — workspace assignment
for i = 1, 5 do
    hl.workspace_rule({ workspace = tostring(i), monitor = env.mainMonitor })
end
for i = 6, 10 do
    hl.workspace_rule({ workspace = tostring(i), monitor = env.secondMonitor })
end

-- Focus Monitor
hl.bind(env.mainMod .. " + comma",  hl.dsp.focus({ monitor = "l" }))
hl.bind(env.mainMod .. " + period", hl.dsp.focus({ monitor = "r" }))