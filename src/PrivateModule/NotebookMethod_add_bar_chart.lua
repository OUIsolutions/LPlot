
PrivateModule.Notebook_add_bar_chart = function(selfobj, data, options)
    if not data or type(data) ~= "table" then
        return selfobj
    end

    options = options or {}
    local display    = options.display    or "vertical"
    local colors     = options.colors     or {}
    local size       = options.size       or {}
    local width      = size.width         or 600
    local height     = size.height        or 400
    local title      = options.title      or ""
    local subtitle   = options.subtitle   or ""
    local ordenation = options.ordenation

    -- build key list respecting ordenation if provided
    local keys = {}
    if ordenation then
        local seen = {}
        for _, k in ipairs(ordenation) do
            if data[k] ~= nil then
                table.insert(keys, k)
                seen[k] = true
            end
        end
        -- append remaining keys (alphabetically) that were not listed
        local extra = {}
        for k in pairs(data) do
            if not seen[k] then table.insert(extra, k) end
        end
        table.sort(extra)
        for _, k in ipairs(extra) do table.insert(keys, k) end
    else
        for k in pairs(data) do table.insert(keys, k) end
        table.sort(keys)
    end

    local values = {}
    for _, k in ipairs(keys) do
        table.insert(values, data[k])
    end

    local max_val = 0
    for _, v in ipairs(values) do
        if v > max_val then max_val = v end
    end
    if max_val == 0 then max_val = 1 end

    local NUM_PALETTE = 8  -- matches .lplot-color-1 … .lplot-color-8 in default.css

    local n = #keys

    -- longest key length (used for dynamic margins)
    local max_key_len = 0
    for _, k in ipairs(keys) do
        if #k > max_key_len then max_key_len = #k end
    end
    local char_w = 6.5  -- approximate pixel width per char at font-size 11

    -- title / subtitle vertical space
    local title_space = 0
    if title    ~= "" then title_space = title_space + 30 end
    if subtitle ~= "" then title_space = title_space + 22 end

    -- dynamic margins
    local left_margin, bottom_margin
    if display == "vertical" then
        -- rotated labels at -35°: vertical component ≈ len * char_w * sin(35°)
        local rot_h = math.ceil(max_key_len * char_w * 0.574) + 20
        bottom_margin = math.max(60, rot_h)
        left_margin   = 65
    else
        -- horizontal: key labels sit to the left of the y-axis
        left_margin   = math.max(65, math.ceil(max_key_len * char_w) + 14)
        bottom_margin = 40
    end

    local margin = { top = 10 + title_space, right = 30, bottom = bottom_margin, left = left_margin }
    local cw = width  - margin.left - margin.right   -- chart width
    local ch = height - margin.top  - margin.bottom  -- chart height

    local p = {}   -- svg parts
    p[#p+1] = string.format('<svg width="%d" height="%d" xmlns="http://www.w3.org/2000/svg">', width, height)

    -- titles
    local ty = 24
    if title ~= "" then
        p[#p+1] = string.format(
            '<text x="%g" y="%d" text-anchor="middle" font-family="sans-serif" font-size="18" font-weight="bold" fill="#333">%s</text>',
            width / 2, ty, title)
        ty = ty + 22
    end
    if subtitle ~= "" then
        p[#p+1] = string.format(
            '<text x="%g" y="%d" text-anchor="middle" font-family="sans-serif" font-size="13" fill="#666">%s</text>',
            width / 2, ty, subtitle)
    end

    p[#p+1] = string.format('<g transform="translate(%d,%d)">', margin.left, margin.top)

    -- returns the fill attribute string: inline color if user supplied one,
    -- otherwise a CSS class from default.css (.lplot-color-N)
    local function bar_fill(key, index)
        local user_color = colors[key]
        if user_color then
            return string.format('fill="%s"', user_color)
        end
        return string.format('class="lplot-color-%d"', ((index - 1) % NUM_PALETTE) + 1)
    end

    local NUM_GRID = 5

    if display == "vertical" then
        -- gridlines + y-axis labels
        for i = 0, NUM_GRID do
            local gy  = ch - (i / NUM_GRID) * ch
            local gval = math.floor((i / NUM_GRID) * max_val)
            p[#p+1] = string.format('<line x1="0" y1="%g" x2="%d" y2="%g" stroke="#e0e0e0" stroke-width="1"/>', gy, cw, gy)
            p[#p+1] = string.format(
                '<text x="-8" y="%g" text-anchor="end" dominant-baseline="middle" font-family="sans-serif" font-size="11" fill="#666">%d</text>',
                gy, gval)
        end

        local slot  = cw / n
        local bar_w = slot * 0.65

        for i, key in ipairs(keys) do
            local val   = values[i]
            local bar_h = (val / max_val) * ch
            local bx    = (i - 1) * slot + (slot - bar_w) / 2
            local by    = ch - bar_h

            p[#p+1] = string.format(
                '<rect x="%g" y="%g" width="%g" height="%g" %s rx="3"/>',
                bx, by, bar_w, bar_h, bar_fill(key, i))
            -- value label above bar
            p[#p+1] = string.format(
                '<text x="%g" y="%g" text-anchor="middle" font-family="sans-serif" font-size="11" fill="#333">%s</text>',
                bx + bar_w / 2, by - 5, tostring(val))
            -- x-axis label rotated so long names don't overlap
            local lx = bx + bar_w / 2
            local ly = ch + 18
            p[#p+1] = string.format(
                '<text x="%g" y="%g" text-anchor="end" font-family="sans-serif" font-size="11" fill="#555" transform="rotate(-35,%g,%g)">%s</text>',
                lx, ly, lx, ly, key)
        end

        -- axes
        p[#p+1] = string.format('<line x1="0" y1="0" x2="0" y2="%d" stroke="#333" stroke-width="1.5"/>', ch)
        p[#p+1] = string.format('<line x1="0" y1="%d" x2="%d" y2="%d" stroke="#333" stroke-width="1.5"/>', ch, cw, ch)

    else -- horizontal
        -- gridlines + x-axis labels
        for i = 0, NUM_GRID do
            local gx   = (i / NUM_GRID) * cw
            local gval = math.floor((i / NUM_GRID) * max_val)
            p[#p+1] = string.format('<line x1="%g" y1="0" x2="%g" y2="%d" stroke="#e0e0e0" stroke-width="1"/>', gx, gx, ch)
            p[#p+1] = string.format(
                '<text x="%g" y="%d" text-anchor="middle" font-family="sans-serif" font-size="11" fill="#666">%d</text>',
                gx, ch + 16, gval)
        end

        local slot  = ch / n
        local bar_h = slot * 0.65

        for i, key in ipairs(keys) do
            local val   = values[i]
            local bar_w = (val / max_val) * cw
            local by    = (i - 1) * slot + (slot - bar_h) / 2

            p[#p+1] = string.format(
                '<rect x="0" y="%g" width="%g" height="%g" %s rx="3"/>',
                by, bar_w, bar_h, bar_fill(key, i))
            -- value label at end of bar
            p[#p+1] = string.format(
                '<text x="%g" y="%g" dominant-baseline="middle" font-family="sans-serif" font-size="11" fill="#333">%s</text>',
                bar_w + 5, by + bar_h / 2, tostring(val))
            -- y-axis label (right-aligned against the axis)
            p[#p+1] = string.format(
                '<text x="-8" y="%g" text-anchor="end" dominant-baseline="middle" font-family="sans-serif" font-size="11" fill="#555">%s</text>',
                by + bar_h / 2, key)
        end

        -- axes
        p[#p+1] = string.format('<line x1="0" y1="0" x2="0" y2="%d" stroke="#333" stroke-width="1.5"/>', ch)
        p[#p+1] = string.format('<line x1="0" y1="%d" x2="%d" y2="%d" stroke="#333" stroke-width="1.5"/>', ch, cw, ch)
    end

    p[#p+1] = '</g>'
    p[#p+1] = '</svg>'

    table.insert(selfobj.content, table.concat(p, "\n"))
    return selfobj
end
