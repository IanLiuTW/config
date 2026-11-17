local look = require("../lib/look")

-- Items whose name contains an `order` entry (shell.toml widgets.menu-extras, case-insensitive)
-- come first in that order; the rest keep macOS order.
local function rankOf(name: string, order: { string }): number
    local lower = string.lower(name)
    for index, entry in ipairs(order) do
        if string.find(lower, string.lower(entry), 1, true) then
            return index
        end
    end
    return #order + 1
end

local function ordered(items: { HiddenBarItem }, order: { string }): { HiddenBarItem }
    local keyed = {}
    for index, item in ipairs(items) do
        keyed[index] = { item = item, rank = rankOf(item.name, order), index = index }
    end
    table.sort(keyed, function(a, b)
        return if a.rank ~= b.rank then a.rank < b.rank else a.index < b.index
    end)
    local result = {}
    for index, entry in ipairs(keyed) do
        result[index] = entry.item
    end
    return result
end

function render(ctx: Context)
    local hidden = ctx.data.hiddenBar
    if not hidden or #hidden.items == 0 then
        return ui.row{}
    end
    local cell = hidden.cell
    local row = { gap = 0 }
    for _, item in ipairs(ordered(hidden.items, (ctx.data.settings or {}).order or {})) do
        local width = math.max(20, math.ceil(item.w))
        row[#row + 1] = ui.stack{ key = item.id, w = width, h = cell, help = item.name,
            onClick = "hidden-bar activate " .. item.id,
            ui.box{ w = width - 4, h = cell - 4, radius = look.radius(6), hover = look.hover },
            if item.image then ui.image{ image = item.image, w = item.w, h = item.h }
            else look.glyph{ name = "app.dashed", w = 16, h = 16, color = "secondaryForeground" } }
    end
    return ui.row(row)
end
