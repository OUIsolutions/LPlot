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