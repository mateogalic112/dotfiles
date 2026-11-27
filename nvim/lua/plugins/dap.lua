local dap = require("dap")

-- Registers the delve adapter plus launch configs (file, package, test, attach)
require("dap-go").setup()

-- Node/TypeScript via vscode-js-debug (installed to ~/.local/share/js-debug by install.sh)
dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = { vim.fn.expand("~/.local/share/js-debug/src/dapDebugServer.js"), "${port}" },
  },
}

local js_configs = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch current file",
    program = "${file}",
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    skipFiles = { "<node_internals>/**", "**/node_modules/**" },
  },
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch npm script",
    runtimeExecutable = "npm",
    runtimeArgs = function()
      return { "run", vim.fn.input("npm run ", "dev") }
    end,
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    console = "integratedTerminal",
    skipFiles = { "<node_internals>/**", "**/node_modules/**" },
  },
  {
    -- For a process started with `node --inspect` (e.g. in another tmux pane or a container on 9229)
    type = "pwa-node",
    request = "attach",
    name = "Attach to process",
    processId = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    skipFiles = { "<node_internals>/**", "**/node_modules/**" },
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach to port",
    port = function()
      return tonumber(vim.fn.input("Inspector port: ", "9229"))
    end,
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    skipFiles = { "<node_internals>/**", "**/node_modules/**" },
  },
}

for _, ft in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
  dap.configurations[ft] = js_configs
end

-- Opens the scopes/breakpoints/repl panel when a session starts, closes it when it ends
require("dap-view").setup({
  auto_toggle = true,
})

-- Shows variable values inline next to the code while stepping
require("nvim-dap-virtual-text").setup({})

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

-- Floating window with the full (expandable) value of the expression under the cursor; `!` focuses it
vim.keymap.set("n", "<leader>dh", "<cmd>DapViewHover!<cr>", { desc = "Hover Value" })
