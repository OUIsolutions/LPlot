---@type PROJECT_NAMEPublicModuleClass
local plot = require("PROJECT_NAME")

local notebook = plot.newNotebook()

local bar_data = {
    payd_users  = 55,
    free_users  = 100,
    trial_users = 30,
}

-- Vertical bar chart
notebook.add_bar_chart(bar_data, {
    display  = "vertical",
    title    = "User Distribution",
    subtitle = "Q1 2026",
    colors   = {
        payd_users  = "#e74c3c",
        free_users  = "#2ecc71",
        trial_users = "#f39c12",
    },
    size = { width = 800, height = 600 },
})

-- Horizontal bar chart (no custom colors — uses defaults)
notebook.add_bar_chart(bar_data, {
    display  = "horizontal",
    title    = "User Distribution (horizontal)",
    size     = { width = 800, height = 400 },
})

local result = notebook.get_html()
io.open("bar_chart.html", "w"):write(result):close()
