local plot = require("lplot")
local notebook = plot.newNotebook()

-- Single-series area chart
notebook.add_title("Server Load Over Time")
notebook.add_area_chart(
    { ["00:00"]=12, ["04:00"]=8, ["08:00"]=45, ["12:00"]=72, ["16:00"]=68, ["20:00"]=50, ["23:00"]=20 },
    {
        title    = "CPU Usage (%)",
        subtitle = "Last 24 hours",
        colors   = { value = "#3498db" },
        size     = { width = 700, height = 350 },
    }
)

notebook.add_separator()

-- Multi-series area chart
notebook.add_subtitle("Bandwidth by Region")
notebook.add_area_chart(
    {
        { x = "Jan", north = 320, south = 180 },
        { x = "Feb", north = 410, south = 220 },
        { x = "Mar", north = 380, south = 260 },
        { x = "Apr", north = 500, south = 300 },
        { x = "May", north = 470, south = 340 },
        { x = "Jun", north = 620, south = 390 },
    },
    {
        title  = "Network Bandwidth (Mbps)",
        x_key  = "x",
        colors = { north = "#3498db", south = "#e74c3c" },
        size   = { width = 700, height = 350 },
    }
)

local html = notebook.get_html()
local f = io.open("area_chart.html", "w")
f:write(html)
f:close()
print("Saved to area_chart.html")
