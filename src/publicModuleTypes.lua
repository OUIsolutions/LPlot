
---@class PROJECT_NAMEChartOptions
---@field colors? table<string, string>  map of data-key → CSS color string (e.g. {sales="#e74c3c"})
---@field size? {width:number, height:number}
---@field title? string
---@field subtitle? string

---@class PROJECT_NAMEBarChartOptions : PROJECT_NAMEChartOptions
---@field display? string        "vertical" (default) or "horizontal"
---@field ordenation? string[]   explicit order for the category keys

---@class PROJECT_NAMELineChartOptions : PROJECT_NAMEChartOptions
---@field x_key? string          key used as x-axis label in multi-series mode (default "x")

---@class PROJECT_NAMEAreaChartOptions : PROJECT_NAMEChartOptions
---@field x_key? string          key used as x-axis label in multi-series mode (default "x")

---@class PROJECT_NAMEPieChartOptions : PROJECT_NAMEChartOptions
---@field donut? boolean         render as donut chart (default false)
---@field ordenation? string[]   explicit order for the slice keys

---@class PROJECT_NAMEScatterChartOptions : PROJECT_NAMEChartOptions

-- Bar and pie charts: a flat dict mapping each category label to its numeric value.
-- Example: {apple=42, banana=17, cherry=30}
---@alias PROJECT_NAMESimpleChartData table<string, number>

-- Line and area charts – simple mode: same flat dict as PROJECT_NAMESimpleChartData.
-- Line and area charts – multi-series mode: an array of row objects where one key
-- (x_key, default "x") holds the x-axis label and every other key is a series name
-- whose value is a number.
-- Example: {{x="Jan", revenue=100, cost=60}, {x="Feb", revenue=120, cost=70}}
---@alias PROJECT_NAMELineChartData table<string, number>|table<string, number|string>[]

-- Scatter chart – single series: an array of {x, y} point objects.
-- Example: {{x=1, y=2}, {x=3, y=4}}
---@alias PROJECT_NAMEScatterSingleData PROJECT_NAMEChartPoint[]

-- Scatter chart – multi-series: a dict mapping each series name to its point array.
-- Example: {groupA={{x=1,y=2}}, groupB={{x=3,y=4}}}
---@alias PROJECT_NAMEScatterMultiData table<string, PROJECT_NAMEChartPoint[]>

-- Accepted by add_scatter_chart – either single or multi-series form.
---@alias PROJECT_NAMEScatterData PROJECT_NAMEScatterSingleData|PROJECT_NAMEScatterMultiData

-- A single data point used in scatter charts.
---@class PROJECT_NAMEChartPoint
---@field x number       x-axis numeric value
---@field y number       y-axis numeric value
---@field label? string  optional text label rendered next to the point

-- Table data – array-of-arrays format: the first sub-array is a string header row;
-- every subsequent sub-array is a data row of strings or numbers.
-- Example: {{"Name","Score"},{"Alice",95},{"Bob",80}}
---@alias PROJECT_NAMETableArrayData (string|number)[][]

-- Table data – array-of-objects format: each element is a record whose string keys
-- become column headers and whose values are the cell contents.
-- Example: {{name="Alice", score=95}, {name="Bob", score=80}}
---@alias PROJECT_NAMETableObjectData table<string, string|number>[]

-- Accepted by add_table – either array-of-arrays or array-of-objects form.
---@alias PROJECT_NAMETableData PROJECT_NAMETableArrayData|PROJECT_NAMETableObjectData

---@class PROJECT_NAMENotebook
---@field add_text fun(text: string): PROJECT_NAMENotebook
---@field add_title fun(title: string): PROJECT_NAMENotebook
---@field add_subtitle fun(subtitle: string): PROJECT_NAMENotebook
---@field add_separator fun(): PROJECT_NAMENotebook
---@field add_table fun(data: PROJECT_NAMETableData): PROJECT_NAMENotebook
---@field add_bar_chart fun(data: PROJECT_NAMESimpleChartData, options?: PROJECT_NAMEBarChartOptions): PROJECT_NAMENotebook
---@field add_line_chart fun(data: PROJECT_NAMELineChartData, options?: PROJECT_NAMELineChartOptions): PROJECT_NAMENotebook
---@field add_area_chart fun(data: PROJECT_NAMELineChartData, options?: PROJECT_NAMEAreaChartOptions): PROJECT_NAMENotebook
---@field add_pie_chart fun(data: PROJECT_NAMESimpleChartData, options?: PROJECT_NAMEPieChartOptions): PROJECT_NAMENotebook
---@field add_scatter_chart fun(data: PROJECT_NAMEScatterData, options?: PROJECT_NAMEScatterChartOptions): PROJECT_NAMENotebook
---@field get_html fun(style?: string): string
---@field content string[]


---@class PROJECT_NAMEPublicModuleClass
---@field newNotebook fun(): PROJECT_NAMENotebook
---@field darkmode string
---@field lightmode string
---@field cyberpunk string