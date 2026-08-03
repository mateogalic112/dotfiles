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
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.pack.add({
  "https://github.com/ellisonleao/gruvbox.nvim",
  "https://github.com/folke/snacks.nvim",
})

vim.keymap.set("n", "<leader>ff", function()
  Snacks.picker.files({ hidden = true })
end, { desc = "Find Files" })

vim.cmd.colorscheme("gruvbox")
