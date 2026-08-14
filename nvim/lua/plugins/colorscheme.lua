require("gruvbox").setup({
  transparent_mode = true,
  overrides = {
    CursorLineNr = { bold = true, bg = "NONE" },
  },
})

vim.cmd.colorscheme("gruvbox")
