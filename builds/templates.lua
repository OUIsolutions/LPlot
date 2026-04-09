function templates_build()
    
    local template_itens = darwin.dtw.list_files_recursively("template")
    for i = 1, #template_itens do
        local current = template_itens[i]
        local content = darwin.dtw.load_file("template/" .. current)
        --aply the replacers
        local new_content = content
        if REPLACERS then
            for key, value in pairs(REPLACERS) do
                -- Escape the replacement value in case it contains '%' characters
                local escaped_value = string.gsub(value, "%%", "%%%%")
                new_content = string.gsub(new_content, key, escaped_value)
            end
        end
        darwin.dtw.write_file(current, new_content)
    end
end 


darwin.add_recipe({
    name="templates",
    description="make the templates for the project",
    callback=templates_build
})