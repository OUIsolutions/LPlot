---@type PROJECT_NAMEPublicModuleClass
local plot = require("PROJECT_NAME")

local notebook = plot.newNotebook()
notebook.add_title("Hello World")
notebook.add_text("This page uses the default style.")

-- Default style (uses assets/default.css)
local html_default = notebook.get_html()
io.open("output_default.html", "w"):write(html_default):close()

-- Custom style passed as a string
local custom_css = "body { font-family: monospace; background: #111; color: #0f0; padding: 16px; }"
local html_custom = notebook.get_html(custom_css)
io.open("output_custom.html", "w"):write(html_custom):close()
