-- Server settings live in nvim/lsp/<name>.lua, which Neovim loads from the
-- runtimepath automatically
vim.lsp.enable("vtsls")
-- tailwindcss-language-server is resolved from the project's node_modules/.bin
-- first, falling back to a global install
vim.lsp.enable("tailwindcss")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(ev)
    vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
      autotrigger = true,
    })

    -- Inline swatches for the colors tailwind/css servers report
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method("textDocument/documentColor") then
      vim.lsp.document_color.enable(true, ev.buf)
    end

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to Definition" })

    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code Action" })

    vim.keymap.set("n", "<leader>ci", function()
      vim.lsp.buf.code_action({
        context = { only = { "source.addMissingImports" }, diagnostics = {} },
        apply = true,
      })
    end, { buffer = ev.buf, desc = "Add Missing Imports" })
  end,
})

-- Diagnostics
vim.o.signcolumn = "yes"

vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚",
      [vim.diagnostic.severity.WARN] = "󰀪",
      [vim.diagnostic.severity.INFO] = "󰋽",
      [vim.diagnostic.severity.HINT] = "󰌶",
    },
  },
})
