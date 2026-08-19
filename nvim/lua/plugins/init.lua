vim.pack.add({
  "https://github.com/ellisonleao/gruvbox.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/sindrets/diffview.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/akinsho/bufferline.nvim",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/windwp/nvim-autopairs",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1.*") },
})

require("plugins.treesitter")
require("plugins.blink")
require("plugins.lsp")
require("plugins.snacks")
require("plugins.gitsigns")
require("plugins.diffview")
require("plugins.conform")
require("plugins.colorscheme")
require("plugins.bufferline")
require("plugins.lualine")
require("plugins.autopairs")
