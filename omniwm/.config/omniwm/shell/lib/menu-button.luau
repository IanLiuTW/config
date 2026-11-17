-- SPDX-License-Identifier: GPL-2.0-only
-- Copyright (C) 2026 OmniNull — https://github.com/OmniNull/OmniWM
-- Copy of default/lib/menu-button.luau: original 24 pt icons, button only 4 pt wider than its icon,
-- 6 pt of space left of the Apple menu so it does not touch the screen edge.

local button = {}

function button.render(ctx: Context, props)
    local style = ctx.data.bar.style
    local h = math.max(16, style.height - 4)
    local icon = math.min(24, math.max(14, h - 8))
    local w = icon + 4
    local capsule = style.transparent and style.backgrounds
    local foreground = style.solidBlack and "#FFFFFF" or "foreground"
    local image = if props.symbol then ui.symbol{ name = props.symbol, size = icon, w = icon, h = icon, color = foreground }
        else ui.icon{ app = props.app, pid = props.pid, w = icon, h = icon, placeholder = "app.dashed" }
    local stack = ui.stack{ w = w, h = h, onClick = props.action, help = props.help,
        radius = if capsule then w / 2 else 4, hover = if style.solidBlack then "#FFFFFF1F" else "foreground/0.12",
        image }
    if props.action == "menu apple" then
        return ui.row{ gap = 0, ui.box{ w = 6, h = 1 }, stack }
    end
    return stack
end

return button
