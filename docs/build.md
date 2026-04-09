# Building from Source

This guide explains how to build **lplot.lua** from the source code.
If you just want to use the library, grab the pre-built release from the [Releases](#) page instead.

---

## Prerequisites

This project uses [Darwin](https://github.com/OUIsolutions/Darwin) as its build tool.
Darwin is a lightweight build runner — you need to install it before you can build anything.

> **Required Darwin version:** `0.020`

---

## Step 1 — Install Darwin

Choose the command that matches your operating system and paste it into your terminal.

### Linux

```bash
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.020/darwin.c -o darwin.c \
  && gcc darwin.c -o darwin.out \
  && sudo mv darwin.out /usr/bin/darwin \
  && rm darwin.c
```

### macOS

```bash
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.020/darwin.c -o darwin.c \
  && gcc darwin.c -o darwin.out \
  && sudo mv darwin.out /usr/local/bin/darwin \
  && rm darwin.c
```

### Other platforms

Check the [Darwin releases page](https://github.com/OUIsolutions/Darwin/releases/tag/0.20.0) for Windows binaries and other formats.

---

## Step 2 — Build the project

Once Darwin is installed, run the following command from the **root of the repository**:

```bash
darwin run_blueprint --target all
```

This will generate **lplot.lua** inside the `release/` folder.

---

## Advanced: Choosing a specific build target

Darwin organises builds into *recipes* (located in the `builds/` folder).

**List all available recipes:**

```bash
darwin list
```

**Build a specific recipe** (replace `<recipe_name>` with one from the list above):

```bash
darwin run_blueprint --target <recipe_name>
```

---

## Quick reference

| Command | What it does |
|---|---|
| `darwin list` | Show all available build recipes |
| `darwin run_blueprint --target all` | Build everything (outputs to `release/`) |
| `darwin run_blueprint --target <recipe>` | Build a single specific recipe |