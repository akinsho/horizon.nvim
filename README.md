# horizon.nvim

![logo](https://user-images.githubusercontent.com/22454918/231746321-fa9aa184-1414-4433-9997-b28242064940.png)

A neovim implementation of the [Horizon theme](https://horizontheme.netlify.app/).

### Status

Some highlights are still being finalised so there may be some changes to the theme in the near future :pray:.

## Screenshots

<img width="1308" alt="image" src="https://user-images.githubusercontent.com/22454918/232234513-1ff99bb1-7c00-433b-b061-060e9ec1fe78.png">

<img width="1201" alt="image" src="https://user-images.githubusercontent.com/22454918/232234444-bd68f424-c6da-4584-aff6-5526954da494.png">

## Installation

```lua
-- packer.nvim
use {"akinsho/horizon.nvim", tag = "*"}

-- lazy.nvim
{ "akinsho/horizon.nvim", version = "*" }

vim.cmd.colorscheme('horizon')
```

### Plugin integrations

Custom highlights for plugin's can be enabled or disabled using the setup options for this plugin.

```lua
{
  "akinsho/horizon.nvim",
  opts = {
    plugins = {
        cmp = true
        indent_blankline = true,
        cmp = true,
        indent_blankline = true,
        nvim_tree = true,
        telescope = true,
        which_key = true,
        barbar = true,
        cmp = true,
        notify = true,
        symbols_outline = true,
        telescope = true,
        nvim_tree = true,
        neo_tree = true,
        gitsigns = true,
        crates = true,
        hop = true,
        navic = true,
        quickscope = true
    }
  },
}
```

Currently supported plugins are:

- cmp
- indent-blankline
- nvim-tree
- telescope
- which-key
- barbar
- cmp
- notify
- symbols-outline
- telescope
- nvim-tree
- neo-tree
- gitsigns
- crates
- hop
- navic
- quickscope

## Contributing

Because this plugin seeks to adhere to the source material closely, it pulls in
the original themes json templates located in `build/{dark,light}/*.json`.
VSCode specifies colour values as 8 digit hex which is not supported by
neovim/terminals as they do not support alpha (opacity) values. To get around
this the json files are parsed and the alpha values are used as the basis for
blending the colour with the background colour to approximate opacity.

To contribute to the theme you can:

### 1. Change how color values are mapped

from vscode to neovim i.e. there is a mapping maintained in the build script
i.e. `build/convert.lua` called `theme_mapping` this maps a colour value from
vscode to neovim. These obviously do not strictly match but by reading through
[theme docs](https://code.visualstudio.com/api/references/theme-color), you determine
if a colour might be a good link for another in neovim e.g. `editorLineNumber.foreground` maps well onto
`LineNr` in neovim.

### 2. Override how a colour is used

Each variant of the theme has an `overrides.json` file which is the same format
as the `template.json` which is taken from [horizon.nvim](https://github.com/alexandernanberg/horizon-theme-vscode) this can be used
to change what the value of a colour is if there is a strong reason to deviate
from the upstream by actually changing the colour that it uses for something
_that we map_.

### 3. Add a custom colour intended for neovim only

In some cases the upstream theme does not have a colour that fits well with
a neovim highlight group because the concept might not even exist in neovim.
In most cases the best thing to do is to use a color from the theme's palette
which is in the generated file i.e. `lua/horizon/palette-{dark,light}.lua`
however if no colour there is suitable then _in extremis_ a colour can be added
to the `get_custom_highlights` function in `lua/horizon/theme.lua`.

## Credit & References

- [horizon-theme](https://github.com/alexandernanberg/horizon-theme-vscode) - The Maintained fork
- [horizon-theme](https://github.com/jolaleye/horizon-theme-vscode) - The OG theme
- [lunarvim theme](https://github.com/lunarvim/horizon.nvim)
