PublicModuleObject.test = function ()
    print(PrivateModuleObject.get_asset("teste.css"))
end


PublicModuleObject.newNotebook = function ()
    ---@type PROJECT_NAMENotebook
    local selfobj = {}
    selfobj.content = {}
    selfobj.add_text = function (text) return PrivateModuleObject.NotebookMethod_add_text(selfobj, text) end
    selfobj.add_title = function (title) return PrivateModuleObject.NotebookMethod_add_title(selfobj, title) end
    selfobj.add_table = function (data) return PrivateModuleObject.NotebookMethod_add_table(selfobj, data) end
    selfobj.get_html = function () return PrivateModuleObject.NotebookMethod_get_html(selfobj) end
    return selfobj
end