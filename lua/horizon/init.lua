local fn, cmd = vim.fn, vim.cmd
local o, g = vim.o, vim.g

local M = {}

local defaults = vim.defaulttable()

defaults.plugins = {
  barbar = true,
  bufferline = true,
  notify = true,
  symbols_outline = true,
  telescope = true,
  nvim_tree = true,
  neo_tree = true,
  gitsigns = true,
  indent_blankline = true,
  crates = true,
  hop = true,
  navic = true,
  quickscope = true,
  whichkey = true,
  cmp = true,
  ts_rainbow = true,
  flash = true,
}

---@param config horizon.Config?
function M.setup(config)
  config = vim.tbl_deep_extend('force', defaults, config or {})
  config = setmetatable(config, getmetatable(defaults))

  cmd.highlight('clear')

  if fn.exists('syntax_on') then cmd.syntax('reset') end

  o.termguicolors = true
  g.colors_name = 'horizon'

  require('horizon.theme').set_highlights(config)
end

return M
