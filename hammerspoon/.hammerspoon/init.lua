-- Message port for the `hs` CLI: hs -c 'hs.reload()'
require("hs.ipc")

-- Deprecated: work-hours tracker, kept commented out. Remove the --[==[ and ]==] lines to restore it.
--[==[
-- Machine-specific values (gitignored): local.lua returns a table,
-- e.g. return { workProjectDir = os.getenv("HOME") .. "/work/..." }
local localPath = hs.configdir .. "/local.lua"
local LOCAL = hs.fs.attributes(localPath) and dofile(localPath) or {}

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
    -- Round to the nearest minute: hs.timer can fire up to 1 s early, and 07:59:59 is before START
    local clock = math.floor((os.time() + 30) / 60) * 60
    local t = os.date("*t", clock)
    local now = t.hour * 3600 + t.min * 60
    if t.wday == 1 or t.wday == 7 or now < START or now > STOP then
        workCanvas:hide()
        return
    end
    local today = os.date("%Y-%m-%d", clock)
    local stamp = os.date("%Y-%m-%d  %H:%M", clock)
    workTask = hs.task.new("/usr/bin/make", function(rc, out, err)
        if rc ~= 0 then
            -- Last stderr line that is not make's own "make: ***" summary
            local msg = ""
            for l in (err or ""):gmatch("[^\n]+") do
                if l:find("%S") and not l:find("^make: %*%*%*") then msg = l end
            end
            if msg == "" then msg = (err or ""):gsub("%s+$", "") end
            show({ { stamp, BRIGHT },
                   { "make failed (rc=" .. rc .. ")", BAD },
                   { msg:sub(1, 24), MUTED },
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

local INTERVAL = hs.timer.seconds(WORK.interval)

-- hs.timer counts time that stops during sleep, so a repeating timer drifts off
-- the clock grid overnight. Arm one shot per slot from the wall clock instead.
local function schedule(after)
    if workTimer then workTimer:stop() end
    local slot = after < START and START
        or START + (math.floor((after - START) / INTERVAL) + 1) * INTERVAL
    if slot > STOP then slot = START end  -- doAt rolls a past time to tomorrow
    workTimer = hs.timer.doAt(slot, function()
        tick()
        schedule(math.max(slot, hs.timer.localTime()))
    end)
end

if WORK.projectDir then
    schedule(hs.timer.localTime())
    workWake = hs.caffeinate.watcher.new(function(event)
        if event == hs.caffeinate.watcher.systemDidWake then schedule(hs.timer.localTime()) end
    end):start()
    tick()
else
    hs.alert.show("Work-hours tracker off: set workProjectDir in ~/.hammerspoon/local.lua")
end
]==]

-- Cmd+Ctrl+C: toggle keep-awake. Blocks display sleep, so the MDM idle lock never starts.
-- While on, a coffee badge stays in the top-left corner of the primary screen.
local CUP = 28
keepAwakeBadge = hs.canvas.new({ x = 0, y = 0, w = CUP + 8, h = CUP + 8 })
keepAwakeBadge[1] = { type = "text", text = "☕", textSize = CUP, textAlignment = "center" }
keepAwakeBadge:level(hs.canvas.windowLevels.screenSaver)
keepAwakeBadge:behavior({ "canJoinAllSpaces", "stationary", "fullScreenAuxiliary" })

local function placeBadge()
    local full = hs.screen.primaryScreen():fullFrame()
    keepAwakeBadge:topLeft({ x = full.x + 5, y = full.y - 1 })  -- cup covers the bar's Apple logo
end
keepAwakeScreens = hs.screen.watcher.new(placeBadge):start()

keepAwakeKey = hs.hotkey.bind({ "cmd", "ctrl" }, "c", function()
    local on = hs.caffeinate.toggle("displayIdle")
    if on then placeBadge(); keepAwakeBadge:show() else keepAwakeBadge:hide() end
    hs.alert.closeAll()
    hs.alert.show(on and "☕  ON" or "☕  OFF", { textSize = 40 }, 1.2)
end)

-- Time check: big 24 h clock at the top right of the focused screen, every quarter hour.
-- Fades in at the top right, holds, then drops down the right edge and fades out at the bottom.
local CLOCK = { size = 80, dateSize = 22, gap = 19, font = "CommitMonoNF-Bold", every = 15 * 60, pad = 23,
                fadeIn = 0.2, hold = 1.3, slide = 0.5, fadeOut = 0.25, fps = 120 }
clockCanvas = hs.canvas.new({ x = 0, y = 0, w = 0, h = 0 })
clockCanvas[1] = { type = "rectangle", action = "strokeAndFill",
                   roundedRectRadii = { xRadius = 10, yRadius = 10 },
                   fillColor = { hex = "#1f2940", alpha = 0.92 },
                   strokeColor = { white = 1 }, strokeWidth = 1 }
clockCanvas[2] = { type = "text", text = "", textSize = CLOCK.size, textColor = { white = 1 },
                   textAlignment = "center" }
clockCanvas[3] = { type = "text", text = "", textSize = CLOCK.dateSize, textColor = { white = 0.72 },
                   textAlignment = "center" }
clockCanvas:level(hs.canvas.windowLevels.overlay)
clockCanvas:behavior(hs.canvas.windowBehaviors.canJoinAllSpaces)

-- Run step(p) with p from 0 to 1 over `duration` seconds at CLOCK.fps, then done()
local function animate(duration, step, done)
    if clockAnim then clockAnim:stop() end
    local t0 = hs.timer.absoluteTime()
    clockAnim = hs.timer.doEvery(1 / CLOCK.fps, function()
        local p = math.min((hs.timer.absoluteTime() - t0) / 1e9 / duration, 1)
        step(p)
        if p >= 1 then
            clockAnim:stop()
            if done then done() end
        end
    end)
end

-- slot: seconds since midnight to show; nil shows the current minute. font: overrides CLOCK.font
function showClock(slot, font)
    slot = slot or math.floor((hs.timer.localTime() + 30) / 60) * 60
    font = font or CLOCK.font  -- nil = system font
    clockCanvas[2].text = string.format("%02d:%02d", slot // 3600 % 24, slot % 3600 // 60)
    clockCanvas[3].text = os.date("%Y.%m.%d %A"):upper()
    -- Pad around the glyphs, not the line box: the box has extra space above the cap height
    local function measure(i, textSize)
        clockCanvas[i].textFont = font
        local box = clockCanvas:minimumTextSize(i, clockCanvas[i].text)
        local info = hs.styledtext.fontInfo({ name = font or hs.styledtext.defaultFonts.system, size = textSize })
        return box, box.h + info.descender - info.capHeight, info.capHeight  -- descender is negative
    end
    local timeBox, timeTop, timeCap = measure(2, CLOCK.size)
    local dateBox, dateTop, dateCap = measure(3, CLOCK.dateSize)
    local w = math.ceil(math.max(timeBox.w, dateBox.w)) + CLOCK.pad * 2
    local timeY = CLOCK.pad + dateCap + CLOCK.gap  -- top of the digits
    local h = math.ceil(timeY + timeCap) + CLOCK.pad
    clockCanvas[1].frame = { x = 0.5, y = 0.5, w = w - 1, h = h - 1 }  -- keep the 1 pt border inside the canvas
    clockCanvas[3].frame = { x = 0, y = CLOCK.pad - dateTop, w = w, h = dateBox.h }
    clockCanvas[2].frame = { x = 0, y = timeY - timeTop, w = w, h = timeBox.h }
    -- Right edge, 10 pt in, from 4 pt under the 38 pt OmniShell bar to the bottom of the screen
    -- Top from the full frame: a notch screen keeps its 38 pt menu bar row out of frame() even with the bar hidden
    local screen = hs.screen.mainScreen()
    local vis = screen:frame()
    local x = vis.x + vis.w - w - 10
    local top, bottom = screen:fullFrame().y + 38 + 4, vis.y + vis.h - h - 12
    clockCanvas:frame({ x = x, y = top, w = w, h = h })
    clockCanvas:alpha(0)
    clockCanvas:show()
    if clockHold then clockHold:stop() end
    animate(CLOCK.fadeIn, function(p) clockCanvas:alpha(p) end)
    if clockPinned then return end
    clockHold = hs.timer.doAfter(CLOCK.fadeIn + CLOCK.hold, function()
        animate(CLOCK.slide, function(p)
            clockCanvas:topLeft({ x = x, y = top + (bottom - top) * p * p * p })  -- accelerate
            clockCanvas:alpha(math.min(1, (1 - p) / CLOCK.fadeOut))  -- fade over the last part
        end, function() clockCanvas:hide() end)
    end)
end

-- Debug: hs -c 'pinClock()' keeps the clock on screen; run it again to hide it
function pinClock(font)
    clockPinned = not clockPinned
    if clockPinned then showClock(nil, font) else clockCanvas:hide() end
end

-- One-shot timer per slot from the wall clock: a repeating hs.timer drifts across sleep.
local function armClock(after)
    if clockTimer then clockTimer:stop() end
    local slot = (math.floor(after / CLOCK.every) + 1) * CLOCK.every % 86400
    clockTimer = hs.timer.doAt(slot, function()  -- doAt rolls 00:00 to tomorrow
        showClock(slot)
        armClock(math.max(slot, hs.timer.localTime()))
    end)
end
armClock(hs.timer.localTime())
clockWake = hs.caffeinate.watcher.new(function(event)
    if event == hs.caffeinate.watcher.systemDidWake then armClock(hs.timer.localTime()) end
end):start()
