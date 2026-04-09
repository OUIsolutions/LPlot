
PrivateModule.NotebookMethod_add_line_chart = function(selfobj, data, options)
    if not data or type(data) ~= "table" then return selfobj end

    options = options or {}
    local size     = options.size     or {}
    local width    = size.width       or 600
    local height   = size.height      or 400
    local title    = options.title    or ""
    local subtitle = options.subtitle or ""
    local colors   = options.colors   or {}
    local x_key    = options.x_key    or "x"

    local PALETTE = {"#3498db","#e74c3c","#2ecc71","#f39c12","#9b59b6","#1abc9c","#e67e22","#34495e"}
    local NUM_PALETTE = #PALETTE

    -- Detect format: array-of-objects (multi-series) vs simple dict {label=value}
    local is_multi = type(data[1]) == "table"
    local labels = {}
    local series = {}
    local series_names = {}

    if is_multi then
        for _, row in ipairs(data) do
            table.insert(labels, tostring(row[x_key] or ""))
        end
        local first = data[1]
        for k in pairs(first) do
            if k ~= x_key then table.insert(series_names, k) end
        end
        table.sort(series_names)
        for _, name in ipairs(series_names) do
            series[name] = {}
            for _, row in ipairs(data) do
                table.insert(series[name], row[name] or 0)
            end
        end
    else
        for k in pairs(data) do table.insert(labels, k) end
        table.sort(labels)
        local vals = {}
        for _, k in ipairs(labels) do table.insert(vals, data[k]) end
        series_names = {"value"}
        series["value"] = vals
    end

    local n = #labels

    local max_val, min_val = -math.huge, math.huge
    for _, name in ipairs(series_names) do
        for _, v in ipairs(series[name]) do
            if v > max_val then max_val = v end
            if v < min_val then min_val = v end
        end
    end
    if max_val == min_val then max_val = min_val + 1 end
    if min_val > 0 then min_val = 0 end

    -- Header height (titles + legend)
    local title_h    = (title    ~= "" and 30 or 0)
    local subtitle_h = (subtitle ~= "" and 22 or 0)
    local legend_h   = (#series_names > 1 and 28 or 0)
    local header_h   = title_h + subtitle_h + legend_h

    local margin = { top = 14 + header_h, right = 30, bottom = 60, left = 65 }
    local cw = width  - margin.left - margin.right
    local ch = height - margin.top  - margin.bottom

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
        ty = ty + 24
    end

    -- Legend
    if #series_names > 1 then
        local lx = margin.left
        for si, name in ipairs(series_names) do
            local color = colors[name] or PALETTE[((si - 1) % NUM_PALETTE) + 1]
            p[#p+1] = string.format('<rect x="%g" y="%g" width="14" height="4" fill="%s" rx="2"/>', lx, ty - 4, color)
            p[#p+1] = string.format('<circle cx="%g" cy="%g" r="4" fill="%s"/>', lx + 7, ty - 2, color)
            p[#p+1] = string.format('<text x="%g" y="%g" font-family="sans-serif" font-size="12" fill="#555">%s</text>', lx + 20, ty, name)
            lx = lx + 20 + #name * 8 + 10
        end
    end

    p[#p+1] = string.format('<g transform="translate(%d,%d)">', margin.left, margin.top)

    local NUM_GRID = 5
    local val_range = max_val - min_val

    local function val_to_y(v)
        return ch - ((v - min_val) / val_range) * ch
    end

    -- Gridlines + y labels
    for i = 0, NUM_GRID do
        local gy  = ch - (i / NUM_GRID) * ch
        local gv  = min_val + (i / NUM_GRID) * val_range
        p[#p+1] = string.format('<line x1="0" y1="%g" x2="%d" y2="%g" stroke="#e0e0e0" stroke-width="1"/>', gy, cw, gy)
        p[#p+1] = string.format(
            '<text x="-8" y="%g" text-anchor="end" dominant-baseline="middle" font-family="sans-serif" font-size="11" fill="#666">%g</text>',
            gy, gv)
    end

    -- X labels
    local slot = n > 1 and (cw / (n - 1)) or cw
    for i, label in ipairs(labels) do
        local lx = (i - 1) * slot
        local ly = ch + 18
        p[#p+1] = string.format(
            '<text x="%g" y="%g" text-anchor="end" font-family="sans-serif" font-size="11" fill="#555" transform="rotate(-35,%g,%g)">%s</text>',
            lx, ly, lx, ly, label)
    end

    -- Series lines and dots
    for si, name in ipairs(series_names) do
        local color = colors[name] or PALETTE[((si - 1) % NUM_PALETTE) + 1]
        local vals  = series[name]
        local pts   = {}
        for i, v in ipairs(vals) do
            local px = (i - 1) * slot
            local py = val_to_y(v)
            table.insert(pts, string.format("%g,%g", px, py))
        end
        p[#p+1] = string.format(
            '<polyline points="%s" fill="none" stroke="%s" stroke-width="2.5" stroke-linejoin="round" stroke-linecap="round"/>',
            table.concat(pts, " "), color)
        for i, v in ipairs(vals) do
            local px = (i - 1) * slot
            local py = val_to_y(v)
            p[#p+1] = string.format('<circle cx="%g" cy="%g" r="4" fill="%s"/>', px, py, color)
        end
    end

    -- Axes
    p[#p+1] = string.format('<line x1="0" y1="0" x2="0" y2="%d" stroke="#333" stroke-width="1.5"/>', ch)
    p[#p+1] = string.format('<line x1="0" y1="%d" x2="%d" y2="%d" stroke="#333" stroke-width="1.5"/>', ch, cw, ch)

    p[#p+1] = '</g>'
    p[#p+1] = '</svg>'

    table.insert(selfobj.content, table.concat(p, "\n"))
    return selfobj
end
