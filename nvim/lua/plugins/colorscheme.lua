require("gruvbox").setup({
  -- Cells with an explicit background paint over Ghostty's background image,
  -- so the editor surface stays unpainted and lets it through.
  transparent_mode = true,
  overrides = {
    -- transparent_mode skips these two, so the statusline keeps a bg2 strip that
    -- shows through lualine's own unpainted sections
    StatusLine = { bg = "NONE" },
    StatusLineNC = { bg = "NONE" },
    CursorLineNr = { bold = true, bg = "NONE" },
    -- FlashLabel links to Substitute, which links to Search, so the label would
    -- otherwise render in the same yellow as the matches it labels
    FlashLabel = { fg = "#1d2021", bg = "#8ec07c", bold = true },
  },
})

vim.cmd.colorscheme("gruvbox")
