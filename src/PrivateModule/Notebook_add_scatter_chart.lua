
PrivateModuleObject.Notebook___add_scatter_chart = function(selfobj, data, options)
    if not data or type(data) ~= "table" then return selfobj end

    options = options or {}
    local size     = options.size     or {}
    local width    = size.width       or 600
    local height   = size.height      or 400
    local title    = options.title    or ""
    local subtitle = options.subtitle or ""
    local colors   = options.colors   or {}

    local PALETTE = {"#3498db","#e74c3c","#2ecc71","#f39c12","#9b59b6","#1abc9c","#e67e22","#34495e"}
    local NUM_PALETTE = #PALETTE

    -- Detect format:
    --   single series: { {x=1, y=2}, ... }
    --   multi-series:  { series1={{x=1,y=2},...}, series2={{x=3,y=4},...} }
    local series = {}
    local series_names = {}

    local first = data[1]
    if first and type(first) == "table" and first.x ~= nil then
        series_names = {"points"}
        series["points"] = data
    else
        for k, v in pairs(data) do
            table.insert(series_names, k)
            series[k] = v
        end
        table.sort(series_names)
    end

    -- Compute data bounds
    local min_x, max_x = math.huge, -math.huge
    local min_y, max_y = math.huge, -math.huge
    for _, name in ipairs(series_names) do
        for _, pt in ipairs(series[name]) do
            if pt.x < min_x then min_x = pt.x end
            if pt.x > max_x then max_x = pt.x end
            if pt.y < min_y then min_y = pt.y end
            if pt.y > max_y then max_y = pt.y end
        end
    end
    local xpad = (max_x - min_x) * 0.05; if xpad == 0 then xpad = 1 end
    local ypad = (max_y - min_y) * 0.05; if ypad == 0 then ypad = 1 end
    min_x = min_x - xpad; max_x = max_x + xpad
    min_y = min_y - ypad; max_y = max_y + ypad

    local title_h    = (title    ~= "" and 30 or 0)
    local subtitle_h = (subtitle ~= "" and 22 or 0)
    local legend_h   = (#series_names > 1 and 28 or 0)
    local header_h   = title_h + subtitle_h + legend_h

    local margin = { top = 14 + header_h, right = 30, bottom = 60, left = 65 }
    local cw = width  - margin.left - margin.right
    local ch = height - margin.top  - margin.bottom

    local p = {}
    p[#p+1] = string.format('<svg width="%d" height="%d" xmlns="http://www.w3.org/2000/svg">', width, height)

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

    if #series_names > 1 then
        local lx = margin.left
        for si, name in ipairs(series_names) do
            local color = colors[name] or PALETTE[((si - 1) % NUM_PALETTE) + 1]
            p[#p+1] = string.format('<circle cx="%g" cy="%g" r="5" fill="%s"/>', lx + 5, ty - 3, color)
            p[#p+1] = string.format('<text x="%g" y="%g" font-family="sans-serif" font-size="12" fill="#555">%s</text>', lx + 16, ty, name)
            lx = lx + 16 + #name * 8 + 10
        end
    end

    p[#p+1] = string.format('<g transform="translate(%d,%d)">', margin.left, margin.top)

    local NUM_GRID = 5

    local function to_px(x)
        return ((x - min_x) / (max_x - min_x)) * cw
    end
    local function to_py(y)
        return ch - ((y - min_y) / (max_y - min_y)) * ch
    end

    -- Vertical gridlines + x labels
    for i = 0, NUM_GRID do
        local gx  = (i / NUM_GRID) * cw
        local gxv = min_x + (i / NUM_GRID) * (max_x - min_x)
        p[#p+1] = string.format('<line x1="%g" y1="0" x2="%g" y2="%d" stroke="#e0e0e0" stroke-width="1"/>', gx, gx, ch)
        p[#p+1] = string.format(
            '<text x="%g" y="%d" text-anchor="middle" font-family="sans-serif" font-size="11" fill="#666">%g</text>',
            gx, ch + 16, gxv)
    end

    -- Horizontal gridlines + y labels
    for i = 0, NUM_GRID do
        local gy  = ch - (i / NUM_GRID) * ch
        local gyv = min_y + (i / NUM_GRID) * (max_y - min_y)
        p[#p+1] = string.format('<line x1="0" y1="%g" x2="%d" y2="%g" stroke="#e0e0e0" stroke-width="1"/>', gy, cw, gy)
        p[#p+1] = string.format(
            '<text x="-8" y="%g" text-anchor="end" dominant-baseline="middle" font-family="sans-serif" font-size="11" fill="#666">%g</text>',
            gy, gyv)
    end

    -- Points
    for si, name in ipairs(series_names) do
        local color = colors[name] or PALETTE[((si - 1) % NUM_PALETTE) + 1]
        for _, pt in ipairs(series[name]) do
            local px = to_px(pt.x)
            local py = to_py(pt.y)
            p[#p+1] = string.format('<circle cx="%g" cy="%g" r="5" fill="%s" fill-opacity="0.75" stroke="%s" stroke-width="1"/>', px, py, color, color)
            if pt.label then
                p[#p+1] = string.format(
                    '<text x="%g" y="%g" font-family="sans-serif" font-size="10" fill="#555">%s</text>',
                    px + 8, py + 4, pt.label)
            end
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
