require("conform").setup({
  -- Prettier resolves from the project's node_modules, falling back to the LSP
  -- formatter in projects without it
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "goimports" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    markdown = { "prettier" },
    yaml = { "prettier" },
  },
  default_format_opts = {
    stop_after_first = true,
  },
  format_on_save = {
    timeout_ms = 1000,
    lsp_format = "fallback",
  },
})
