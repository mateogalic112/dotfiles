-- Search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear Search Highlight" })

-- Buffer Navigation
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- Save
-- The trailing <esc> returns to normal mode when saving from insert/visual
vim.keymap.set({ "n", "i", "x" }, "<C-s>", "<cmd>write<cr><esc>", { desc = "Save File" })
