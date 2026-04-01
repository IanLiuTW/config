-- Reverse scroll direction for external mouse only (trackpad unchanged)
hs.eventtap
    .new({ hs.eventtap.event.types.scrollWheel }, function(event)
        local isTrackpad = event:getProperty(hs.eventtap.event.properties.scrollWheelEventIsContinuous)
        if isTrackpad == 1 then
            return false
        end

        event:setProperty(
            hs.eventtap.event.properties.scrollWheelEventDeltaAxis1,
            -event:getProperty(hs.eventtap.event.properties.scrollWheelEventDeltaAxis1)
        )
        return false
    end)
    :start()
