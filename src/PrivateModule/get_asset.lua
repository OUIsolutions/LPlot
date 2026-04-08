

PrivateModuleObject.get_asset = function (name)
    for i = 1, #PROJECT_NAME_AssetsObject do
        if PROJECT_NAME_AssetsObject[i].path == name then
            return PROJECT_NAME_AssetsObject[i].content
        end
    end
    return nil
end