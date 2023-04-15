local fn, fmt = vim.fn, string.format

---@alias TokenColors{settings: {foreground: string}, scope: string | string[]}
---@alias HLToken { colors: { [string]: string }, tokenColors: TokenColors[]}
---@alias ColorMap {[string]: {[string]: string}}

local alpha_map = {
  ['E6'] = 90, -- 'high'
  ['B3'] = 70, -- 'highMed',
  ['80'] = 50, -- 'med',
  ['4D'] = 30, -- 'medLow'
  ['1A'] = 10, -- 'low',
  ['00'] = 0, -- 'none',
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
    ['string.quoted'] = 'string',
    ['string.regexp'] = 'regex',
    ['variable'] = 'variable',
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
---reference: https://stackoverflow.com/a/56348573
---@param bg string hex colour
---@param target string hex colour
---@param alpha_hex string hex alpha
---@return string mixed hex colour
local function mix(bg, target, alpha_hex)
  local alpha = alpha_map[alpha_hex]
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
---@param colors ColorMap
---@return string color
---@return string? alpha
local function parse_variables(var, colors)
  local result = {}
  for w in var:gmatch('{{(.-)}}') do
    local parts = vim.split((vim.trim(w)), '%.')
    local item = vim.tbl_get(colors, parts[1], parts[2])
    table.insert(result, item)
  end
  if #result == 0 then return var end
  return result[1], result[2]
end

---@param token TokenColors
---@param colors ColorMap
---@return {bg: string, fg: string, bold: boolean, italics: boolean}
local function parse_token_settings(token, colors)
  local hl = {}
  for k, v in pairs(token.settings) do
    k = ({ foreground = 'fg', background = 'bg' })[k] or k
    local var, alpha = parse_variables(v, colors)
    if alpha then var = mix(colors.ui.background, var, alpha) end
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
  local colors_file = io.open(('./build/%s/globals.json'):format(mode), 'r')
  local template_file = io.open(('./build/%s/template.json'):format(mode), 'r')
  assert(template_file, 'Unable to open the json template file')
  assert(colors_file, 'Unable to open the json colors file')
  local template = vim.json.decode(template_file:read('*a')) ---@type HLToken
  local colors = vim.json.decode(colors_file:read('*a')) ---@type ColorMap

  local result = {}
  for color, value in pairs(template.colors) do
    local hl_name = theme_mappings.colors[color]
    if hl_name then
      local colour, alpha = parse_variables(value, colors)
      if alpha then colour = mix(colors.ui.background, colour, alpha) end
      result[hl_name] = colour
    end
  end
  for scope, mapping in pairs(theme_mappings.tokenColors) do
    for _, token in ipairs(template.tokenColors) do
      local current_scope = token.scope
      if current_scope == scope or (type(current_scope) == 'table' and vim.tbl_contains(current_scope, scope)) then
        result[mapping] = parse_token_settings(token, colors)
      end
    end
  end
  local colors_map = vim.inspect(result, { indent = string.rep(' ', 2) })
  local str = fmt('local colors = %s\n\nreturn colors', colors_map):gsub('"', "'") -- single quote strings
  fn.writefile(vim.split(str, '\n'), ('./lua/horizon/palette-%s.lua'):format(mode))
end

convert('light')
convert('dark')