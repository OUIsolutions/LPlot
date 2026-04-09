
PrivateModule.lib_start = function ()
    ---@type PROJECT_NAMEPublicModuleClass
    local PublicModule = {
        newNotebook = PrivateModule.newNotebook,
        darkmode = PrivateModule.get_asset("darkmode.css"),
        lightmode = PrivateModule.get_asset("lightmode.css"),
        cyberpunk = PrivateModule.get_asset("cyberpunk.css")
    }
    return PublicModule
end     