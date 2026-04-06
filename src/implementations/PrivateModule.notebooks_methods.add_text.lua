PrivateModule.notebook_methods.add_text = function(selfobj, text)
    selfobj.content[#selfobj.content + 1] = text
    return selfobj
end