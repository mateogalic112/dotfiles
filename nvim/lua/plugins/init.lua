vim.pack.add({
  "https://github.com/ellisonleao/gruvbox.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

-- vim.pack.add is synchronous, so plugins are on the runtimepath by here and
-- these modules are free to require them. Colorscheme goes last so anything
-- setting highlights above it isn't overwritten.
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.snacks")
require("plugins.conform")
require("plugins.colorscheme")
