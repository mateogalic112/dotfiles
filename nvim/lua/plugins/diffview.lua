require("diffview").setup({
  enhanced_diff_hl = true,
})

-- lib.views holds every open view, so an empty table means nothing is open
local function no_view_open()
  return next(require("diffview.lib").views) == nil
end

vim.keymap.set("n", "<leader>gd", function()
  vim.cmd(no_view_open() and "DiffviewOpen" or "DiffviewClose")
end, { desc = "Diff View" })

vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "File History" })

vim.keymap.set("n", "<leader>gH", "<cmd>DiffviewFileHistory<cr>", { desc = "Repo History" })
