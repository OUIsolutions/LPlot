PrivateModuleObject.NotebookMethod_add_table = function (selfobj, data)
    if not data or type(data) ~= "table" or #data == 0 then
        return selfobj
    end
    
    local html = "<table border='1' style='border-collapse: collapse; margin: 10px 0;'>\n"
    
    -- Check if the first element is an array (indexed table) or hash (key-value table)
    local first_element = data[1]
    if type(first_element) == "table" then
        -- Determine if this is array format or hash format
        local is_array_format = type(first_element[1]) == "string"
        
        if is_array_format then
            -- Array format: first row is headers, subsequent rows are data
            -- Header row
            html = html .. "  <tr style='background-color: #f2f2f2; font-weight: bold;'>\n"
            for _, header in ipairs(first_element) do
                html = html .. "    <th style='padding: 8px; text-align: left;'>" .. tostring(header) .. "</th>\n"
            end
            html = html .. "  </tr>\n"
            
            -- Data rows
            for i = 2, #data do
                html = html .. "  <tr>\n"
                for _, cell in ipairs(data[i]) do
                    html = html .. "    <td style='padding: 8px;'>" .. tostring(cell) .. "</td>\n"
                end
                html = html .. "  </tr>\n"
            end
        else
            -- Hash format: extract headers from first element keys
            local headers = {}
            for key, _ in pairs(first_element) do
                table.insert(headers, key)
            end
            table.sort(headers) -- Sort for consistent column order
            
            -- Header row
            html = html .. "  <tr style='background-color: #f2f2f2; font-weight: bold;'>\n"
            for _, header in ipairs(headers) do
                html = html .. "    <th style='padding: 8px; text-align: left;'>" .. tostring(header) .. "</th>\n"
            end
            html = html .. "  </tr>\n"
            
            -- Data rows
            for _, row in ipairs(data) do
                html = html .. "  <tr>\n"
                for _, header in ipairs(headers) do
                    local value = row[header] or ""
                    html = html .. "    <td style='padding: 8px;'>" .. tostring(value) .. "</td>\n"
                end
                html = html .. "  </tr>\n"
            end
        end
    end
    
    html = html .. "</table>\n"
    
    table.insert(selfobj.content, html)
    return selfobj
end