require("snacks").setup({
  dashboard = {
    enabled = true,
    sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 1 },
    },
  },

  picker = {
    sources = {
      -- Centered float instead of the default sidebar
      explorer = {
        layout = { preset = "default", preview = true, layout = { backdrop = 60 } },
        auto_close = true,
        jump = { close = true },
        hidden = true,
        ignored = true,
      },
      lazygit = { enabled = true },
      files = {
        hidden = true,
        ignored = true,
      },
      -- Defaults to git_checkout, which checks the commit out by SHA and
      -- detaches HEAD. The preview already shows the diff, so just close
      git_log = { confirm = "close" },
    },
  },
})

vim.keymap.set("n", "<leader>ff", function()
  Snacks.picker.files({ hidden = true })
end, { desc = "Find Files" })

vim.keymap.set("n", "<leader>fb", function()
  Snacks.picker.buffers()
end, { desc = "Find buffers" })

vim.keymap.set("n", "<leader>fr", function()
  Snacks.picker.recent()
end, { desc = "Recent Files" })

vim.keymap.set("n", "<leader>sg", function()
  Snacks.picker.grep()
end, { desc = "Grep" })

-- Visual mode greps the selection instead of the word under the cursor
vim.keymap.set({ "n", "x" }, "<leader>sw", function()
  Snacks.picker.grep_word()
end, { desc = "Grep Word/Selection" })

vim.keymap.set("n", "<leader>sl", function()
  Snacks.picker.lines()
end, { desc = "Search Buffer Lines" })

vim.keymap.set("n", "<leader>sb", function()
  Snacks.picker.grep_buffers()
end, { desc = "Grep Open Buffers" })

vim.keymap.set("n", "<leader>sd", function()
  Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })

vim.keymap.set("n", "<leader>sr", function()
  Snacks.picker.resume()
end, { desc = "Resume Last Picker" })

vim.keymap.set("n", "<leader>e", function()
  Snacks.explorer()
end, { desc = "File Explorer" })

vim.keymap.set("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })

vim.keymap.set("n", "<leader>gg", function()
  Snacks.lazygit.open()
end, { desc = "Open LazyGit" })

vim.keymap.set("n", "<leader>gs", function()
  Snacks.picker.git_status()
end, { desc = "Git Status" })

vim.keymap.set("n", "<leader>gl", function()
  Snacks.picker.git_log()
end, { desc = "Git Log" })

vim.keymap.set("n", "<leader>gb", function()
  Snacks.picker.git_branches()
end, { desc = "Git Branches" })
