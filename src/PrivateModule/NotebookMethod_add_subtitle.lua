
PrivateModule.NotebookMethod_add_subtitle = function(selfobj, subtitle)
    table.insert(selfobj.content, '<h3>' .. tostring(subtitle) .. '</h3>')
    return selfobj
end
