local dap = require("dap")

-- Registers the delve adapter plus launch configs (file, package, test, attach)
require("dap-go").setup()

-- Opens the scopes/breakpoints/repl panel when a session starts, closes it when it ends
require("dap-view").setup({
  auto_toggle = true,
})

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "Visual" })

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Condition: "))
end, { desc = "Conditional Breakpoint" })

vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Start/Continue" })
vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step Out" })
vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to Cursor" })
vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run Last" })
vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Terminate" })

vim.keymap.set("n", "<leader>dt", function()
  require("dap-go").debug_test()
end, { desc = "Debug Nearest Test" })

vim.keymap.set("n", "<leader>dT", function()
  require("dap-go").debug_last_test()
end, { desc = "Debug Last Test" })

vim.keymap.set("n", "<leader>du", "<cmd>DapViewToggle<cr>", { desc = "Toggle Debug View" })
vim.keymap.set({ "n", "x" }, "<leader>dw", "<cmd>DapViewWatch<cr>", { desc = "Watch Expression" })
