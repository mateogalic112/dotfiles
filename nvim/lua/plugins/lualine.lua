local colors = {
  -- Ghostty's background image shows through any cell we leave unpainted, so the
  -- bar stays transparent like the editor surface (see colorscheme.lua).
  bg = "NONE",
  fg = "#a89984",
  dim = "#7c6f64",
  branch = "#fe8019",
  added = "#b8bb26",
  changed = "#fabd2f",
  removed = "#fb4934",
  normal = "#83a598",
  insert = "#b8bb26",
  visual = "#fe8019",
  replace = "#fb4934",
  command = "#d3869b",
}

-- Every section shares one background so the bar reads as a single unpainted
-- strip; only the mode accent changes between modes.
local function section(accent)
  return {
    a = { fg = accent, bg = colors.bg, gui = "bold" },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.fg, bg = colors.bg },
  }
end

local theme = {
  normal = section(colors.normal),
  insert = section(colors.insert),
  visual = section(colors.visual),
  replace = section(colors.replace),
  command = section(colors.command),
  inactive = section(colors.dim),
}

local function gitsigns_diff()
  local status = vim.b.gitsigns_status_dict
  if not status then
    return nil
  end
  return { added = status.added, modified = status.changed, removed = status.removed }
end

-- Reuses the signs configured in lsp.lua so both stay in sync
local function diagnostic_symbols()
  local signs = vim.diagnostic.config().signs
  local text = type(signs) == "table" and signs.text or {}
  local severity = vim.diagnostic.severity
  return {
    error = (text[severity.ERROR] or "E") .. " ",
    warn = (text[severity.WARN] or "W") .. " ",
    info = (text[severity.INFO] or "I") .. " ",
    hint = (text[severity.HINT] or "H") .. " ",
  }
end

require("lualine").setup({
  options = {
    theme = theme,
    globalstatus = true,
    component_separators = { left = "│", right = "│" },
    section_separators = { left = "│", right = "│" },
  },
  sections = {
    lualine_a = { { "mode", icon = "" } },
    lualine_b = {
      { "branch", icon = "", color = { fg = colors.branch, gui = "bold" } },
      {
        "diff",
        source = gitsigns_diff,
        symbols = { added = " ", modified = " ", removed = " " },
        diff_color = {
          added = { fg = colors.added },
          modified = { fg = colors.changed },
          removed = { fg = colors.removed },
        },
      },
    },
    lualine_c = {
      { "filename", path = 1, symbols = { modified = "●", readonly = "" } },
      { "diagnostics", symbols = diagnostic_symbols() },
    },
    -- All three share one section so component_separators draws the dividers;
    -- across separate sections lualine omits them when the highlights match.
    lualine_x = {
      "filetype",
      function()
        return " " .. vim.fn.line(".") .. ":" .. vim.fn.virtcol(".")
      end,
    },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { "man", "quickfix" },
})

vim.o.showmode = false
