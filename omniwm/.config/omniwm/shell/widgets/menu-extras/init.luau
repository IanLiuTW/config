local look = require("../lib/look")

function render(ctx: Context)
    local hidden = ctx.data.hiddenBar
    if not hidden or #hidden.items == 0 then
        return ui.row{}
    end
    local cell = hidden.cell
    local row = { gap = 0 }
    for _, item in ipairs(hidden.items) do
        local width = math.max(20, math.ceil(item.w))
        row[#row + 1] = ui.stack{ key = item.id, w = width, h = cell, help = item.name,
            onClick = "hidden-bar activate " .. item.id,
            ui.box{ w = width - 4, h = cell - 4, radius = look.radius(6), hover = look.hover },
            if item.image then ui.image{ image = item.image, w = item.w, h = item.h }
            else look.glyph{ name = "app.dashed", w = 16, h = 16, color = "secondaryForeground" } }
    end
    return ui.row(row)
end
