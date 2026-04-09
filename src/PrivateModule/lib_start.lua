PrivateModule.lib_start = function ()
    ---@type PROJECT_NAMEPublicModuleClass
    local PublicModule = {
        newNotebook = PrivateModule.newNotebook,
        darkmode = tostring(PrivateModule.get_asset("darkmode.css") or ""),
        lightmode = tostring(PrivateModule.get_asset("lightmode.css") or ""),
        cyberpunk = tostring(PrivateModule.get_asset("cyberpunk.css") or "")
    }
    return PublicModule
end