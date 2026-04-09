### Building from Scratch
if you want to build the project from the repo, just install [Darwin](https://github.com/OUIsolutions/Darwin) on version 0.020 with:
### Linux Build
```bash
curl -L https://github.com/OUIsolutions/Darwin/releases/download/REQUIRED_DARWIN_VERSION/darwin.c -o darwin.c && gcc darwin.c -o darwin.out && sudo mv darwin.out /usr/bin/darwin && rm darwin.c   
```
### Mac Build
```bash
curl -L https://github.com/OUIsolutions/Darwin/releases/download/REQUIRED_DARWIN_VERSION/darwin.c -o darwin.c && gcc darwin.c -o darwin.out && sudo mv darwin.out /usr/local/bin/darwin && rm darwin.c
```

### OTher FOormats
check the [release](https://github.com/OUIsolutions/Darwin/releases/tag/0.20.0) page for other formats.


and then you can build the **PROJECT_NAME.lua** with:
```bash
darwin run_blueprint --target all
```
it will generte the **PROJECT_NAME.lua** in the `release/` folder.

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