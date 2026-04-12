return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  opts = {
    settings = {
      tsserver_file_preferences = {
        includeInlayParameterNameHints = "all",
        includeCompletionsForModuleExports = true,
      },
    },
  },
  keys = {
    { "<leader>oi", "<cmd>TSToolsOrganizeImports<cr>", desc = "Organize imports" },
    { "<leader>ru", "<cmd>TSToolsRemoveUnused<cr>", desc = "Remove unused" },
    { "<leader>mi", "<cmd>TSToolsAddMissingImports<cr>", desc = "Add missing imports" },
    { "<leader>rf", "<cmd>TSToolsRenameFile<cr>", desc = "Rename file" },
  },
}
