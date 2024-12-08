local spaces = require("hs.spaces") -- https://github.com/asmagill/hs._asm.spaces

-- [[Util functions - Window]]
local function getMainWindow(app)
    -- get main window from app
    local win = nil
    while win == nil do
        win = app:mainWindow()
    end
    return win
end
local function moveWindow(app, space, mainScreen)
    -- move to main space
    local win = getMainWindow(app)
    if win:isFullScreen() then
        hs.eventtap.keyStroke("fn", "f", 0, app)
    end
    local winFrame = win:frame()
    local scrFrame = mainScreen:fullFrame()
    winFrame.w = scrFrame.w
    winFrame.y = scrFrame.y
    winFrame.x = scrFrame.x
    win:setFrame(winFrame, 0)
    spaces.moveWindowToSpace(win, space)
    if win:isFullScreen() then
        hs.eventtap.keyStroke("fn", "f", 0, app)
    end
    win:focus()
end
local function bind_key_toggle_window(mod, key, bundle_id, window_pos)
    hs.hotkey.bind(mod, key, function() -- hotkey config
        local app = hs.application.get(bundle_id)
        if app ~= nil and app:isFrontmost() then
            app:hide()
        else
            local space = spaces.activeSpaceOnScreen()
            local mainScreen = hs.screen.mainScreen()
            if app == nil and hs.application.launchOrFocusByBundleID(bundle_id) then
                local appWatcher = nil
                appWatcher = hs.application.watcher.new(function(name, event, app)
                    if event == hs.application.watcher.launched and app:bundleID() == bundle_id then
                        getMainWindow(app):move(hs.geometry(window_pos))
                        app:hide()
                        moveWindow(app, space, mainScreen)
                        appWatcher:stop()
                    end
                end)
                appWatcher:start()
            end
            if app ~= nil then
                moveWindow(app, space, mainScreen)
            end
        end
    end)
end
local function bind_key_focus_window(mod, key, bundle_id)
    hs.hotkey.bind(mod, key, function() -- hotkey config
        local app = hs.application.get(bundle_id)
        hs.application.launchOrFocusByBundleID(bundle_id)
    end)
end

-- [[Bind keys for common apps]]
bind_key_toggle_window({ "control", "shift" }, "g", "net.kovidgoyal.kitty", { x = 0, y = 0, w = 1, h = 0.5 })
bind_key_focus_window({ "control", "shift" }, "b", "com.brave.Browser")
bind_key_focus_window({ "control", "shift" }, "c", "com.google.Chrome")
bind_key_focus_window({ "control", "shift" }, "s", "com.tinyspeck.slackmacgap")

-- local appBundleID = hs.application.get("Slack"):bundleID()
-- print(appBundleID)

-- [[Reverse Mouse Scroll]]
reverse_mouse_scroll = hs.eventtap
    .new({ hs.eventtap.event.types.scrollWheel }, function(event)
        -- detect if this is touchpad or mouse
        local isTrackpad = event:getProperty(hs.eventtap.event.properties.scrollWheelEventIsContinuous)
        if isTrackpad == 1 then
            return false -- trackpad: pass the event along
        end

        event:setProperty(
            hs.eventtap.event.properties.scrollWheelEventDeltaAxis1,
            -event:getProperty(hs.eventtap.event.properties.scrollWheelEventDeltaAxis1)
        )
        return false -- pass the event along
    end)
    :start()
