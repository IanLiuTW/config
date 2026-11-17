-- Items keep a fixed 0.93 scale, so a bar height override on one monitor does not resize them.
-- All bar text uses the heavy system font weight.
local function text(props)
    if props.color == nil and props.role == "secondary" then
        props.color = "secondaryForeground"
    end
    props.role = nil
    props.weight = "heavy"
    return ui.text(props)
end

return require("./skin")({ capsules = true, scale = function() return 0.93 end, text = text })
