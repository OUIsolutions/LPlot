
PrivateModuleObject.Notebook___add_pie_chart = function(selfobj, data, options)
    if not data or type(data) ~= "table" then return selfobj end

    options = options or {}
    local size     = options.size     or {}
    local width    = size.width       or 500
    local height   = size.height      or 400
    local title    = options.title    or ""
    local subtitle = options.subtitle or ""
    local colors   = options.colors   or {}
    local donut    = options.donut    or false

    local PALETTE = {"#3498db","#e74c3c","#2ecc71","#f39c12","#9b59b6","#1abc9c","#e67e22","#34495e"}
    local NUM_PALETTE = #PALETTE

    local keys = {}
    for k in pairs(data) do table.insert(keys, k) end
    table.sort(keys)

    local total = 0
    for _, k in ipairs(keys) do total = total + (data[k] or 0) end
    if total == 0 then total = 1 end

    local title_h    = (title    ~= "" and 30 or 0)
    local subtitle_h = (subtitle ~= "" and 22 or 0)
    local legend_h   = 28   -- always show legend for pie
    local header_h   = title_h + subtitle_h

    -- Usable vertical space for the pie
    local pie_area_h = height - header_h - legend_h - 20
    local radius     = math.min(width * 0.42, pie_area_h / 2) - 5
    if radius < 10 then radius = 10 end
    local inner_r    = donut and (radius * 0.5) or 0

    local cx = width / 2
    local cy = header_h + 14 + pie_area_h / 2

    local p = {}
    p[#p+1] = string.format('<svg width="%d" height="%d" xmlns="http://www.w3.org/2000/svg">', width, height)

    -- Titles
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

    -- Slices
    local angle = -math.pi / 2
    for i, k in ipairs(keys) do
        local val   = data[k] or 0
        local sweep = (val / total) * 2 * math.pi
        local ea    = angle + sweep
        local large = (sweep > math.pi) and 1 or 0
        local color = colors[k] or PALETTE[((i - 1) % NUM_PALETTE) + 1]

        local x1 = cx + radius * math.cos(angle)
        local y1 = cy + radius * math.sin(angle)
        local x2 = cx + radius * math.cos(ea)
        local y2 = cy + radius * math.sin(ea)

        local path
        if inner_r > 0 then
            local ix1 = cx + inner_r * math.cos(ea)
            local iy1 = cy + inner_r * math.sin(ea)
            local ix2 = cx + inner_r * math.cos(angle)
            local iy2 = cy + inner_r * math.sin(angle)
            path = string.format(
                'M %g %g A %g %g 0 %d 1 %g %g L %g %g A %g %g 0 %d 0 %g %g Z',
                x1, y1, radius, radius, large, x2, y2,
                ix1, iy1, inner_r, inner_r, large, ix2, iy2)
        else
            path = string.format(
                'M %g %g A %g %g 0 %d 1 %g %g L %g %g Z',
                x1, y1, radius, radius, large, x2, y2, cx, cy)
        end

        p[#p+1] = string.format('<path d="%s" fill="%s" stroke="white" stroke-width="2"/>', path, color)

        -- Percentage label inside slice (only if slice is large enough)
        local pct = (val / total) * 100
        if pct >= 5 then
            local mid  = angle + sweep / 2
            local lr   = radius * 0.65 + inner_r * 0.35
            local lx   = cx + lr * math.cos(mid)
            local ly   = cy + lr * math.sin(mid)
            p[#p+1] = string.format(
                '<text x="%g" y="%g" text-anchor="middle" dominant-baseline="middle" font-family="sans-serif" font-size="12" fill="white" font-weight="bold">%.0f%%</text>',
                lx, ly, pct)
        end

        angle = ea
    end

    -- Legend at bottom
    local lx = 10
    local ly = height - 10
    for i, k in ipairs(keys) do
        local color = colors[k] or PALETTE[((i - 1) % NUM_PALETTE) + 1]
        p[#p+1] = string.format('<rect x="%g" y="%g" width="12" height="12" fill="%s" rx="2"/>', lx, ly - 11, color)
        p[#p+1] = string.format('<text x="%g" y="%g" font-family="sans-serif" font-size="11" fill="#555">%s</text>', lx + 16, ly, k)
        lx = lx + 16 + #k * 7 + 14
    end

    p[#p+1] = '</svg>'

    table.insert(selfobj.content, table.concat(p, "\n"))
    return selfobj
end
