-- Message port for the `hs` CLI: hs -c 'hs.reload()'
require("hs.ipc")

-- Machine-specific values (gitignored): local.lua returns a table,
-- e.g. return { workProjectDir = os.getenv("HOME") .. "/work/..." }
local ok, LOCAL = pcall(dofile, hs.configdir .. "/local.lua")
if not ok or type(LOCAL) ~= "table" then LOCAL = {} end

-- Work-hours tracker: elapsed vs logged time, top-right of the focused screen.
-- Runs every `interval` from `startTime` to `endTime` inclusive, weekdays only.
local WORK = {
    startTime  = "08:00",   -- first run of the day
    endTime    = "18:00",   -- last run of the day, inclusive
    interval   = "30m",     -- time between runs
    dailyLimit = "8h",      -- expected working time per day
    display    = 3,         -- seconds the panel stays visible
    projectDir = LOCAL.workProjectDir,  -- repo whose `make time` reports logged hours
}

local START, STOP = hs.timer.seconds(WORK.startTime), hs.timer.seconds(WORK.endTime)
local LIMIT = hs.timer.seconds(WORK.dailyLimit)
local PAD, MARGIN_Y, ANCHOR_RIGHT = 14, 12, 103
local BRIGHT, MUTED = { white = 1 }, { white = 0.72 }
local GOOD, BAD = { hex = "#4ade80" }, { hex = "#f87171" }

-- Four stacked centred lines; panel height falls out of the font sizes
workCanvas = hs.canvas.new({ x = 0, y = 0, w = 200, h = 0 })
workCanvas[1] = { type = "rectangle", action = "fill",
                  roundedRectRadii = { xRadius = 8, yRadius = 8 },
                  fillColor = { hex = "#1f2940", alpha = 0.92 } }
local HEIGHT = PAD
for i, size in ipairs({ 18, 13, 13, 18 }) do
    workCanvas[i + 1] = { type = "text", text = "", textSize = size, textAlignment = "center",
                          frame = { x = PAD, y = HEIGHT, w = 172, h = size + 8 } }
    HEIGHT = HEIGHT + size + 8
end
HEIGHT = HEIGHT + PAD
workCanvas:level(hs.canvas.windowLevels.overlay)
workCanvas:behavior(hs.canvas.windowBehaviors.canJoinAllSpaces)

local function fmt(secs)
    return string.format("%dh %02dm", math.floor(secs / 3600), math.floor(secs % 3600 / 60))
end

-- Size to the widest line, then hang off a fixed centre near the top-right
local function show(lines)
    local widest = 0
    for i, l in ipairs(lines) do
        workCanvas[i + 1].text = l[1]
        workCanvas[i + 1].textColor = l[2]
        widest = math.max(widest, workCanvas:minimumTextSize(i + 1, l[1]).w)
    end
    local w = math.ceil(widest) + PAD * 2
    for i = 1, #lines do
        local f = workCanvas[i + 1].frame
        workCanvas[i + 1].frame = { x = PAD, y = f.y, w = w - PAD * 2, h = f.h }
    end
    -- x off the physical edge (the Dock column is empty up here), y below the menubar
    local scr = hs.screen.mainScreen()
    local full, vis = scr:fullFrame(), scr:frame()
    workCanvas:frame({ x = full.x + full.w - ANCHOR_RIGHT - w / 2,
                       y = vis.y + MARGIN_Y, w = w, h = HEIGHT })
    workCanvas:show()
    if workHide then workHide:stop() end
    workHide = hs.timer.doAfter(WORK.display, function() workCanvas:hide() end)
end

local function tick()
    local t = os.date("*t")
    local now = t.hour * 3600 + t.min * 60
    if t.wday == 1 or t.wday == 7 or now < START or now > STOP then
        workCanvas:hide()
        return
    end
    local today = os.date("%Y-%m-%d")
    workTask = hs.task.new("/usr/bin/make", function(rc, out, err)
        local stamp = os.date("%Y-%m-%d  %H:%M")
        if rc ~= 0 then
            show({ { stamp, BRIGHT },
                   { "make failed (rc=" .. rc .. ")", BAD },
                   { (err or ""):gsub("%s+$", ""):sub(1, 24), MUTED },
                   { "", MUTED } })
            return
        end
        local logged = 0
        for line in out:gmatch("[^\n]+") do
            if line:find("DAY AGGREGATION", 1, true) and line:find(today, 1, true) then
                local h, m = line:match("(%d+)h%s+(%d+)m")
                if h then logged = tonumber(h) * 3600 + tonumber(m) * 60 end
            end
        end
        local worked = math.min(math.max(now - START, 0), LIMIT)
        local diff = logged - worked
        show({ { stamp, BRIGHT },
               { "Worked hours: " .. fmt(worked), MUTED },
               { "Logged hours: " .. fmt(logged), MUTED },
               { string.format("Diff: %s%s", diff >= 0 and "+" or "-", fmt(math.abs(diff))),
                 diff >= 0 and GOOD or BAD } })
    end, { "-C", WORK.projectDir, "time" })
    workTask:start()
end

-- Anchored at startTime, so ticks land on the clock grid and endTime is hit exactly
if WORK.projectDir then
    workTimer = hs.timer.doAt(WORK.startTime, WORK.interval, tick)
    tick()
else
    hs.alert.show("Work-hours tracker off: set workProjectDir in ~/.hammerspoon/local.lua")
end
