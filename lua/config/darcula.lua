local M = {}

M.palette = {
  bg = "#1e1f22",
  fg = "#a9b7c6",
  keyword = "#CC7832",
  func = "#FFC66D",
  string = "#6A8759",
  number = "#6897BB",
  property = "#9876AA",
  comment = "#808080",
  tag = "#E8BF6A",
  attribute = "#BABABA",
  link = "#6D9CBE",
  html_string = "#A5C261",
  error = "#f44747",
  warn = "#cd9731",
  info = "#6796e6",
  hint = "#b267e6",
  line_nr = "#606366",
  line_nr_active = "#999999",
  cursor_line = "#2b2d30",
  ui_bg = "#2b2d30",
  ui_fg = "#bababa",
  tab_active = "#515658",
  tab_inactive = "#3c3e3f",
  border = "#393b40",
  indent = "#393b40",
  indent_active = "#4e5157",
  scrollbar = "#43454a",
  search = "#415a41",
  shadow = "#131416",
  dim = "#9aa1a9",
  float_fg = "#dbe2e9",
  float_bg = "#18191b",
}

function M.apply(hl)
  local p = M.palette

  local groups = {
    ["@keyword"] = { fg = p.keyword },
    ["@keyword.function"] = { fg = p.keyword },
    ["@keyword.return"] = { fg = p.keyword },
    ["@keyword.conditional"] = { fg = p.keyword },
    ["@keyword.repeat"] = { fg = p.keyword },
    ["@keyword.exception"] = { fg = p.keyword },
    ["@keyword.import"] = { fg = p.keyword },
    ["@keyword.export"] = { fg = p.keyword },
    ["@keyword.coroutine"] = { fg = p.keyword },
    ["@keyword.modifier"] = { fg = p.keyword },
    ["@keyword.type"] = { fg = p.keyword },
    ["@type.qualifier"] = { fg = p.keyword },
    ["@punctuation.delimiter"] = { fg = p.keyword },
    ["@punctuation.special"] = { fg = p.keyword },
    ["@string.escape"] = { fg = p.keyword },
    Keyword = { fg = p.keyword },
    Statement = { fg = p.keyword },
    Conditional = { fg = p.keyword },
    Repeat = { fg = p.keyword },
    Exception = { fg = p.keyword },
    Include = { fg = p.keyword },
    Define = { fg = p.keyword },
    PreProc = { fg = p.keyword },
    StorageClass = { fg = p.keyword },
    Structure = { fg = p.keyword },
    Delimiter = { fg = p.keyword },

    ["@constant.builtin"] = { fg = p.keyword, bold = true },
    ["@boolean"] = { fg = p.keyword, bold = true },
    ["@variable.builtin"] = { fg = p.keyword, bold = true },
    ["@type.builtin"] = { fg = p.keyword, bold = true },
    Boolean = { fg = p.keyword, bold = true },

    ["@function"] = { fg = p.func },
    ["@function.call"] = { fg = p.func },
    ["@function.builtin"] = { fg = p.func },
    ["@function.method"] = { fg = p.func },
    ["@function.method.call"] = { fg = p.func },
    ["@function.macro"] = { fg = p.func },
    ["@constructor"] = { fg = p.func },
    ["@attribute"] = { fg = p.func },
    Function = { fg = p.func },

    ["@string"] = { fg = p.string },
    ["@string.regexp"] = { fg = p.string },
    ["@string.special"] = { fg = p.string },
    ["@character"] = { fg = p.string },
    ["@comment.documentation"] = { fg = p.string },
    String = { fg = p.string },
    Character = { fg = p.string },

    ["@number"] = { fg = p.number },
    ["@number.float"] = { fg = p.number },
    Number = { fg = p.number },
    Float = { fg = p.number },

    ["@property"] = { fg = p.property },
    ["@variable.member"] = { fg = p.property },
    ["@field"] = { fg = p.property },
    ["@constant"] = { fg = p.property },
    ["@constant.macro"] = { fg = p.property },

    ["@variable"] = { fg = p.fg },
    ["@variable.parameter"] = { fg = p.fg },
    ["@operator"] = { fg = p.fg },
    ["@punctuation.bracket"] = { fg = p.fg },
    ["@module"] = { fg = p.fg },
    ["@type"] = { fg = p.fg },
    ["@type.definition"] = { fg = p.fg },
    ["@label"] = { fg = p.fg },
    Identifier = { fg = p.fg },
    Operator = { fg = p.fg },
    Type = { fg = p.fg },

    ["@comment"] = { fg = p.comment, italic = true },
    Comment = { fg = p.comment, italic = true },

    ["@tag"] = { fg = p.tag },
    ["@tag.builtin"] = { fg = p.tag },
    ["@tag.delimiter"] = { fg = p.tag },
    ["@tag.attribute"] = { fg = p.attribute },
    ["@markup.link"] = { fg = p.link, italic = true },
    ["@markup.link.url"] = { fg = p.link, italic = true },
    ["@markup.heading"] = { fg = p.keyword, bold = true },
    ["@markup.raw"] = { fg = p.string },
    ["@diff.plus"] = { fg = p.string },
    ["@diff.minus"] = { fg = p.error },

    ["@lsp.type.keyword"] = { fg = p.keyword },
    ["@lsp.type.function"] = { fg = p.func },
    ["@lsp.type.method"] = { fg = p.func },
    ["@lsp.type.decorator"] = { fg = p.func },
    ["@lsp.type.string"] = { fg = p.string },
    ["@lsp.type.number"] = { fg = p.number },
    ["@lsp.type.property"] = { fg = p.property },
    ["@lsp.type.enumMember"] = { fg = p.property },
    ["@lsp.type.variable"] = { fg = p.fg },
    ["@lsp.type.parameter"] = { fg = p.fg },
    ["@lsp.type.namespace"] = { fg = p.fg },
    ["@lsp.type.class"] = { fg = p.fg },
    ["@lsp.type.interface"] = { fg = p.fg },
    ["@lsp.type.type"] = { fg = p.fg },
    ["@lsp.type.typeParameter"] = { fg = p.fg },
    ["@lsp.type.operator"] = { fg = p.fg },
    ["@lsp.type.comment"] = { fg = p.comment, italic = true },

    DiagnosticError = { fg = p.error },
    DiagnosticWarn = { fg = p.warn },
    DiagnosticInfo = { fg = p.info },
    DiagnosticHint = { fg = p.hint },
  }

  for group, spec in pairs(groups) do
    hl[group] = spec
  end

  hl.NonText = vim.tbl_extend("force", hl.NonText or {}, { fg = p.dim })
  hl.Conceal = vim.tbl_extend("force", hl.Conceal or {}, { fg = p.dim })
  hl.NormalFloat = vim.tbl_extend("force", hl.NormalFloat or {}, { fg = p.float_fg, bg = p.float_bg })
  hl.FloatBorder = vim.tbl_extend("force", hl.FloatBorder or {}, { fg = p.indent_active, bg = p.float_bg })
  hl.SnacksPicker = { fg = p.float_fg, bg = p.float_bg }
  hl.SnacksPickerBorder = { fg = p.indent_active, bg = p.float_bg }
end

function M.apply_background(colors)
  local p = M.palette

  colors.bg = p.bg
  colors.bg_dark = p.ui_bg
  colors.bg_dark1 = p.shadow
  colors.bg_float = p.float_bg
  colors.bg_popup = p.float_bg
  colors.bg_sidebar = p.ui_bg
  colors.bg_statusline = p.ui_bg
  colors.bg_highlight = p.cursor_line
  colors.bg_visual = p.scrollbar
  colors.bg_search = p.search
  colors.border = p.border
  colors.border_highlight = p.indent_active
  colors.fg = p.fg
  colors.fg_dark = p.ui_fg
  colors.fg_float = p.ui_fg
  colors.fg_sidebar = p.ui_fg
  colors.fg_gutter = p.line_nr
  colors.comment = p.comment
  colors.terminal_black = p.line_nr
end

return M
