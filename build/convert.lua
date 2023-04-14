local fn, fmt = vim.fn, string.format

---@alias HLToken { colors: { [string]: string }, tokenColors: {settings: {foreground: string}, scope: string | string[]}[]}

local current = {
  light = {
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
      high = 'E6',
      highMed = 'B3',
      med = '80',
      medLow = '4D',
      low = '1A',
      none = '00',
    },
  },
  dark = {
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
      high = 'E6',
      highMed = 'B3',
      med = '80',
      medLow = '4D',
      low = '1A',
      none = '00',
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
    ['editorSuggestWidget.highlightForeground'] = 'pmenu_sel_bg',
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
    ['entity.name.function'] = 'method',
    ['entity.name.tag'] = 'tag',
    ['entity.name.type'] = 'type',
    ['entity.name.variable'] = 'class_variable',
    ['variable.language'] = 'variable',
    ['keyword'] = 'keyword',
    ['keyword.operator'] = 'operator',
    ['unit'] = 'unit',
    ['quotes'] = 'quotes',
    ['markup.heading'] = 'title',
    ['bold'] = 'bold',
    ['italic'] = 'italics',
    ['markup.fenced_code.block'] = 'code_block',
    ['markup.underline.link'] = 'link',
    ['string.template'] = 'template',
    ['parameter'] = 'parameter',
  },
}

---@param var string
---@param mode Theme
---@return string? color
---@return string? alpha
local function parse_variables(var, mode)
  local result = {}
  for w in var:gmatch('{{(.-)}}') do
    local parts = vim.split((vim.trim(w)), '%.')
    local item = vim.tbl_get(current[mode], parts[1], parts[2])
    table.insert(result, item)
  end
  return result[1], result[2]
end

---@param mode Theme
local function convert(mode)
  local file = io.open(('./templates/%s.json'):format(mode), 'r')
  assert(file, 'Unable to open the json template file')
  local contents = file:read('*a')
  local json = vim.json.decode(contents) ---@type HLToken
  local result = {}
  for color, value in pairs(json.colors) do
    if theme_mappings.colors[color] then result[theme_mappings.colors[color]] = parse_variables(value, mode) end
  end
  for scope, mapping in pairs(theme_mappings.tokenColors) do
    for _, token in ipairs(json.tokenColors) do
      local sc = token.scope
      if sc == scope or (type(sc) == 'table' and vim.tbl_contains(sc, token)) then
        local hl = {}
        for k, v in pairs(token.settings) do
          k = k:gsub('foreground', 'fg')
          k = k:gsub('background', 'bg')
          hl[k] = parse_variables(v, mode)
        end
        result[mapping] = hl
      end
    end
  end
  local str = fmt('local colors = %s\n\nreturn colors', vim.inspect(result, { indent = string.rep(' ', 2) }))
  fn.writefile(vim.split(str, '\n'), ('./lua/horizon/palette-%s.lua'):format(mode))
end

convert('light')
convert('dark')
