local fn, fmt = vim.fn, string.format

---@alias TokenColors{settings: {foreground: string}, scope: string | string[]}
---@alias HLToken { colors: { [string]: string }, tokenColors: TokenColors[]}
---@alias ColorMap {[string]: {[string]: string}}
---@alias ParsedFiles {template: HLToken, overrides:  HLToken, colors: ColorMap}

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
    ['editorWidget.background'] = { 'pmenu_bg', 'float_bg' },
    ['editorWidget.foreground'] = { 'pmenu_fg', 'float_fg' },
    ['editorWidget.border'] = 'float_border',
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
    ['punctuation.separator'] = 'delimiter',
    ['punctuation.definition.template-expression'] = 'template_delimiter',
  },
}

local function hex_to_rgb(hex_str)
  local hex = '[abcdef0-9][abcdef0-9]'
  local pat = '^#(' .. hex .. ')(' .. hex .. ')(' .. hex .. ')$'
  hex_str = string.lower(hex_str)
  assert(string.find(hex_str, pat) ~= nil, 'hex_to_rgb: invalid hex_str: ' .. tostring(hex_str))
  local red, green, blue = string.match(hex_str, pat)
  return { tonumber(red, 16), tonumber(green, 16), tonumber(blue, 16) }
end

---approximate opacity to be mixing the colour with background color
---references:
--- - https://stackoverflow.com/a/56348573
--- - https://github.com/zbirenbaum/neodim/blob/ba5dfa830b41fabab251f7a2b97d5d14a2208c8b/lua/neodim/util.lua
---@param bg string hex colour
---@param fg string hex colour
---@param alpha_hex string hex alpha
---@return string mixed hex colour
local function blend(bg, fg, alpha_hex)
  local alpha = (math.floor(tonumber(alpha_hex, 16) / 255 * 100)) / 100
  assert(alpha, 'must provide strength to mix')
  local bg_rgb = hex_to_rgb(bg)
  local fg_rgb = hex_to_rgb(fg)
  local blend_channel = function(i)
    local ret = (alpha * fg_rgb[i] + ((1 - alpha) * bg_rgb[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end
  return ('#%02X%02X%02X'):format(blend_channel(1), blend_channel(2), blend_channel(3))
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
  local colour, alpha = result[1], result[2]
  if alpha then return blend(colors.ui.background, colour, alpha) end
  return colour
end

---@param token TokenColors
---@param colors ColorMap
---@return {bg: string, fg: string, bold: boolean, italics: boolean}
local function parse_token_settings(token, colors)
  local hl = {}
  for k, v in pairs(token.settings) do
    k = ({ foreground = 'fg', background = 'bg' })[k] or k
    local value = parse_variables(v, colors)
    if k == 'fontStyle' then
      hl[value] = true
    else
      hl[k] = value
    end
  end
  return hl
end

---@param mode Theme
---@return ParsedFiles
local function read_json_files(mode)
  local paths = {
    dark = {
      template = 'build/dark/template.json',
      colors = 'build/dark/globals.json',
      overrides = 'build/dark/overrides.json',
    },
    light = {
      template = 'build/light/template.json',
      colors = 'build/light/globals.json',
      overrides = 'build/light/overrides.json',
    },
  }
  if not paths[mode] then error('Invalid mode: ' .. mode) end
  local result = {}
  for name, path in pairs(paths[mode]) do
    local file = io.open(path, 'r')
    assert(file, 'Unable to open the json file: ' .. path)
    local json = vim.json.decode(file:read('*a'))
    result[name] = json
  end
  return result
end

---@param files ParsedFiles
local function apply_overrides(files)
  local template, colors, overrides = files.template, files.colors, files.overrides

  if overrides.colors then template.colors = vim.tbl_deep_extend('force', template.colors, overrides.colors) end

  if overrides.tokenColors then
    local seen = {}
    local function get_name(scope) return type(scope) == 'table' and table.concat(scope, ',') or scope end
    for _, token in ipairs(overrides.tokenColors) do
      seen[get_name(token.scope)] = token
    end
    template.tokenColors = vim.tbl_map(function(tk) return seen[get_name(tk.scope)] or tk end, template.tokenColors)
  end
  return template, colors
end

---@param mode Theme
local function convert(mode)
  local files = read_json_files(mode)
  local template, colors = apply_overrides(files)

  local result = {}
  for color, value in pairs(template.colors) do
    local hl_name = theme_mappings.colors[color]
    if hl_name then
      if type(hl_name) == 'string' then hl_name = { hl_name } end
      local colour = parse_variables(value, colors)
      for _, name in ipairs(hl_name) do
        result[name] = colour
      end
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

for _, mode in ipairs({ 'light', 'dark' }) do
  convert(mode)
end
