
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
List available recipes (located in `src/builds`):
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

