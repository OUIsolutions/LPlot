PrivateModuleObject.NotebookMethod_add_title = function (selfobj, title)
    local html = "<h2 style='margin: 20px 0 10px 0; color: #333;'>" .. tostring(title) .. "</h2>\n"
    table.insert(selfobj.content, html)
    return selfobj
end