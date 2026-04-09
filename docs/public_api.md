### These documentation explains how to use the library

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