vim.pack.add({
  "https://github.com/ellisonleao/gruvbox.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/rafamadriz/friendly-snippets",
  -- Gutter hunks, drawn into the signcolumn lsp.lua already pins open
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/sindrets/diffview.nvim",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  -- Tracking a release tag rather than main is what lets blink fetch its
  -- prebuilt Rust fuzzy matcher instead of needing a local cargo build
  { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1.*") },
})

-- vim.pack.add is synchronous, so plugins are on the runtimepath by here and
-- these modules are free to require them. Colorscheme goes last so anything
-- setting highlights above it isn't overwritten.
require("plugins.treesitter")
-- Before lsp, which reads blink's completion capabilities
require("plugins.blink")
require("plugins.lsp")
require("plugins.snacks")
require("plugins.gitsigns")
require("plugins.diffview")
require("plugins.conform")
require("plugins.colorscheme")
