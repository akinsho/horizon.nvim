local fn, fmt = vim.fn, string.format

---@alias TokenColors{settings: {foreground: string}, scope: string | string[]}
---@alias HLToken { colors: { [string]: string }, tokenColors: TokenColors[]}

local current = {
  light = {
    tagStyle = 'italic',
    keywordStyle = 'italic',
    syntax = {
      amethyst = '#8A31B9',
      crimson = '#DA103F',
      elm = '#1D8991',
      thunderbird = '#DC3318',
      tango = '#F6661E',
      jaffa = '#F77D26',
      black = '#333333',
    },
    ui = {
      shadow = '#16161C',
      border = '#1A1C23',
      background = '#FDF0ED',
      backgroundAlt = '#FADAD1',
      accent = '#F9CBBE',
      accentAlt = '#F9CEC3',
      secondaryAccent = '#E73665',
      secondaryAccentAlt = '#E84A72',
      tertiaryAccent = '#AF5427',
      positive = '#07DA8C',
      negative = '#F43E5C',
      warning = '#1EB980',
      modified = '#1EAEAE',
      lightText = '#D5D8DA',
      darkText = '#06060C',
    },
    ansi = {
      normal = {
        blue = '#26BBD9',
        cyan = '#59E1E3',
        green = '#29D398',
        magenta = '#EE64AC',
        red = '#E95678',
        yellow = '#FAB795',
      },
      bright = {
        blue = '#3FC4DE',
        cyan = '#6BE4E6',
        green = '#3FDAA4',
        magenta = '#F075B5',
        red = '#EC6A88',
        yellow = '#FBC3A7',
      },
    },
    alpha = {
      high = 90, -- 'E6'
      highMed = 70, -- 'B3',
      med = 50, -- '80',
      medLow = 30, -- '4D'
      low = 10, -- '1A',
      none = 0, -- '00',
    },
  },
  dark = {
    tagStyle = 'italic',
    keywordStyle = 'italic',
    syntax = {
      lavender = '#B877DB',
      cranberry = '#E95678',
      turquoise = '#25B0BC',
      apricot = '#F09483',
      rosebud = '#FAB795',
      tacao = '#FAC29A',
      gray = '#BBBBBB',
    },
    ui = {
      shadow = '#16161C',
      border = '#1A1C23',
      background = '#1C1E26',
      backgroundAlt = '#232530',
      accent = '#2E303E',
      accentAlt = '#6C6F93',
      secondaryAccent = '#E9436D',
      secondaryAccentAlt = '#E95378',
      tertiaryAccent = '#FAB38E',
      positive = '#09F7A0',
      negative = '#F43E5C',
      warning = '#27D797',
      modified = '#21BFC2',
      lightText = '#D5D8DA',
      darkText = '#06060C',
    },
    ansi = {
      normal = {
        blue = '#26BBD9',
        cyan = '#59E1E3',
        green = '#29D398',
        magenta = '#EE64AC',
        red = '#E95678',
        yellow = '#FAB795',
      },
      bright = {
        blue = '#3FC4DE',
        cyan = '#6BE4E6',
        green = '#3FDAA4',
        magenta = '#F075B5',
        red = '#EC6A88',
        yellow = '#FBC3A7',
      },
    },
    alpha = {
      high = 90, -- 'E6'
      highMed = 70, -- 'B3',
      med = 50, -- '80',
      medLow = 30, -- '4D'
      low = 10, -- '1A',
      none = 0, -- '00',
    },
  },
}

local theme_mappings = {
  colors = {
    ['statusBar.foreground'] = 'statusline_fg',
    ['statusBar.background'] = 'statusline_bg',
    ['statusBarItem.prominentBackground'] = 'statusline_active_fg',
    ['breadcrumbPicker.background'] = 'winbar',
    ['gitDecoration.addedResourceForeground'] = 'git_added_fg',
    ['gitDecoration.modifiedResourceForeground'] = 'git_modified_fg',
    ['gitDecoration.deletedResourceForeground'] = 'git_deleted_fg',
    ['gitDecoration.untrackedResourceForeground'] = 'git_untracked_fg',
    ['gitDecoration.ignoredResourceForeground'] = 'git_ignored_fg',
    ['editorLineNumber.foreground'] = 'inactive_line_number_fg',
    ['editorLineNumber.activeForeground'] = 'active_line_number_fg',
    ['foreground'] = 'fg',
    ['editor.background'] = 'bg',
    ['editor.lineHighlightBackground'] = 'cursorline_bg',
    ['editorWidget.background'] = 'pmenu_bg',
    ['editorSuggestWidget.highlightForeground'] = 'pmenu_item_sel_fg',
    ['scrollbarSlider.activeBackground'] = 'pmenu_thumb_fg',
    ['scrollbarSlider.background'] = 'pmenu_thumb_bg',
    ['sideBar.background'] = 'sidebar_bg',
    ['sideBar.foreground'] = 'sidebar_fg',
    ['editorGroup.border'] = 'winseparator_fg',
    ['editorCursor.background'] = 'cursor_fg',
    ['editorCursor.foreground'] = 'cursor_bg',
    ['terminalCursor.background'] = 'term_cursor_bg',
    ['terminalCursor.foreground'] = 'term_cursor_fg',
    ['selection.background'] = 'visual',
    ['editor.selectionHighlightBackground'] = 'visual',
    ['editorIndentGuide.background'] = 'indent_guide_fg',
    ['editorIndentGuide.activeBackground'] = 'indent_guide_active_fg',
    ['editorCodeLens.foreground'] = 'codelens_fg',
    ['editorBracketMatch.background'] = 'match_paren',
    ['editorError.foreground'] = 'error',
    ['editorWarning.foreground'] = 'warning',
    ['editorGutter.modifiedBackground'] = 'sign_modified_bg',
    ['editorGutter.addedBackground'] = 'sign_added_bg',
    ['editorGutter.deletedBackground'] = 'sign_deleted_bg',
    ['diffEditor.insertedTextBackground'] = 'diff_added_bg',
    ['diffEditor.removedTextBackground'] = 'diff_deleted_bg',
  },
  ['tokenColors'] = {
    comment = 'comment',
    constant = 'constant',
    ['entity.name'] = 'structure',
    ['entity.name.function'] = 'func',
    ['entity.name.tag'] = 'tag',
    ['entity.name.type'] = 'type',
    ['entity.name.variable'] = 'class_variable',
    ['string.quoted'] = 'str',
    ['string.regexp'] = 'regex',
    ['variable.language'] = 'variable',
    ['support.type.property-name'] = 'field',
    ['storage'] = 'storage',
    ['keyword'] = 'keyword',
    ['keyword.operator'] = 'operator',
    ['unit'] = 'unit',
    ['quotes'] = 'quotes',
    ['markup.heading'] = 'title',
    ['bold'] = 'bold',
    ['italic'] = 'italics',
    ['markup.fenced_code.block'] = 'code_block',
    ['markup.underline.link'] = 'link',
    ['variable.parameter'] = 'parameter',
    ['keyword.operator.new'] = 'special_keyword',
    ['keyword.operator.expression'] = 'special_keyword',
    ['keyword.operator.logical'] = 'special_keyword',
    ['keyword.operator.delete'] = 'special_keyword',
  },
}

