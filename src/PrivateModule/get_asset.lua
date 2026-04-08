

PrivateModuleObject.get_asset = function (name)
    for i = 1, #AssetsObject do
        if AssetsObject[i].path == name then
            return AssetsObject[i].content
        end
    end
    return nil
end