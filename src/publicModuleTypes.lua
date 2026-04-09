
---@class PROJECT_NAMEChartOptions
---@field colors? table          map of data-key → CSS color string
---@field size? {width:number, height:number}
---@field title? string
---@field subtitle? string

---@class PROJECT_NAMEBarChartOptions : PROJECT_NAMEChartOptions
---@field display? string        "vertical" (default) or "horizontal"

---@class PROJECT_NAMELineChartOptions : PROJECT_NAMEChartOptions
---@field x_key? string          key used as x-axis label in multi-series mode (default "x")

---@class PROJECT_NAMEAreaChartOptions : PROJECT_NAMEChartOptions
---@field x_key? string          key used as x-axis label in multi-series mode (default "x")

---@class PROJECT_NAMEPieChartOptions : PROJECT_NAMEChartOptions
---@field donut? boolean         render as donut chart (default false)

---@class PROJECT_NAMEScatterChartOptions : PROJECT_NAMEChartOptions

---@class PROJECT_NAMENotebook
---@field add_text fun(text: string): PROJECT_NAMENotebook
---@field add_title fun(title: string): PROJECT_NAMENotebook
---@field add_subtitle fun(subtitle: string): PROJECT_NAMENotebook
---@field add_separator fun(): PROJECT_NAMENotebook
---@field add_table fun(data: table): PROJECT_NAMENotebook
---@field add_bar_chart fun(data: table, options?: PROJECT_NAMEBarChartOptions): PROJECT_NAMENotebook
---@field add_line_chart fun(data: table, options?: PROJECT_NAMELineChartOptions): PROJECT_NAMENotebook
---@field add_area_chart fun(data: table, options?: PROJECT_NAMEAreaChartOptions): PROJECT_NAMENotebook
---@field add_pie_chart fun(data: table, options?: PROJECT_NAMEPieChartOptions): PROJECT_NAMENotebook
---@field add_scatter_chart fun(data: table, options?: PROJECT_NAMEScatterChartOptions): PROJECT_NAMENotebook
---@field get_html fun(style?: string): string
---@field content string[]


---@class PROJECT_NAMEPublicModule
---@field newNotebook fun(): PROJECT_NAMENotebook
---@field darkmode string
---@field lightmode string
---@field cyberpunk string