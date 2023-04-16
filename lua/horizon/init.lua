local fn, api, cmd = vim.fn, vim.api, vim.cmd
local o, g = vim.o, vim.g

---@class horizon.Plugins
---@field barbar boolean
---@field bufferline boolean
---@field notify boolean
---@field symbols_outline boolean
---@field telescope boolean
---@field nvim_tree boolean
---@field neo_tree boolean
---@field gitsigns boolean
---@field crates boolean
---@field hop boolean
---@field navic boolean
---@field quickscope boolean
---@field whichkey boolean
---@field indent_blankline boolean
---@field cmp boolean
---@field ts_rainbow boolean

---@class horizon.Config
---@field plugins horizon.Plugins

local M = {}

local defaults = {
  plugins = {
    barbar = true,
    bufferline = true,
    notify = true,
    symbols_outline = true,
    telescope = true,
    nvim_tree = true,
    neo_tree = true,
    gitsigns = true,
    indent_blankline = false,
    crates = true,
    hop = true,
    navic = true,
    quickscope = true,
    whichkey = true,
    cmp = true,
    ts_rainbow = true,
  },
}

---@param config horizon.Config?
function M.setup(config)
  config = vim.tbl_deep_extend('force', defaults, config or {})

  cmd.highlight('clear')

  if fn.exists('syntax_on') then cmd.syntax('reset') end

  o.termguicolors = true
  g.colors_name = 'horizon'

  require('horizon.theme').set_highlights(config)
end

return M
