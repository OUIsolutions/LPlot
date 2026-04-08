function add_dir(project, dir)
    local concat_path = true
    local src_files = darwin.dtw.list_files_recursively(dir, concat_path)
    for i = 1, #src_files do
        local current = src_files[i]
        project.add_lua_code("-- file: " .. current .. "\n")
        project.add_lua_file(current)
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
    project.embed_global(ASSETS_OBJECT,assets_object)
end
function amalgamation_build()

    local project = darwin.create_project(PROJECT_NAME)
    project.add_lua_code("return (function()")
    for i = 1, #GLOBAL_OBJECTS do
        project.add_lua_code("local " .. GLOBAL_OBJECTS[i] .. " = {}")
    end
    add_dir(project, "src/PublicModule")
    add_dir(project, "src/PrivateModule")
    project.add_lua_code("return " .. RETURN_OBJECT)
    project.add_lua_code("end)()")
    add_assets(project)
    project.generate_lua_file({
        output = "release/" .. PROJECT_NAME .. ".lua"
    })


end 



darwin.add_recipe({
    name="amalgamation",
    description="make a single file amalgamation of the project",
    outs={"release/" .. PROJECT_NAME .. ".lua"},
    inputs={"src","builds"},
    callback=amalgamation_build
})