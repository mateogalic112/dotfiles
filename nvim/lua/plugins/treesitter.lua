return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({
      "lua",
      "tsx",
      "typescript",
      "rust",
      "javascript",
      "html",
      "json",
      "yaml",
      "dockerfile",
      "markdown",
      "markdown_inline",
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "lua",
        "typescript",
        "typescriptreact",
        "javascript",
        "javascriptreact",
        "rust",
        "html",
        "json",
        "yaml",
        "dockerfile",
        "markdown",
      },
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
