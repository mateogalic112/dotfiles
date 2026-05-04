return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  opts = {
    settings = {
      tsserver_file_preferences = {
        includeInlayParameterNameHints = "none",
        includeCompletionsForModuleExports = true,
      },
    },
  },
  keys = {
    { "<leader>oi", "<cmd>TSToolsOrganizeImports<cr>", desc = "Organize imports" },
    { "<leader>ru", "<cmd>TSToolsRemoveUnused<cr>", desc = "Remove unused" },
    { "<leader>mi", "<cmd>TSToolsAddMissingImports<cr>", desc = "Add missing imports" },
    { "<leader>rf", "<cmd>TSToolsRenameFile<cr>", desc = "Rename file" },
    { "<leader>fa", "<cmd>TSToolsFixAll<cr>", desc = "Fix all" },
    { "<leader>gs", "<cmd>TSToolsGoToSourceDefinition<cr>", desc = "Go to source definition" },
    { "<leader>fr", "<cmd>TSToolsFileReferences<cr>", desc = "File references" },
  },
}
