require("nvim-autopairs").setup({
  -- Use treesitter to skip pairing inside strings/comments
  check_ts = true,

  -- <M-e> wraps the rest of the line in the pair you're sitting on
  fast_wrap = {},
})
