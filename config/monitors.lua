local env = require("config.env")

-- config/monitors.conf
hl.monitor({ output = env.mainMonitor,   mode = env.mainResolution,   position = env.mainPosition,   scale = env.mainScale })
hl.monitor({ output = env.secondMonitor, mode = env.secondResolution, position = env.secondPosition, scale = env.secondScale })
-- fallback untuk monitor lain (baris `monitor=,preferred,auto,1`)
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })