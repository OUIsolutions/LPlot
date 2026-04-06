function add_dir(project, dir)
    local concat_path = true
    local src_files = darwin.dtw.list_files_recursively(dir, concat_path)
    for i = 1, #src_files do
        local current = src_files[i]
        project.add_lua_code("-- file: " .. current .. "\n")
        project.add_lua_file(current)
    end
end
function amalgamation_build()

    local project = darwin.create_project(PROJECT_NAME)
    project.add_lua_code("return (function()")
    project.add_lua_code("local PublicModule = {}")
    project.add_lua_code("local PrivateModule = {}")
    add_dir(project, "src/PublicModule")
    add_dir(project, "src/PrivateModule")
    project.add_lua_code("return PublicModule")
    project.add_lua_code("end)()")
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