---@type lplotPublicModuleClass
local plot = require("lplot")
local notebook = plot.newNotebook()

-- Pie chart with explicit slice order
notebook.add_title("Traffic Sources")
notebook.add_pie_chart(
    { organic = 42, paid = 28, referral = 18, direct = 12 },
    {
        title      = "Website Traffic Sources",
        subtitle   = "Q1 2026",
        ordenation = { "organic", "paid", "referral", "direct" },
        size       = { width = 500, height = 380 },
    }
)

notebook.add_separator()

-- Donut chart
notebook.add_subtitle("Device Breakdown (donut)")
notebook.add_pie_chart(
    { mobile = 55, desktop = 30, tablet = 15 },
    {
        title  = "Visits by Device",
        donut  = true,
        colors = { mobile = "#3498db", desktop = "#2ecc71", tablet = "#f39c12" },
        size   = { width = 500, height = 380 },
    }
)

local html = notebook.get_html()
local f = io.open("pie_chart.html", "w")
f:write(html)
f:close()
print("Saved to pie_chart.html")
