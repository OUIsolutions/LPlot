---@type PROJECT_NAMEPublicModuleClass
local plot = require("PROJECT_NAME")
local notebook = plot.newNotebook()

-- Single-series line chart (simple dict)
notebook.add_title("Monthly Revenue")
notebook.add_line_chart(
    { Jan=4200, Feb=3800, Mar=5100, Apr=4700, May=6200, Jun=5800 },
    {
        title    = "Revenue 2026",
        subtitle = "Single series",
        colors   = { value = "#3498db" },
        size     = { width = 700, height = 350 },
    }
)

notebook.add_separator()

-- Multi-series line chart
notebook.add_subtitle("Revenue vs Costs")
notebook.add_line_chart(
    {
        { x = "Jan", revenue = 4200, costs = 2100 },
        { x = "Feb", revenue = 3800, costs = 2300 },
        { x = "Mar", revenue = 5100, costs = 2000 },
        { x = "Apr", revenue = 4700, costs = 2400 },
        { x = "May", revenue = 6200, costs = 2600 },
        { x = "Jun", revenue = 5800, costs = 2500 },
    },
    {
        title    = "Revenue vs Costs 2026",
        subtitle = "Multi-series",
        x_key    = "x",
        colors   = { revenue = "#2ecc71", costs = "#e74c3c" },
        size     = { width = 700, height = 350 },
    }
)

local html = notebook.get_html()
local f = io.open("line_chart.html", "w")
f:write(html)
f:close()
print("Saved to line_chart.html")
