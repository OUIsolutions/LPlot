
### Obverwiew
these project is a lua library for plotage of graphics,tables and content 
in plain html
### Build Requirements
to build you need to have [darwin](https://github.com/OUIsolutions/Darwin) installed on the machine on version 0.20.0 or higher. to check these run
```bash
darwin --version 
```
if you dont have darwin, you can install it by running the following command:
```bash
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.20.0/darwin.c -o darwin.c && gcc darwin.c -o darwin.out && sudo mv darwin.out /usr/local/bin/darwin && rm darwin.c 
```
### Build 

### List Available recipes
these comands will list the available builds, located in the (builds_dir)[src/builds]
```bash 
darwin list 
```

#### Build All
```bash 
darwin run_blueprint --target all 
```
#### Build especific recipe
```bash 
darwin run_blueprint --target <recipe_name> 
```

