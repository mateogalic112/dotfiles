require("gruvbox").setup({
  overrides = {
    CursorLineNr = { bold = true, bg = "NONE" },
    SignColumn = { bg = "NONE" },
    GruvboxRedSign = { bg = "NONE" },
    GruvboxGreenSign = { bg = "NONE" },
    GruvboxYellowSign = { bg = "NONE" },
    GruvboxBlueSign = { bg = "NONE" },
    GruvboxPurpleSign = { bg = "NONE" },
    GruvboxAquaSign = { bg = "NONE" },
    GruvboxOrangeSign = { bg = "NONE" },
  },
})

vim.cmd.colorscheme("gruvbox")
