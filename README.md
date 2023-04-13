# horizon.nvim

![logo](https://user-images.githubusercontent.com/22454918/231746321-fa9aa184-1414-4433-9997-b28242064940.png)

A neovim implementation of the Horizon theme.

## Installation

```lua
-- packer.nvim
use "akinsho/horizon.nvim"

-- lazy.nvim
{ "akinsho/horizon.nvim" }

vim.cmd.colorscheme('horizon')
```

### Plugin integrations

Custom highlights for plugin's can be enabled or disabled using the setup options for this plugin.

```lua
{
  "akinsho/horizon.nvim",
  opts = {
    plugins = {
        cmp = false
        indent_blankline = false,
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

## Screenshots

<img width="2560" alt="first screenshot" src="https://user-images.githubusercontent.com/22454918/231746696-e56fcfa1-a788-41c7-836e-219589c5a1e6.png">

## Credit & References

- [horizon-theme](https://github.com/jolaleye/horizon-theme-vscode)
- [lunarvim theme](https://github.com/lunarvim/horizon.nvim)
