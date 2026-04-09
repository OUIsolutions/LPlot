local plot = require("lplot")
local notebook = plot.newNotebook()

-- Single-series scatter chart
notebook.add_title("Height vs Weight")
notebook.add_scatter_chart(
    {
        { x = 160, y = 55, label = "A" },
        { x = 172, y = 70 },
        { x = 168, y = 65 },
        { x = 180, y = 85, label = "B" },
        { x = 155, y = 50 },
        { x = 175, y = 78 },
        { x = 165, y = 60 },
    },
    {
        title    = "Height (cm) vs Weight (kg)",
        subtitle = "Survey data",
        colors   = { points = "#9b59b6" },
        size     = { width = 600, height = 400 },
    }
)

notebook.add_separator()

-- Multi-series scatter chart
notebook.add_subtitle("Two Groups")
notebook.add_scatter_chart(
    {
        groupA = {
            { x = 1.2, y = 3.4 },
            { x = 2.5, y = 4.1 },
            { x = 3.1, y = 2.8 },
        },
        groupB = {
            { x = 4.0, y = 6.2 },
            { x = 5.5, y = 7.0, label = "peak" },
            { x = 6.1, y = 5.8 },
        },
    },
    {
        title  = "Group Comparison",
        colors = { groupA = "#3498db", groupB = "#e74c3c" },
        size   = { width = 600, height = 400 },
    }
)

local html = notebook.get_html()
local f = io.open("scatter_chart.html", "w")
f:write(html)
f:close()
print("Saved to scatter_chart.html")
