---@type lplotPublicModuleClass
local plot = require("lplot")

local notebook = plot.newNotebook()

local bar_data = {
    payd_users  = 55,
    free_users  = 100,
    trial_users = 30,
}

-- Vertical bar chart with custom order
notebook.add_bar_chart(bar_data, {
    display    = "vertical",
    title      = "User Distribution",
    subtitle   = "Q1 2026",
    ordenation = { "free_users", "payd_users", "trial_users" },
    colors     = {
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
