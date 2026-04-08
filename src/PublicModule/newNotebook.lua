
PublicModuleObject.newNotebook = function ()
    ---@type PROJECT_ALIASNotebook
    local selfobj = {}
    selfobj.content = {}
    selfobj.add_text = function (text) return PrivateModule.NotebookMethod_add_text(selfobj, text) end
    selfobj.add_title = function (title) return PrivateModule.NotebookMethod_add_title(selfobj, title) end
    selfobj.add_table = function (data) return PrivateModule.NotebookMethod_add_table(selfobj, data) end
    selfobj.get_html = function () return PrivateModule.NotebookMethod_get_html(selfobj) end
    return selfobj
end