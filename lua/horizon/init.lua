local fn, cmd = vim.fn, vim.cmd

local M = {}

function M.setup()
  local o, g = vim.o, vim.g
  cmd.highlight('clear')

  o.background = 'dark'
  if fn.exists('syntax_on') then cmd.syntax('reset') end

  o.termguicolors = true
  g.colors_name = 'horizon'

  require('horizon.theme').set_highlights()
end

return M
