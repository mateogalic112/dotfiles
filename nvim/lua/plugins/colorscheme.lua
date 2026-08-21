require("gruvbox").setup({
  transparent_mode = true,
  overrides = {
    CursorLineNr = { bold = true, bg = "NONE" },
    -- FlashLabel links to Substitute, which links to Search, so the label would
    -- otherwise render in the same yellow as the matches it labels
    FlashLabel = { fg = "#1d2021", bg = "#8ec07c", bold = true },
  },
})

vim.cmd.colorscheme("gruvbox")
