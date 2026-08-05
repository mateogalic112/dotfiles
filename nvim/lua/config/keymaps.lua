-- Window Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go Left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go Down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go Up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go Right" })

-- Buffer Navigation
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
