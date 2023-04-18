# horizon.nvim

![logo](https://user-images.githubusercontent.com/22454918/231746321-fa9aa184-1414-4433-9997-b28242064940.png)

A neovim implementation of the Horizon theme.

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

## Credit & References

- [horizon-theme](https://github.com/jolaleye/horizon-theme-vscode)
- [lunarvim theme](https://github.com/lunarvim/horizon.nvim)