local function rgb_to_hex(rgb) return string.format('#%02X%02X%02X', rgb.r, rgb.g, rgb.b) end

local function hex_to_rgb(hex_str)
  -- normalise
  local hex = '[abcdef0-9][abcdef0-9]'
  local pat = '^#(' .. hex .. ')(' .. hex .. ')(' .. hex .. ')$'
  hex_str = string.lower(hex_str)
  -- convert
  local r, g, b = string.match(hex_str, pat)
  r, g, b = tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)
  return { r = r, g = g, b = b }
end

local function clamp(val, min, max) return math.min(max, math.max(min, val)) end

---approximate opacity to be mixing the colour with background color
---@param bg string hex colour
---@param target string hex colour
---@param alpha number hex alpha
---@return string mixed hex colour
local function mix(bg, target, alpha)
  assert(alpha, 'must provide strength to mix')
  alpha = clamp(alpha, 0, 100) / 100
  local rgb1 = hex_to_rgb(bg)
  local rgb2 = hex_to_rgb(target)
  local r = math.floor(rgb1.r + (rgb2.r - rgb1.r) * alpha)
  local g = math.floor(rgb1.g + (rgb2.g - rgb1.g) * alpha)
  local b = math.floor(rgb1.b + (rgb2.b - rgb1.b) * alpha)
  return rgb_to_hex({ r = r, g = g, b = b })
end

---@param var string
---@param mode Theme
---@return string color
---@return number? alpha
local function parse_variables(var, mode)
  local result = {}
  for w in var:gmatch('{{(.-)}}') do
    local parts = vim.split((vim.trim(w)), '%.')
    local item = vim.tbl_get(current[mode], parts[1], parts[2])
    table.insert(result, item)
  end
  if #result == 0 then return var end
  return result[1], result[2]
end

---@param token TokenColors
---@param mode Theme
---@return {bg: string, fg: string, bold: boolean, italics: boolean}
local function parse_token_settings(token, mode)
  local hl = {}
  for k, v in pairs(token.settings) do
    k = ({ foreground = 'fg', background = 'bg' })[k] or k
    local var, alpha = parse_variables(v, mode)
    if alpha then var = mix(current[mode].ui.background, var, alpha) end
    if k == 'fontStyle' then
      hl[var] = true
    else
      hl[k] = var
    end
  end
  return hl
end

---@param mode Theme
local function convert(mode)
  local file = io.open(('./templates/%s.json'):format(mode), 'r')
  assert(file, 'Unable to open the json template file')
  local contents = file:read('*a')
  local json = vim.json.decode(contents) ---@type HLToken
  local result = {}
  for color, value in pairs(json.colors) do
    local hl_name = theme_mappings.colors[color]
    if hl_name then
      local colour, alpha = parse_variables(value, mode)
      if alpha then colour = mix(current[mode].ui.background, colour, alpha) end
      result[hl_name] = colour
    end
  end
  for scope, mapping in pairs(theme_mappings.tokenColors) do
    for _, token in ipairs(json.tokenColors) do
      local sc = token.scope
      if sc == scope or (type(sc) == 'table' and vim.tbl_contains(sc, token)) then
        result[mapping] = parse_token_settings(token, mode)
      end
    end
  end
  local str = fmt('local colors = %s\n\nreturn colors', vim.inspect(result, { indent = string.rep(' ', 2) }))
  fn.writefile(vim.split(str, '\n'), ('./lua/horizon/palette-%s.lua'):format(mode))
end

convert('light')
convert('dark')
