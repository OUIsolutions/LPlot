
---@class PROJECT_NAMEBarChartOptions
---@field display? string        "vertical" (default) or "horizontal"
---@field colors? table          map of data-key → CSS color string
---@field size? {width:number, height:number}
---@field title? string
---@field subtitle? string

---@class PROJECT_NAMENotebook
---@field add_text fun(text: string): PROJECT_NAMENotebook
---@field add_title fun(title: string): PROJECT_NAMENotebook
---@field add_table fun(data: table): PROJECT_NAMENotebook
---@field add_bar_chart fun(data: table, options?: PROJECT_NAMEBarChartOptions): PROJECT_NAMENotebook
---@field get_html fun(style?: string): string
---@field content string[]


---@class PROJECT_NAMEPublicModule
---@field newNotebook fun(): PROJECT_NAMENotebook



