

function add_lua_file_replacing_alias(project,file)
    local content = darwin.dtw.load_file(file)
    content = content:gsub("PROJECT_NAME",PROJECT_NAME)
    project.add_lua_code(content)

end
function add_dir(project, dir)
    local concat_path = true
    local src_files = darwin.dtw.list_files_recursively(dir, concat_path)
    for i = 1, #src_files do
        local current = src_files[i]
        project.add_lua_code("-- file: " .. current .. "\n")
        add_lua_file_replacing_alias(project,current)
    end
end
function add_assets(project)
    local assets = darwin.dtw.list_files_recursively("assets")
    local assets_object= {}
    for i = 1, #assets do
        local current = assets[i]
         assets_object[#assets_object+1] = {
            content = darwin.dtw.load_file("assets/" .. current),
            path = current
         }
    end
    project.embed_global(PROJECT_NAME.."_AssetsObject",assets_object)
end
function amalgamation_build()

    local project = darwin.create_project(PROJECT_NAME)
    project.add_lua_code("return (function()")
    project.add_lua_code("local PublicModuleObject = {}")
    project.add_lua_code("local PrivateModuleObject = {}")
    add_dir(project, "src/PublicModule")
    add_dir(project, "src/PrivateModule")
    project.add_lua_code("PrivateModuleObject.lib_start()")
    project.add_lua_code("return PublicModuleObject")
    project.add_lua_code("end)()")
    add_assets(project)
    local code = project.generate_lua_code({})
    darwin.dtw.write_file("release/" .. PROJECT_NAME .. ".lua", code)
    darwin.dtw.write_file("samples/" .. PROJECT_NAME .. ".lua", code)



end 



darwin.add_recipe({
    name="amalgamation",
    description="make a single file amalgamation of the project",
    outs={"release/" .. PROJECT_NAME .. ".lua"},
    inputs={"src","builds"},
    callback=amalgamation_build
})