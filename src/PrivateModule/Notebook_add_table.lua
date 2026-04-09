PrivateModuleObject.Notebook___add_table = function (selfobj, data)
    if not data or type(data) ~= "table" or #data == 0 then
        return selfobj
    end

    local html = "<table>\n"

    local first_element = data[1]
    if type(first_element) == "table" then
        local is_array_format = type(first_element[1]) == "string"

        if is_array_format then
            html = html .. "  <tr>\n"
            for _, header in ipairs(first_element) do
                html = html .. "    <th>" .. tostring(header) .. "</th>\n"
            end
            html = html .. "  </tr>\n"

            for i = 2, #data do
                html = html .. "  <tr>\n"
                for _, cell in ipairs(data[i]) do
                    html = html .. "    <td>" .. tostring(cell) .. "</td>\n"
                end
                html = html .. "  </tr>\n"
            end
        else
            local headers = {}
            for key, _ in pairs(first_element) do
                table.insert(headers, key)
            end
            table.sort(headers)

            html = html .. "  <tr>\n"
            for _, header in ipairs(headers) do
                html = html .. "    <th>" .. tostring(header) .. "</th>\n"
            end
            html = html .. "  </tr>\n"

            for _, row in ipairs(data) do
                html = html .. "  <tr>\n"
                for _, header in ipairs(headers) do
                    local value = row[header] or ""
                    html = html .. "    <td>" .. tostring(value) .. "</td>\n"
                end
                html = html .. "  </tr>\n"
            end
        end
    end

    html = html .. "</table>\n"

    table.insert(selfobj.content, html)
    return selfobj
end
