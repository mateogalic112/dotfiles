require("snacks").setup({
  picker = {
    focus = "list",
    sources = {
      -- Centered float instead of the default sidebar
      explorer = {
        layout = { preset = "default", preview = true, layout = { backdrop = 60 } },
        auto_close = true,
        jump = { close = true },
      },
    },
  },
})

vim.keymap.set("n", "<leader>ff", function()
  Snacks.picker.files({ hidden = true })
end, { desc = "Find Files" })

vim.keymap.set("n", "<leader>fb", function()
  Snacks.picker.buffers()
end, { desc = "Find buffers" })

vim.keymap.set("n", "<leader>e", function()
  Snacks.explorer()
end, { desc = "File Explorer" })
