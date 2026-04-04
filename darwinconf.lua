local project = darwin.create_project("lplot")
project.add_lua_code("private_lplot =  {}")
project.add_lua_code("lplot = {}")
project.add_lua_code("private_lua_argv_string_functions = {}")

local concat_path = true
local src_files = darwin.dtw.list_files_recursively("src", concat_path)
for i = 1, #src_files do
    local current = src_files[i]
    project.add_lua_code("-- file: " .. current .. "\n")
    project.add_lua_file(current)
end
project.add_lua_code("return lplot")

project.generate_lua_file({
    output = "lplot.lua"
})