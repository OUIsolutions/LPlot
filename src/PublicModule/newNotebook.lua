
PublicModule.newNotebook = function ()
    ---@type PROJECT_ALIASNotebook
    local self_obj = {}
    self_obj.content = {}
    self_obj.add_text = function (text) return PrivateModule.NotebookMethod_add_text(self_obj, text) end
    return self_obj
end