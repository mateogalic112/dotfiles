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
    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
    end

    -- Nvim already binds gr*/gO to the built-in LSP handlers, which dump results
    -- into a bare quickfix list. Same keys, but answered by a picker with preview.
    map("gd", Snacks.picker.lsp_definitions, "Go to Definition")
    map("grr", Snacks.picker.lsp_references, "References")
    map("gri", Snacks.picker.lsp_implementations, "Implementations")
    map("grt", Snacks.picker.lsp_type_definitions, "Type Definition")
    map("gO", Snacks.picker.lsp_symbols, "Symbols (Buffer)")
    map("<leader>ss", Snacks.picker.lsp_symbols, "Symbols (Buffer)")
    map("<leader>sS", Snacks.picker.lsp_workspace_symbols, "Symbols (Workspace)")

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
