
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

### sr struct 
the project its contained in the src dir, with these following format

| content                     | Read Everytime | description                                                                                               |
| ---                         | ---             | ---                                                                                                      |
| src/                        | no              | the source code of the project                                                                           |
| src/privateModuleTypes.lua  | yes             | the private type notation of project                                                                     |
| src/publicModuleTypes       | yes              | the public type notation of project  (will be exported to release dir)                                   |
| src/modules.lua             | yes              | the type indication of public and private modules, to make easy for intelisense (dont need to change )   |
| src/PrivateModule           | no              | the dir containing all the functions of the *PrivateModule*                                              |
| src/PublicModule            | no              | the dir containing all the functions of the *PublicModule*                                               |


### Implementations 
all the **PrivateModule** and **PublicModule** are implemented in the `src/PrivateModule` and `src/PublicModule` dirs respectively
, each function is contained in a file with the same name as the function, and the file is a lua file with the extension `.lua`

### How to read a function 

if you want to read the function **PublicModule.newNotebook** you need to read the file `src/PublicModule/newNotebook.lua`


