
function types_build()
    
    local public_content = darwin.dtw.load_file("src/publicModuleTypes.lua")
    
    public_content = public_content:gsub("PROJECT_ALIAS", PROJECT_NAME)
    
    darwin.dtw.write_file("release/" .. PROJECT_NAME .. "Types.lua", public_content)
end 


darwin.add_recipe({
    name="types",
    description="make the release of type especification",
    outs={"release/" .. PROJECT_NAME .. "Types.lua"},
    inputs={"src"},
    callback=types_build
})