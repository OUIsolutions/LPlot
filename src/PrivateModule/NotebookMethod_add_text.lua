
PrivateModule.NotebookMethod_add_text = function (selfobj, text)
    selfobj.content[#selfobj.content+1] = text
    return self_obj
end