

PublicModuleObject.newNotebook = function ()
    ---@type PROJECT_NAMENotebook
    local selfobj = {}
    selfobj.content = {}
    selfobj.add_text = function (text) return PrivateModuleObject.NotebookMethod_add_text(selfobj, text) end
    selfobj.add_title = function (title) return PrivateModuleObject.NotebookMethod_add_title(selfobj, title) end
    selfobj.add_table = function (data) return PrivateModuleObject.NotebookMethod_add_table(selfobj, data) end
    selfobj.add_bar_chart = function (data, options) return PrivateModuleObject.NotebookMethod_add_bar_chart(selfobj, data, options) end
    selfobj.get_html = function (style) return PrivateModuleObject.NotebookMethod_get_html(selfobj, style) end
    return selfobj
end