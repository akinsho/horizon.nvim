-- These colours represent values not directly taken from the
-- original theme, but are similar to/inspired by the original.
-- they are largely used to plugin the gaps where there is no
-- color specified for something that needs to be highlighted
-- in the neovim context
-- TODO: over time ideally this highlights should be added either as
-- overrides in (overrides.json) since they do not scale to the light theme
-- or inherited/updated from the original theme.

local dark = {
  gray = '#4B4C53',
  gold = '#C09553',
  error_bg = '#33222c',
  warn_bg = '#332e31',
  info_bg = '#1e3132',
  hint_bg = '#252732',
  diff_change = '#273842',
  diff_text = '#314753',
  blue1 = '#214a63',
  blue2 = '#042E48',
  blue3 = '#75BEFF',
  purple1 = '#B180D7',
}

local light = {}

local colors = {
  dark = dark,
  light = setmetatable(light, { __index = dark }),
}

return colors
