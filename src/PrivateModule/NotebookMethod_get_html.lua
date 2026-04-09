
PrivateModuleObject.NotebookMethod_get_html = function (selfobj, style)
    local css
    if type(style) == "string" then
        css = style
    else
        css = PrivateModuleObject.get_asset("default.css") or ""
    end
    local parts = {}
    parts[#parts + 1] = "<!DOCTYPE html><html><head><meta charset=\"UTF-8\"><style>"
    parts[#parts + 1] = css
    parts[#parts + 1] = "</style></head><body>"
    for _, v in ipairs(selfobj.content) do
        parts[#parts + 1] = v
    end
    parts[#parts + 1] = "</body></html>"
    return table.concat(parts, "")
end