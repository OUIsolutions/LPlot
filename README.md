<div align="center">

# lplot
![Lua Logo](https://img.shields.io/badge/lplot-0.0.2-blue?style=for-the-badge&logo=lua)
[![GitHub Release](https://img.shields.io/github/release/OUIsolutions/lplot.svg?style=for-the-badge)](https://github.com/OUIsolutions/LPlot/releases)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](https://github.com/OUIsolutions/LPlot/blob/main/LICENSE)
![Status](https://img.shields.io/badge/Status-Alpha-orange?style=for-the-badge)
![Platforms](https://img.shields.io/badge/Platforms-Windows%20|%20Linux%20|%20macOS-lightgrey?style=for-the-badge)

</div>

---

## ⚠️ Important Notice

> **This is alpha software!** Use at your own risk. While we're working hard to make it stable, bugs are expected. Perfect for learning and prototyping! 🧪

---

### Overview

lplot is a library to plot graphics, tables, and content in plain HTML.

This library is designed for developers who need to:
- Generate HTML reports natively from Lua
- Plot data visualizations
- Create structured tables dynamically

### Key Features

- **Plain HTML Output** - Generate functional graphics and tables without heavy frameworks
- **Simplified integration** - Single-file inclusion
- **Type Annotations** - Comes with external type definitions mapped to `lplotTypes.lua`
- **Cross-platform functionality** - Compatible with Windows, Linux, and macOS
- **Minimal dependencies** - No additional library installations required

---

## Releases

| **File** | **Description** |
|----------|-----------------|
| [lplot.lua](https://github.com/OUIsolutions/LPlot/releases/download/0.0.2/lplot.lua) | The library in plain lua code |
| [lplotTypes.lua](https://github.com/OUIsolutions/LPlot/releases/download/0.0.2/lplotTypes.lua) | The library type annotations |

## Installation Tutorials

To install the library, you just need to download it and import it with `require`.

### Download the lib 
```bash
curl -L "https://github.com/OUIsolutions/LPlot/releases/download/0.0.2/lplot.lua" -o "lplot.lua"
```

### Import the lib
```lua
local lplot = require("lplot")
```

## [Public API](docs/public_api.md)
Click here [Public API](docs/public_api.md) to see the full list of public API functions.

## Documentation & Samples 

| **Documentation** | **Description** |
|-------------------|-----------------|
| [Build](docs/build.md) | How to build the project |
| [Samples](/samples) | Examples of how to use the library |

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---