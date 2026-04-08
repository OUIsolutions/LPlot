

PrivateModuleObject.get_asset = function (name)
    for i = 1, #PROJECT_ALIAS_AssetsObject do
        if PROJECT_ALIAS_AssetsObject[i].path == name then
            return PROJECT_ALIAS_AssetsObject[i].content
        end
    end
    return nil
end