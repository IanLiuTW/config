-- SPDX-License-Identifier: GPL-2.0-only
-- Copyright (C) 2026 OmniNull — https://github.com/OmniNull/OmniWM

local look = require("../lib/look")
local media = require("../lib/media")

function render(ctx)
    local m = media.state(ctx)
    if not m then
        return ui.box{ w = 0, h = 0 }
    end
    local behaviour = { onClick = ui.popout, onRightClick = m.toggle, help = m.help }
    local button = look.mediaBar and look.mediaBar(ctx, m)
    if not button then
        local scale = look.scale(ctx)
        local props = table.clone(behaviour)
        props[1] = look.glyph{ name = m.symbol, size = 14 * scale }
        if not ctx.data.bar.style.vertical then
            -- Artist above title, each truncated on its own line
            local width = 240 * scale
            if m.artist and m.artist ~= "" then
                local size = 11
                props[2] = ui.column{ center = false,
                    look.text{ text = m.artist, size = size, maxWidth = width, lines = 1 },
                    look.text{ text = m.title, size = size, maxWidth = width, lines = 1 } }
            else
                props[2] = look.text{ text = m.title, size = math.round(13 * scale), maxWidth = width, lines = 1 }
            end
        end
        button = look.bar(ctx, props)
    end
    for key, value in behaviour do
        button[key] = value
    end
    return button
end

function popout(ctx)
    local m = media.model(ctx)
    return look.mediaPanel and look.mediaPanel(ctx, m)
        or look.panel(ctx, { w = look.width + 28, look.heading(omniwm.l10n("Media")), media.content(ctx, false, nil, m) })
end
