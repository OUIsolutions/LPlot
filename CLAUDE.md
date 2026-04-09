
### Overview
Lua library for plotting graphics, tables, and content in plain HTML.

### Build Requirements
Requires [darwin](https://github.com/OUIsolutions/Darwin) v0.20.0+. Check with:
```bash
darwin --version
```
Install darwin:
```bash
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.20.0/darwin.c -o darwin.c && gcc darwin.c -o darwin.out && sudo mv darwin.out /usr/local/bin/darwin && rm darwin.c
```

### Build
List available recipes (located in `builds`):
```bash
darwin list
```
Build all:
```bash
darwin run_blueprint --target all
```
Build a specific recipe:
```bash
darwin run_blueprint --target <recipe_name>
```

### Source Structure
The project lives in `src/` with the following layout:

| Path | Read Every Time | Description |
| --- | --- | --- |
| `src/` | no | Source code root |
| `src/privateModuleTypes.lua` | yes | Private type annotations |
| `src/publicModuleTypes.lua` | yes | Public type annotations (exported to release dir) |
| `src/InternalObjectsTyps.lua` | yes | Type hints for internal objects |
| `src/PrivateModule/` | no | All PrivateModule function implementations |
| `src/PublicModule/` | no | All PublicModule function implementations |

### Implementations
Each function in `PrivateModule` and `PublicModule` lives in its own `.lua` file named after the function.

**Example:** `PublicModule.newNotebook` → `src/PublicModule/newNotebook.lua`

### Assets
(js,css,images,fonts,etc) must be stored in [assets](/assets/) folder, and they can be retrived by the lib
using the function `PrivateModule.get_asset(asset_name: string): string`

### Replacment Mechanic
the project use a replacement mechanic, if you need to create a markdown or a sample ,create inside template dir
when the recipe templates its runned, it aplys the replacment using the REPLACERS var inside [darwinconf.lua](darwinconf.lua)

### Public Functions or methods
what ever public function or method you need to create, fowlow these steps:
1. implement the code
2. write into [template/samples/<sample>.lua] a sample of usage the lib
3. write into [template/docs/public_api.md] a documentation of the function

