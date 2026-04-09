---@type PROJECT_NAMEPublicModuleClass
local plot  = require("PROJECT_NAME")

local teste = plot.newNotebook()

-- Test array format
local array_format_table = {
    {"name", "age", "city"},
    {"mateus", "22", "rio de janeiro"},
    {"joao", "23", "sao paulo"},
    {"maria", "24", "belo horizonte"},
}

-- Test object format
local object_format_table = {
    {name = "mateus", age = "22", city = "rio de janeiro"},
    {name = "joao", age = "23", city = "sao paulo"},
    {name = "maria", age = "24", city = "belo horizonte"},
}

teste.add_text('<h2>Array Format Table</h2>')
teste.add_table(array_format_table)

teste.add_text('<h2>Object Format Table</h2>')
teste.add_table(object_format_table)

local result = teste.get_html()
io.open("table.html", "w"):write(result):close()