
PublicModule.newNotebook = function ()
    ---@type PROJECT_ALIASNotebook
    local selfobj = {}
    selfobj.content = {}
    selfobj.add_text = function (text) return PrivateModule.NotebookMethod_add_text(selfobj, text) end
    selfobj.get_html = function () return PrivateModule.NotebookMethod_get_html(selfobj) end
    return selfobj
end