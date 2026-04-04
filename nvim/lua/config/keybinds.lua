vim.g.mapleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>")
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neo-tree" })

vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Move to left window" })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Move to right window" })

vim.keymap.set('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>', { desc = "Next buffer" })
vim.keymap.set('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>', { desc = "Previous buffer" })
vim.keymap.set('n', '<leader>x', '<cmd>bp|bd #<cr>', { desc = "Close buffer" })
vim.keymap.set('n', '<leader>X', '<cmd>BufferLineCloseOthers<cr><cmd>bd<cr>', { desc = "Close all buffers" })

vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
