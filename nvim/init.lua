-- Leader Keys
vim.g.mapleader = " "

-- Line Numbers
vim.o.relativenumber = true

-- Window Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go Left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go Down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go Up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go Right" })

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

-- Highlight Yanks
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Reload Files Changed Outside Neovim
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "TermClose", "TermLeave" }, {
  group = vim.api.nvim_create_augroup("checktime", { clear = true }),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd.checktime()
    end
  end,
})

vim.pack.add({
  "https://github.com/ellisonleao/gruvbox.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/neovim/nvim-lspconfig",
})

-- LSP
vim.lsp.enable("vtsls")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(ev)
    vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
      autotrigger = true,
    })
  end,
})

-- Diagnostics
vim.o.signcolumn = "yes"

vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " 󰅚",
      [vim.diagnostic.severity.WARN] = " 󰀪",
      [vim.diagnostic.severity.INFO] = " 󰋽",
      [vim.diagnostic.severity.HINT] = " 󰌶",
    },
  },
})

-- Snacks
vim.keymap.set("n", "<leader>ff", function()
  Snacks.picker.files({ hidden = true })
end, { desc = "Find Files" })

vim.keymap.set("n", "<leader>fb", function()
  Snacks.picker.buffers()
end, { desc = "Find buffers" })

require("conform").setup({
  -- Prettier resolves from the project's node_modules, falling back to the LSP
  -- formatter in projects without it
  formatters_by_ft = {
    lua = { "stylua" },
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

-- Colorscheme
require("gruvbox").setup({
  -- Blend the sign column into the buffer background
  overrides = {
    SignColumn = { bg = "NONE" },
    GruvboxRedSign = { bg = "NONE" },
    GruvboxGreenSign = { bg = "NONE" },
    GruvboxYellowSign = { bg = "NONE" },
    GruvboxBlueSign = { bg = "NONE" },
    GruvboxPurpleSign = { bg = "NONE" },
    GruvboxAquaSign = { bg = "NONE" },
    GruvboxOrangeSign = { bg = "NONE" },
  },
})

vim.cmd.colorscheme("gruvbox")
