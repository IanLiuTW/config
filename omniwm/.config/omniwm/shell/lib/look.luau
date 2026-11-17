-- Bar fills the 38 pt notch strip; base 38 / 0.93 scales every item to 0.93 of its default size.
-- All bar text uses the heaviest system font weight.
local function text(props)
    if props.color == nil and props.role == "secondary" then
        props.color = "secondaryForeground"
    end
    props.role = nil
    props.weight = "black"
    return ui.text(props)
end

return require("./skin")({ capsules = true, base = 38 / 0.93, text = text })
