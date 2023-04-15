-- These colours represent values not directly taken from the
-- original theme, but are similar to/inspired by the original.
-- they are largely used to plugin the gaps where there is no
-- color specified for something that needs to be highlighted
-- in the neovim context
-- TODO: over time ideally this highlights should be added either as
-- overrides in (overrides.json) since they do not scale to the light theme
-- or inherited/updated from the original theme.
local colors = {
  -- dropdown_bg = '#232530',
  -- scroll_bg = '#16161C',
  -- scroll_fg = '#6C6F93',
  -- editor_line_bg = '#22232D',
  -- match_paren = '#6C6F93',
  -- punctuation = '#BBBBBB',
  -- dark = '#16161C',
  -- accent = '#6C6F93',
  -- popup_back = '#16161C',
  -- search_orange = '#083C5A',
  -- search_blue = '#083C5A',
  -- tree_gray = '#1D1F27',
  -- context = '#6C6F93',
  -- white = '#8B8D8F',
  -- sign_add = '#27D796',
  -- tree_sign_add = '#09F7A0',
  -- tree_sign_change = '#FAB28E',
  -- cursor_fg = '#515052',
  -- cursor_bg = '#8E8F8D',
  -- purple_test = '#ff007c',
  -- cyan_test = '#00dfff',
  -- ui3_blue = '#0195F7',
  -- bg = '#1C1E26', -- #1D1F27
  -- fg = '#C1C1C1',

  alt_fg = '#8B8D8F',
  alt_bg = '#1D1F27',
  pale_grey = '#252732',
  line = '#1D1F27',
  gray = '#4B4C53',
  reference = '#2E303E',
  dark_gray = '#21252E',
  light_gray = '#c8ccd4',
  purple = '#B877DB',
  cyan = '#25B2BC',
  red = '#E95678',
  orange = '#F09383',
  yelloworange = '#FAB795',
  yellow = '#FAC29A',
  folder_blue = '#6C6F93',
  sign_change = '#21BFC2',
  sign_add_alt = '#27D796',
  sign_change_alt = '#21BFC2',
  sign_delete = '#E95379',
  error = '#F43E5C',
  warn = '#FAB28E',
  info = '#27D796',
  hint = '#6C6F93',
  error_bg = '#33222c',
  warn_bg = '#332e31',
  info_bg = '#1e3132',
  hint_bg = '#252732',
  success_green = '#09F7A0',
  ui_blue = '#214a63',
  ui2_blue = '#042E48',
  ui4_blue = '#75BEFF',
  ui_orange = '#E8AB53',
  ui_purple = '#B180D7',
}

return colors
