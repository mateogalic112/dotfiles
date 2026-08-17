vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(nil, true),
})

vim.lsp.config("gopls", {
  settings = {
    gopls = {
      staticcheck = true,
      analyses = {
        unusedparams = true,
        unusedwrite = true,
        nilness = true,
      },
    },
  },
})

vim.lsp.enable("vtsls")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("gopls")
vim.lsp.enable("eslint")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(ev)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to Definition" })

    -- vtsls answers to addMissingImports, gopls to organizeImports; each server
    -- ignores the kind it doesn't implement, so one keymap covers both
    vim.keymap.set("n", "<leader>ci", function()
      vim.lsp.buf.code_action({
        context = {
          only = { "source.addMissingImports", "source.organizeImports" },
          diagnostics = {},
        },
        apply = true,
      })
    end, { buffer = ev.buf, desc = "Fix Imports" })
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
