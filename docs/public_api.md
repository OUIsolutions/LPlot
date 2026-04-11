### These documentation explains how to use the library

---

## `notebook.add_bar_chart(data: table, options?: BarChartOptions): notebook`

Renders a bar chart (vertical or horizontal) as an inline SVG and appends it to the notebook.

### `data`

A flat key → number table where each key is a category label and each value is the bar's magnitude.

```lua
local data = {
    payd_users  = 55,
    free_users  = 100,
    trial_users = 30,
}
```

### `options` (all fields optional)

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `display` | `"vertical"` \| `"horizontal"` | `"vertical"` | Orientation of the bars. |
| `ordenation` | `string[]` | alphabetical | Explicit order for the category keys. Keys not listed are appended alphabetically at the end. |
| `colors` | `table` | built-in palette | Map of data key → CSS color string (e.g. `"#e74c3c"`). Missing keys fall back to the default palette. |
| `size.width` | `number` | `600` | SVG width in pixels. |
| `size.height` | `number` | `400` | SVG height in pixels. |
| `title` | `string` | `""` | Chart title rendered above the chart. |
| `subtitle` | `string` | `""` | Smaller subtitle rendered below the title. |

**Returns:** the notebook (chainable).

### Example

```lua
local plot = require("lplot")
local notebook = plot.newNotebook()

notebook.add_bar_chart(
    { payd_users = 55, free_users = 100, trial_users = 30 },
    {
        display  = "vertical",
        title    = "User Distribution",
        subtitle = "Q1 2026",
        colors   = {
            payd_users  = "#e74c3c",
            free_users  = "#2ecc71",
            trial_users = "#f39c12",
        },
        size = { width = 800, height = 600 },
    }
)

local html = notebook.get_html()
```

---

## `notebook.add_line_chart(data: table, options?: LineChartOptions): notebook`

Renders a line chart as an inline SVG. Supports single-series (dict) and multi-series (array of objects) formats.

### `data` — single series

```lua
{ Jan=100, Feb=120, Mar=95, Apr=140 }
```

### `data` — multi-series

```lua
{
    { x="Jan", sales=100, costs=60 },
    { x="Feb", sales=120, costs=70 },
    { x="Mar", sales=95,  costs=55 },
}
```

### `options`

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `x_key` | `string` | `"x"` | Key used as x-axis label in multi-series mode. |
| `colors` | `table` | built-in palette | Map of series name → CSS color string. |
| `size.width` | `number` | `600` | SVG width in pixels. |
| `size.height` | `number` | `400` | SVG height in pixels. |
| `title` | `string` | `""` | Chart title. |
| `subtitle` | `string` | `""` | Chart subtitle. |

**Returns:** the notebook (chainable).

---

## `notebook.add_area_chart(data: table, options?: AreaChartOptions): notebook`

Like `add_line_chart` but fills the area under each line with a semi-transparent color.
Accepts the same data formats and options as `add_line_chart`.

**Returns:** the notebook (chainable).

---

## `notebook.add_pie_chart(data: table, options?: PieChartOptions): notebook`

Renders a pie (or donut) chart as an inline SVG.

### `data`

```lua
{ mobile=45, desktop=30, tablet=25 }
```

### `options`

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `donut` | `boolean` | `false` | Render as a donut chart with a hollow center. |
| `ordenation` | `string[]` | alphabetical | Explicit order for the slice keys. Keys not listed are appended alphabetically at the end. |
| `colors` | `table` | built-in palette | Map of slice key → CSS color string. |
| `size.width` | `number` | `500` | SVG width in pixels. |
| `size.height` | `number` | `400` | SVG height in pixels. |
| `title` | `string` | `""` | Chart title. |
| `subtitle` | `string` | `""` | Chart subtitle. |

**Returns:** the notebook (chainable).

---

## `notebook.add_scatter_chart(data: table, options?: ScatterChartOptions): notebook`

Renders a scatter plot as an inline SVG. Supports single-series and multi-series.

### `data` — single series

```lua
{
    { x=1.2, y=3.4 },
    { x=2.1, y=5.0, label="peak" },
}
```

### `data` — multi-series

```lua
{
    groupA = { {x=1, y=2}, {x=3, y=4} },
    groupB = { {x=2, y=5}, {x=4, y=3} },
}
```

Each point may include an optional `label` field rendered next to the dot.

### `options`

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `colors` | `table` | built-in palette | Map of series name → CSS color string. |
| `size.width` | `number` | `600` | SVG width in pixels. |
| `size.height` | `number` | `400` | SVG height in pixels. |
| `title` | `string` | `""` | Chart title. |
| `subtitle` | `string` | `""` | Chart subtitle. |

**Returns:** the notebook (chainable).

---

## `notebook.add_subtitle(subtitle: string): notebook`

Appends a styled `<h3>` subtitle heading to the notebook.

**Returns:** the notebook (chainable).

---

## `notebook.add_separator(): notebook`

Appends a horizontal rule (`<hr>`) to visually separate sections.

**Returns:** the notebook (chainable).

---

## `notebook.get_html(style?: string): string`

Renders the notebook as a complete HTML document.

| Argument | Type | Description |
| --- | --- | --- |
| `style` | `string` (optional) | Custom CSS to embed in the `<style>` tag. If omitted, `assets/default.css` is used. |

**Returns:** A full HTML string (`<!DOCTYPE html>…</html>`).

### Examples

```lua
local plot = require("lplot")
local notebook = plot.newNotebook()
notebook.add_title("Report")
notebook.add_text("Some content.")

-- Default style (assets/default.css)
local html = notebook.get_html()

-- Custom style
local html_custom = notebook.get_html("body { background: #000; color: #fff; }")
```